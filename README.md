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

两条路径的数据互为验证:`ARBITER_WIN_EX_STALL` 分别是 69.3% 和 68.8%。

## 这个案例的结论

被测 kernel 是**发射受限**而非延迟受限——指令挤不进访存管线,而不是数据回不来。
两种方法独立得出同一结论,并且都指向同一个优化目标(epilogue 的 `buffer_store_short`)。

| 方法 | 证据 |
|---|---|
| PMC | `SQ_VMEM_TA_CMD_FIFO_FULL / SQ_BUSY_CYCLES` = **27.2%**(阈值 10%),而 `TA_ADDR_STALLED_BY_TC` 仅 0.9% → TA 活太多,不是被下游堵 |
| PC Sampling | `ARBITER_WIN_EX_STALL` 占 **69%**,其中 84% 是 VMEM 指令;`WAITCNT` 仅 9% |
| tag 访问模型 | store 的浪费倍数 **2.0**(G2S 是 1.0),且占 73% 的指令数 |
