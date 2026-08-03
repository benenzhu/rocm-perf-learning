# 01 · 当 vmcnt 不是瓶颈:用 PMC 定位 VMEM 发射停顿

> 平台:AMD Instinct MI355X (gfx950 / CDNA4),ROCm `rocprofv3`
> 案例:一个真实的 MXFP4 GEMM kernel,M=N=K=8192,4250 TFLOPS

---

## TL;DR — 直接照着做

### 第 1 步:一趟采集,判断是不是发射卡住

```bash
rocprofv3 --pmc SQ_VMEM_TA_CMD_FIFO_FULL SQ_VMEM_TA_ADDR_FIFO_FULL SQ_BUSY_CYCLES \
                SQ_INSTS_VMEM SQ_WAIT_INST_ANY \
                TA_TA_BUSY TA_ADDR_STALLED_BY_TC_CYCLES GRBM_GUI_ACTIVE \
          --kernel-include-regex "你的kernel" --output-format csv \
          -d out -o p1 -- ./your_app
```

> 这组刚好卡在硬件槽位上限内(SQ 用 5/8,TA 用 2/2,GRBM 用 1/2),**一趟采完不用重放**。

**这些计数器分别是什么意思**(引号内为官方原文):

| 计数器 | 在链路哪一站 | 数的是什么 | 怎么用 |
|---|---|---|---|
| `SQ_VMEM_TA_CMD_FIFO_FULL` | ①→② | *"cycles texture requests are stalled due to full **cmd** fifo in TA"*<br>SQ 想发 VMEM,但 TA 的**命令**队列满了的周期数 | **主判据**,除以 `SQ_BUSY_CYCLES` |
| `SQ_VMEM_TA_ADDR_FIFO_FULL` | ①→② | 同上,但满的是**地址**队列(装 64 个 lane 的地址) | 佐证,通常和上面同向 |
| `SQ_VMEM_WR_TA_DATA_FIFO_FULL` | ①→② | 同上,满的是**写数据**队列(仅 store 相关) | store 密集时才看 |
| `SQ_BUSY_CYCLES` | ① | *"clock cycles there are active waves in a shader engine"*<br>SE 里**有 wave 存在**的周期数(不是 wave 数量) | **发射侧的分母** |
| `SQ_INSTS_VMEM` | ① | 发射出去的 VMEM 指令**条数** | 算每条指令的平均代价 |
| `SQ_WAIT_INST_ANY` | ① | *"wave-cycles spent waiting for **any instruction issue**"*<br>wave 想发指令但发不出去的周期(**注意单位是 quad-cycle,要 ×4**) | 「发不出去」的总量,含非 VMEM 原因 |
| `TA_TA_BUSY` | ③ | TA 单元忙碌的周期数 | 除以 `GRBM_PER_XCD × CU` 得忙碌率 |
| `TA_ADDR_STALLED_BY_TC_CYCLES` | ③←④ | *"cycles addr path **stalled by TC**"*<br>TA 的地址通路**被下游(L1)堵住**的周期数 | **分水岭判据**:区分"TA 活多"还是"TA 被堵" |
| `GRBM_GUI_ACTIVE` | 全局 | GPU 活跃周期数,**全局时基** | 大部分百分比的分母(⚠️见下方坑 3) |

**三个容易误解的点:**

- **`FIFO_FULL` 数的是"周期",不是"次数"** —— 它是「队列满、SQ 发不出去」这个**状态持续了多少个时钟周期**,所以要除以时间(`SQ_BUSY_CYCLES`)才有意义。
- **官方用词是 stalled 不是 waiting** —— 这是**结构冒险**(队列没位置),不是数据依赖。和 `s_waitcnt vmcnt` 是两回事。
- **CMD / ADDR / DATA 是三个独立队列**,任何一个满都会卡住发射。装的分别是:指令本身、64 个 lane 的地址、store 的写数据。

### 第 2 步:算两个数,查表定位

```
A = SQ_VMEM_TA_CMD_FIFO_FULL / SQ_BUSY_CYCLES                        ← 发射卡不卡
B = TA_ADDR_STALLED_BY_TC_CYCLES / (GRBM_PER_XCD × cu_per_gpu)       ← 是不是被下游堵
                                    ↑ rocprofv3 报的 GRBM 值 ÷ XCD 数(MI355X=8)
```

| A | B | 诊断 | 下一步 |
|---|---|---|---|
| **<10%** | — | **不是发射问题** | 查 `vmcnt` 延迟 / I-cache / wave 数不足 |
| **≥10%** | **低** | **TA 活太多**(本文案例:A=27.2%, B=0.9%) | → 第 3 步,减少指令数或 tag 访问 |
| **≥10%** | **高** | TA 被下游反压 | → 第 4 步,查 L1/TLB/L2 |

### 第 3 步(A高B低):建 tag 模型,找真正的浪费

```bash
rocprofv3 --pmc TA_TOTAL_WAVEFRONTS TA_BUFFER_WAVEFRONTS \
                TCP_GATE_EN1 TCP_TOTAL_CACHE_ACCESSES \
                TCP_TCR_TCP_STALL_CYCLES TCP_READ_TAGCONFLICT_STALL_CYCLES ...
```

**核心公式**(§1.5,本文最实用的部分):

```
单条指令的 tag 访问数 = 该指令 64 lane 的地址覆盖了几个不同的 64B cacheline
下限                 = ceil(该指令实际搬运字节数 / 64)
浪费倍数             = 实际 / 下限        ← 1.0 = 已最优,>1.0 才有优化空间
```

dump ISA 数出每类指令条数,乘以各自 tag 访问数求和,**和 `TCP_TOTAL_CACHE_ACCESSES` 对得上才算真懂了**(本文模型精确命中 2176,零误差)。然后**只看浪费倍数**排序开刀:

| | 每条 tag 访问 | **浪费倍数** | 结论 |
|---|---|---|---|
| G2S 主数据 | 16(最多) | **1.0** | 零浪费,**别动** |
| scale | 4 | **1.0** | 单条最优 → 减指令条数 |
| store | 4 | **2.0** | 改 lane 映射 + 减条数 |

⚠️ **只看浪费倍数,别看 tag 访问的绝对值。** G2S 每条 16 个是全 kernel 最多的,却零浪费——它真的在搬那么多数据。

### 第 4 步(A高B高):往下游查

| 查什么 | 公式 | 判据 |
|---|---|---|
| L2 反压 L1 | `TCP_TCR_TCP_STALL_CYCLES / TCP_GATE_EN1` | ≥10% |
| TLB 容量 | `TCP_UTCL1_STALL_INFLIGHT_MAX / TCP_GATE_EN2` | ≥10% |
| 页表遍历 | `TCP_UTCL1_STALL_LFIFO_NO_RES / TCP_GATE_EN2` | ≥10% |
| tag 冲突 | `TCP_READ_TAGCONFLICT_STALL_CYCLES / TCP_GATE_EN1` | ≥10% |
| tag bank 热点 | `TCP_TAGRAM{0..3}_REQ` 是否均衡 | 某 bank ≫25% |

这几个计数器的含义:

| 计数器 | 数的是什么 |
|---|---|
| `TCP_TOTAL_CACHE_ACCESSES` | *"total cache line (**tag**) accesses (includes hits and misses)"*<br>**查了多少次 tag** —— 命中未命中都算,§1.5 模型的核心量 |
| `TCP_TCR_TCP_STALL_CYCLES` | L1 发往 L2 的请求接口被**反压**的周期数 |
| `TCP_UTCL1_STALL_INFLIGHT_MAX` | 在飞的**地址翻译**请求数打满 → TLB 容量不够 |
| `TCP_UTCL1_STALL_LFIFO_NO_RES` | 等 UTCL2 返回翻译结果 → 页表遍历慢 |
| `TCP_*_TAGCONFLICT_STALL_CYCLES` | 多个请求撞同一个 tag set 导致的串行化 |
| `TCP_TAGRAM{0..3}_REQ` | 4 个 tag bank **各自**收到的请求数,看分布是否均衡 |
| `TCP_GATE_EN1` / `EN2` | TCP 的**接口时钟** / **核心时钟**开启周期数 —— TCP 类指标的分母 |

> ⚠️ **`EN1` 还是 `EN2`?AMD 自己的两个面板不一致,这个坑要知道。**
>
> | | 1600 vL1D 面板 | 3000 mem_bw 面板 |
> |---|---|---|
> | `TCP_TCR_TCP_STALL_CYCLES` | ÷ `GATE_EN1` | ÷ **`GATE_EN2`** |
> | `TCP_*_TAGCONFLICT_*` | ÷ `GATE_EN1` | — |
> | `TCP_UTCL1_STALL_*` | — | ÷ `GATE_EN2` |
>
> `EN1` 是接口时钟(总是开),`EN2` 是核心时钟(有活才开),所以
> **`EN2 / EN1` 本身就是 TCP 利用率**(3000 面板第 95 行正是这么定义的),`EN2 ≤ EN1`。
> 用 `EN2` 当分母得到的比例更大 —— 它衡量「TCP **干活时**有多少在停顿」,
> 用 `EN1` 则是「**全时段**有多少在停顿」。
>
> **两者都不算错,但绝不能混着比。** 本文统一用 `EN1`(和 1600 面板一致),
> 阈值 10% 也来自那套配置。换分母时记得阈值要跟着换。

### 第 5 步(可选):用 PC Sampling 定位到指令

PMC 只能告诉你"哪个硬件单元堵了",PC Sampling 能告诉你**哪条指令**:

```bash
rocprofv3 --pc-sampling-beta-enabled --pc-sampling-method stochastic \
          --pc-sampling-unit cycles --pc-sampling-interval 1048576 \
          --kernel-include-regex "你的kernel" --output-format csv -d out -o pc -- ./your_app
```

看 `Stall_Reason` 字段,**关键是分清两个 ARBITER**:

| | 含义 |
|---|---|
| `ARBITER_WIN_EX_STALL` | **赢了仲裁但执行单元不收** ← 对应发射停顿 |
| `ARBITER_NOT_WIN` | 没抢到发射槽(wave 之间竞争),**不是**同一回事 |

本文案例:`ARBITER_WIN_EX_STALL` 占 **68.8%**,其中 **83% 是 VMEM 指令**(`buffer_store_short` 53.8% + `buffer_load_dwordx4` 23.2%)——和 PMC 的 27.2% 相互印证。

> ⚠️ **必须过滤两次**:① `Instruction` 字段非空 ② 只保留本 kernel 的 `Dispatch_Id`。
> **`--kernel-include-regex` 不过滤 PC sampling 数据流**,少一道就会看到假的 "WAITCNT 79%"。详见 §7.1。
>
> **不建议用它替代 PMC 先跑**:更慢(10.7s vs 6.7s)、是抽样、且没有阈值判据。详见 §7.4。

### 五条保命经验

1. **发射受限和延迟受限的药方相反。** 前者要**减少**请求,后者要**增加** inflight。搞反了越优化越慢。
2. **TA 不是缓存。** `SQ_INSTS_VMEM == TA_TOTAL_WAVEFRONTS`(实测完全相等),提高命中率**不减轻 TA 负担**。
3. **分母有坑,而且官方自己都不统一。** `rocprofv3` 报的 `GRBM_GUI_ACTIVE` 是 8 个 XCD 求和值,TA 类要先除 XCD 数(用错差 16 倍);TCP 类的分母 AMD 两个面板一个用 `GATE_EN1` 一个用 `GATE_EN2`(见第 4 步的说明),**自己统一就好,但别混着比**。
4. **wall-clock 异常先用 GPU 侧计数器验证。** 我曾测到一个 9 倍性能悬崖,结果是测试脚本的问题(§6 坑 1)。
5. **传闻的坑要实测。** 本文 kernel 完全符合"512B stride"这个著名踩坑条件,实测 tag 冲突却是 **0**(§6 坑 2)。

> **只有 gfx950 有的计数器**:`SQ_VMEM_TA_*_FIFO_FULL`、`TCP_UTCL1_*`、`TCP_TAGRAM{0..3}_REQ`。
> MI300 上第 1 步做不了,只能靠 `TA_ADDR_STALLED_BY_TC_CYCLES` 间接推断。

---

## 0. 这篇要解决的问题

打开 [CDNA Performance Model](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/conceptual/cdna/cdna-performance-model.html),你会看到几百个指标,按 CU、L2、SE、CP 分门别类。文档告诉你每个指标**是什么**,但没告诉你**什么时候该看哪个**。

结果就是大部分人只用两招:看 occupancy,看 cache 命中率。这两招对访存受限的 kernel 有用,但对一类非常常见的情况完全失效——

**你的 load 指令发不出去。**

不是数据回来得慢(那是延迟问题,看 `vmcnt`),而是指令**根本挤不进访存管线**。这两件事的症状看起来一样(wave 停着不动),但**药方完全相反**:延迟问题要增加 inflight instructions,发射问题要减少请求条数。搞反了会越优化越慢。

这篇讲怎么用三五个 PMC 在十分钟内区分这两者,并定位到具体代码行。

---

## 1. 一条 `buffer_load` 的完整旅程

要理解"发射卡住",得先知道一条 `buffer_load` 从指令变成数据,中间经过了什么。这一节是全文的地基,后面所有计数器都挂在这条链路的某一站上。

### 1.0 hw缩写

计数器名字的前缀就是硬件单元名,先把它们对应到实际职能:

| 缩写 | 全称 | **实际是什么** |
|---|---|---|
| **SQ** | **S**e**q**uencer | **wavefront 调度器**。发射指令、管理 wave slot |
| **SPI** | **S**hader **P**ipe **I**nterpolator | **workgroup(nv的CTA: Cooperative Thread Array) 管理器**。把 workgroup 分派到 CU |
| **TA** | **T**exture **A**ddresser | **地址生成单元**。算 64 个 lane 的地址并合并 |
| **TD** | **T**exture **D**ata | **数据返回单元**。把数据送回 VGPR |
| **TCP** | **T**exture **C**ache **P**er pipe | **vL1D**,每个 CU 的 L1 向量缓存 |
| **TCC** | **T**exture **C**ache per **C**hannel | **L2 缓存**,全 XCD 共享,分 16 个 channel |
| **TCA** | **T**exture **C**ache **A**rbiter | L1↔L2 之间的**仲裁**。只有 `TCA_BUSY`/`TCA_CYCLE` 两个计数器,官方未描述其职能,分析面板也没用到——**知道有这么个块即可** |
| **TCR** | **T**exture **C**ache **R**equest | TCP 发往 L2 的**请求接口**,见 `TCP_TCR_*` |
| **EA** | **E**fficiency **A**rbiter | **访存接口**,L2 之外通往 HBM/跨die/PCIe |
| **UTCL1/2** | **U**nified **T**ranslation **C**ache | **TLB**(地址翻译缓存),L1/L2 两级 |
| **CU** | **C**ompute **U**nit | 计算单元,含 4 个 SIMD |
| **XCD** | e**X**ccelerator **C**omplex **D**ie | 一个计算 die。MI355X 有 8 个,每个 32 CU |
| **GRBM** | **G**raphics **R**egister **B**us **M**anager | 提供**全局时基**,几乎所有百分比的分母 |

**几个特别容易踩的点:**

- **TCP ≠ TCC**。差一个字母,一个是 CU 私有的 L1(每 CU 一个),一个是全 XCD 共享的 L2(16 channel)。**这是最常见的混淆。**
- **SQ 不是"队列"**,是 Sequencer(调度器)。`SQ_*` 计数器测的是指令发射侧的事。
- vL1D 和 TCP 在文档里混用,指同一个东西(官方原话:*"Together, this complex is known as the vL1D, or Texture Cache per Pipe (TCP)"*)。

记住一条就够用了:**`前缀_XXX` 的前缀告诉你这个计数器在链路的哪一站**。下面这张图就是那条链路。

### 1.0.1 全景:六站流水线

下图的**左半部分是本文的战场**。注意中间那条粗线:指令一旦越过它,就"让出"了发射流水线,后面发生什么都不再影响下一条指令能不能发出去。

```
       一条 buffer_load_dwordx4  (64 lane,每 lane 取 16B)
                  │
╔═════════════════▼══════════════════════════════════════════════════╗
║           发 射 侧 —— 决定「下一条指令能不能进来」                     ║
║                     ★ 本文全部内容在这里 ★                          ║
╟────────────────────────────────────────────────────────────────────╢
║  ┌──────────────────────────────────────────────────────────────┐  ║
║  │ ① SQ 调度器                                                   │  ║
║  │    round-robin 选 SIMD,每类别发 1 条                           │  ║
║  │    🔴 卡点:下游 FIFO 满 → SQ_VMEM_TA_{CMD,ADDR}_FIFO_FULL     │  ║
║  │       实测 27.2%(阈值 10%)  ← 我们的病灶                     │  ║
║  └──────────────────────────┬───────────────────────────────────┘  ║
║                             │ 1 条指令                              ║
║  ┌──────────────────────────▼───────────────────────────────────┐  ║
║  │ ② SQ→TA FIFO    CMD / ADDR / DATA 三个队列                    │  ║
║  │    任何一个满 → SQ 就发不出下一条 VMEM                          │  ║
║  └──────────────────────────┬───────────────────────────────────┘  ║
║                             │                                      ║
║  ┌──────────────────────────▼───────────────────────────────────┐  ║
║  │ ③ TA 地址生成 + 合并                                           │  ║
║  │    64 个 lane 地址 → 归并成 N 个 64B tag 访问                   │  ║
║  │    ⏱ 平均占用 12.9 周期/条  ← 而发射侧 1 周期就能塞一条          │  ║
║  │       13 倍失配 = FIFO 必然被填满                              │  ║
║  │    📊 TA_TOTAL_WAVEFRONTS、TA_TA_BUSY                          │  ║
║  │    🔴 卡点:被下游堵 → TA_ADDR_STALLED_BY_TC_CYCLES             │  ║
║  │       实测 0.9% → 没被堵,是 TA 自己活太多                      │  ║
║  └──────────────────────────┬───────────────────────────────────┘  ║
║                             │  N 个 tag 访问 ← ★ 放大发生在这里      ║
║  ┌──────────────────────────▼───────────────────────────────────┐  ║
║  │ ④a UTCL1 地址翻译 (TLB)   VA → PA                              │  ║
║  │    ⚠️ 必须先翻译完,TCP 才能用物理地址查 tag                     │  ║
║  │    miss → UTCL2 → 页表遍历(几百~上千周期)                     │  ║
║  │    🔴 卡点:TCP_UTCL1_STALL_*  ← 反压可一路传回 SQ!            │  ║
║  │       实测命中率 99.996%,stall 5.2% → 本例不是瓶颈(§1.2.6)   │  ║
║  └──────────────────────────┬───────────────────────────────────┘  ║
║  ┌──────────────────────────▼───────────────────────────────────┐  ║
║  │ ④b TCP (vL1D) 用物理地址查 tag                                 │  ║
║  │    🔴 卡点:TCP_TCR_TCP_STALL_CYCLES(被 L2 反压)              │  ║
║  │       同样会反压 TA → SQ                                       │  ║
║  └──────────────────────────┬───────────────────────────────────┘  ║
╚═════════════════════════════│══════════════════════════════════════╝
      ┌───────────────────────┴────────────────────────┐
      │ 命中 → 数据直接回                未命中 → 下发 L2 │
      └───────────────────────┬────────────────────────┘
════════════ 请求离开 CU,后续指令的发射不再受它影响 ════════════
                              │
╔═════════════════════════════▼══════════════════════════════════════╗
║           延 迟 侧 —— 决定「数据什么时候回来」                        ║
║                  由 s_waitcnt vmcnt 追踪,本文不展开                 ║
╟────────────────────────────────────────────────────────────────────╢
║  📊 TCP_TOTAL_CACHE_ACCESSES、TCP_TCC_READ_REQ(④ 的产出量)         ║
║  ┌──────────────────────────▼───────────────────────────────────┐  ║
║  │ ⑤ TCC (L2,每 XCD 16 channel,4MB)  📊 TCC_HIT / TCC_MISS      │  ║
║  └──────────────────────────┬───────────────────────────────────┘  ║
║  ┌──────────────────────────▼───────────────────────────────────┐  ║
║  │ ⑥ EA → HBM / GMI(跨die) / IO(PCIe)  📊 TCC_EA0_RDREQ         │  ║
║  └──────────────────────────┬───────────────────────────────────┘  ║
║                             │  ④~⑥ 合计几百周期                     ║
║                             ▼                                      ║
║      数据回程:TD → VGPR(或 direct-to-LDS 直接进 LDS)               ║
║      此刻 vmcnt 递减 —— 这才是「指令完成」                            ║
╚════════════════════════════════════════════════════════════════════╝
```

**分清这两侧是全文的关键:**

| | 位置 | 现象 | 计数器 | 解法 |
|---|---|---|---|---|
| **发射侧** | ①②③④ | 指令**进不去** | `SQ_VMEM_TA_*_FIFO_FULL` | **减少指令数 / 减少每条的 tag 访问** |
| **延迟侧** | ⑤⑥ | 数据**回不来** | `s_waitcnt vmcnt` 等待 | 增加 inflight instructions |

**两者症状一样(wave 不动),药方却相反**——发射受限要**减少**请求,延迟受限要**增加**在飞请求。搞反了会越优化越慢。

> **⚠️ 边界没那么干脆,这里要说清楚。**
> 上图把 ④(UTCL1 + TCP tag)划在发射侧,是因为**它俩的停顿会反压回 SQ**:
> `UTCL1 卡 → TCP 卡 → TA 卡(TA_ADDR_STALLED_BY_TC)→ FIFO 满 → SQ 发不出`。
>
> 真正"越过分界线"的时刻,是**请求离开 CU 下发 L2 之后**——从那一刻起它只影响 `vmcnt`,
> 不再影响发射。所以判断顺序应该是:
> **先看 `TA_ADDR_STALLED_BY_TC_CYCLES`** —— 低(本例 0.9%)说明 ④ 没在反压,
> 病灶在 ③ 之前(指令太多/tag 访问太多);高则要继续往 ④⑤⑥ 查。

> **打个比方:** TA 是收银台,L2/HBM 是后厨。
> 队伍卡住有两种原因——**收银员刷条码太慢**(发射侧),还是**后厨出菜太慢**(延迟侧)。
> 我们这个 kernel 是前者:收银员每单要 12.9 秒,而顾客 1 秒就能到柜台。**后厨再快也没用。**

这也解释了为什么**提高 L2 命中率对我们这个问题帮助不大**:TA 算完地址就把请求交出去了,它不知道后面命中与否;只要 ④ 没在反压(本例 `TA_ADDR_STALLED_BY_TC` = 0.9%),L2 再快也不会让指令发得更快。

### 1.0.2 实测:一条指令在每一站被放大成多少

用我们的 kernel(K=1024,每 wave 352 条 VMEM 指令)实测,看数量如何沿链路变化:

| 站点 | 每 wave 的量 | 相对上一站 |
|---|---|---|
| ① 指令数 (`SQ_INSTS_VMEM`) | **352** | — |
| ③ TA 处理 (`TA_TOTAL_WAVEFRONTS`) | **352** | ×1.0(**一条不少,也一条不多**) |
| ④ TCP tag 访问 (`TCP_TOTAL_CACHE_ACCESSES`) | **2,176** | **×6.2** ← 放大 |
| ④→⑤ 下发 L2 (`TCP_TCC_*_REQ`) | 1,568 | ×0.72(vL1D 吸收了一部分) |
| ⑤→⑥ 下发 HBM (`TCC_EA0_RDREQ`) | ~103 | L2 命中率 77.3% |

**一条指令平均炸成 6.2 个 tag 访问。** 这个放大倍数就是 TA 的真实工作量,也是发射受限的根源。

### 1.1 ① 调度器:每周期只看一个 SIMD

CU 里的调度器(scheduler)负责给所有在执行的 wave 发射指令。官方文档([Pipeline descriptions](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/conceptual/cdna/pipeline-descriptions.html))对它的描述是:

> On every clock cycle, the scheduler:
> - Considers waves from **one of the SIMD units**, selected in a **round-robin** fashion
> - Issues up to **one instruction per wavefront** on the selected SIMD
> - Issues up to **one instruction per each instruction category** among the waves on the selected SIMD:
>   VALU / **VMEM** / SALU·SMEM / LDS / Branch

三个关键点:

1. **每周期只服务一个 SIMD**,四个 SIMD 轮转。所以对某个 SIMD 上的 wave 来说,**平均每 4 个周期才轮到一次发射机会**。
2. 被选中的 SIMD 上,**每个类别最多发 1 条**。VALU 和 VMEM 属于不同类别,所以一条 MFMA 和一条 `buffer_load` **可以同一周期一起发出去**——它们不抢发射槽。
3. 五个类别加起来,峰值 **IPC = 5**(per-SIMD per-CU)。

> **这里修正一下常见的误解(也是我自己一开始的说法):**
> 不是"VALU 每周期 4 条、VMEM 每周期 1 条"这种带宽比。
> 真实机制是**每个 SIMD 每轮到一次、每类别各发 1 条**。
> VMEM 发不出去,不是因为被 VALU 抢了槽位,而是因为**下游 TA 的队列满了**。

### 1.2 ② 发射之后:SQ → TA 的三个 FIFO

指令发射出去,并不等于访存开始。它先进入 **SQ 到 TA 之间的队列**:

```
                    ┌──────────── 一个 CU ────────────┐
   SIMD0  SIMD1  SIMD2  SIMD3    ← 各有独立的指令缓冲(每 SIMD 8 个 wave slot)
     └──────┴──┬───┴──────┘
               │  scheduler:round-robin 选 SIMD,每类别发 1 条
               ▼
        ┌─── SQ→TA FIFO ───┐     ← ★ 卡就卡在这里
        │  CMD  / ADDR  / DATA │     三个队列各自会满
        └──────────┬──────────┘
                   ▼
                  TA             ← 地址生成:整个 CU 只有 1 个
                   │
               TCP (vL1D)        ← L1 向量缓存:整个 CU 只有 1 个
                   │
                  TD             ← 数据返回:整个 CU 只有 1 个
```

三个 FIFO 分别装:指令本身(CMD)、64 个 lane 的地址(ADDR)、store 的写数据(DATA)。

**任何一个满了,SQ 就发不出下一条 VMEM 指令**——哪怕 wave 完全就绪、哪怕调度器正好轮到它。这就是我们要测的那三个计数器,官方描述是:

> `SQ_VMEM_TA_CMD_FIFO_FULL` — *"Number of cycles texture requests are stalled due to full cmd fifo in TA."*

注意用词是 **stalled**,不是 waiting——这是**结构冒险**,不是数据依赖。`s_waitcnt vmcnt` 一点关系都没有。

### 1.2.5 那么 `buffer_load` 到底什么时候"返回"?

这是最容易混淆的一点,值得单独讲清楚。**"返回"其实指两件不同的事:**

| | 什么时候发生 | 卡住谁 | 怎么测 |
|---|---|---|---|
| **①「让出 TA」** | TA 把地址拆完、请求交给 TCP | **后续指令发不出去** | `SQ_VMEM_TA_*_FIFO_FULL` |
| **②「数据到位」** | 数据真的写进 VGPR / LDS | **本 wave 用数据时** | `s_waitcnt vmcnt` |

**①→② 之间隔着 L1/L2/HBM 的几百个周期。关键是:指令在 ① 就离开发射流水线了,不等 ②。**

TA 处理完一条(平均 12.9 周期)就能接收下一条,**不会等数据从 HBM 回来**。这就是为什么第 ④⑤⑥ 站属于"数据通路",和"发不出去"无关。

**ISA 直接证明了这一点。** 看这个 kernel 的主循环:

```asm
buffer_load_dwordx4 v118, s[12:15], s30 offen lds   ← 第 1 条
buffer_load_dwordx4 v119, s[12:15], s30 offen lds
...                                                  ← 连发 32 条,中间零等待
buffer_load_dwordx4 v121, s[12:15], s24 offen lds   ← 第 32 条
s_waitcnt vmcnt(28)        ← 直到这里才第一次等
ds_read_b128 v[30:33], v151
```

**连发 32 条 load 都不等一下。** 如果发射需要等数据返回,这段代码根本不可能存在。

再看 `vmcnt(28)` 的语义——**不是"等 28 条完成"**,而是「**允许 28 条仍在飞**」:

```
已发出 32 条,允许 28 条在飞  →  只等最早的 32 − 28 = 4 条到位
```

这是典型的软件流水:早发的用掉,晚发的继续在飞。**代码已经把 inflight 堆到 32 条了,延迟掩盖得很好**——这正是我们测到 `vmcnt` 不卡、却卡在发射的原因。

> **direct-to-LDS 的一个细节:** 这个 kernel 的主数据用 `buffer_load ... lds`,
> 数据绕过 VGPR 直接写进 LDS。那它怎么算"完成"?
> **仍然由 `vmcnt` 追踪**——数据落进 LDS 的那一刻 `vmcnt` 递减,之后才能 `ds_read`。
>
> ⚠️ 这里有个坑:LLVM 曾经把 direct-to-LDS 的完成**错记到 `lgkmcnt`**(LDS 指令的计数器)上,
> 导致同步错误,[llvm#179305](https://github.com/llvm/llvm-project/pull/179305) 修的就是这个。**记住是 `vmcnt` 不是 `lgkmcnt`。**

**完整生命周期,以及每一段决定什么:**

```
t0  SQ 发射          需要:轮到该 SIMD + FIFO 有空位
                     🔴 卡这里 = SQ_VMEM_TA_CMD_FIFO_FULL   ← 我们的问题
t1  进 SQ→TA FIFO
t2  TA 算地址+合并    平均 12.9 周期(取决于跨几个 64B 区间)
t3  UTCL1 翻译 VA→PA  ┐ 这两步若卡,反压 TA → SQ,仍属发射侧
t4  TCP 查 tag        ┘ 本例都没卡(§1.2.6、TA_ADDR_STALLED 0.9%)
    ═══════ 请求下发 L2、离开 CU,后续指令的发射不再受影响 ═══════
t5  TCC (L2)
t6  EA → HBM          t5~t6 合计几百周期
t7  数据写进 VGPR/LDS,vmcnt 递减
                      🔴 卡这里 = s_waitcnt vmcnt 等待

    t0~t4 决定发射吞吐  |  t5~t7 决定延迟
```

**这个区分直接决定该做什么(以本例「④ 没在反压」为前提):**

| 对发射受限**没用** | 对发射受限**有用**(作用在 t2) |
|---|---|
| 提高 L2 命中率 | 减少 VMEM 指令条数 |
| 增加 occupancy 掩盖延迟 | 降低每条指令跨的 64B 区间数 |
| 优化数据局部性 | 用更宽的 load(条件见 §4) |

> 左列的前提是 `TA_ADDR_STALLED_BY_TC_CYCLES` 低。如果它高,说明 ④ 正在反压,
> 那么改善 vL1D 命中率、缓解 TLB 压力**就会直接转化为发射吞吐**——此时左列的项目变得有用。
> **先测这个数,再决定往哪使劲。**

### 1.2.6 ④a 那 UTCL1(TLB)会不会也卡?

会,而且**它卡起来是能一路反压到发射侧的**——这是个真实且常被忽略的路径。但本例实测不是,值得把过程讲清楚。

**为什么它有资格卡住发射:**

TA 算出来的是**虚拟地址**,TCP 查 tag 需要**物理地址**。中间必须过 UTCL1 翻译:

```
③ TA 算出 VA
     ↓
  UTCL1 查 VA→PA      miss → UTCL2 → 页表遍历(几百~上千周期)
     ↓
④b TCP 用 PA 查 tag
```

**翻译不完,tag 查不了 → TCP 反压 TA → TA 反压 SQ → 发射停顿。** 因果链完整成立。

**本例实测(K=1024):**

| 指标 | 实测 | 判据 |
|---|---|---|
| UTCL1 命中率 | **99.996%** | — |
| 翻译 miss 总数 | **357 次**(每 wave 0.09) | — |
| `STALL_INFLIGHT_MAX / TCP_GATE_EN2` | 5.20% | ≥10% |
| `STALL_LFIFO_NO_RES / TCP_GATE_EN2` | 0.68% | ≥10% |
| `SERIALIZATION_STALL` | **0** | — |

**全 kernel 只有 357 次翻译 miss。** GEMM 访问的是几个大而连续的 buffer,涉及页数很少,TLB 几乎必然全命中。

那 5.2% 的 `STALL_INFLIGHT_MAX` 也**不是"翻译慢"**,而是在飞翻译请求数打满——它是我们发太多请求的**结果**,不是原因。同理还有 `TCP_PENDING_STALL_CYCLES` 偏高:这些都是 §1.5 那个「tag 访问总量过大」的下游表现,**是症状不是病因**。

> **关于"第一条 load 卡很久"——这个观察是对的,但它不是稳态瓶颈。**
> 冷启动时第一次访问某页确实要走 UTCL1 miss → UTCL2 →(可能)页表遍历,上千周期,
> ATT trace 里 kernel 开头那段长 stall 就是它。
> **但它是一次性的**:357 次 miss 摊到 4096 个 wave、几十万条指令上可以忽略。
> 我们要解释的 27.2% 是**贯穿整个 kernel 的稳态现象**,不是开头那一下。

**什么时候 UTCL1 才真的是瓶颈**(换个 kernel 就可能撞上):

- 访问**快速跳过大量页面**(>32 页):随机 gather、大 stride 扫描、指针追逐
- 工作集远超 TLB 覆盖范围(4KB 页的话覆盖不了多大)
- 典型场景:**sparse、embedding lookup、图计算**——而不是 GEMM

判据:`TCP_UTCL1_STALL_INFLIGHT_MAX / TCP_GATE_EN2 ≥ 10%`(TLB 容量不够)
或 `TCP_UTCL1_STALL_LFIFO_NO_RES / TCP_GATE_EN2 ≥ 10%`(页表遍历慢)。
修法:上 **2MB 大页**,或改数据布局减少页面跳跃。

⚠️ 这组 `TCP_UTCL1_*` 计数器**只有 gfx950 有**,MI300 上测不了,只能靠推断。

### 1.3 ③ TA:排空速度远慢于发射速度

TA 拿到一条指令后要做**地址合并(coalescing)**:把 64 个 lane 的地址归并成 cacheline 请求,再逐个发给 TCP。

这一步的耗时**不是常数**,取决于归并出多少个请求:

| 访问模式 | 产生的 cacheline 请求 |
|---|---|
| 64 lane 完美合并 | 4 |
| 64 lane 各读 4 字节、分散在不同 line | 64 |

于是就有了这个**根本失配**:

```
发射侧:轮到该 SIMD 时,1 周期就能塞 1 条进 FIFO
TA 侧 :排空 1 条要 4 ~ 64 周期
```

实测我们这个 kernel(算法见 §3.1):

```
TA_TA_BUSY / (GRBM_PER_XCD × cu_per_gpu) = 47.7%
每 CU 的 VMEM 指令数 = 16,384
=> TA 平均每条指令占用 ≈ 12.9 个周期
```

**发射侧 1 周期一条,TA 侧 12.9 周期一条——13 倍的失配。** FIFO 被填满是必然的,只是时间问题。

注意这个失配是**结构性**的:哪怕数据全部命中 vL1D、延迟为零,TA 依然只能 12.9 周期吐一条。**它和数据在哪儿无关,只和"要算多少个地址"有关。** 下一节解释为什么。

### 1.4 ③ TA 的代价模型:为什么缓存救不了它

一个容易误解的点:**TA 不是缓存,没有任何复用机制。**

```
SQ_INSTS_VMEM       = 4,194,304
TA_TOTAL_WAVEFRONTS = 4,194,304    ← 完全相等
```

**每一条 VMEM 指令都要过 TA 一次,无一例外。** 第 1000 次访问同一个 cacheline,照样要重新算地址——因为命中判断是 **TCP 的事,发生在 TA 之后**:

```
SQ 发射 → TA 算地址(每条必过)→ TCP 查 tag(这里才有命中/未命中)→ ...
```

**推论:缓存命中率再高,也一点都不减轻 TA 的负担。** 这类瓶颈只能靠减少指令条数、改善合并度来解;调局部性、加缓存统统无效。

那"合并"到底在合并什么?**只在一条指令的 64 个 lane 之间比对**,跨指令没有任何记忆。上一条指令刚访问过的 cacheline,下一条指令再访问,TA 完全不知道。

所以:

```
TA 总开销 ≈ Σ (每条指令归并出的 cacheline 请求数)
             ↑ 对所有 VMEM 指令求和,一条都跑不掉
```

**两个可优化的变量就是这个求和式的两项:指令条数,和每条的合并度。** 后面整篇都在围绕这两个数做文章。

### 1.5 定量模型:从源码预测 TA 负担

前面都是定性的。这一节给一个**能算出具体数字、并且被实测验证的模型**——这是本文最实用的部分,你可以拿去套自己的 kernel。

#### 先说清楚:64B 和 "tag" 到底是什么

这两个概念是整个模型的基础,而且**不是经验法则,是硬件定义**。

**64B 从哪来?** 官方文档([Vector L1 cache](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/conceptual/cdna/vector-l1-cache.html))原文:

> *"All cache accesses in vL1D are for a single cache line's worth of data. The size of a cache line may vary, however on current CDNA architecture-based AMD Instinct MI-Series GPUs and GCN GPUs **the L1 cache line size is 64B**."*

两句话拆开看:

1. **vL1D 的 cacheline = 64B**
2. **每次 cache 访问只能覆盖一个 cacheline** ← 这条才是关键

所以一条搬 1024B 的指令,**物理上必须拆成 16 次访问**,没有别的可能。

> ⚠️ **L1 是 64B,L2 不是。** TCC 那边是 32B sector 粒度、请求可以是 32/64/128B
> (看 `TCC_EA0_RDREQ_{32B,64B,128B}` 就知道)。**两级粒度不同,别混用。**

**"tag" 是什么?** vL1D 内部的流水线是这样的:

```
TA 送来地址
    ↓
UTCL1 翻译 VA → PA
    ↓
Tag RAM 查询   ← "这个 64B cacheline 现在在不在缓存里?"
    ↓
命中 → 从 Cache RAM (TC) 取数据
未命中 → 下发 L2
```

Tag RAM 存的是**"缓存里当前装着哪些 cacheline 的地址标签"**。要访问任何一个 64B line,**都得先查一次 tag** 才知道命中与否。

**所以 `TCP_TOTAL_CACHE_ACCESSES` 数的是"查了多少次 tag"**,和命中率无关——命中要查,未命中也要查。这就是为什么 §1.4 说"缓存命中率救不了 TA":**查询次数只由你的地址模式决定。**

#### 模型本身

**核心规则:tag 访问数 = 该指令 64 个 lane 的地址覆盖了多少个不同的 64B cacheline。**

```
tag 访问数 = |{ addr[lane] / 64  :  lane = 0..63 }|      ← 去重后的集合大小
```

三种典型情况:

| 指令 | 每 lane | 总跨度 | 是否连续 | tag 访问 |
|---|---|---|---|---|
| `buffer_load_dwordx4` | 16B | 64×16 = 1024B | 连续 | **16** |
| `buffer_load_dword` | 4B | 64×4 = 256B | 连续 | **4** |
| `buffer_store_short` | 2B | 4 段 × 32B(行间跨 N) | 分段 | **4** |

> ⚠️ 注意最后一行:store 每 lane 只写 2 字节、总共才 128B,却产生 4 个 tag 访问。
> 因为 64 个 lane 分成 **4 组、写 4 个不同的行**,每行落在不同的 64B line 上。
> **决定 tag 访问数的是"地址铺开后跨了几个 64B 区间",不是"搬了多少字节"。**

**代入我们的 kernel 验证(K=1024,每 wave):**

```
G2S   : 64 条 × 16 = 1024
scale : 32 条 ×  4 =  128
store : 256 条 ×  4 = 1024
                     ─────
              合计 = 2176
```

实测 `TCP_TOTAL_CACHE_ACCESSES` = **2176**。**精确命中,零误差。**

模型一旦对上,就可以直接用它做优化决策了:

| 来源 | 指令数 | tag 访问 | 占 TA 负担 | 搬运字节 |
|---|---|---|---|---|
| G2S 主数据 | 64 (18%) | 1024 | 47% | 64 KB |
| scale | 32 (9%) | 128 | 6% | 8 KB |
| store | 256 (73%) | 1024 | 47% | 32 KB |

**但光看这张表会得出错误结论。** G2S 和 store 各占 47% 的 TA 负担,看起来一样糟——
实际上 G2S 无可优化,store 有一半是浪费的。差别在于**它们搬的数据量不同**:
G2S 用 1024 次 tag 访问搬了 64 KB,store 同样 1024 次只搬了 32 KB。

要把这个差别变成一个可排序的数,就需要下一节的**浪费倍数**。

#### 关键:tag 访问数有下限,"多"不等于"浪费"

前面说"降低每条指令跨的 64B 区间数",这个说法**容易误导**,必须补一句:

**区间数有物理下限,你降不到下限以下:**

```
下限 = ceil( 该指令实际需要搬运的字节数 / 64 )
```

一条 `buffer_load_dwordx4` 搬 64 lane × 16B = 1024B,**无论怎么优化,至少要 16 次 tag 访问**。

所以真正该问的不是"tag 访问多不多",而是:

```
浪费倍数 = 实际 tag 访问数 / 下限

= 1.0  → 已经最优,单条指令层面无可优化
> 1.0  → 有 lane 映射问题,存在优化空间
```

**套到我们的 kernel:**

| | 实际搬运 | 下限 | 实际 tag 访问 | **浪费倍数** |
|---|---|---|---|---|
| G2S | 1024 B | 16 | 16 | **1.0** ✓ 完美 |
| scale | 256 B | 4 | 4 | **1.0** ✓ 完美 |
| store | 128 B | 2 | 4 | **2.0** ✗ 翻倍 |

**这个结果可能出乎意料:G2S 产生最多 tag 访问(每条 16 个),却是零浪费的。**

验证一下 G2S 的 lane→地址映射(代码是 `row = lane//8; col = (lane%8)*16`):

```
lane 0 → addr    0  ┐
lane 1 → addr   16  │ 4 个 lane 正好拼满一个 64B cacheline
lane 2 → addr   32  │
lane 3 → addr   48  ┘
lane 4 → addr   64  ┐ 下一个 cacheline
...                 │
lane 8 → addr  512  ← 换到下一行

64 lane × 16B = 1024 B,覆盖 16 个 64B line,一个字节都没浪费
```

**这正好回答了一个常见疑问:** `dwordx4` 每 lane 取 16B,而 64B ÷ 16B = 4,
所以**每 4 个连续 lane 访问连续地址**才能填满一个 cacheline——G2S 做到了。
如果 lane 0~3 访问的是 4 个相距很远的地址,就会变成 4 次 tag 访问搬 64B,**浪费倍数 4.0**。

#### 两条不同的优化路径,别用错

| | 手段 | **什么时候用** |
|---|---|---|
| **路径 A:改 lane 映射** | 调整 swizzle,让相邻 lane 访问连续地址 | **浪费倍数 > 1.0** 时 |
| **路径 B:减少指令条数** | 用更宽的 load、合并多次访问 | **多条指令落在同一批 cacheline** 时 |

对号入座:

- **G2S**:浪费 1.0,两条路都到头了 → **不要动**
- **scale**:浪费 1.0,路径 A 无空间 → **走路径 B**(合并多个 K-step,见 §4)
- **store**:浪费 2.0 且占 73% 指令 → **两条路都有空间**(LDS shuffle 改布局 + `float4` 宽存)

> **为什么 scale 单条完美却还能优化?**
> 因为它的问题**不在单条指令内部,而在跨指令重复**。
> 相邻 K-step 的 scale 在内存里紧挨着,分 8 次去取等于把同一片区域切碎了访问。
> **路径 B 解决的正是这类问题**——§4 会详细算这笔账。

> **这就是为什么要算浪费倍数、而不是看 tag 访问的绝对量。**
> 单看总量会觉得 G2S 和 store 一样是大头(各 47%),
> 但一个浪费倍数 1.0(零浪费),另一个 2.0(一半白干)。**只有归一化之后才可比。**

**怎么用在你自己的 kernel 上:**

1. dump ISA,数出每种 VMEM 指令的条数
2. 对每种指令,算它 64 个 lane 的地址跨多少个 64B 区间
3. 相乘求和,和 `TCP_TOTAL_CACHE_ACCESSES` 对比——**对上了才说明你真的理解了访存模式**
4. 按**浪费倍数**排序,从最大的开刀(1.0 的直接跳过,那是物理下限)

第 3 步的验证非常重要。如果模型和实测对不上,说明你对某条指令的地址模式理解错了(常见:忽略了 swizzle、忘了 stride 不连续、或者 exec mask 不满)。**对不上就别急着优化。**

---

## 2. 三个关键计数器(CDNA4 才有)

CDNA4 新增了三个直接测量"SQ 想发射但 TA 队列满了"的计数器。**这是本文的主角**,MI300 上没有:

| 计数器 | 含义 |
|---|---|
| `SQ_VMEM_TA_CMD_FIFO_FULL` | 命令队列满的周期数 |
| `SQ_VMEM_TA_ADDR_FIFO_FULL` | 地址队列满的周期数 |
| `SQ_VMEM_WR_TA_DATA_FIFO_FULL` | 写数据队列满(仅 store 相关) |

用法是除以 `SQ_BUSY_CYCLES`:

```
VMEM 发射停顿率 = SQ_VMEM_TA_CMD_FIFO_FULL / SQ_BUSY_CYCLES
```

> **≥ 10% 判定为「TCP 的反压已经传导到 SQ」。**
>
> 这不是我拍脑袋定的阈值,是 rocprof-compute 配置文件里写死的判据:
> `analysis_configs/gfx950/3000_mem_bw.yaml` —— *"A high stall rate (>= 10%) indicates that TCP stall is backpressured to SQ."*

配套要看的第二个计数器,用来区分"TA 自己慢"还是"TA 被下游堵":

```
TA 被下游反压 = TA_ADDR_STALLED_BY_TC_CYCLES / (GRBM_GUI_ACTIVE × cu_per_gpu)
```

**这两个的组合是整个分析的分水岭:**

| FIFO_FULL | TA_ADDR_STALLED | 结论 | 往哪查 |
|---|---|---|---|
| 高 | **低** | TA 活太多 | **指令条数 / 合并度** |
| 高 | 高 | TA 被 L1/L2/HBM 堵 | 下游 TCP → TCC → EA |
| 低 | 低 | 不是发射问题 | 看 `vmcnt` 延迟、I-cache 缺失、wave 数不足 |

---

## 3. 实战:一个 FP4 GEMM

被测 kernel:`fp4_gemm_4wave`,MXFP4 矩阵乘,M=N=K=8192,基线 **242 µs / 4526 TFLOPS**。这已经是个调得相当好的 kernel(用了 direct-to-LDS、8 buffer LDS ping-pong、MFMA 与 load 交错),不是随便写的反面教材。

### 3.1 第一趟:确认是不是发射问题

```bash
rocprofv3 --pmc SQ_VMEM_TA_CMD_FIFO_FULL SQ_VMEM_TA_ADDR_FIFO_FULL \
                SQ_BUSY_CYCLES SQ_WAIT_INST_ANY SQ_INSTS_VMEM \
                TA_TA_BUSY TA_ADDR_STALLED_BY_TC_CYCLES GRBM_GUI_ACTIVE \
          --kernel-include-regex "kernel_gemm" \
          --output-format csv -d out -o p1 -- python3 your_bench.py
```

> **注意 block 的槽位限制。** 一次能同时采的计数器数量是硬件限制的:
> SQ=8, SPI=6, TCP=4, TCC=4, TA=2, TD=2, CPC=2, CPF=2, GRBM=2
> (见 `rocprofiler-compute/src/utils/mi_gpu_spec.yaml`)
> 超了 rocprofv3 会自动多趟重放 kernel,不同趟之间的数据严格来说不可比。
> 上面这组 SQ 类 5 个、TA 类 2 个,刚好一趟采完。

结果(每次 dispatch 平均):

| 计数器 | 值 |
|---|---|
| `SQ_BUSY_CYCLES` | 12,802,567 |
| `SQ_VMEM_TA_CMD_FIFO_FULL` | 3,483,262 |
| `SQ_VMEM_TA_ADDR_FIFO_FULL` | 2,895,311 |
| `TA_TA_BUSY` | 54,027,298 |
| `TA_ADDR_STALLED_BY_TC_CYCLES` | 1,010,418 |
| `GRBM_GUI_ACTIVE` | 3,540,485 |

算一下:

```
命令 FIFO 满  = 3,483,262 / 12,802,567 = 27.2%    ← 阈值 10%,超了 2.7 倍
地址 FIFO 满  = 2,895,311 / 12,802,567 = 22.6%
TA 忙碌率     = 54,027,298 / (442,561 × 256)  = 47.7%
TA 被下游堵   =  1,010,418 / (442,561 × 256)  =  0.9%    ← 几乎为零
```

> ⚠️ **分母有坑,这里花一分钟说清楚。**
>
> `rocprofv3` 报的 `GRBM_GUI_ACTIVE = 3,540,485` 是 **8 个 XCD 求和后**的值。
> 而官方公式(`analysis_configs/gfx950/*.yaml`)用的是 `$GRBM_GUI_ACTIVE_PER_XCD × $cu_per_gpu`,
> 即 **单 XCD 周期数 × 全卡 CU 数** = `(3,540,485 / 8) × 256` = `442,561 × 256`。
>
> 自检方法:`442,561 周期 ÷ 2.4 GHz ≈ 184 µs`,和实测 kernel 时长 235 µs 同量级 ✓
> 如果你误用了求和值 3,540,485 当作单 XCD 周期,会得到 ~24 µs 这种明显不合理的数。

**结论落在表格第一行:发射受限,且 TA 没有被下游反压。**

顺带把 §1.3 那个失配数算实:

```
TA busy cycles/CU = 47.7% × 442,561 = 211,101
每 CU 的 VMEM 指令 = 4,194,304 / 256 = 16,384
=> TA 每条指令占用 = 211,101 / 16,384 = 12.9 周期
```

**发射侧 1 周期能塞一条,TA 侧 12.9 周期才排空一条。** FIFO 必然被填满。

这个 0.9% 非常重要——它意味着**继续往 TCC、HBM、Infinity Fabric 查是浪费时间**。很多人的直觉是"访存慢 → 查 L2 命中率 → 查带宽",在这个 kernel 上会一无所获。瓶颈在 CU 内部的地址生成前端。

### 3.2 第二趟:量化合并度

```bash
rocprofv3 --pmc TA_TOTAL_WAVEFRONTS TA_BUFFER_READ_WAVEFRONTS TA_BUFFER_WRITE_WAVEFRONTS \
                TCP_TOTAL_READ TCP_TOTAL_WRITE TCP_TOTAL_ACCESSES TCP_GATE_EN1 \
          --kernel-include-regex "kernel_gemm" --output-format csv -d out -o p2 -- python3 your_bench.py
```

官方的合并度公式(`analysis_configs/gfx950/1600_vector_l1_data_cache.yaml`):

```
Coalescing (%) = 100 × 64 × TA_TOTAL_WAVEFRONTS / (4 × TCP_TOTAL_ACCESSES)
```

范围 25%(完全不合并)到 100%(完美)。**≤50% 判定 TA 为瓶颈。**

但**直接套总量公式会得出误导性结论**,这是本文最想强调的一点。我们把读写分开:

| | 指令数/wave | TCP 访问/wave | 每条指令的访问数 | 合并度 |
|---|---|---|---|---|
| 读 | 768 | 36,864 | **48.0** | **33.3%** |
| 写 | 256 | 4,096 | 16.0 | 100% |

读侧 33.3%,平均每条读指令产生 **48 个 TCP 访问**。看起来是灾难性的不合并。

**但这个平均值是个陷阱。**

> 用 §1.5 的模型就能立刻看穿:读指令有两种,`dwordx4`(16 个 tag 访问)和 `dword`(4 个)。
> K=8192 时两者比例是 2:1,加权平均 = (2×16 + 1×4)/3 ≈ 12……
> **但实测是 48,差了 4 倍。** 这个对不上的差值本身就是线索——
> 说明 `TCP_TOTAL_READ` 统计的粒度比 tag 访问更细(约 16B/次)。
> 所以**合并度百分比只适合做趋势对比,绝对值要回到 §1.5 的 tag 模型上算。**

### 3.3 关键一步:别信平均值,去看 ISA

平均值把两种完全不同的指令混在了一起。dump ISA 直接数:

```bash
FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/isa python3 -c "...compile only..."
grep -oE "buffer_load[a-z0-9_]*|buffer_store[a-z0-9_]*|ds_read[a-z0-9_]*" \
     /tmp/isa/kernel_gemm_0/21_final_isa.s | sort | uniq -c | sort -rn
```

```
    256 buffer_store_short
    128 ds_read_b128
     64 buffer_load_dwordx4      ← 全部带 lds 修饰符(direct-to-LDS)
     32 buffer_load_dword
```

现在建模验证。K=4096(16 个 K-step)时,每 wave 的读指令应该是:

```
G2S 主数据:  16 ksteps × 16 = 256 条 buffer_load_dwordx4 (direct-to-LDS)
scale 加载:  16 ksteps ×  8 = 128 条 buffer_load_dword
                             ─────
                              384 条  ✓ 实测 384.0

TCP 读访问 = 256 × 64  +  128 × 16  = 18,432   ✓ 实测 18,432.0
             ↑            ↑
        主数据每条        scale 每条
        64 个访问         16 个访问
```

**模型精确匹配实测。** 现在真相清楚了:

| 来源 | 指令数 | 占比 | 每条 TCP 访问 | 说明 |
|---|---|---|---|---|
| **G2S 主数据** | 256 (67%) | | **64** | 每 lane 搬 128B,**这是必要的数据量** |
| **scale 加载** | 128 (33%) | | **16** | 每 lane 只取 **4 字节** |

**注意这个反直觉的结论:那个"48 accesses/指令"的可怕平均值,主要来自 G2S 主数据(64 accesses),而 G2S 恰恰是这个 kernel 里写得最好的部分。**

它是 `buffer_load_dwordx4 ... lds`——direct-to-LDS,绕过寄存器文件直接写 LDS,一条指令搬 64 lane × 128B = 8KB。它的 64 个 TCP 访问不是浪费,是**真的要搬这么多数据**。这已经是最优形态了。

真正低效的是 scale:**33% 的读指令,只为了每 lane 取 4 字节。**

如果只看总合并度 33.3% 就去"优化合并",你会盯着 G2S 改半天,而它本来就没问题。

---

## 4. 从计数器回到代码

对着 kernel 源码,scale 加载长这样:

```python
def load_step(self, kstep, base_tile):
    for g in range_constexpr(self.n_groups):
        i32_off = (base_group + g) * self.row_stride + kstep * 64 + lane
        out.append(buffer_load(self.rsrc, i32_off, vec_width=1, dtype=fx.Int32))
        #                                          ^^^^^^^^^^^ 每次 4 字节
```

每个 K-step 发 8 条 `buffer_load_dword`,每条每 lane 取 4 字节。K=8192 时累计 **256 条指令,占全部读指令的 33%**,而搬运的数据量占比不到 2%。

**这就是 TA 压力的主要可优化来源。**

修复方向也很直接:相邻 K-step 的 scale 在内存里是连续的(offset 里 `kstep * 64` 是线性项),所以可以**一次取多个 K-step 的 scale**。取 4 个 K-step 就是 `dwordx4`,指令数直接降到 1/4。

**为什么这样确实有效——用 §1.5 的模型算一遍:**

合并指令**不一定**降低 tag 访问总数。如果 4 条指令访问的是 4 段互不相邻的地址,合并后单条指令跨的 64B 区间数会等比上升,总和不变,只省下指令条数的固定开销。

但 scale 这个场景是**净赚**的,因为它满足一个关键条件:**这些数据本来就挤在同一批 64B line 里,现在被多条指令重复请求。**

```
现在  :每 K-step 8 条 dword,每条跨 4 个 64B 区间 → 8 × 4 = 32 tag 访问 / K-step
      但这 8 条访问的地址范围只有 8 × 256B = 2KB = 32 个 64B line
      → 32 个 line 被 32 次访问,看似 1:1,实际相邻 K-step 会反复命中同一批 line

合并 4 个 K-step 后:2 条 dwordx4,每条跨 16 个区间 → 2 × 16 = 32 tag 访问 / 4 K-step
      → 摊到每 K-step 只有 8 个 tag 访问,降为 1/4
```

**指令数降到 1/4,tag 访问也降到 1/4。** 这是因为合并后的访问是**紧密连续**的——同一个 64B line 里的 16 个 dword 现在被一条指令一次取走,而不是被 16 条指令分别请求。

> **判断能不能这样合并的通用准则:**
> 看这几条指令的地址是否**在同一批 cacheline 内**。是 → 合并净赚;
> 否(各自跨到远处)→ 只省指令条数,tag 访问不变,收益有限。

**同一个 cacheline 现在被 8 条指令重复请求了多次。** 合并之后这些重复请求消失——省下的不只是指令条数,是实打实的 cacheline 请求总量。这才是收益的真正来源。

> 本文只做定位,不做优化实现——这是下一篇的内容。

---

## 5. 副产品:用 K 扫描分离固定开销

发射分析之外,还有一个几乎零成本的技巧:**扫 K,做线性拟合**。

GEMM 的时间应该是 `固定开销 + 每 K-step 开销 × K-step 数`。测 6 个 K 值:

| K-steps | 24 | 32 | 40 | 48 | 56 | 64 |
|---|---|---|---|---|---|---|
| µs | 185.3 | 242.9 | 277.7 | 357.9 | 386.7 | 421.4 |

最小二乘拟合:

```
时间(µs) = 6.04 × ksteps + 46.1
                            ^^^^
                    与 K 无关的固定开销
```

**46 µs 固定开销,在 K=8192 时占总时间的 19%。** 主要来自 epilogue——ISA 里那 256 条 `buffer_store_short`,每次只存一个 bf16。

（本文先搁置 store:它有成熟解法——先在 LDS 里做一次 shuffle 换布局,再用 `float4` 宽存,能把 256 条降到 ~16 条。但 hot loop 里的 load 才是主要矛盾,先集中火力。）

扣掉固定开销后,稳态段是 **5600~5900 TFLOPS**。这个数字告诉你 hot loop 本身其实相当健康,天花板主要被固定开销和 scale 加载拉低。

---

## 6. ⚠️ 四个真实踩过的坑

这些不是理论提醒,是我在做这次分析时**实际踩到并纠正**的。

### 坑 1:同进程连续测多个 shape,数据会骗你

我第一版扫描脚本在一个进程里循环测 K=4096→16384,结果:

```
K=12288   381.7 us   4320 TFLOPS   us/kstep =  7.95
K=14336  3991.0 us    482 TFLOPS   us/kstep = 71.27   ← 9 倍悬崖!
```

看起来像重大发现。**但它是假的。**

核实方法很简单——用 `rocprofv3` 看 kernel 本身的时长,而不是 wall clock:

```
kernel_gemm_0 @ K=14336:  442 µs      ← 而不是 3991 µs
GRBM_GUI_ACTIVE:  5.59M vs 4.87M      ← +15%,对应 K 的 +17%,完全线性
```

GPU 侧周期数**线性正常**,是主机侧的问题(显存碎片/分配开销)。改成每个 K 独立进程重跑,曲线完全平滑:

```
K= 8192  242.9 us   K=12288  361.4 us   K=14336  386.7 us   K=16384  452.3 us
```

**教训:wall-clock 异常时,先用 GPU 侧计数器交叉验证再下结论。** 我差点把这个"发现"当成 kernel 的问题报出去。

### 坑 2:512B stride 的 tag 冲突 —— 以及"符合条件≠真踩坑"

这是个**广为流传、确实存在、但极易误判**的坑,值得完整讲一遍。

**官方结论**([MI300X workload tuning guide](https://rocm.docs.amd.com/en/latest/how-to/tuning-guides/mi300x/workload.html)):

> 当矩阵的行 stride 是 **512 字节的倍数**时,会造成 Tagram 通道热点,
> *"causing a significant performance drop, especially for TN transpose cases…
> **increase the latency of VMEM instructions**."*
>
> **修法**:padding 让 stride 不是 512B 的倍数。例如 `K % 256 == 0` 时用 `lda = ldb = K + 128`。

原理:tag 查询要按地址的某几位选 tag bank(gfx950 有 4 个)。如果地址的这几位被 stride 固定住,所有访问挤向同一个 bank,**其余 bank 闲着**。

**但注意官方措辞是 "increase the latency"** —— 它首先影响的是 `vmcnt` 那条路。只有冲突严重到 TCP 反压 TA 时,才会传导成**发射**停顿。

**我们的 kernel 完全符合触发条件,实测却没踩坑。**

K=1024 时,A 的行 stride = `K/2` = **512 B,正好是 512 的倍数**。按传闻应该中招。实测:

| 计数器 | 实测 | 判据 |
|---|---|---|
| `TCP_READ_TAGCONFLICT_STALL_CYCLES` | **0** | ≥10% |
| `TCP_WRITE_TAGCONFLICT_STALL_CYCLES` | **0** | ≥10% |
| `TCP_ATOMIC_TAGCONFLICT_STALL_CYCLES` | **0** | ≥10% |

再看 4 个 tag bank 的请求分布(gfx950 独有的 `TCP_TAGRAM{0..3}_REQ`):

```
TAGRAM0  28.3%      TAGRAM1  21.7%
TAGRAM2  28.3%      TAGRAM3  21.7%        最大/最小 = 1.31×
```

**略有不均,但远不到热点级别**(真热点会看到某个 bank 占 70%+)。

**为什么没触发?**(以下是我的推断,AMD 文档没有明说)

- 官方案例针对 **TN transpose**:两个矩阵都按列访问,同一条指令的 64 个 lane 地址跨度极大,每个 lane 打到不同的 tag set
- 我们的 G2S 是 **8 个 lane 覆盖连续 128B**(见 §1.5),**同一条指令内部高度局部化**,tag 集中在少数几个 set 里
- B 矩阵还是 preshuffled 的,布局已被重排

**这个坑真正的教训不是"避开 512B",而是:**

> **表面条件符合 ≠ 真的踩坑。** 决定是否冲突的是**实际的 lane→地址映射**,
> 不是 stride 这一个数字。同样 512B stride,列访问会炸,行访问可能完全没事。
>
> **先测 `TCP_*_TAGCONFLICT_STALL_CYCLES` 和 `TCP_TAGRAM{0..3}_REQ`,再决定要不要 padding。**
> 盲目 padding 的代价是实打实的:显存变大、可能破坏对齐、影响其他访问的合并度。

⚠️ `TCP_TAGRAM{0..3}_REQ` 只有 gfx950 有。MI300 上只能靠 `TAGCONFLICT_STALL` 那三个判断。

### 坑 3:配置文件里有个不存在的计数器

`rocprofiler-compute` 的 gfx950 配置 `3000_mem_bw.yaml` 里引用了 `TA_ADDRESSER_STALLED_CYCLES`(出现 3 次),但 SDK 的计数器定义表里**根本没有这个计数器**:

```bash
grep -c "TA_ADDRESSER_STALLED_CYCLES" \
  /opt/rocm/share/rocprofiler-sdk/config.yaml
# → 0
```

相关指标在真机上出不来值。看到空值别慌,也别浪费时间调。

### 坑 4:EA 读 credit 计数器在 MI350 上不可靠

如果你顺着往下游查到了 HBM 带宽,注意这条:AMD 自己在 [rocm-systems#4237](https://github.com/ROCm/rocm-systems/pull/4237) 的验证里说明,MI350 上即使读带宽跑到 ~6 TB/s,`TCC_EA0_RDREQ_DRAM_CREDIT_STALL` 仍然 **< 1%**。

**读侧不能用来判断 HBM 读瓶颈。** 写侧是好的。判断读瓶颈请改用 L2-Fabric Read BW 对比理论带宽。

---

## 7. 用 PC Sampling 交叉验证

前面全部结论都建立在 PMC 上。**换一种完全独立的方法验证一遍**——如果两者指向同一处,结论才真的可信。

[PC Sampling](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/how-to/pc_sampling.html) 周期性抓取每个 wave 的 PC 和状态,直接告诉你**哪条指令在停、为什么停**。gfx950 支持 stochastic 模式(硬件采样,能给出停顿原因):

```bash
rocprofv3 --pc-sampling-beta-enabled \
          --pc-sampling-method stochastic \
          --pc-sampling-unit cycles --pc-sampling-interval 1048576 \
          --kernel-include-regex "你的kernel" --output-format csv \
          -d out -o pc -- ./your_app
```

### 7.1 ⚠️ 两道过滤,少一道结论就反了

**这是本节最重要的内容。** 原始输出直接汇总,得到的是:

```
WAITCNT                    79.0%   ← 看起来是延迟受限?!
ARBITER_WIN_EX_STALL        9.4%
```

**完全错误。** 要过滤两次:

**第一道:丢掉 `Instruction` 字段为空的行。** 这些 PC 解析不到任何 code object。

**第二道(极易漏):只保留本 kernel 的样本。** 两个事实叠加造成了这个坑:

```
① --kernel-include-regex 不过滤 PC sampling 数据流
② PC sampling 的 csv 里没有 Kernel_Name 列,只有 Dispatch_Id
```

即使加了 `--kernel-include-regex`,**进程里所有 kernel 的样本照样进 csv**;而光看这个 csv 又无法知道哪个 dispatch 属于谁。

**正解:采样时同时开 `--kernel-trace`**,它生成 `Dispatch_Id → Kernel_Name` 对照表,join 即可精确分离。本例:

```
9853 个原始样本
├─ 1925 个 PC 无法解析                                → 丢掉
├─ 4147 个来自 PyTorch 其他算子(reduce/elementwise)  → 丢掉
└─ 3781 个来自 kernel_gemm_0                          ← 只有这些有效
```

漏掉第二道的后果:`ARBITER_WIN_EX_STALL` 显示成 **9.4%** 而非真实的 **68.8%**,`WAITCNT` 显示成 **79%** 而非 **9.5%**——**结论完全反向**。发现线索是报告里出现了 `global_load_*` 的停顿,而我们 kernel 的 ISA 里 `grep -c global_load` 是 **0**。

> ⚠️ **不要用"我的 kernel 独有的指令"来猜。** 通用 opcode 可能和别的 kernel 重合,
> 而且会漏掉 dispatch(本例真实有 23 个,靠指令反查只找到 5 个)。详见 [02 §3.5](02-pc-sampling-howto.md)。

### 7.2 过滤后:两种方法指向同一处

kernel 内、未发射样本的真实分布(n=2909):

| 停顿原因 | 占比 | 含义 |
|---|---|---|
| **`ARBITER_WIN_EX_STALL`** | **68.8%** | **赢了仲裁,但执行单元不收** ← 发射受限 |
| `BARRIER_WAIT` | 13.6% | 等 barrier |
| `WAITCNT` | **9.5%** | 等数据返回 |
| `ALU_DEPENDENCY` | 7.6% | |
| `NO_INSTRUCTION_AVAILABLE` | 0.3% | |
| `ARBITER_NOT_WIN` | 0.2% | 仲裁竞争 |

**发射侧 68.8% vs 延迟侧 9.5%,相差 7.2 倍。** 这个 kernel 已经把 32 条 load 堆在飞行中,延迟掩盖得很好——正如 §1.2.5 的 ISA 所示。

**分清这两个 ARBITER 很关键:**

- **`ARBITER_NOT_WIN`** = 没抢到发射槽(wave 之间竞争)
- **`ARBITER_WIN_EX_STALL`** = **抢到了却发不出去,因为下游满了** ← 这才对应 `SQ_VMEM_TA_*_FIFO_FULL`

再看 `ARBITER_WIN_EX_STALL`(n=2002)落在哪些指令上:

| 样本数 | 占比 | 指令 | 对应什么 |
|---|---|---|---|
| **1078** | **53.8%** | `buffer_store_short` | epilogue,每 wave 256 条,每 lane 只写 2B |
| **464** | **23.2%** | `buffer_load_dwordx4` | G2S 主数据,direct-to-LDS,每 wave 64 条 |
| 223 | 11.1% | `v_mfma_scale_f32_16x16x128` | MFMA |
| 114 | 5.7% | `buffer_load_dword` | scale 加载,每 wave 32 条 |
| 40 | 2.0% | `ds_read_b128` | LDS |

**VMEM 指令占了 `ARBITER_WIN_EX_STALL` 的 83%。** 这正是 §3.1 那个 27.2% 在指令级的样子——PMC 说"VMEM 发射被 TA 队列堵住",PC Sampling 说"堵的就是这几条 `buffer_*`"。

对照 `ARBITER_NOT_WIN` 只有 **5 个样本(0.2%)**——**wave 之间几乎没有仲裁竞争**,卡的全是"抢到了却发不出去"。

**两种独立方法、同一个结论。**

### 7.3 一个 PMC 没看出来的排序

PC Sampling 补上了 PMC 给不了的信息:**同样是 VMEM 发射停顿,哪条指令占大头。**

```
buffer_store_short  1078 样本 (53.8%)   ← 最大单一来源
buffer_load_dwordx4  464 样本 (23.2%)
buffer_load_dword    114 样本 ( 5.7%)
```

这和 §1.5 的浪费倍数模型**互相印证**:

| | 浪费倍数 | PC 停顿样本 | 结论 |
|---|---|---|---|
| store | **2.0** | **1078(最多)** | 两个方法都指向它 |
| G2S | 1.0 | 464 | 量大但零浪费,不可优化 |
| scale | 1.0 | 114 | 单条最优,靠减条数 |

**store 是浪费倍数最高、且实测停顿样本最多的**——两条独立证据都说它该先改。本文前面按"hot loop 优先"把 store 排在后面,**从这个数据看应该提前**。

### 7.4 那应该先跑 PC Sampling 吗?

一个自然的想法是:PC Sampling 直接指到指令,是不是该先跑?**实测下来答案是否定的**,建议仍然 **PMC 先行**:

| | PMC(第 1 步那趟) | PC Sampling |
|---|---|---|
| 耗时 | **6.7 s** | 10.7 s |
| 统计基础 | 全量计数,**1280 万个周期** | **抽样**,过滤后 2909 个有效停顿样本 |
| 误差 | 无抽样误差 | 68.8% **± 1.7%**(95% CI,采样越密越准但越慢) |
| 阈值 | 有官方判据(≥10%) | **无**,只能看相对占比 |
| 数据可信度 | 直接可用 | **必须先过滤 NO_INST**,否则结论反向 |
| 定位精度 | 到硬件单元 | **到具体指令** ← 优势 |

三个理由:

1. **PC Sampling 更慢**(本例 10.7s vs 6.7s),"更快"是错觉
2. **是抽样不是全量**:本例加密采样后有 2909 个有效停顿样本(±1.7%),但默认间隔下只有 309 个(±5.2%)。**要好精度就得跑更久,PMC 没有这个取舍**
3. **没有阈值可依**:PMC 有"≥10% 即认定反压"这样的官方判据;PC Sampling 只有相对占比,**没有基准告诉你多少算高**

**正确的用法是互补:**

```
PMC 定方向(哪个硬件单元、超没超阈值)
   ↓
PC Sampling 定位置(具体哪条指令)
   ↓
两者一致 → 结论可信;不一致 → 有一方的理解错了,继续查
```

反过来先跑 PC Sampling 也不是不行,但你会拿着"68.8% ARBITER_WIN_EX_STALL"不知道**这算高还是不算高**——没有基准,而且很容易漏掉 §7.1 那两道过滤。

> 📄 **完整报告**:[`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt)
> 含停顿原因分布、`ARBITER_WIN_EX_STALL` 按指令分解、停顿原因 × 指令矩阵、热点 PC 列表。

---

## 8. 速查表

> 判定流程和核心公式见开头的 **TL;DR**。这里是完整参考:每站的计数器归属、全部公式、以及经验总结。

**判定流程(展开版):**

```
① SQ_VMEM_TA_CMD_FIFO_FULL / SQ_BUSY_CYCLES  ≥ 10% ?
   │
   ├─ 否 → 不是发射问题。查 vmcnt 延迟 / I-cache 缺失 / wave 数不足
   │
   └─ 是 → ② TA_ADDR_STALLED_BY_TC_CYCLES / (GRBM_PER_XCD×CU) 高吗?
             │
             ├─ 高 → TA 被下游反压。分两支继续:
             │        ├ TCP_UTCL1_STALL_* / TCP_GATE_EN2 ≥10% → TLB 问题,上大页
             │        └ TCP_TCR_TCP_STALL / TCP_GATE_EN1 ≥10% → L2 问题,查 TCC/EA
             │
             └─ 低 → TA 活太多(本文的情况)
                       ├→ ③ 分读写算合并度
                       ├→ ④ dump ISA,数指令,别信平均值
                       └→ ⑤ 建 §1.5 tag 模型,对上实测再动手
```

**每站的对应计数器**(照着链路查):

| 站 | 单元 | 主计数器 | 停顿计数器 |
|---|---|---|---|
| ① | SQ 调度器 | `SQ_INSTS_VMEM` | `SQ_VMEM_TA_{CMD,ADDR}_FIFO_FULL` |
| ③ | TA 地址生成 | `TA_TOTAL_WAVEFRONTS` / `TA_TA_BUSY` | `TA_ADDR_STALLED_BY_{TC,TD}_CYCLES` |
| ④ | TCP (vL1D) | `TCP_TOTAL_CACHE_ACCESSES` / `TCP_TCC_*_REQ` | `TCP_TCR_TCP_STALL_CYCLES` / `TCP_PENDING_STALL_CYCLES` |
| ④ | UTCL1 (TLB) | `TCP_UTCL1_REQUEST` | `TCP_UTCL1_STALL_*` |
| ⑤ | TCC (L2) | `TCC_REQ` / `TCC_HIT` / `TCC_MISS` | `TCC_TAG_STALL` / `TCC_IB_STALL` |
| ⑥ | EA → HBM | `TCC_EA0_RDREQ` / `TCC_EA0_WRREQ` | `TCC_EA0_*_CREDIT_STALL` |

**核心公式:**

| 指标 | 公式 | 判据 |
|---|---|---|
| VMEM 发射停顿 | `SQ_VMEM_TA_CMD_FIFO_FULL / SQ_BUSY_CYCLES` | ≥10% |
| TA 忙碌率 | `TA_TA_BUSY / (GRBM_PER_XCD × cu_per_gpu)` | — |
| TA 被反压 | `TA_ADDR_STALLED_BY_TC_CYCLES / (GRBM_PER_XCD × cu_per_gpu)` | 高=下游堵 |
| 合并度 | `100 × 64 × TA_TOTAL_WAVEFRONTS / (4 × TCP_TOTAL_ACCESSES)` | ≤50% |
| L1→L2 反压 | `100 × TCP_TCR_TCP_STALL_CYCLES / TCP_GATE_EN1` | ≥10% |
| TLB 容量不够 | `100 × TCP_UTCL1_STALL_INFLIGHT_MAX / TCP_GATE_EN2` | ≥10% |
| 页表遍历慢 | `100 × TCP_UTCL1_STALL_LFIFO_NO_RES / TCP_GATE_EN2` | ≥10% |
| tag 冲突 | `100 × TCP_READ_TAGCONFLICT_STALL_CYCLES / TCP_GATE_EN1` | ≥10% |
| tag bank 热点 | `TCP_TAGRAM{0..3}_REQ` 四者是否均衡 | 某 bank ≫ 25% |
| **tag 访问浪费倍数** | `实际 tag 访问 / ceil(实际搬运字节 / 64)` | **>1.0 可优化** |

> `GRBM_PER_XCD = rocprofv3 报的 GRBM_GUI_ACTIVE / XCD 数`(MI355X 是 8)。
> TCP 类指标的分母是 `TCP_GATE_EN1`(TCP 接口时钟),UTCL1 类用 `TCP_GATE_EN2`,**都不是 GRBM**。
> `TCP_UTCL1_*` 只有 gfx950 有。

**block 槽位限制**(一趟能采几个):

```
SQ:8   SPI:6   TCP:4   TCC:4   TA:2   TD:2   CPC:2   CPF:2   GRBM:2
```

**六条经验:**

1. **发射受限的药方和延迟受限相反。** 前者要减少指令条数,后者要增加 inflight instructions。先分清再动手。
2. **TA 不是缓存。** 每条 VMEM 指令都必过 TA(`SQ_INSTS_VMEM == TA_TOTAL_WAVEFRONTS`,实测完全相等),命中率再高也不减轻它的负担。这类瓶颈只能靠减少指令数和改善合并度来解。
3. **算「浪费倍数」,不要看 tag 访问的绝对量。** `实际 tag 访问 / ceil(搬运字节/64)`。本文里 G2S 每条产生 16 个 tag 访问(全 kernel 最多),浪费倍数却是 **1.0——零浪费**;store 每条只有 4 个,浪费倍数 **2.0**。**多不等于差。**
4. **浪费 1.0 时改 lane 映射没用,要减指令条数。** 两条路径别用错:浪费 >1.0 → 改 swizzle;多条指令挤在同一批 cacheline → 合并成更宽的 load。scale 属于后者。
5. **模型对不上就别动手。** 建模型(Σ 指令数 × 每条 tag 访问数),和 `TCP_TOTAL_CACHE_ACCESSES` 对比。本文模型精确命中 **2176**,零误差——正是这个匹配才让后面的优化决策站得住。对不上说明你对某条指令的地址模式理解错了。
6. **传闻的坑要实测验证。** 本文的 kernel 完全符合"512B stride"这个著名踩坑条件,实测 tag 冲突却是 **0**。决定冲突的是实际 lane→地址映射,不是 stride 这一个数字。

---

## 下一篇

- 把 scale 加载合并成 `dwordx4`,看发射停顿率能降多少
- LDS shuffle + `float4` 宽存改造 epilogue,冲那 46 µs 固定开销(store 浪费倍数 2.0,是唯一两条路都有空间的)
- 按 §7.3 的排序先改 store:它浪费倍数 2.0、PC 停顿样本 1078(占 53.8%),两个独立方法都指向它
- 优化后重新跑同一套 PMC + PC Sampling,验证瓶颈是否真的转移

---

## 参考

- [CDNA Performance Model](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/conceptual/cdna/cdna-performance-model.html)
- [Vector L1 Cache](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/conceptual/cdna/vector-l1-cache.html)
- 计数器定义:`/opt/rocm/share/rocprofiler-sdk/config.yaml`
- 判据来源:`rocprofiler-compute/src/rocprof_compute_soc/analysis_configs/gfx950/3000_mem_bw.yaml`
- 阈值验证 PR:[#3836](https://github.com/ROCm/rocm-systems/pull/3836) (L1) · [#4091](https://github.com/ROCm/rocm-systems/pull/4091) (L2) · [#4237](https://github.com/ROCm/rocm-systems/pull/4237) (EA)
