# 00 · ROCm Profiler PC Sampling 笔记:如何定位 buffer_load issue stall

> 平台:AMD Instinct MI355X (gfx950 / CDNA4)
> 工具:`rocprof-compute` / `rocprofv3`(两条路径都讲,§6 对比)
> 案例:一个真实的 MXFP4 GEMM kernel(M=N=K=8192,~4500 TFLOPS)
> 配套:[`pc_sampling_report.py`](pc_sampling_report.py) · 报告样例 [`pc-sampling-official.txt`](pc-sampling-official.txt)

---

## 0. 为什么不用 ATT?

经常在 ROCm 上写 kernel、调 kernel 的人,对 **ATT(Advanced Thread Trace)** 应该都不陌生。它能给出 GPU 硬件上**每条指令的实际执行顺序**、**每条指令 issue 了多久**,以及**哪里 stall 了**。对照着改代码、定位瓶颈,非常方便。

官方文档([Thread trace](https://rocm.docs.amd.com/projects/rocprofiler-sdk/en/latest/how-to/using-thread-trace.html))里那张表大致是这样的:

| Codeobj | Vaddr | Instruction | Hitcount | **Latency** | **Stall** | **Idle** | Source |
|---|---|---|---|---|---|---|---|

- **Latency** = Stall time + Issue time(gfx9)
- **Stall** = 硬件管线发不出指令的周期数
- **Idle** = 上一条指令结束到这一条开始之间的空隙

但最近用下来,发现它有两个绕不过去的局限。

### 0.1 局限一:知道 stall 了,但不知道**为什么** stall

ATT 会告诉你某条指令 stall 了多少个周期,**却不告诉你原因**。

比如下图这种情况——`buffer_load` 经常卡很久,前后没有任何说明,而且是**随机**卡:

<!-- TODO: 补图 1 —— ATT trace 中 buffer_load 长时间 stall 的截图 -->

官方对 Stall 列的解释只有一句:

> *"Usually caused when the hardware unit is busy, such as **TCP or LDS backpressure**."*

"通常是下游单元忙" —— 这句话本身没错,但**到底是 TCP 满了、LDS 满了、TLB 在翻译、还是 L2 反压回来了?ATT 看不出来。** 而这几种原因的修法完全不同,甚至相反(见 [01](01-vmem-issue-stalls.md))。

我们真正想知道的是:**它为什么会 stall。**

### 0.2 局限二:那段空白到底是什么?

第二个问题更让人困惑:代码里每隔一段(比如循环边界、跨 code object 调用),**ATT 里会出现一段空白**。

<!-- TODO: 补图 2 —— ATT trace 中出现空白段的截图 -->

这段空白的成因有好几种可能:

- **I-cache miss** —— 取指跟不上(官方把它列在 Idle 的成因里)
- **ATT 自身的局限** —— 它只能追踪 **每个 SE 的一个 CU**(`att-target-cu`),采样窗口有限
- **ATT 的 overhead** —— trace 缓冲区写满、或者 trace 本身的开销

之前我一直倾向于认为是 I-cache miss,但**没有办法证实**。而这三种原因,一种是真问题、两种是测量假象——搞错了就是白优化。

### 0.3 这就是引入 PC Sampling 的理由

**PC Sampling 恰好补上了 ATT 缺的那一块:它直接给出 `Stall_Reason`。**

```
ARBITER_WIN_EX_STALL      赢了仲裁,但执行单元不收   → 发射受限
ARBITER_NOT_WIN           没抢到发射槽              → wave 之间竞争
WAITCNT                   等 s_waitcnt              → 延迟问题
NO_INSTRUCTION_AVAILABLE  取指跟不上                → I-cache 压力  ← 能验证 0.2 的猜想
BARRIER_WAIT              等 s_barrier              → 同步开销
```

同一条 `buffer_load`,ATT 说"它 stall 了 N 个周期",PC Sampling 说"**它 stall 是因为赢了仲裁但 TA 不收**"——后者才能直接指向修法。

而且 `NO_INSTRUCTION_AVAILABLE` 这个原因,正好能用来验证 §0.2 那段空白到底是不是 I-cache miss。

**两者是互补的**:ATT 给时间线和顺序,PC Sampling 给原因分布。

| | ATT | PC Sampling |
|---|---|---|
| 指令执行顺序 / 时间线 | ✅ | ❌ |
| 每条指令 stall 多久 | ✅ | ❌(只有相对占比) |
| **stall 的原因** | ❌ | ✅ |
| 覆盖范围 | 每 SE 一个 CU | 全 GPU 抽样 |

---

**本篇讲怎么用 ROCm 的 PC Sampling。** 下一篇 [01](01-vmem-issue-stalls.md) 讲 PMC ——
当 PC Sampling 告诉你"下游单元不收"之后,**用哪些 counter 能查出到底是从哪一级反压回来的**。

---

## 1. 三个工具,各回答一个问题

§0 说了 ATT 和 PC Sampling 的互补关系。把 PMC 也放进来,三者的分工是这样的:

| 工具 | 回答的问题 | 粒度 | 数据性质 |
|---|---|---|---|
| **ATT** | 指令**按什么顺序**执行、各停了多久 | 时间线 | 每 SE 一个 CU |
| **PC Sampling** | **哪条指令**在停、**为什么**停 | 具体指令 | 全 GPU 抽样 |
| **PMC** | **哪个硬件单元**是瓶颈、超没超阈值 | 硬件单元 | 全量计数 |

一个典型的排查链条:

```
ATT          看到 buffer_load 卡了很久,但不知道为什么
   ↓
PC Sampling  ARBITER_WIN_EX_STALL —— 赢了仲裁但执行单元不收
   ↓
PMC          SQ_VMEM_TA_CMD_FIFO_FULL 27.2% —— 是 TA 的队列满了
             TA_ADDR_STALLED_BY_TC 0.9%    —— 且 TA 不是被下游堵的
   ↓
结论         TA 自己活太多 → 减少 VMEM 指令数 / 提高合并度
```

**本篇走第二步**,[01](01-vmem-issue-stalls.md) 走第三步。

PC Sampling 相对 PMC 的取舍(§5 有实测):

| | PMC | PC Sampling |
|---|---|---|
| 数据 | 全量计数,无误差 | 抽样,有置信区间 |
| 阈值 | 有官方判据(≥10%) | 无,只有相对占比 |
| 开销(本例) | 6.7 s | 10.7 s |

---

## 2. 用 stochastic 模式

`--pc-sampling-method` 有两个取值,**必须选 `stochastic`**(MI300+ 支持):它是硬件采样,输出里带这三列——

```
Wave_Issued_Instruction    这次采样时,该指令发出去了没有
Instruction_Type           VALU / TEX / MATRIX / ...
Stall_Reason               ★ 没发出去的话,为什么          ← 全文的核心
```

另一个模式 `host_trap` 是软件定时中断,**输出里没有 `Stall_Reason`**,只能告诉你 PC 分布(哪里热)、给不出原因——那正是 §0 里 ATT 已经能做的事。所以本文不用它。

### ⚠️ 采样间隔:不要往小了调

`--pc-sampling-interval` 在 `cycles` 单位下必须是 2 的幂且 ≥65536。直觉是"调小 → 样本多 → 更准",**但这个直觉在这里是错的**。

同一个 kernel(K=8192,基线 242 µs)实测三种配置:

| 间隔 | 迭代 | stalled 样本 | 精度 | kernel 中位时长 | **相对基线** |
|---|---|---|---|---|---|
| **65536** | 40 | 285 | ±5.5% | **19,576 µs** | **慢 80 倍** ❌ |
| 262144 | 40 | 8,436 | ±1.0% | 285 µs | 1.18× |
| **1048576** | **250** | **11,889** | **±0.8%** | **236 µs** | **≈1.0×** ✅ |

**间隔调到 65536 反而只拿到 285 个样本。** 原因是雪崩式的:采样太密 → kernel 被拖慢 80 倍 → 单次 dispatch 长达 130 ms → **采样缓冲区在第一次 dispatch 就写满**,后面 42 次一个样本都没采到。样本全部来自那一次被严重扭曲的执行。

而稀疏采样几乎零开销(236 vs 242 µs,在噪声内),252/253 次 dispatch 全覆盖。

> **正确做法:保持默认的 1048576,靠增加迭代次数补样本量。**
> 三个间隔的停顿原因分布是一致的(65.5% / 66.6% / 67.4%),
> **稀疏采样只是样本少,不会引入系统性偏差**——多跑几遍就补回来了。

> 怎么发现自己踩了这个坑:对比 `--kernel-trace` 里的 kernel 时长和你已知的基线。
> 差一个数量级就说明采样开销已经扭曲了被测对象。

## 3. 读懂 `Stall_Reason`

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

## 4. 本案例的结果

### 4.1 停顿原因分布(n=11376)

```
ARBITER_WIN_EX_STALL     7536   66.2%   ##############################
ALU_DEPENDENCY           2222   18.7%   #########
WAITCNT                  1032    8.7%   ####
BARRIER_WAIT              418    3.5%   ##
NO_INSTRUCTION_AVAILABLE  156    1.3%   #
ARBITER_NOT_WIN            43    0.4%
```

**发射侧 66.2% vs 延迟侧 8.7%,相差 7.6 倍。**

三个值得注意的数:

- **`WAITCNT` 只有 8.7%** —— 这个 kernel 已经把 32 条 load 堆在飞行中,延迟掩盖得很好
- **`ARBITER_NOT_WIN` 只有 0.2%** —— wave 之间几乎没有仲裁竞争,卡的全是「抢到了却发不出去」
- **`NO_INSTRUCTION_AVAILABLE` 只有 1.3%** —— **这回答了 §0.2 那个问题**:
  ATT 里那些空白段,在这个 kernel 上**不是 I-cache miss**(取指几乎没有停顿),
  更可能是 ATT 自身的采样局限。同样的方法可以用来验证你自己 kernel 里的空白段。

### 4.2 停顿落在哪些指令上

| 样本数 | 占比 | 指令 | 是什么 |
|---|---|---|---|
| **4324** | **57.4%** | `v_mfma_scale_f32_16x16x128` | MFMA,每 wave 2048 条 |
| **1185** | **15.7%** | `buffer_load_dwordx4` | G2S 主数据,direct-to-LDS,每 wave 512 条 |
| 855 | 11.3% | `buffer_store_short` | epilogue,每 wave 256 条,每 lane 只写 2B |
| 771 | 10.2% | `buffer_load_dword` | scale 加载,每 wave 256 条 |

**VMEM 指令合计占 `ARBITER_WIN_EX_STALL` 的 37%,MFMA 占 57%。**

> ⚠️ **这个排序对 K 很敏感,值得单独说明。**
> epilogue 的 store 数量**不随 K 变化**(固定每 wave 256 条),而 G2S / scale / MFMA 都随 K 线性增长:
>
> | | K=1024 | K=8192 |
> |---|---|---|
> | G2S | 64 | 512 |
> | scale | 32 | 256 |
> | store | **256** | **256**(不变) |
> | MFMA | 256 | 2048 |
> | store 占 VMEM 指令 | **73%** | **25%** |
>
> 所以 **K 小的时候 store 是主要瓶颈,K 大的时候 MFMA 和 G2S 才是**。
> 分析结论必须绑定具体 shape——换个 K 优化目标就变了。

### 4.3 和 PMC 模型互相印证

这是 PC Sampling 最有价值的地方 —— 它给出了 PMC 给不了的**排序**:

| | 浪费倍数([01 §1.5](01-vmem-issue-stalls.md)) | PC 停顿样本 | 每条指令停顿率 | 结论 |
|---|---|---|---|---|
| G2S | 1.0 | **1185** | 64.5% | 量大但零浪费 |
| store | **2.0** | 855 | **83.5%** | 浪费最高、停顿率最高 |
| scale | 1.0 | 771 | 79.4% | 单条最优,只能减条数 |

三个 VMEM 来源里,**store 的浪费倍数(2.0)和停顿率(83.5%)都是最高的**——虽然在 K=8192 下它的绝对样本数不是第一,但**单位指令的代价最大**,仍是优先优化目标。

而 MFMA 虽然贡献了 57% 的发射停顿,停顿率只有 **38.3%**(全场最低)——它条数多(每 wave 2048)所以总量大,但**单条指令是健康的**。这正是 §6.1 那张停顿率表的价值:**绝对值会误导,要看比率**。

---

## 5. 那要不要先跑 PC Sampling?

一个自然的想法:它能直接指到指令,是不是应该先跑?**实测答案是否定的。**

| | PMC | PC Sampling |
|---|---|---|
| 耗时 | **6.7 s** | 10.7 s |
| 统计 | 全量,1280 万周期 | 抽样,11376 个有效停顿样本 |
| 误差 | 无 | ±0.8%(95% CI) |
| 阈值 | **有**(≥10%) | **无** |
| 陷阱 | 分母要选对 | 采样时忘了 `--kernel-trace` |

三个理由:

1. **更慢**,"更快"是错觉
2. **是抽样**:要好精度就得加密采样、跑更久
3. **没有基准**:拿到「66.2%」你不知道算不算高;PMC 有官方的 ≥10% 判据

**推荐流程:**

```
PMC 定方向  →  PC Sampling 定位置  →  两者一致才可信
```

不一致的话,说明有一方的理解错了,继续查——本文和 [01](01-vmem-issue-stalls.md) 就是这么互相印证的。

---

## 6. 另一条路:官方 `rocprof-compute`

前面用的是 `rocprofv3` 直接采集。官方还有一条更完整的路径,**它有两个 `rocprofv3` 给不了的东西**。

```bash
# 采集
rocprof-compute profile -n pcs --experimental --pc-sampling \
    --pc-sampling-method stochastic --pc-sampling-interval 1048576 -- ./your_app

# 分析(-k 0 = 只看 Top Stats 里第 0 个 kernel)
rocprof-compute analyze -p workloads/pcs/MI355 -k 0 \
    --pc-sampling-sorting-type count --pc-sampling-rows 0
```

输出长这样,每行是**一个 PC 地址**:

```
│ index │ source_line │ instruction        │ offset │ count │ count_issued │ count_stalled │ stall_reason        │ Kernel_Name   │
│  1546 │ N/A         │ s_waitcnt vmcnt(0) │ 0x46bc │   144 │            0 │           144 │ [('WAITCNT', 144)]  │ kernel_gemm_0 │
```

### 6.1 官方独有的两件事

**① `-k 0` 内置 kernel 过滤。** 官方 analyze 层直接按 kernel 名过滤,输出自带 `Kernel_Name` 列——**不需要自己 join `--kernel-trace`**。

**② `source_line` 列。** 用 `-g` 编译时能把每个 PC 映射回**源码行号**。`rocprofv3` 的 csv 里没有这个。

> **停顿率不是官方独有的。** 官方的 `count_issued` / `count_stalled` 拆分很好用,
> 但 `rocprofv3` 的 csv 里有等价信息——`Wave_Issued_Instruction` 列(0/1)。
> 本文的脚本两条路径都会输出这张表,数值一致(store 停顿率 83.5% vs 84.6%,
> 差异来自两次独立采样)。

### 6.2 官方缺的:全局聚合

官方输出是**每个 PC 一行**(本例上千行),是原始素材而非结论。你没法直接看出:

- 「发射受限占 66.2%」—— 要把所有行的 `stall_reason` 拆开累加
- 「MFMA 占 `ARBITER_WIN_EX_STALL` 的 58%,但它停顿率最低」—— 同一 opcode 散落在几百行里

而这两个恰恰是**判断方向和选优化目标**的关键。

> ⚠️ **聚合时用 `count_stalled`,别直接累加 `stall_reason` 列。**
> 该列里混了 `OTHER_WAIT`,数量约等于 issued 总数——它其实是"没停顿"。
> 直接累加会把 `ARBITER_WIN_EX_STALL` 的占比显著稀释。

### 6.3 工具:两种输入都支持

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

`--from-analyze` 模式额外输出 §6.1 那张**停顿率表**。
输出样例:[`pc-sampling-official.txt`](pc-sampling-official.txt)(官方数据)·
[`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt)(rocprofv3 数据)

### 6.4 两条路怎么选

| | `rocprofv3` + 脚本 | `rocprof-compute` |
|---|---|---|
| 依赖 | **零**(ROCm 自带) | 重,见下 |
| kernel 过滤 | 手动 join `--kernel-trace` | ✅ **`-k 0` 内置** |
| 停顿率(stalled/sampled) | ✅(脚本从 `Wave_Issued_Instruction` 算) | ✅(原生 `count_stalled`) |
| `source_line` 映射 | ❌ | ✅(需 `-g`) |
| Top Stats / System Info | ❌ | ✅ 同一份报告 |
| 全局聚合 | ✅ | ❌ 需自己算 |

**两者数据一致**,互为验证:

```
官方     : ARBITER_WIN_EX_STALL = 7831/11826 = 66.2%
rocprofv3: ARBITER_WIN_EX_STALL = 7536/11376 = 66.2%
```

**建议:能装 `rocprof-compute` 就用官方**(`-k 0` 省掉过滤麻烦,还多一个源码行映射),用脚本的 `--from-analyze` 补聚合。环境受限时 `rocprofv3` 直采是等价的备选——两者的停顿原因和停顿率都能算出来。

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

## 7. 速查:完整流程

把前面讲的串起来,可以直接照抄:

```bash
# 1. 采样。四个 flag 缺一不可:
#    --pc-sampling-beta-enabled   PC sampling 目前是 beta,不加不生效
#    --pc-sampling-method stochastic   必须是 stochastic,只有它给 Stall_Reason
#    --pc-sampling-interval 1048576    保持默认!调小会把 kernel 拖慢几十倍(§2)
#    --kernel-trace                    ★ 否则无法知道样本属于哪个 kernel
rocprofv3 --pc-sampling-beta-enabled \
          --pc-sampling-method stochastic \
          --pc-sampling-unit cycles --pc-sampling-interval 1048576 \
          --kernel-trace \
          --output-format csv -d out -o pc -- ./your_app
# 产出: out/pc_pc_sampling_stochastic.csv   样本
#       out/pc_kernel_trace.csv             Dispatch_Id -> Kernel_Name

# 2. 看采到了哪些 kernel(务必先做,能立刻看出混入了多少别人的样本)
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

**为什么第 1 步一定要带 `--kernel-trace`:** PC sampling 的 csv 里**没有 `Kernel_Name` 列**,
只有 `Dispatch_Id`;而 `--kernel-include-regex` **不过滤 PC sampling 数据流**(rocprofv3 的
help 只承诺 counter-collection 和 thread-trace,C++ 侧 `is_targeted_kernel()` 也确实不在
`pc_sampling_callback()` 里调用)。所以进程里**所有 kernel 的样本都会进 csv**,必须靠
`--kernel-trace` 生成的 `Dispatch_Id → Kernel_Name` 对照表把它们分开。

**这个 flag 必须在采样时就加,事后补不了。**

> 走官方 `rocprof-compute` 路径则不用管这些,`analyze -k 0` 内置了 kernel 过滤,
> 见 [§6](#6-另一条路官方-rocprof-compute)。

---

## 参考

- [PC Sampling 官方文档](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/how-to/pc_sampling.html)
- [01 · 当 vmcnt 不是瓶颈:用 PMC 定位 VMEM 发射停顿](01-vmem-issue-stalls.md)
- 本案例完整报告:[`pc-sampling-official.txt`](pc-sampling-official.txt)(官方路径)·
  [`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt)(rocprofv3 路径)
