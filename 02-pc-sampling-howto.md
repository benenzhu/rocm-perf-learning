# 02 · PC Sampling 实战:定位到具体哪条指令在停

> 平台:AMD Instinct MI355X (gfx950 / CDNA4),ROCm `rocprofv3`
> 案例:同 [01](01-vmem-issue-stalls.md) —— MXFP4 GEMM kernel
> 配套工具:[`pc_sampling_report.py`](pc_sampling_report.py) · 输出样例:[`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt)

---

## TL;DR

```bash
# 1. 采样 —— 必须同时加 --kernel-trace,否则无法知道样本属于哪个 kernel
rocprofv3 --pc-sampling-beta-enabled --pc-sampling-method stochastic \
          --pc-sampling-unit cycles --pc-sampling-interval 65536 \
          --kernel-trace \
          --output-format csv -d out -o pc -- ./your_app

# 2. 看采到了哪些 kernel
./pc_sampling_report.py out/pc_pc_sampling_stochastic.csv \
    --kernel-trace out/pc_kernel_trace.csv --list

# 3. 按 kernel 名过滤,生成报告
./pc_sampling_report.py out/pc_pc_sampling_stochastic.csv \
    --kernel-trace out/pc_kernel_trace.csv \
    --kernel kernel_gemm --title "my_kernel" -o report.txt
```

**最容易踩的坑:`--kernel-include-regex` 不过滤 PC sampling 数据流,而 PC sampling 的 csv 里又没有 `Kernel_Name` 列。** 必须靠 `--kernel-trace` 把 `Dispatch_Id` 翻译成 kernel 名。不做这一步,本案例的结论会从「发射受限 68.8%」变成「延迟受限 79%」——**完全相反**。

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
> **用 65536 能拿到 2909 个**,精度从 ±5.2% 提到 ±1.7%。

---

## 3. ⚠️ 两道过滤,少一道结论就反了

**这是全文最重要的一节。** 我第一次做这个分析时漏了第二道,得出了完全错误的结论。

### 3.1 第一道:丢掉 PC 解析不出来的行

```
Instruction 字段为空 → PC 落在无法解析的 code object 上
```

本例 9656 个原始样本里有 **1787 个**是这种。

### 3.2 第二道:只保留本 kernel 的样本

两个事实叠加造成了这个坑:

```
① --kernel-include-regex 不过滤 PC sampling 数据流
② PC sampling 的 csv 里没有 Kernel_Name 列,只有 Dispatch_Id
```

**即使命令行加了 `--kernel-include-regex "kernel_gemm"`,进程里所有 kernel 的样本照样进 csv**;而你光看这个 csv 又无法知道哪个 dispatch 是谁的。

**正解:采样时同时开 `--kernel-trace`**,它会生成一份 `Dispatch_Id → Kernel_Name` 的对照表,join 一下就能精确分离:

```bash
rocprofv3 --pc-sampling-beta-enabled --pc-sampling-method stochastic \
          --pc-sampling-unit cycles --pc-sampling-interval 65536 \
          --kernel-trace \
          --output-format csv -d out -o pc -- ./your_app
# → out/pc_pc_sampling_stochastic.csv   样本
# → out/pc_kernel_trace.csv             Dispatch_Id -> Kernel_Name
```

本例的实际构成:

```
9853 个原始样本
├─ 1925  PC 无法解析                             → 丢
├─ 4147  来自 PyTorch 其他算子(reduce/elementwise 等)  → 丢   ← 占一半!
└─ 3781  来自 kernel_gemm_0(dispatch 143~147)  ← 只有这些有效
```

### 3.3 漏掉第二道会怎样

| | 只过滤一道(错) | 两道都做(对) |
|---|---|---|
| `WAITCNT` | **79.0%** | 9.5% |
| `ARBITER_WIN_EX_STALL` | 9.4% | **68.8%** |
| 结论 | 「延迟受限」 | 「**发射受限**」 |

**完全相反。** 那 79% 的 WAITCNT 全是 PyTorch 量化算子的,和被测 kernel 毫无关系。

### 3.4 怎么发现自己踩了坑

我是靠**指令对不上**发现的:报告里出现了 `global_load_dwordx4` 的停顿,但——

```bash
$ grep -c global_load kernel_gemm_0/21_final_isa.s
0
```

**我们的 kernel 里根本没有这条指令。** 出现了不该有的 opcode,就说明混进了别的 kernel。

**用 `--list` 看采到了哪些 kernel**(有 `--kernel-trace` 时显示真实名字):

```bash
$ ./pc_sampling_report.py out/pc_pc_sampling_stochastic.csv \
      --kernel-trace out/pc_kernel_trace.csv --list

 SAMPLES   KERNEL
------------------------------------------------------------------
    3781   kernel_gemm_0                             ← 我们的
    1052   void at::native::reduce_kernel<512, 1, ...
     676   void at::native::elementwise_kernel_manual_unroll<128, ...
     366   void at::native::vectorized_elementwise_kernel<4, ...
```

### 3.5 ⚠️ 别用"独有指令"这种启发式来猜

我第一版工具是这么做的:**找出含有 `v_mfma_scale` 的 dispatch,认为那就是我们的 kernel**。看起来能work,实际上有两个问题:

**问题一:别的 kernel 可能共用同样的 opcode。** `buffer_load_dwordx4`、`buffer_store_short` 这种通用指令到处都是,一旦选中的"特征指令"不够独特,就会混入别人的样本——而你不会收到任何警告。

**问题二:会漏掉 dispatch。** 实测对比:

```
权威(--kernel-trace):  23 个 dispatch  ← kernel_gemm 一共被调用 23 次
启发式(--match)    :   5 个 dispatch  ← 只有采到样本的那几个
漏掉的: 148 ~ 165
```

本例恰好漏掉的那 18 个 dispatch 采样数都是 0(因为 PC sampling 是抽样,不是每次 dispatch 都被采到),所以样本数一致。**但这是运气,不是保证** —— 换个采样间隔或运行时长就可能漏掉真实样本。

**结论:始终用 `--kernel-trace`。** 工具保留了 `--dispatch` 手动指定作为兜底,但没有 kernel trace 时会打印警告。

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

### 5.1 停顿原因分布(n=2909)

```
ARBITER_WIN_EX_STALL     2002   68.8%   ################################
BARRIER_WAIT              396   13.6%   ######
WAITCNT                   275    9.5%   ####
ALU_DEPENDENCY            222    7.6%   ####
NO_INSTRUCTION_AVAILABLE    9    0.3%
ARBITER_NOT_WIN             5    0.2%
```

**发射侧 68.8% vs 延迟侧 9.5%,相差 7.2 倍。**

两个值得注意的数:

- **`WAITCNT` 只有 9.5%** —— 这个 kernel 已经把 32 条 load 堆在飞行中,延迟掩盖得很好
- **`ARBITER_NOT_WIN` 只有 0.2%** —— wave 之间几乎没有仲裁竞争,卡的全是「抢到了却发不出去」

### 5.2 停顿落在哪些指令上

| 样本数 | 占比 | 指令 | 是什么 |
|---|---|---|---|
| **1078** | **53.8%** | `buffer_store_short` | epilogue,每 wave 256 条,每 lane 只写 2B |
| **464** | **23.2%** | `buffer_load_dwordx4` | G2S 主数据,direct-to-LDS,每 wave 64 条 |
| 223 | 11.1% | `v_mfma_scale_f32_16x16x128` | MFMA |
| 114 | 5.7% | `buffer_load_dword` | scale 加载,每 wave 32 条 |

**VMEM 指令占 `ARBITER_WIN_EX_STALL` 的 83%** —— 和 PMC 说的「VMEM 发射被 TA 堵住」完全一致。

### 5.3 和 PMC 模型互相印证

这是 PC Sampling 最有价值的地方 —— 它给出了 PMC 给不了的**排序**:

| | 浪费倍数([01 §1.5](01-vmem-issue-stalls.md)) | PC 停顿样本 | 结论 |
|---|---|---|---|
| store | **2.0** | **1078(最多)** | **两个独立方法都指向它** |
| G2S | 1.0 | 464 | 量大但零浪费,不可优化 |
| scale | 1.0 | 114 | 单条最优,只能减条数 |

**store 既是浪费倍数最高的,也是实测停顿样本最多的。** 两条独立证据交叉验证,优化顺序就很明确了。

---

## 6. 那要不要先跑 PC Sampling?

一个自然的想法:它能直接指到指令,是不是应该先跑?**实测答案是否定的。**

| | PMC | PC Sampling |
|---|---|---|
| 耗时 | **6.7 s** | 10.7 s |
| 统计 | 全量,1280 万周期 | 抽样,2909 个有效样本 |
| 误差 | 无 | ±1.7%(95% CI) |
| 阈值 | **有**(≥10%) | **无** |
| 陷阱 | 分母要选对 | **两道过滤,漏了结论反向** |

三个理由:

1. **更慢**,"更快"是错觉
2. **是抽样**:要好精度就得加密采样、跑更久
3. **没有基准**:拿到「68.8%」你不知道算不算高;PMC 有官方的 ≥10% 判据

**推荐流程:**

```
PMC 定方向  →  PC Sampling 定位置  →  两者一致才可信
```

不一致的话,说明有一方的理解错了(比如漏了过滤),继续查。

---

## 7. 工具用法

[`pc_sampling_report.py`](pc_sampling_report.py) 把 csv 聚合成 6 张表:停顿原因、`ARBITER_WIN_EX_STALL` 按指令分解、全部停顿指令、原因×指令矩阵、指令类型分布、热点 PC。

```bash
# 列出采到了哪些 kernel(先做这步!)
./pc_sampling_report.py sample.csv --kernel-trace trace.csv --list

# 按 kernel 名过滤(推荐)
./pc_sampling_report.py sample.csv --kernel-trace trace.csv \
    --kernel kernel_gemm -o report.txt

# 兜底:手动指定 dispatch id(没有 kernel trace 时会警告)
./pc_sampling_report.py sample.csv --dispatch 143,144,145,146 -o report.txt
```

两个防呆:误用 `host_trap` 数据会直接报错提示换 stochastic;不带 `--kernel-trace` 用 `--dispatch` 会警告无法验证这些 dispatch 是否属于同一个 kernel。

---

## 参考

- [PC Sampling 官方文档](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/how-to/pc_sampling.html)
- [01 · 当 vmcnt 不是瓶颈:用 PMC 定位 VMEM 发射停顿](01-vmem-issue-stalls.md)
- 本案例完整报告:[`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt)
