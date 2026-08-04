# 参考实现:aiter 手写 asm f4gemm

从 aiter 预编译 code object 反汇编出来的参考实现,用于对照分析。

## 来源

```
hsa/gfx950/f4gemm/f4gemm_bf16_per1x32Fp4_BpreShuffle_256x256.co
kernel: _ZN5aiter42f4gemm_bf16_per1x32Fp4_BpreShuffle_256x256E
```

反汇编命令:

```bash
llvm-objdump -d --mcpu=gfx950 f4gemm_bf16_per1x32Fp4_BpreShuffle_256x256.co
llvm-readelf --notes f4gemm_bf16_per1x32Fp4_BpreShuffle_256x256.co   # 元数据
```

## 文件

| | |
|---|---|
| [`aiter-f4gemm-256x256-gfx950.s`](aiter-f4gemm-256x256-gfx950.s) | 反汇编,3379 条指令 |
| [`aiter-f4gemm-256x256-gfx950.meta.yaml`](aiter-f4gemm-256x256-gfx950.meta.yaml) | kernel 参数、资源占用 |

## 资源占用

```
LDS      163840 B  (160 KB,gfx950 上限)
VGPR     512
SGPR     96
workgroup 256 threads (4 waves)
```

对比 FlyDSL 版本:LDS 131072 B / VGPR 256。**aiter 用满了 160KB LDS 和 512 VGPR。**

## 指令构成

```
  513  v_mul_f32_e32
  512  v_mfma_scale_f32_16x16x128_f8f6f4     ← MFMA
  512  v_accvgpr_read_b32
  256  v_accvgpr_write_b32
  256  v_cvt_pk_bf16_f32                     ← f32 -> bf16,一次转两个
  210  s_nop
  144  ds_read_b128
  128  v_permlane16_swap_b32_e32             ← ★ 跨 lane 转置
  128  buffer_atomic_pk_add_bf16             ← splitK 路径
   88  buffer_load_dwordx4
   32  buffer_store_dwordx4                  ← ★ 宽存,非 splitK 路径
   22  buffer_load_dword
```

## ★ 关键设计:epilogue 用 `permlane16_swap` 而非 LDS shuffle

这是和 FlyDSL 版本差别最大的地方,也是性能差距的主要来源。

**问题**:MFMA 的累加器布局是"每 lane 持有同一列的 4 个连续行",而输出矩阵要求相邻 lane 写相邻列。直接存就只能一次写一个 bf16(`buffer_store_short`)。

**FlyDSL 现在的做法**:每 lane 直接存,256 条 `buffer_store_short`,每条每 lane 只写 2 字节。

**aiter 的做法**:用 `v_permlane16_swap_b32` **在寄存器里做跨 lane 转置**,不经过 LDS:

```asm
v_cvt_pk_bf16_f32 v16, v8,  v9      ; f32x2 -> bf16x2,打包
v_cvt_pk_bf16_f32 v17, v10, v11
v_cvt_pk_bf16_f32 v18, v12, v13
v_cvt_pk_bf16_f32 v19, v14, v15
s_nop 1
v_permlane16_swap_b32_e32 v16, v18  ; 跨 lane 交换,换成连续布局
s_nop 1
v_permlane16_swap_b32_e32 v17, v19
s_nop 1
buffer_store_dwordx4 v[16:19], v235, s[4:7], 0 offen   ; 一次写 16 字节
```

**三步**:`cvt_pk` 打包 → `permlane16_swap` 转置 → `dwordx4` 宽存。

相比"LDS shuffle + 宽存"的方案,这条路**省掉了一次 LDS 往返和一个 barrier**。

PC sampling 实测(见 [`../reports/`](../reports/)):

| | store 指令 | 采样数 | 停顿率 |
|---|---|---|---|
| FlyDSL | `buffer_store_short` | 1741 | 84.3% |
| aiter | `buffer_store_dwordx4` | 1029 | 96.3% |

采样数少 41%;单条停顿率虽高,但那是满负荷工作(每条搬 8 倍的数据)。

## 另一个设计:splitK 用 atomic 累加

反汇编里有两条 epilogue 路径:

- **非 splitK**:`buffer_store_dwordx4` 直接写(32 条)
- **splitK**:`buffer_atomic_pk_add_bf16` 原子累加(128 条)

`pk_add_bf16` 一次原子加两个 bf16,避免了 splitK 常见的"额外 workspace + 二次 reduce"。
