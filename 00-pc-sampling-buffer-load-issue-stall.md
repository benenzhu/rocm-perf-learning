# 00 · ROCm Profiler PC Sampling 笔记:如何定位 buffer_load issue stall

> 平台:AMD Instinct MI355X (gfx950 / CDNA4)
> 工具:`rocprof-compute` / `rocprofv3`(两条路径都讲,§7 对比)
> 案例:一个真实的 MXFP4 GEMM kernel(M=N=K=8192,~4500 TFLOPS)
> 配套:[`pc_sampling_report.py`](pc_sampling_report.py) · 报告样例 [`pc-sampling-official.txt`](pc-sampling-official.txt)

**这是本系列的开篇。** 想找 kernel 的性能问题,PC Sampling 通常是最快的第一步——它直接告诉你**哪条指令在停、为什么停**,不需要先猜是哪个硬件单元。

想进一步搞清楚"为什么这条指令会停"、以及硬件层面的量化模型,看 [01 · 用 PMC 定位 VMEM 发射停顿](01-vmem-issue-stalls.md)。

---

## TL;DR

```bash
# 1. 采样。四个 flag 缺一不可:
#    --pc-sampling-beta-enabled   PC sampling 目前是 beta,不加不生效
#    --pc-sampling-method stochastic   只有它给停顿原因(host_trap 没有)
#    --pc-sampling-interval 65536      cycles 单位下必须是 2 的幂且 >= 65536
#    --kernel-trace                    ★ 否则无法知道样本属于哪个 kernel
rocprofv3 --pc-sampling-beta-enabled \
          --pc-sampling-method stochastic \
          --pc-sampling-unit cycles --pc-sampling-interval 65536 \
          --kernel-trace \
          --output-format csv -d out -o pc -- ./your_app
# 产出: out/pc_pc_sampling_stochastic.csv   样本
#       out/pc_kernel_trace.csv             Dispatch_Id -> Kernel_Name

# 2. 看采到了哪些 kernel(先做这步,能立刻看出混入了多少别人的样本)
./pc_sampling_report.py out/pc_pc_sampling_stochastic.csv \
    --kernel-trace out/pc_kernel_trace.csv --list

# 3. 按 kernel 名过滤,生成报告
./pc_sampling_report.py out/pc_pc_sampling_stochastic.csv \
    --kernel-trace out/pc_kernel_trace.csv \
    --kernel kernel_gemm -o report.txt
```

第 2 步的输出长这样,一眼能看出问题的严重程度:

```
 SAMPLES   KERNEL
    3399   kernel_gemm_0                                   ← 我们要的
    1205   void at::native::elementwise_kernel_manual_...  ← 混入的
    1071   void at::native::reduce_kernel<512, 1, ...      ← 混入的
```

**最容易踩的坑:`--kernel-include-regex` 不过滤 PC sampling 数据流**(§3.2 有源码依据),
**而 PC sampling 的 csv 里又没有 `Kernel_Name` 列**——只能靠 `--kernel-trace` 把
`Dispatch_Id` 翻译成 kernel 名。不做这一步,本案例的结论会从「发射受限 68.8%」
变成「延迟受限 79%」——**完全相反**。

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
本文用 PC Sampling 定位到具体指令;[01](01-vmem-issue-stalls.md) 用 PMC 从硬件单元的角度独立验证同一结论,两者互为交叉印证。

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

> 💡 **用官方 `rocprof-compute analyze -k 0` 可以完全跳过这一节**——它内置了 kernel 过滤。
> 见 [§7](#7-另一条路官方-rocprof-compute)。本节针对的是直接用 `rocprofv3` 的情况。

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

> **这不是 bug,是设计如此。** 查源码可以确认(`rocprofv3` 本身是个 Python 脚本,
> 只把参数转成环境变量,真正的过滤在 C++ 库里):
>
> **① 官方 help 原文就限定了作用范围**——只承诺这两类数据:
> > *"Include the kernels matching this filter from **counter-collection and thread-trace** data"*
>
> **② C++ 侧的过滤函数 `is_targeted_kernel()` 全文只有 4 个调用点**
> (`rocprofiler-sdk/source/lib/rocprofiler-sdk-tool/tool.cpp`):
>
> | 行号 | 函数 | 数据流 |
> |---|---|---|
> | 1769 | `att_dispatch_callback` | thread trace |
> | 1800 | `att_dispatch_consecutive_kernel_callback` | thread trace |
> | 1869 | `counter_dispatch_callback` | **PMC** |
> | 2003 | `spm_dispatch_callback` | SPM |
>
> **`pc_sampling_callback()`(同文件 1659 行)里一次都没调用它。**
>
> 想想也合理:PC sampling 是**周期性硬件采样**,采的是"此刻各 wave 的 PC",
> 而不是"per-dispatch 收集数据"——它没有一个天然的时机去判断"这次 dispatch 要不要采"。
> 所以**别浪费时间试各种 flag 组合,老老实实用 `--kernel-trace` join**。

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

## 7. 另一条路:官方 `rocprof-compute`

前面用的是 `rocprofv3` 直接采集。官方还有一条更完整的路径,**它有两个 `rocprofv3` 给不了的东西**。

```bash
# 采集
rocprof-compute profile -n pcs --experimental --pc-sampling \
    --pc-sampling-method stochastic --pc-sampling-interval 65536 -- ./your_app

# 分析(-k 0 = 只看 Top Stats 里第 0 个 kernel)
rocprof-compute analyze -p workloads/pcs/MI355 -k 0 \
    --pc-sampling-sorting-type count --pc-sampling-rows 0
```

输出长这样,每行是**一个 PC 地址**:

```
│ index │ source_line │ instruction        │ offset │ count │ count_issued │ count_stalled │ stall_reason        │ Kernel_Name   │
│  1546 │ N/A         │ s_waitcnt vmcnt(0) │ 0x46bc │   144 │            0 │           144 │ [('WAITCNT', 144)]  │ kernel_gemm_0 │
```

### 7.1 官方独有的两件事

**① `-k 0` 内置 kernel 过滤。** §3 那两道过滤的麻烦,官方 analyze 层已经处理好了——输出直接带 `Kernel_Name` 列。**如果你用官方路径,可以跳过 §3 的全部折腾。**

**② `count_issued` / `count_stalled` 拆分。** 这个很有价值:

```
INSTRUCTION                          COUNT  ISSUED  STALLED   STALL%
buffer_store_short                    1367      77     1290    94.4%
buffer_load_dwordx4                    522      35      487    93.3%
v_mfma_scale_f32_16x16x128_f8f6f4      522     284      238    45.6%
v_accvgpr_read_b32                      86      74       12    14.0%
```

**同一条指令被采样时,有多大比例发不出去。** VMEM 指令 86~94%,VALU 只有 14% —— 这是**每条指令的健康度**,PMC(按硬件单元统计)和只看停顿样本的统计都给不了。

另外还有 `source_line` 列,用 `-g` 编译时能映射回源码行号。

### 7.2 官方缺的:全局聚合

官方输出是**每个 PC 一行**(本例 1126 行),是原始素材而非结论。你没法直接看出:

- 「发射受限占 69.3%」—— 要把 1126 行的 `stall_reason` 全拆开累加
- 「`buffer_store_short` 占 `ARBITER_WIN_EX_STALL` 的 55%」—— 同一 opcode 散落在几百行里

而这两个恰恰是**判断方向和选优化目标**的关键。

> ⚠️ **聚合时用 `count_stalled`,别直接累加 `stall_reason` 列。**
> 该列里混了 `OTHER_WAIT`,数量约等于 issued 总数(本例 892 vs 891)——
> 它其实是"没停顿"。直接累加会把 `ARBITER_WIN_EX_STALL` 从 **69.3%** 稀释到 **52.9%**。

### 7.3 工具:两种输入都支持

[`pc_sampling_report.py`](pc_sampling_report.py) 补的就是这层聚合:

```bash
# 输入 rocprof-compute analyze 的报告(推荐)
rocprof-compute analyze -p workloads/pcs/MI355 -k 0 \
    --pc-sampling-sorting-type count --pc-sampling-rows 0 > analyze.txt
./pc_sampling_report.py analyze.txt --from-analyze -o report.txt

# 或输入 rocprofv3 的 csv
./pc_sampling_report.py sample.csv --kernel-trace trace.csv --list
./pc_sampling_report.py sample.csv --kernel-trace trace.csv \
    --kernel kernel_gemm -o report.txt
```

`--from-analyze` 模式额外输出 §7.1 那张**停顿率表**。
输出样例:[`pc-sampling-official.txt`](pc-sampling-official.txt)(官方数据)·
[`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt)(rocprofv3 数据)

### 7.4 两条路怎么选

| | `rocprofv3` + 脚本 | `rocprof-compute` |
|---|---|---|
| 依赖 | **零**(ROCm 自带) | 重,见下 |
| kernel 过滤 | 手动 join `--kernel-trace` | ✅ **`-k 0` 内置** |
| 停顿率(issued/stalled) | ❌ | ✅ |
| `source_line` 映射 | ❌ | ✅(需 `-g`) |
| Top Stats / System Info | ❌ | ✅ 同一份报告 |
| 全局聚合 | ✅ | ❌ 需自己算 |

**两者数据一致**,互为验证:

```
官方   : ARBITER_WIN_EX_STALL = 1992/2876 = 69.3%
rocprofv3: ARBITER_WIN_EX_STALL = 2002/2909 = 68.8%
```

**建议:能装 `rocprof-compute` 就用官方**(`-k 0` 省掉一大堆过滤麻烦,还多两个维度),用脚本的 `--from-analyze` 补聚合。环境受限时 `rocprofv3` 直采是等价的备选。

> **实测安装成本**(ROCm 7.2.4 自带的是 3.4.0,没有 PC sampling,需要用仓库里的 3.8.0):
> 1. **不能 `pip install -e .`** —— `pyproject.toml` 里只有 ruff 配置,没有 `[build-system]`。直接 `python3 src/rocprof-compute` 运行
> 2. **`src/vendored/pyyaml/` 是空的**(正常由 CMake 填充)→ 软链到系统 pyyaml:
>    `ln -s $(python3 -c "import yaml,os;print(os.path.dirname(yaml.__file__))") src/vendored/pyyaml/lib/yaml`
> 3. **缺 `libdw-dev`**,且 `json` 子模块 clone 会卡住 → `apt install libdw-dev` + 手动 `git clone --depth 1 https://github.com/nlohmann/json.git src/lib/external/json`
> 4. **analyze 模式的版本锁很严**(且是字符串比较,`tabulate 0.10.0 >= 0.9.0` 也判失败)。
>    它优先读 `src/requirements.txt`,该文件默认不存在——**放一份去掉版本号的进去即可**,
>    不用改代码也不用降级任何已装的包:
>    `sed -E 's/^([a-zA-Z0-9_-]+)[><=]+.*/\1/' requirements.txt > src/requirements.txt`

---

## 参考

- [PC Sampling 官方文档](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/how-to/pc_sampling.html)
- [01 · 当 vmcnt 不是瓶颈:用 PMC 定位 VMEM 发射停顿](01-vmem-issue-stalls.md)
- 本案例完整报告:[`pc-sampling-official.txt`](pc-sampling-official.txt)(官方路径)·
  [`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt)(rocprofv3 路径)
