# rocm-perf-learning

在 AMD Instinct MI355X (gfx950 / CDNA4) 上做 kernel 性能分析的笔记。
每篇都基于同一个真实案例:一个 MXFP4 GEMM kernel(M=N=K=8192,~4500 TFLOPS)。

## 文章

| | 内容 |
|---|---|
| [**00 · PC Sampling 笔记:如何定位 buffer_load issue stall**](00-pc-sampling-buffer-load-issue-stall.md) | **从这里开始。** 用采样直接定位到「哪条指令在停、为什么停」。含 `rocprof-compute` 和 `rocprofv3` 两条路径的对比,以及一个会让结论完全反向的过滤陷阱。 |
| [**01 · 当 vmcnt 不是瓶颈:用 PMC 定位 VMEM 发射停顿**](01-vmem-issue-stalls.md) | 讲**为什么会停**。一条 `buffer_load` 的完整硬件链路、发射侧 vs 延迟侧的区分、PMC 判据,以及一个能从源码预测 TA 负担的定量模型(实测零误差)。 |

## 工具

- [`pc_sampling_report.py`](pc_sampling_report.py) — 把 PC sampling 输出聚合成可读报告。
  支持 `rocprof-compute analyze` 报告(`--from-analyze`)和 `rocprofv3` csv 两种输入。

## 案例报告

- [`pc-sampling-official.txt`](pc-sampling-official.txt) — 官方 `rocprof-compute` 路径
- [`pc-sampling-fp4-gemm.txt`](pc-sampling-fp4-gemm.txt) — `rocprofv3` 路径

两条路径的数据互为验证:`ARBITER_WIN_EX_STALL` 都是 **66.2%**。

## 这个案例的结论

被测 kernel 是**发射受限**而非延迟受限——指令挤不进访存管线,而不是数据回不来。
两种方法独立得出同一结论。优化目标随 shape 变化:K 小时 epilogue 的 `buffer_store_short` 是主要瓶颈,K 大时 MFMA 和 G2S 的绝对量更大——但 store 的单位代价始终最高。

**一个具体的可优化点**([00 §4.5](00-pc-sampling-buffer-load-issue-stall.md)):主循环每轮重算 10 条地址加法,
而 ISA 显示这些地址是**循环不变**的(基址寄存器在循环体内 0~1 次写入,偏移是编译期常量)。
把它们提到循环外可消除 `buffer_load` 前的 RAW 依赖——502 个 `ALU_DEP` 样本,占主循环停顿的 5.3%。

| 方法 | 证据 |
|---|---|
| PMC | `SQ_VMEM_TA_CMD_FIFO_FULL / SQ_BUSY_CYCLES` = **27.2%**(阈值 10%),而 `TA_ADDR_STALLED_BY_TC` 仅 0.9% → TA 活太多,不是被下游堵 |
| PC Sampling | `ARBITER_WIN_EX_STALL` 占 **66%**,`WAITCNT` 仅 8.7%;停顿率 store 83.5% > scale 79.4% > G2S 64.5% > MFMA 38.3% |
| tag 访问模型 | store 的浪费倍数 **2.0**(G2S 是 1.0),且占 73% 的指令数 |
