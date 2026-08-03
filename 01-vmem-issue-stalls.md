# 01 · 当 vmcnt 不是瓶颈:用 PMC 定位 VMEM 发射停顿

> 平台:AMD Instinct MI355X (gfx950 / CDNA4),ROCm `rocprofv3`
> 案例:一个真实的 MXFP4 GEMM kernel,M=N=K=8192,4250 TFLOPS

---

## 0. 这篇要解决的问题

打开 [CDNA Performance Model](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/conceptual/cdna/cdna-performance-model.html),你会看到几百个指标,按 CU、L2、SE、CP 分门别类。文档告诉你每个指标**是什么**,但没告诉你**什么时候该看哪个**。

结果就是大部分人只用两招:看 occupancy,看 cache 命中率。这两招对访存受限的 kernel 有用,但对一类非常常见的情况完全失效——

**你的 load 指令发不出去。**

不是数据回来得慢(那是延迟问题,看 `vmcnt`),而是指令**根本挤不进访存管线**。这两件事的症状看起来一样(波前停着不动),但**药方完全相反**:延迟问题要增加 inflight instructions,发射问题要减少请求条数。搞反了会越优化越慢。

这篇讲怎么用三五个 PMC 在十分钟内区分这两者,并定位到具体代码行。

---

## 1. 先建立一个结构性直觉

在讲计数器之前,你需要知道 CDNA CU 内部的一个**不对称性**。这个不对称是后面所有分析的基础。

```
                    ┌─────────── 一个 CU ───────────┐
                    │                                │
     SIMD0  SIMD1  SIMD2  SIMD3      ← VALU:每个 SIMD 一个,共 4 个
       │      │      │      │
       └──────┴───┬──┴──────┘
                  │
                 TA                  ← 地址生成:整个 CU 只有 1 个
                  │
              TCP (vL1D)             ← L1 向量缓存:整个 CU 只有 1 个
                  │
                 TD                  ← 数据返回:整个 CU 只有 1 个
```

**向量运算的发射带宽是每周期 4 条,访存指令是每周期 1 条,而且四个 SIMD 要抢。**

推论:只要指令流里访存指令占比超过约 1/4,你在**结构上**就必然是 TA 发射受限的——跟带宽、跟缓存命中率、跟 HBM 统统没关系。

更关键的是 TA 处理一条指令的**耗时不是常数**,取决于这条指令要拆成多少个 cacheline 请求:

| 访问模式 | 一条指令产生的 TCP 访问 | TA 占用 |
|---|---|---|
| 64 lane 完美合并读 128B | 4 | ~4 周期 |
| 64 lane 各读 4 字节(分散) | 64 | ~64 周期 |

**同样一条指令,代价能差 16 倍。** 在这几十个周期里,后面所有想发访存指令的波前全部堵住。

这就是为什么"指令条数"和"每条指令的合并度"是发射受限分析的两个核心变量。

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
| 低 | 低 | 不是发射问题 | 看 `vmcnt`、I-cache、MFMA 抢发射槽 |

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
TA 忙碌率     = 54,027,298 / (3,540,485 × 32) = 47.7%
TA 被下游堵   =  1,010,418 / (3,540,485 × 32) =  0.9%    ← 几乎为零
```

**结论落在表格第一行:发射受限,且 TA 没有被下游反压。**

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

（这部分本文按你的判断先搁置:store 有成熟的解法——先在 LDS 里做一次 shuffle 换布局,再用 `float4` 宽存,能把 256 条降到 ~16 条。但 hot loop 里的 load 才是主要矛盾。）

扣掉固定开销后,稳态段是 **5600~5900 TFLOPS**。这个数字告诉你 hot loop 本身其实相当健康,天花板主要被固定开销和 scale 加载拉低。

---

## 6. ⚠️ 三个真实踩过的坑

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

### 坑 2:配置文件里有个不存在的计数器

`rocprofiler-compute` 的 gfx950 配置 `3000_mem_bw.yaml` 里引用了 `TA_ADDRESSER_STALLED_CYCLES`(出现 3 次),但 SDK 的计数器定义表里**根本没有这个计数器**:

```bash
grep -c "TA_ADDRESSER_STALLED_CYCLES" \
  /opt/rocm/share/rocprofiler-sdk/config.yaml
# → 0
```

相关指标在真机上出不来值。看到空值别慌,也别浪费时间调。

### 坑 3:EA 读 credit 计数器在 MI350 上不可靠

如果你顺着往下游查到了 HBM 带宽,注意这条:AMD 自己在 [rocm-systems#4237](https://github.com/ROCm/rocm-systems/pull/4237) 的验证里说明,MI350 上即使读带宽跑到 ~6 TB/s,`TCC_EA0_RDREQ_DRAM_CREDIT_STALL` 仍然 **< 1%**。

**读侧不能用来判断 HBM 读瓶颈。** 写侧是好的。判断读瓶颈请改用 L2-Fabric Read BW 对比理论带宽。

---

## 7. 速查表

**判定流程:**

```
① SQ_VMEM_TA_CMD_FIFO_FULL / SQ_BUSY_CYCLES  ≥ 10% ?
   │
   ├─ 否 → 不是发射问题。查 vmcnt 延迟 / I-cache / MFMA 抢发射槽
   │
   └─ 是 → ② TA_ADDR_STALLED_BY_TC_CYCLES / (GRBM×CU) 高吗?
             │
             ├─ 高 → TA 被下游堵。查 TCP → TCC → EA
             │
             └─ 低 → TA 活太多。③ 分读写算合并度
                       │
                       └→ ④ dump ISA,数指令,别信平均值
```

**核心公式:**

| 指标 | 公式 | 判据 |
|---|---|---|
| VMEM 发射停顿 | `SQ_VMEM_TA_CMD_FIFO_FULL / SQ_BUSY_CYCLES` | ≥10% |
| TA 忙碌率 | `TA_TA_BUSY / (GRBM_GUI_ACTIVE × cu_per_gpu)` | — |
| TA 被反压 | `TA_ADDR_STALLED_BY_TC_CYCLES / (GRBM_GUI_ACTIVE × cu_per_gpu)` | 高=下游堵 |
| 合并度 | `100 × 64 × TA_TOTAL_WAVEFRONTS / (4 × TCP_TOTAL_ACCESSES)` | ≤50% |
| L1→L2 反压 | `100 × TCP_TCR_TCP_STALL_CYCLES / TCP_GATE_EN1` | ≥10% |

**block 槽位限制**(一趟能采几个):

```
SQ:8   SPI:6   TCP:4   TCC:4   TA:2   TD:2   CPC:2   CPF:2   GRBM:2
```

**三条经验:**

1. **发射受限的药方和延迟受限相反。** 前者要减少指令条数,后者要增加 inflight instructions。先分清再动手。
2. **总合并度会骗人。** 必读写分开、按来源分开。一条搬 8KB 的 direct-to-LDS 产生 64 个访问是健康的,一条取 4 字节的 scale load 产生 16 个访问是浪费。
3. **计数器和 ISA 要互相印证。** 建个模型(指令数 × 每条访问数),和实测对上了才敢下结论。本文的模型精确命中 18,432,这个匹配才让"scale 是主要可优化项"的结论站得住。

---

## 下一篇

- 把 scale 加载合并成 `dwordx4`,看发射停顿率能降多少
- LDS shuffle + `float4` 宽存改造 epilogue,冲那 46 µs 固定开销
- 优化后重新跑同一套 PMC,验证瓶颈是否真的转移

---

## 参考

- [CDNA Performance Model](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/conceptual/cdna/cdna-performance-model.html)
- [Vector L1 Cache](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/conceptual/cdna/vector-l1-cache.html)
- 计数器定义:`/opt/rocm/share/rocprofiler-sdk/config.yaml`
- 判据来源:`rocprofiler-compute/src/rocprof_compute_soc/analysis_configs/gfx950/3000_mem_bw.yaml`
- 阈值验证 PR:[#3836](https://github.com/ROCm/rocm-systems/pull/3836) (L1) · [#4091](https://github.com/ROCm/rocm-systems/pull/4091) (L2) · [#4237](https://github.com/ROCm/rocm-systems/pull/4237) (EA)
