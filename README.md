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

## 参考材料

- [`kernel_gemm_0_K8192.s`](kernel_gemm_0_K8192.s) — 被测 kernel 的最终 ISA(gfx950,K=8192)。
  主循环是第 773 行 `.LBB0_1` 到第 1788 行 `s_cbranch_vccnz`。

## 案例报告([`reports/`](reports/))

全部 M=N=K=8192,采集配置相同(`--pc-sampling-interval 1048576` + 250 次迭代),可直接横向对比。

**同一 kernel、两条采集路径**——数据互为验证,`ARBITER_WIN_EX_STALL` 都是 **66.2%**:

| 报告 | 采集方式 |
|---|---|
| [`pc-sampling-official.txt`](reports/pc-sampling-official.txt) | `rocprof-compute profile/analyze` |
| [`pc-sampling-fp4-gemm.txt`](reports/pc-sampling-fp4-gemm.txt) | `rocprofv3` 直采 |

**三个 kernel 实现的横向对比**:

| 报告 | 实现 | TFLOPS | 发射停顿 | epilogue store |
|---|---|---|---|---|
| [`pc-sampling-fp4-gemm.txt`](reports/pc-sampling-fp4-gemm.txt) | FlyDSL `main` | 4247 | 66.2% | `store_short` ×1583,停顿率 84.6% |
| [`pc-sampling-zty-dev-moe.txt`](reports/pc-sampling-zty-dev-moe.txt) | FlyDSL `zty_dev_moe` | 4392 | 66.1% | `store_short` ×1741,停顿率 84.3% |
| [`pc-sampling-aiter-asm.txt`](reports/pc-sampling-aiter-asm.txt) | aiter 手写 asm | **4583** | **60.7%** | **`store_dwordx4`** ×1029,停顿率 96.3% |

两个值得注意的点:

- **`zty_dev_moe` 消除了 `buffer_load_dwordx4` 的全部 `ALU_DEP`**(468 → 0),做法是把循环不变的地址计算从 VGPR 迁到 SGPR。但停顿率几乎没变(62.4% → 62.6%)——瓶颈只是从"等地址"转成了"等 TA 队列",**暴露得更清楚而非被消除**。
- **aiter 的 epilogue 用 `dwordx4` 宽存**,正是本仓库两条独立证据(浪费倍数 2.0 + 停顿率最高)指向的优化。store 采样数少 41%,单条停顿率虽高但那是满负荷工作。

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
