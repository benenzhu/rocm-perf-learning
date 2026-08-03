# 02 · PC Sampling 实战:定位到具体哪条指令在停

> 平台:AMD Instinct MI355X (gfx950 / CDNA4),ROCm `rocprofv3`
> 案例:同 [01](01-vmem-issue-stalls.md) —— MXFP4 GEMM kernel
> 配套工具:[`pc_sampling_report.py`](pc_sampling_report.py) · 输出样例:[`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt)

---

## TL;DR

```bash
# 1. 采样(注意 beta flag,gfx950 上用 stochastic 才有停顿原因)
rocprofv3 --pc-sampling-beta-enabled --pc-sampling-method stochastic \
          --pc-sampling-unit cycles --pc-sampling-interval 65536 \
          --output-format csv -d out -o pc -- ./your_app

# 2. 先看有哪些 dispatch(⚠️ 别的 kernel 的样本也在里面)
./pc_sampling_report.py out/pc_pc_sampling_stochastic.csv --list

# 3. 用你 kernel 独有的指令自动锁定,生成报告
./pc_sampling_report.py out/pc_pc_sampling_stochastic.csv \
    --match v_mfma_scale --title "my_kernel" -o report.txt
```

**最容易踩的坑:`--kernel-include-regex` 不过滤 PC sampling 数据流。** 不按 `Dispatch_Id` 二次过滤,本案例的结论会从「发射受限 66.7%」变成「延迟受限 79%」——**完全相反**。

---

## 1. PC Sampling 能回答什么,PMC 不能

PMC 是**计数器**:告诉你「TA 的队列满了 27.2% 的时间」。
PC Sampling 是**采样器**:周期性抓取每个 wave 的 PC + 状态,告诉你「**是这条 `buffer_store_short` 在停**」。

| | PMC | PC Sampling |
|---|---|---|
| 粒度 | 硬件单元 | **具体指令** |
| 数据 | 全量计数 | 抽样 |
| 阈值 | 有官方判据(≥10%) | 无,只有相对占比 |
| 开销(本例) | 6.7 s | 10.7 s |

**两者互补**:PMC 定方向(哪个单元),PC Sampling 定位置(哪条指令)。
[01](01-vmem-issue-stalls.md) 用 PMC 得出「VMEM 发射被 TA 堵住」,这篇用 PC Sampling 验证并进一步排序。

---

## 2. 两种模式,选 stochastic

| | `host_trap` | `stochastic` |
|---|---|---|
| 采样方式 | 软件定时中断 | **硬件采样** |
| 单位 | 时间(µs) | **周期 / 指令** |
| 支持 | MI200+ | MI300+ |
| **有停顿原因吗** | ❌ **没有** | ✅ **有** |

实测两种模式的输出列:

```
host_trap  : Sample_Timestamp, Exec_Mask, Dispatch_Id, Instruction,
             Instruction_Comment, Correlation_Id
stochastic : ... + Wave_Issued_Instruction, Instruction_Type,
             Stall_Reason, Wave_Count          ← 关键的三列
```

**要分析停顿必须用 `stochastic`。** `host_trap` 只能告诉你 PC 分布(哪里热),不能告诉你为什么停。

> 采样间隔:`stochastic` + `cycles` 时必须是 2 的幂且 ≥65536。
> 默认 1048576 太稀疏(本例只拿到 309 个有效停顿样本);
> **用 65536 能拿到 2232 个**,精度从 ±5.2% 提到 ±2.0%。

---

## 3. ⚠️ 两道过滤,少一道结论就反了

**这是全文最重要的一节。** 我第一次做这个分析时漏了第二道,得出了完全错误的结论。

### 3.1 第一道:丢掉 PC 解析不出来的行

```
Instruction 字段为空 → PC 落在无法解析的 code object 上
```

本例 9656 个原始样本里有 **1787 个**是这种。

### 3.2 第二道:只保留本 kernel 的 dispatch

```
--kernel-include-regex 不过滤 PC sampling 数据流!
```

这个行为很反直觉:**即使命令行加了 `--kernel-include-regex "kernel_gemm"`,进程里所有 kernel 的样本照样进 csv。**

本例的实际构成:

```
9656 个原始样本
├─ 1787  PC 无法解析                             → 丢
├─ 4863  来自 PyTorch 其他算子(量化 / shuffle)  → 丢   ← 占了一半!
└─ 3006  来自 kernel_gemm_0(dispatch 143~146)  ← 只有这些有效
```

### 3.3 漏掉第二道会怎样

| | 只过滤一道(错) | 两道都做(对) |
|---|---|---|
| `WAITCNT` | **79.0%** | 8.5% |
| `ARBITER_WIN_EX_STALL` | 9.4% | **66.7%** |
| 结论 | 「延迟受限」 | 「**发射受限**」 |

**完全相反。** 那 79% 的 WAITCNT 全是 PyTorch 量化算子的,和被测 kernel 毫无关系。

### 3.4 怎么发现自己踩了坑

我是靠**指令对不上**发现的:报告里出现了 `global_load_dwordx4` 的停顿,但——

```bash
$ grep -c global_load kernel_gemm_0/21_final_isa.s
0
```

**我们的 kernel 里根本没有这条指令。** 出现了不该有的 opcode,就说明混进了别的 kernel。

**自查方法**:先跑 `--list` 看每个 dispatch 的指令构成:

```bash
$ ./pc_sampling_report.py out/pc_pc_sampling_stochastic.csv --list

  DISPATCH  SAMPLES   TOP OPCODES
------------------------------------------------------------------
       144     1059   buffer_store_short(384), v_mfma_scale(161), ...
       143      762   buffer_store_short(274), buffer_load_dwordx4(120), ...
       145      740   buffer_store_short(258), buffer_load_dwordx4(129), ...
        72      660   s_waitcnt(251), s_barrier(109), s_load_dwordx4(40)   ← 不是我们的
         4      541   s_waitcnt(174), s_barrier(49), s_or_b64(47)          ← 不是我们的
       146      445   v_mfma_scale(105), buffer_store_short(89), ...
```

一眼就能看出 143~146 是我们的(有 `v_mfma_scale` 和 `buffer_load_dwordx4`),72 和 4 是别人的。

**锁定方法**:用你 kernel 独有的指令自动反查:

```bash
./pc_sampling_report.py ... --match v_mfma_scale
# --match 'v_mfma_scale' -> dispatch 143,144,145,146
```

---

## 4. 读懂 `Stall_Reason`

拿到干净数据后,核心是这一列。**最关键的是分清两个 ARBITER:**

| 值 | 含义 | 说明 |
|---|---|---|
| **`ARBITER_WIN_EX_STALL`** | **赢了仲裁,但执行单元不收** | **← 这才是发射停顿**,对应 `SQ_VMEM_TA_*_FIFO_FULL` |
| `ARBITER_NOT_WIN` | 没抢到发射槽 | wave 之间竞争,**是另一回事** |
| `WAITCNT` | 等 `s_waitcnt` | **延迟**问题,不是发射问题 |
| `BARRIER_WAIT` | 等 `s_barrier` | 同步开销 |
| `ALU_DEPENDENCY` | 等前序指令结果 | |
| `NO_INSTRUCTION_AVAILABLE` | 取指跟不上 | I-cache 压力 |

> **`ARBITER_WIN_EX_STALL` 是 "won arbitration, execution stall" 的缩写。**
> 语义是:调度器已经选中了这条指令,但**下游单元(TA / LDS / MFMA)满了不肯收**。
> 这正是 [01 §1.2](01-vmem-issue-stalls.md) 讲的 SQ→TA FIFO 满。

---

## 5. 本案例的结果

### 5.1 停顿原因分布(n=2232)

```
ARBITER_WIN_EX_STALL     1488   66.7%   ###############################
BARRIER_WAIT              333   14.9%   #######
ALU_DEPENDENCY            208    9.3%   ####
WAITCNT                   189    8.5%   ####
NO_INSTRUCTION_AVAILABLE    9    0.4%
ARBITER_NOT_WIN             4    0.2%
```

**发射侧 66.7% vs 延迟侧 8.5%,相差 7.9 倍。**

两个值得注意的数:

- **`WAITCNT` 只有 8.5%** —— 这个 kernel 已经把 32 条 load 堆在飞行中,延迟掩盖得很好
- **`ARBITER_NOT_WIN` 只有 0.2%** —— wave 之间几乎没有仲裁竞争,卡的全是「抢到了却发不出去」

### 5.2 停顿落在哪些指令上

| 样本数 | 占比 | 指令 | 是什么 |
|---|---|---|---|
| **813** | **54.6%** | `buffer_store_short` | epilogue,每 wave 256 条,每 lane 只写 2B |
| **377** | **25.3%** | `buffer_load_dwordx4` | G2S 主数据,direct-to-LDS,每 wave 64 条 |
| 172 | 11.6% | `v_mfma_scale_f32_16x16x128` | MFMA |
| 62 | 4.2% | `buffer_load_dword` | scale 加载,每 wave 32 条 |

**VMEM 指令占 `ARBITER_WIN_EX_STALL` 的 84.1%** —— 和 PMC 说的「VMEM 发射被 TA 堵住」完全一致。

### 5.3 和 PMC 模型互相印证

这是 PC Sampling 最有价值的地方 —— 它给出了 PMC 给不了的**排序**:

| | 浪费倍数([01 §1.5](01-vmem-issue-stalls.md)) | PC 停顿样本 | 结论 |
|---|---|---|---|
| store | **2.0** | **813(最多)** | **两个独立方法都指向它** |
| G2S | 1.0 | 377 | 量大但零浪费,不可优化 |
| scale | 1.0 | 62 | 单条最优,只能减条数 |

**store 既是浪费倍数最高的,也是实测停顿样本最多的。** 两条独立证据交叉验证,优化顺序就很明确了。

---

## 6. 那要不要先跑 PC Sampling?

一个自然的想法:它能直接指到指令,是不是应该先跑?**实测答案是否定的。**

| | PMC | PC Sampling |
|---|---|---|
| 耗时 | **6.7 s** | 10.7 s |
| 统计 | 全量,1280 万周期 | 抽样,2232 个有效样本 |
| 误差 | 无 | ±2.0%(95% CI) |
| 阈值 | **有**(≥10%) | **无** |
| 陷阱 | 分母要选对 | **两道过滤,漏了结论反向** |

三个理由:

1. **更慢**,"更快"是错觉
2. **是抽样**:要好精度就得加密采样、跑更久
3. **没有基准**:拿到「66.7%」你不知道算不算高;PMC 有官方的 ≥10% 判据

**推荐流程:**

```
PMC 定方向  →  PC Sampling 定位置  →  两者一致才可信
```

不一致的话,说明有一方的理解错了(比如漏了过滤),继续查。

---

## 7. 工具用法

[`pc_sampling_report.py`](pc_sampling_report.py) 把 csv 聚合成 6 张表:停顿原因、`ARBITER_WIN_EX_STALL` 按指令分解、全部停顿指令、原因×指令矩阵、指令类型分布、热点 PC。

```bash
# 列出所有 dispatch 及其指令构成(先做这步!)
./pc_sampling_report.py sample.csv --list

# 用独有指令自动锁定
./pc_sampling_report.py sample.csv --match v_mfma_scale -o report.txt

# 或直接指定 dispatch id
./pc_sampling_report.py sample.csv --dispatch 143,144,145,146 -o report.txt
```

误用 `host_trap` 的数据会直接报错并提示原因,而不是给出无意义的结果。

---

## 参考

- [PC Sampling 官方文档](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/how-to/pc_sampling.html)
- [01 · 当 vmcnt 不是瓶颈:用 PMC 定位 VMEM 发射停顿](01-vmem-issue-stalls.md)
- 本案例完整报告:[`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt)
