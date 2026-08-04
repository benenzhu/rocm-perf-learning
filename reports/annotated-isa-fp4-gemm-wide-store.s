; PC-sampling annotated disassembly   (r_results.json)
; code_object_id=3  samples=21774  landed on an instruction=21772 (100.0%)
; columns:  STALLED/SAMPLED  DOMINANT_REASON


/tmp/tmpxyex7w6f/kernel.hsaco:	file format elf64-amdgpu

Disassembly of section .text:

0000000000001a00 <kernel_gemm_0>:
	s_load_dwordx2 s[20:21], s[0:1], 0x4c                                                               ;     3/4     NO_INST_AVAIL
	s_load_dword s25, s[0:1], 0x64
	v_lshrrev_b32_e32 v3, 6, v0                                                                         ;     5/5     ARB_WIN_EX
	v_lshlrev_b32_e32 v70, 11, v3
	v_or_b32_e32 v6, 0x20400, v70
	s_waitcnt lgkmcnt(0)                                                                                ;    36/36    WAITCNT
	s_add_i32 s3, s21, 0xff
	s_ashr_i32 s4, s3, 31
	s_lshr_b32 s4, s4, 24
	s_add_i32 s4, s3, s4
	s_ashr_i32 s8, s4, 8
	s_and_b32 s4, s4, 0xffffff00
	s_cmp_lg_u32 s3, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s12, s8, 0
	s_add_i32 s3, s20, 0xff
	s_ashr_i32 s4, s3, 31
	s_lshr_b32 s4, s4, 24
	s_add_i32 s4, s3, s4
	s_ashr_i32 s13, s4, 8
	s_and_b32 s4, s4, 0xffffff00
	s_cmp_lg_u32 s3, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s3, s13, 0
	s_abs_i32 s6, s12
	v_cvt_f32_u32_e32 v1, s6
	s_sub_i32 s8, 0, s6
	s_mul_i32 s14, s12, s3
	s_ashr_i32 s3, s2, 31
	v_rcp_iflag_f32_e32 v1, v1                                                                          ;     2/4     ARB_WIN_EX
	s_ashr_i32 s7, s12, 31
	s_xor_b32 s15, s3, s7
	s_abs_i32 s7, s2
	v_mul_f32_e32 v1, 0x4f7ffffe, v1                                                                    ;     5/5     ARB_WIN_EX
	v_cvt_u32_f32_e32 v1, v1
	v_and_b32_e32 v7, 64, v0
	v_lshlrev_b32_e32 v8, 3, v3
	v_and_b32_e32 v9, 7, v0                                                                             ;     1/2     ARB_WIN_EX
	v_readfirstlane_b32 s9, v1
	s_mul_i32 s8, s8, s9                                                                                ;     2/2     ALU_DEP
	s_mul_hi_u32 s8, s9, s8
	s_add_i32 s9, s9, s8
	s_mul_hi_u32 s8, s7, s9
	s_mul_i32 s9, s8, s6
	s_sub_i32 s7, s7, s9
	s_add_i32 s9, s8, 1
	s_sub_i32 s10, s7, s6
	s_cmp_ge_u32 s7, s6
	s_cselect_b32 s8, s9, s8
	s_cselect_b32 s7, s10, s7
	s_add_i32 s9, s8, 1
	s_cmp_ge_u32 s7, s6
	s_cselect_b32 s6, s9, s8
	s_xor_b32 s16, s6, s15
	s_sub_i32 s6, s16, s15
	s_mul_i32 s17, s6, s12
	s_cmp_lg_u32 s2, s17
	s_cselect_b64 s[6:7], -1, 0
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[8:9], -1, 0
	s_xor_b32 s10, s12, s2
	s_cmp_lt_i32 s10, 0
	s_cselect_b64 s[10:11], -1, 0
	s_and_b64 s[6:7], s[10:11], s[6:7]
	s_subb_u32 s10, s16, s15
	s_lshr_b32 s3, s3, 29
	s_add_i32 s3, s2, s3
	s_sub_i32 s11, s2, s17
	s_ashr_i32 s15, s3, 3
	s_and_b32 s3, s3, -8
	s_cmp_lg_u32 s2, s3
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[6:7], s[8:9], s[6:7]
	s_subb_u32 s8, s15, 0
	s_sub_i32 s9, s2, s3
	s_ashr_i32 s2, s14, 31
	s_lshr_b32 s2, s2, 29
	s_add_i32 s2, s14, s2
	s_ashr_i32 s15, s2, 3
	s_and_b32 s2, s2, -8
	s_cmp_lg_u32 s14, s2
	s_cselect_b64 s[2:3], -1, 0
	s_cmp_lt_i32 s14, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[2:3], s[6:7], s[2:3]
	s_subb_u32 s2, s15, 0
	s_lshl_b32 s3, s12, 2
	s_abs_i32 s6, s3
	v_cvt_f32_u32_e32 v1, s6                                                                            ;     1/2     ARB_WIN_EX
	s_mul_i32 s2, s2, s9
	s_sub_i32 s7, 0, s6
	s_add_i32 s8, s8, s2
	v_rcp_iflag_f32_e32 v1, v1                                                                          ;     1/4     ARB_WIN_EX
	s_xor_b32 s2, s8, s3
	s_ashr_i32 s9, s2, 31
	s_abs_i32 s2, s8
	v_mul_f32_e32 v1, 0x4f7ffffe, v1
	v_cvt_u32_f32_e32 v1, v1
	v_lshlrev_b32_e32 v10, 4, v9
	v_and_b32_e32 v2, 63, v0
	v_bfe_u32 v154, v0, 5, 1
	v_readfirstlane_b32 s15, v1                                                                         ;     2/3     ARB_WIN_EX
	s_mul_i32 s7, s7, s15                                                                               ;     7/7     ALU_DEP
	s_mul_hi_u32 s7, s15, s7
	s_add_i32 s15, s15, s7
	s_mul_hi_u32 s7, s2, s15
	s_mul_i32 s15, s7, s6
	s_sub_i32 s2, s2, s15
	s_add_i32 s15, s7, 1
	s_sub_i32 s16, s2, s6
	s_cmp_ge_u32 s2, s6
	s_cselect_b32 s7, s15, s7
	s_cselect_b32 s2, s16, s2
	s_add_i32 s15, s7, 1
	s_cmp_ge_u32 s2, s6
	s_cselect_b32 s2, s15, s7
	s_xor_b32 s15, s2, s9
	s_sub_i32 s2, s15, s9
	s_mul_i32 s16, s2, s3
	s_cmp_lg_u32 s8, s16
	s_cselect_b64 s[2:3], -1, 0
	s_xor_b32 s6, s8, s12
	s_cmp_lt_i32 s6, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[2:3], s[6:7], s[2:3]
	s_subb_u32 s2, s15, s9
	s_sub_i32 s15, s8, s16
	s_lshl_b32 s18, s2, 2
	s_cmp_lg_u64 s[4:5], 0
	s_subb_u32 s6, s13, s18
	s_min_i32 s2, s6, 4
	s_abs_i32 s3, s2
	v_cvt_f32_u32_e32 v1, s3
	s_sub_i32 s23, 0, s3
	s_xor_b32 s7, s15, s2
	s_ashr_i32 s19, s7, 31
	v_rcp_iflag_f32_e32 v1, v1
	s_abs_i32 s7, s15
	s_load_dwordx2 s[4:5], s[0:1], 0x0
	s_load_dwordx2 s[8:9], s[0:1], 0x10
	s_load_dwordx2 s[12:13], s[0:1], 0x30
	s_load_dwordx2 s[16:17], s[0:1], 0x40
	v_bfe_u32 v155, v2, 4, 1
	v_mul_f32_e32 v1, 0x4f7ffffe, v1
	v_cvt_u32_f32_e32 v1, v1
	v_or_b32_e32 v66, 0x20000, v70                                                                      ;     1/1     ARB_WIN_EX
	s_mov_b32 s22, 0
	v_and_b32_e32 v5, 48, v0
	v_readfirstlane_b32 s24, v1                                                                         ;     1/2     ARB_WIN_EX
	s_mul_i32 s23, s23, s24                                                                             ;     3/3     ALU_DEP
	s_mul_hi_u32 s23, s24, s23
	s_add_i32 s24, s24, s23
	s_mul_hi_u32 s23, s7, s24
	s_mul_i32 s24, s23, s3
	s_sub_i32 s7, s7, s24
	s_add_i32 s24, s23, 1
	s_sub_i32 s26, s7, s3
	s_cmp_ge_u32 s7, s3
	s_cselect_b32 s23, s24, s23
	s_cselect_b32 s7, s26, s7
	s_add_i32 s24, s23, 1
	s_cmp_ge_u32 s7, s3
	s_cselect_b32 s3, s24, s23
	s_xor_b32 s23, s3, s19
	s_sub_i32 s3, s23, s19
	s_mul_i32 s24, s2, s3
	s_cmp_lg_u32 s15, s24
	s_cselect_b64 s[2:3], -1, 0
	s_xor_b32 s6, s6, s15
	s_cmp_lt_i32 s6, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[2:3], s[6:7], s[2:3]
	s_subb_u32 s19, s23, s19
	s_sub_i32 s2, s15, s24
	s_add_i32 s18, s18, s2
	s_cmpk_lt_i32 s14, 0x400
	s_cselect_b64 s[2:3], -1, 0
	s_and_b32 s6, s14, 7
	s_cselect_b64 s[6:7], -1, 0
	s_or_b64 s[2:3], s[2:3], s[6:7]
	s_and_b64 s[2:3], s[2:3], exec
	s_cselect_b32 s7, s11, s19
	v_readfirstlane_b32 s24, v6                                                                         ;     2/4     ARB_WIN_EX
	v_lshrrev_b32_e32 v6, 1, v0
	v_lshl_or_b32 v153, s7, 8, v7
	v_bfe_u32 v7, v0, 3, 3                                                                              ;     1/4     ARB_WIN_EX
	s_cselect_b32 s6, s10, s18
	v_and_b32_e32 v6, 64, v6                                                                            ;     3/6     ARB_WIN_EX
	v_or_b32_e32 v7, v7, v8
	s_lshl_b32 s2, s6, 20
	v_lshl_or_b32 v152, s6, 8, v6                                                                       ;     1/2     ARB_WIN_EX
	s_bfe_u32 s6, s25, 0xa0006
	v_lshlrev_b32_e32 v11, 3, v7                                                                        ;     4/5     ARB_WIN_EX
	s_lshl_b32 s3, s7, 20
	v_and_b32_e32 v11, 0x70, v11                                                                        ;     2/3     ARB_WIN_EX
	v_lshlrev_b32_e32 v12, 12, v7                                                                       ;     1/2     ARB_WIN_EX
	s_lshl_b32 s7, s6, 3
	v_bitop3_b32 v71, v11, v12, v10 bitop3:0xde                                                         ;     2/3     ARB_WIN_EX
	v_add_u32_e32 v12, s7, v7                                                                           ;     2/4     ARB_WIN_EX
	v_lshlrev_b32_e32 v13, 3, v12                                                                       ;     1/1     ARB_WIN_EX
	v_and_b32_e32 v13, 0x70, v13
	v_lshlrev_b32_e32 v12, 12, v12
	s_lshl_b32 s10, s6, 4
	s_mul_i32 s6, s6, 24
	v_bitop3_b32 v72, v13, v12, v10 bitop3:0xde
	v_add_lshl_u32 v12, s10, v7, 12
	v_add_u32_e32 v7, s6, v7                                                                            ;     1/1     ARB_WIN_EX
	v_bitop3_b32 v73, v12, v11, v10 bitop3:0xf6
	v_lshlrev_b32_e32 v11, 3, v7
	v_and_b32_e32 v11, 0x70, v11
	v_lshlrev_b32_e32 v7, 12, v7
	v_bitop3_b32 v74, v11, v7, v10 bitop3:0xde
	v_or_b32_e32 v7, v8, v9
	v_lshlrev_b32_e32 v11, 5, v0
	v_lshlrev_b32_e32 v9, 9, v0
	v_lshlrev_b32_e32 v10, 4, v7
	v_and_b32_e32 v12, 0x400, v11
	s_mov_b32 s25, 0x10000
	v_and_b32_e32 v10, 0xf0, v10
	v_and_b32_e32 v13, 0x300, v11
	v_and_or_b32 v9, v9, s25, v12
	v_or3_b32 v75, v9, v13, v10
	v_add_u32_e32 v9, s7, v7
	v_add_lshl_u32 v8, s10, v8, 12
	s_mov_b32 s7, 0x7ff0400
	v_bitop3_b32 v8, v11, s7, v8 bitop3:0xc8
	v_add_u32_e32 v7, s6, v7
	v_or3_b32 v77, v8, v13, v10
	v_lshlrev_b32_e32 v8, 12, v7
	s_movk_i32 s11, 0xf0
	v_and_b32_e32 v8, 0xfff0000, v8
	v_lshlrev_b32_e32 v7, 4, v7
	v_and_or_b32 v7, v7, s11, v8
	v_and_b32_e32 v1, 15, v0
	v_or3_b32 v78, v7, v12, v13
	v_readfirstlane_b32 s25, v3
	v_lshrrev_b32_e32 v3, 5, v152
	v_lshlrev_b32_e32 v7, 2, v154
	v_or3_b32 v67, v3, v7, v155
	v_lshlrev_b32_e32 v2, 2, v1
	v_lshrrev_b32_e32 v8, 5, v153
	v_readfirstlane_b32 s23, v66
	v_lshl_or_b32 v79, v67, 11, v2
	v_or3_b32 v68, v8, v7, v155
	s_mov_b32 s15, 0x27000                                                                              ;     4/4     ALU_DEP
	s_mov_b32 s14, -1
	v_lshlrev_b32_e32 v3, 2, v79
	v_lshl_or_b32 v80, v68, 11, v2
	s_add_i32 s26, s23, 0x2000
	s_waitcnt lgkmcnt(0)                                                                                ;     3/3     WAITCNT
	s_and_b32 s13, s13, 0xffff
	s_and_b32 s17, s17, 0xffff
	s_mov_b32 s18, s14
	s_mov_b32 s19, s15
	s_mov_b32 m0, s23
	buffer_load_dwordx4 v3, s[12:15], s22 offen lds                                                     ;     3/4     ARB_WIN_EX
	v_lshlrev_b32_e32 v2, 2, v80
	s_mov_b32 m0, s24
	buffer_load_dwordx4 v2, s[16:19], s22 offen lds                                                     ;     4/7     ARB_WIN_EX
	v_or_b32_e32 v7, 0x100, v3
	s_mov_b32 m0, s26
	buffer_load_dwordx4 v7, s[12:15], s22 offen lds                                                     ;     3/4     ALU_DEP
	s_add_i32 s26, s24, 0x2000
	v_lshlrev_b32_e32 v14, 12, v9
	v_or_b32_e32 v7, 0x100, v2
	s_mov_b32 m0, s26
	buffer_load_dwordx4 v7, s[16:19], s22 offen lds                                                     ;     3/4     ARB_WIN_EX
	v_or_b32_e32 v3, 0x200, v3
	s_add_i32 s26, s23, 0x4000
	v_or_b32_e32 v2, 0x200, v2
	s_movk_i32 s35, 0x70
	v_and_b32_e32 v14, 0x3ff0000, v14
	v_lshlrev_b32_e32 v9, 4, v9
	s_mov_b32 m0, s26
	buffer_load_dwordx4 v3, s[12:15], s22 offen lds                                                     ;     1/3     ALU_DEP
	s_add_i32 s26, s24, 0x4000
	s_mov_b32 m0, s26
	buffer_load_dwordx4 v2, s[16:19], s22 offen lds                                                     ;     2/2     ARB_WIN_EX
	v_or_b32_e32 v2, v6, v1
	v_lshlrev_b32_e32 v3, 3, v0
	s_or_b32 s29, s2, 0x80000
	s_or_b32 s28, s3, 0x80000
	v_and_or_b32 v9, v9, s11, v14
	s_lshl_b32 s25, s25, 10
	s_or_b32 s18, s2, 0x80
	v_and_b32_e32 v6, 0x70, v3
	v_bitop3_b32 v69, v3, v5, s35 bitop3:0x6c
	v_lshlrev_b32_e32 v85, 7, v2
	v_or_b32_e32 v3, 64, v5
	v_or3_b32 v76, v9, v12, v13
	s_and_b32 s5, s5, 0xffff
	s_mov_b32 s6, s14
	s_mov_b32 s7, s15
	s_and_b32 s9, s9, 0xffff
	s_mov_b32 s10, s14
	s_mov_b32 s11, s15
	s_mov_b32 m0, s25
	buffer_load_dwordx4 v71, s[4:7], s2 offen lds                                                       ;     3/3     ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v72, s[4:7], s2 offen lds                                                       ;     3/8     ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v73, s[4:7], s2 offen lds                                                       ;     5/8     ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v74, s[4:7], s2 offen lds                                                       ;    10/11    ARB_WIN_EX
	s_add_i32 s26, s25, 0x10000
	s_mov_b32 m0, s26
	buffer_load_dwordx4 v75, s[8:11], s3 offen lds                                                      ;     6/9     ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v76, s[8:11], s3 offen lds                                                      ;     7/9     ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v77, s[8:11], s3 offen lds                                                      ;     8/10    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v78, s[8:11], s3 offen lds                                                      ;     9/10    ARB_WIN_EX
	s_add_i32 s27, s25, 0x14000
	s_mov_b32 m0, s27
	buffer_load_dwordx4 v75, s[8:11], s28 offen lds                                                     ;    12/12    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v76, s[8:11], s28 offen lds                                                     ;    10/10    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v77, s[8:11], s28 offen lds                                                     ;     6/8     ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v78, s[8:11], s28 offen lds                                                     ;    14/17    ARB_WIN_EX
	s_add_i32 s28, s25, 0x4000
	s_mov_b32 m0, s28
	buffer_load_dwordx4 v71, s[4:7], s29 offen lds                                                      ;    25/26    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v72, s[4:7], s29 offen lds                                                      ;    18/22    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v73, s[4:7], s29 offen lds                                                      ;    14/14    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v74, s[4:7], s29 offen lds                                                      ;    17/18    ARB_WIN_EX
	s_add_i32 s29, s25, 0x8000
	s_mov_b32 m0, s29
	buffer_load_dwordx4 v71, s[4:7], s18 offen lds                                                      ;    19/20    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v72, s[4:7], s18 offen lds                                                      ;    18/22    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v73, s[4:7], s18 offen lds                                                      ;    13/17    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v74, s[4:7], s18 offen lds                                                      ;    26/29    ARB_WIN_EX
	s_or_b32 s18, s3, 0x800
	v_bitop3_b32 v2, v6, v85, v5 bitop3:0xde
	v_bitop3_b32 v86, v5, v6, 64 bitop3:0x36
	v_bitop3_b32 v5, v3, v85, v6 bitop3:0xde
	s_add_i32 s30, s25, 0x18000
	s_mov_b32 m0, s30
	buffer_load_dwordx4 v75, s[8:11], s18 offen lds                                                     ;    19/22    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v76, s[8:11], s18 offen lds                                                     ;    17/19    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v77, s[8:11], s18 offen lds                                                     ;    26/29    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v78, s[8:11], s18 offen lds                                                     ;    31/34    ARB_WIN_EX
	s_or_b32 s18, s3, 0x80800
	s_add_i32 s31, s25, 0x1c000
	s_mov_b32 m0, s31
	buffer_load_dwordx4 v75, s[8:11], s18 offen lds                                                     ;    26/30    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v76, s[8:11], s18 offen lds                                                     ;    31/36    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v77, s[8:11], s18 offen lds                                                     ;    27/31    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v78, s[8:11], s18 offen lds                                                     ;    17/22    ARB_WIN_EX
	s_or_b32 s10, s2, 0x80080
	s_add_i32 s33, s25, 0xc000
	s_mov_b32 m0, s33
	buffer_load_dwordx4 v71, s[4:7], s10 offen lds                                                      ;    21/23    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v72, s[4:7], s10 offen lds                                                      ;    23/27    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v73, s[4:7], s10 offen lds                                                      ;    22/26    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v74, s[4:7], s10 offen lds                                                      ;    15/18    ARB_WIN_EX
	s_waitcnt vmcnt(28)                                                                                 ;     1/1     WAITCNT
	s_barrier                                                                                           ;    30/31    BARRIER
	ds_read_b128 v[62:65], v2
	ds_read_b128 v[58:61], v2 offset:2048                                                               ;     2/2     ARB_WIN_EX
	ds_read_b128 v[46:49], v5                                                                           ;     1/1     ARB_WIN_EX
	ds_read_b128 v[42:45], v5 offset:2048                                                               ;     4/6     ARB_WIN_EX
	ds_read_b128 v[54:57], v2 offset:4096                                                               ;     1/2     ARB_WIN_EX
	ds_read_b128 v[50:53], v2 offset:6144                                                               ;     3/4     ARB_WIN_EX
	ds_read_b128 v[38:41], v5 offset:4096                                                               ;     6/8     ARB_WIN_EX
	ds_read_b128 v[34:37], v5 offset:6144                                                               ;     7/9     ARB_WIN_EX
	v_lshlrev_b32_e32 v5, 4, v0                                                                         ;     4/4     ARB_WIN_EX
	v_lshlrev_b32_e32 v2, 7, v0                                                                         ;     7/8     ARB_WIN_EX
	v_and_b32_e32 v5, 0x70, v5                                                                          ;     6/10    ARB_WIN_EX
	s_movk_i32 s6, 0x2400
	v_bfe_u32 v4, v0, 4, 2                                                                              ;     4/4     ARB_WIN_EX
	v_and_or_b32 v87, v2, s6, v5                                                                        ;     3/4     ARB_WIN_EX
	v_mov_b32_e32 v2, 0x10000                                                                           ;     2/4     ARB_WIN_EX
	v_lshl_or_b32 v88, v4, 7, v2
	v_lshl_or_b32 v89, v3, 3, v2                                                                        ;     2/2     ARB_WIN_EX
	v_or_b32_e32 v10, v88, v87                                                                          ;     2/4     ARB_WIN_EX
	v_or_b32_e32 v14, v89, v87                                                                          ;     1/2     ARB_WIN_EX
	s_waitcnt vmcnt(24)
	s_barrier                                                                                           ;     6/6     BARRIER
	ds_read_b128 v[18:21], v10
	ds_read_b128 v[22:25], v10 offset:2048                                                              ;     2/3     ARB_WIN_EX
	ds_read_b128 v[2:5], v14                                                                            ;     1/1     ARB_WIN_EX
	ds_read_b128 v[6:9], v14 offset:2048                                                                ;     1/2     ARB_WIN_EX
	ds_read_b128 v[26:29], v10 offset:4096                                                              ;     1/3     ARB_WIN_EX
	ds_read_b128 v[30:33], v10 offset:6144                                                              ;     2/2     ARB_WIN_EX
	ds_read_b128 v[10:13], v14 offset:4096                                                              ;     1/1     ARB_WIN_EX
	ds_read_b128 v[14:17], v14 offset:6144                                                              ;     1/1     ARB_WIN_EX
	v_lshlrev_b32_e32 v81, 2, v0
	v_and_b32_e32 v81, 0xfc, v81                                                                        ;     1/2     ARB_WIN_EX
	v_or_b32_e32 v82, v66, v81
	ds_read2st64_b32 v[98:99], v82 offset1:1                                                            ;     2/3     ALU_DEP
	ds_read2st64_b32 v[146:147], v82 offset0:2 offset1:3                                                ;     1/2     ARB_WIN_EX
	ds_read2st64_b32 v[150:151], v82 offset0:4 offset1:5                                                ;     1/1     ARB_WIN_EX
	ds_read2st64_b32 v[148:149], v82 offset0:6 offset1:7                                                ;     1/1     ARB_WIN_EX
	s_movk_i32 s34, 0x300
	v_lshlrev_b32_e32 v66, 13, v68                                                                      ;     3/4     ARB_WIN_EX
	v_lshlrev_b32_e32 v68, 4, v1                                                                        ;     2/3     ARB_WIN_EX
	v_or3_b32 v83, v66, v68, s34
	v_lshlrev_b32_e32 v66, 13, v67                                                                      ;     4/4     ARB_WIN_EX
	v_or3_b32 v84, v66, v68, s34                                                                        ;     4/4     ARB_WIN_EX
	v_mov_b32_e32 v66, 0                                                                                ;     1/1     ARB_WIN_EX
	s_or_b32 s34, s3, 0x81800
	s_or_b32 s35, s2, 0x80180
	s_mov_b64 s[2:3], -2
	s_movk_i32 s36, 0x6000
	v_add_u32_e32 v159, v87, v88                                                                        ;     2/3     ARB_WIN_EX
	v_add_u32_e32 v158, v87, v89
	v_add_u32_e32 v157, v85, v69                                                                        ;     1/2     ARB_WIN_EX
	v_add_u32_e32 v156, v85, v86
	s_mov_b32 s6, s14
	s_mov_b32 s10, s14
	s_mov_b32 s18, s14
	v_accvgpr_write_b32 a252, v66
	v_accvgpr_write_b32 a253, v66
	v_accvgpr_write_b32 a254, v66
	v_accvgpr_write_b32 a255, v66
	v_accvgpr_write_b32 a248, v66
	v_accvgpr_write_b32 a249, v66
	v_accvgpr_write_b32 a250, v66
	v_accvgpr_write_b32 a251, v66
	v_accvgpr_write_b32 a244, v66
	v_accvgpr_write_b32 a245, v66
	v_accvgpr_write_b32 a246, v66
	v_accvgpr_write_b32 a247, v66
	v_accvgpr_write_b32 a240, v66
	v_accvgpr_write_b32 a241, v66
	v_accvgpr_write_b32 a242, v66
	v_accvgpr_write_b32 a243, v66
	v_accvgpr_write_b32 a236, v66
	v_accvgpr_write_b32 a237, v66
	v_accvgpr_write_b32 a238, v66
	v_accvgpr_write_b32 a239, v66
	v_accvgpr_write_b32 a232, v66
	v_accvgpr_write_b32 a233, v66
	v_accvgpr_write_b32 a234, v66
	v_accvgpr_write_b32 a235, v66
	v_accvgpr_write_b32 a228, v66
	v_accvgpr_write_b32 a229, v66
	v_accvgpr_write_b32 a230, v66
	v_accvgpr_write_b32 a231, v66
	v_accvgpr_write_b32 a224, v66
	v_accvgpr_write_b32 a225, v66
	v_accvgpr_write_b32 a226, v66
	v_accvgpr_write_b32 a227, v66
	v_accvgpr_write_b32 a220, v66
	v_accvgpr_write_b32 a221, v66
	v_accvgpr_write_b32 a222, v66
	v_accvgpr_write_b32 a223, v66
	v_accvgpr_write_b32 a216, v66
	v_accvgpr_write_b32 a217, v66
	v_accvgpr_write_b32 a218, v66
	v_accvgpr_write_b32 a219, v66
	v_accvgpr_write_b32 a212, v66
	v_accvgpr_write_b32 a213, v66
	v_accvgpr_write_b32 a214, v66
	v_accvgpr_write_b32 a215, v66
	v_accvgpr_write_b32 a208, v66
	v_accvgpr_write_b32 a209, v66
	v_accvgpr_write_b32 a210, v66
	v_accvgpr_write_b32 a211, v66
	v_accvgpr_write_b32 a204, v66
	v_accvgpr_write_b32 a205, v66
	v_accvgpr_write_b32 a206, v66
	v_accvgpr_write_b32 a207, v66
	v_accvgpr_write_b32 a200, v66
	v_accvgpr_write_b32 a201, v66
	v_accvgpr_write_b32 a202, v66
	v_accvgpr_write_b32 a203, v66
	v_accvgpr_write_b32 a196, v66
	v_accvgpr_write_b32 a197, v66
	v_accvgpr_write_b32 a198, v66
	v_accvgpr_write_b32 a199, v66
	v_accvgpr_write_b32 a192, v66
	v_accvgpr_write_b32 a193, v66
	v_accvgpr_write_b32 a194, v66
	v_accvgpr_write_b32 a195, v66
	v_accvgpr_write_b32 a188, v66
	v_accvgpr_write_b32 a189, v66
	v_accvgpr_write_b32 a190, v66
	v_accvgpr_write_b32 a191, v66
	v_accvgpr_write_b32 a184, v66
	v_accvgpr_write_b32 a185, v66
	v_accvgpr_write_b32 a186, v66
	v_accvgpr_write_b32 a187, v66
	v_accvgpr_write_b32 a180, v66
	v_accvgpr_write_b32 a181, v66
	v_accvgpr_write_b32 a182, v66
	v_accvgpr_write_b32 a183, v66
	v_accvgpr_write_b32 a176, v66
	v_accvgpr_write_b32 a177, v66
	v_accvgpr_write_b32 a178, v66
	v_accvgpr_write_b32 a179, v66
	v_accvgpr_write_b32 a172, v66
	v_accvgpr_write_b32 a173, v66
	v_accvgpr_write_b32 a174, v66
	v_accvgpr_write_b32 a175, v66
	v_accvgpr_write_b32 a168, v66
	v_accvgpr_write_b32 a169, v66
	v_accvgpr_write_b32 a170, v66
	v_accvgpr_write_b32 a171, v66
	v_accvgpr_write_b32 a164, v66
	v_accvgpr_write_b32 a165, v66
	v_accvgpr_write_b32 a166, v66
	v_accvgpr_write_b32 a167, v66
	v_accvgpr_write_b32 a160, v66
	v_accvgpr_write_b32 a161, v66
	v_accvgpr_write_b32 a162, v66
	v_accvgpr_write_b32 a163, v66
	v_accvgpr_write_b32 a156, v66
	v_accvgpr_write_b32 a157, v66
	v_accvgpr_write_b32 a158, v66
	v_accvgpr_write_b32 a159, v66
	v_accvgpr_write_b32 a152, v66
	v_accvgpr_write_b32 a153, v66
	v_accvgpr_write_b32 a154, v66
	v_accvgpr_write_b32 a155, v66
	v_accvgpr_write_b32 a148, v66
	v_accvgpr_write_b32 a149, v66
	v_accvgpr_write_b32 a150, v66
	v_accvgpr_write_b32 a151, v66
	v_accvgpr_write_b32 a144, v66
	v_accvgpr_write_b32 a145, v66
	v_accvgpr_write_b32 a146, v66
	v_accvgpr_write_b32 a147, v66
	v_accvgpr_write_b32 a140, v66
	v_accvgpr_write_b32 a141, v66
	v_accvgpr_write_b32 a142, v66
	v_accvgpr_write_b32 a143, v66
	v_accvgpr_write_b32 a136, v66
	v_accvgpr_write_b32 a137, v66
	v_accvgpr_write_b32 a138, v66
	v_accvgpr_write_b32 a139, v66
	v_accvgpr_write_b32 a132, v66
	v_accvgpr_write_b32 a133, v66
	v_accvgpr_write_b32 a134, v66
	v_accvgpr_write_b32 a135, v66
	v_accvgpr_write_b32 a128, v66
	v_accvgpr_write_b32 a129, v66
	v_accvgpr_write_b32 a130, v66
	v_accvgpr_write_b32 a131, v66
	v_accvgpr_write_b32 a124, v66
	v_accvgpr_write_b32 a125, v66
	v_accvgpr_write_b32 a126, v66
	v_accvgpr_write_b32 a127, v66
	v_accvgpr_write_b32 a120, v66
	v_accvgpr_write_b32 a121, v66
	v_accvgpr_write_b32 a122, v66
	v_accvgpr_write_b32 a123, v66
	v_accvgpr_write_b32 a116, v66
	v_accvgpr_write_b32 a117, v66
	v_accvgpr_write_b32 a118, v66
	v_accvgpr_write_b32 a119, v66
	v_accvgpr_write_b32 a112, v66
	v_accvgpr_write_b32 a113, v66
	v_accvgpr_write_b32 a114, v66
	v_accvgpr_write_b32 a115, v66
	v_accvgpr_write_b32 a108, v66
	v_accvgpr_write_b32 a109, v66
	v_accvgpr_write_b32 a110, v66
	v_accvgpr_write_b32 a111, v66
	v_accvgpr_write_b32 a104, v66
	v_accvgpr_write_b32 a105, v66
	v_accvgpr_write_b32 a106, v66
	v_accvgpr_write_b32 a107, v66
	v_accvgpr_write_b32 a100, v66
	v_accvgpr_write_b32 a101, v66
	v_accvgpr_write_b32 a102, v66
	v_accvgpr_write_b32 a103, v66
	v_accvgpr_write_b32 a96, v66
	v_accvgpr_write_b32 a97, v66
	v_accvgpr_write_b32 a98, v66
	v_accvgpr_write_b32 a99, v66
	v_accvgpr_write_b32 a92, v66
	v_accvgpr_write_b32 a93, v66
	v_accvgpr_write_b32 a94, v66
	v_accvgpr_write_b32 a95, v66
	v_accvgpr_write_b32 a88, v66
	v_accvgpr_write_b32 a89, v66
	v_accvgpr_write_b32 a90, v66
	v_accvgpr_write_b32 a91, v66
	v_accvgpr_write_b32 a84, v66
	v_accvgpr_write_b32 a85, v66
	v_accvgpr_write_b32 a86, v66
	v_accvgpr_write_b32 a87, v66
	v_accvgpr_write_b32 a80, v66
	v_accvgpr_write_b32 a81, v66
	v_accvgpr_write_b32 a82, v66
	v_accvgpr_write_b32 a83, v66
	v_accvgpr_write_b32 a76, v66
	v_accvgpr_write_b32 a77, v66
	v_accvgpr_write_b32 a78, v66
	v_accvgpr_write_b32 a79, v66
	v_accvgpr_write_b32 a72, v66
	v_accvgpr_write_b32 a73, v66
	v_accvgpr_write_b32 a74, v66
	v_accvgpr_write_b32 a75, v66
	v_accvgpr_write_b32 a68, v66
	v_accvgpr_write_b32 a69, v66
	v_accvgpr_write_b32 a70, v66
	v_accvgpr_write_b32 a71, v66
	v_accvgpr_write_b32 a64, v66
	v_accvgpr_write_b32 a65, v66
	v_accvgpr_write_b32 a66, v66
	v_accvgpr_write_b32 a67, v66
	v_accvgpr_write_b32 a60, v66
	v_accvgpr_write_b32 a61, v66
	v_accvgpr_write_b32 a62, v66
	v_accvgpr_write_b32 a63, v66
	v_accvgpr_write_b32 a56, v66
	v_accvgpr_write_b32 a57, v66
	v_accvgpr_write_b32 a58, v66
	v_accvgpr_write_b32 a59, v66
	v_accvgpr_write_b32 a52, v66
	v_accvgpr_write_b32 a53, v66
	v_accvgpr_write_b32 a54, v66
	v_accvgpr_write_b32 a55, v66
	v_accvgpr_write_b32 a48, v66
	v_accvgpr_write_b32 a49, v66
	v_accvgpr_write_b32 a50, v66
	v_accvgpr_write_b32 a51, v66
	v_accvgpr_write_b32 a44, v66
	v_accvgpr_write_b32 a45, v66
	v_accvgpr_write_b32 a46, v66
	v_accvgpr_write_b32 a47, v66
	v_accvgpr_write_b32 a40, v66
	v_accvgpr_write_b32 a41, v66
	v_accvgpr_write_b32 a42, v66
	v_accvgpr_write_b32 a43, v66
	v_accvgpr_write_b32 a36, v66
	v_accvgpr_write_b32 a37, v66
	v_accvgpr_write_b32 a38, v66
	v_accvgpr_write_b32 a39, v66
	v_accvgpr_write_b32 a32, v66
	v_accvgpr_write_b32 a33, v66
	v_accvgpr_write_b32 a34, v66
	v_accvgpr_write_b32 a35, v66
	v_accvgpr_write_b32 a28, v66
	v_accvgpr_write_b32 a29, v66
	v_accvgpr_write_b32 a30, v66
	v_accvgpr_write_b32 a31, v66
	v_accvgpr_write_b32 a24, v66
	v_accvgpr_write_b32 a25, v66
	v_accvgpr_write_b32 a26, v66
	v_accvgpr_write_b32 a27, v66
	v_accvgpr_write_b32 a20, v66
	v_accvgpr_write_b32 a21, v66
	v_accvgpr_write_b32 a22, v66
	v_accvgpr_write_b32 a23, v66
	v_accvgpr_write_b32 a16, v66
	v_accvgpr_write_b32 a17, v66
	v_accvgpr_write_b32 a18, v66
	v_accvgpr_write_b32 a19, v66
	v_accvgpr_write_b32 a12, v66
	v_accvgpr_write_b32 a13, v66
	v_accvgpr_write_b32 a14, v66
	v_accvgpr_write_b32 a15, v66
	v_accvgpr_write_b32 a8, v66
	v_accvgpr_write_b32 a9, v66
	v_accvgpr_write_b32 a10, v66
	v_accvgpr_write_b32 a11, v66
	v_accvgpr_write_b32 a4, v66
	v_accvgpr_write_b32 a5, v66
	v_accvgpr_write_b32 a6, v66
	v_accvgpr_write_b32 a7, v66
	v_accvgpr_write_b32 a0, v66
	v_accvgpr_write_b32 a1, v66
	v_accvgpr_write_b32 a2, v66
	v_accvgpr_write_b32 a3, v66
	s_add_u32 s2, s2, 2                                                                                 ;    52/67    NO_INST_AVAIL
	s_addc_u32 s3, s3, 0
	s_add_i32 s41, s36, 0xffffa000
	s_and_b32 s46, s41, 0x4000
	s_waitcnt vmcnt(17)                                                                                 ;    13/13    WAITCNT
	s_barrier                                                                                           ;    98/114   BARRIER
	s_waitcnt lgkmcnt(1)                                                                                ;    14/14    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[18:21], v[62:65], a[252:255], v150, v98 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     4/33    ARB_WIN_EX
	s_add_i32 s40, s35, 0xfff7ff80
	s_mov_b32 m0, s25
	buffer_load_dwordx4 v71, s[4:7], s40 offen lds                                                      ;    47/71    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[22:25], v[62:65], a[248:251], v150, v98 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     9/35    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[26:29], v[62:65], a[244:247], v151, v98 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    36/77    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v72, s[4:7], s40 offen lds                                                      ;    54/76    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[30:33], v[62:65], a[240:243], v151, v98 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    27/57    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[18:21], v[58:61], a[236:239], v150, v98 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    44/64    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v73, s[4:7], s40 offen lds                                                      ;    72/105   ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[22:25], v[58:61], a[232:235], v150, v98 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     6/25    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[26:29], v[58:61], a[228:231], v151, v98 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    35/54    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v74, s[4:7], s40 offen lds                                                      ;    52/73    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[30:33], v[58:61], a[224:227], v151, v98 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[18:21], v[54:57], a[220:223], v150, v99 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    25/53    ARB_WIN_EX
	ds_read_b128 v[86:89], v159 offset:16384                                                            ;    15/27    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[22:25], v[54:57], a[216:219], v150, v99 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[26:29], v[54:57], a[212:215], v151, v99 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    28/55    ARB_WIN_EX
	ds_read_b128 v[90:93], v158 offset:16384                                                            ;    21/32    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[30:33], v[54:57], a[208:211], v151, v99 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[18:21], v[50:53], a[204:207], v150, v99 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    27/48    ARB_WIN_EX
	ds_read_b128 v[94:97], v159 offset:18432                                                            ;    14/27    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[22:25], v[50:53], a[200:203], v150, v99 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[26:29], v[50:53], a[196:199], v151, v99 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    28/46    ARB_WIN_EX
	ds_read_b128 v[100:103], v158 offset:18432                                                          ;    21/33    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[30:33], v[50:53], a[192:195], v151, v99 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_add_u32_e32 v68, s46, v82                                                                         ;    17/27    ARB_WIN_EX
	s_add_i32 s39, s34, 0xfff7f800
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[2:5], v[46:49], a[252:255], v150, v98 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[104:107], v159 offset:20480                                                          ;     9/21    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[6:9], v[46:49], a[248:251], v150, v98 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[10:13], v[46:49], a[244:247], v151, v98 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    30/58    ARB_WIN_EX
	ds_read_b128 v[108:111], v158 offset:20480                                                          ;    15/28    ALU_DEP
	s_waitcnt lgkmcnt(6)                                                                                ;    15/15    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[14:17], v[46:49], a[240:243], v151, v98 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[2:5], v[42:45], a[236:239], v150, v98 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    29/60    ARB_WIN_EX
	ds_read_b128 v[112:115], v159 offset:22528                                                          ;    17/29    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[6:9], v[42:45], a[232:235], v150, v98 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[10:13], v[42:45], a[228:231], v151, v98 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    32/61    ARB_WIN_EX
	ds_read_b128 v[116:119], v158 offset:22528                                                          ;     7/25    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[14:17], v[42:45], a[224:227], v151, v98 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[2:5], v[38:41], a[220:223], v150, v99 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    24/52    ARB_WIN_EX
	ds_read2st64_b32 v[144:145], v68 offset0:32 offset1:33                                              ;    16/35    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[6:9], v[38:41], a[216:219], v150, v99 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[10:13], v[38:41], a[212:215], v151, v99 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    27/60    ARB_WIN_EX
	ds_read2st64_b32 v[66:67], v68 offset0:34 offset1:35                                                ;    16/39    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[14:17], v[38:41], a[208:211], v151, v99 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[2:5], v[34:37], a[204:207], v150, v99 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    30/68    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[6:9], v[34:37], a[200:203], v150, v99 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    27/66    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[10:13], v[34:37], a[196:199], v151, v99 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    35/65    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[14:17], v[34:37], a[192:195], v151, v99 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    27/60    ARB_WIN_EX
	s_waitcnt lgkmcnt(9)                                                                                ;    11/11    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[86:89], v[62:65], a[188:191], v148, v98 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    11/34    ARB_WIN_EX
	s_mov_b32 m0, s26
	buffer_load_dwordx4 v75, s[8:11], s39 offen lds                                                     ;    47/87    ARB_WIN_EX
	s_waitcnt lgkmcnt(7)                                                                                ;    13/13    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[94:97], v[62:65], a[184:187], v148, v98 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(5)                                                                                ;    16/16    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[104:107], v[62:65], a[180:183], v149, v98 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    16/40    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v76, s[8:11], s39 offen lds                                                     ;    36/72    ARB_WIN_EX
	s_waitcnt lgkmcnt(3)                                                                                ;    13/13    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[112:115], v[62:65], a[176:179], v149, v98 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[86:89], v[58:61], a[172:175], v148, v98 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    16/48    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v77, s[8:11], s39 offen lds                                                     ;    36/74    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[94:97], v[58:61], a[168:171], v148, v98 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    13/38    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[104:107], v[58:61], a[164:167], v149, v98 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    27/56    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v78, s[8:11], s39 offen lds                                                     ;    40/68    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[112:115], v[58:61], a[160:163], v149, v98 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[86:89], v[54:57], a[156:159], v148, v99 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    33/60    ALU_DEP
	ds_read_b128 v[58:61], v157 offset:16384                                                            ;    13/31    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[94:97], v[54:57], a[152:155], v148, v99 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[104:107], v[54:57], a[148:151], v149, v99 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    27/51    ARB_WIN_EX
	ds_read_b128 v[62:65], v156 offset:16384                                                            ;    11/30    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[112:115], v[54:57], a[144:147], v149, v99 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    15/37    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[86:89], v[50:53], a[140:143], v148, v99 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    25/57    ARB_WIN_EX
	ds_read_b128 v[54:57], v157 offset:18432                                                            ;    15/31    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[94:97], v[50:53], a[136:139], v148, v99 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/33    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[104:107], v[50:53], a[132:135], v149, v99 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    24/49    ARB_WIN_EX
	ds_read_b128 v[120:123], v156 offset:18432                                                          ;    13/33    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[112:115], v[50:53], a[128:131], v149, v99 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_add_i32 s38, s34, 0xfffff800
	s_and_b32 s44, s36, 0x6000                                                                          ;    25/44    NO_INST_AVAIL
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[90:93], v[46:49], a[188:191], v148, v98 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[50:53], v157 offset:20480                                                            ;    16/29    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[100:103], v[46:49], a[184:187], v148, v98 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[108:111], v[46:49], a[180:183], v149, v98 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    21/56    ARB_WIN_EX
	ds_read_b128 v[124:127], v156 offset:20480                                                          ;    19/31    ALU_DEP
	s_waitcnt lgkmcnt(8)                                                                                ;    14/14    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[116:119], v[46:49], a[176:179], v149, v98 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[90:93], v[42:45], a[172:175], v148, v98 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    42/72    ALU_DEP
	ds_read_b128 v[46:49], v157 offset:22528                                                            ;    13/32    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[100:103], v[42:45], a[168:171], v148, v98 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[108:111], v[42:45], a[164:167], v149, v98 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    29/59    ARB_WIN_EX
	ds_read_b128 v[128:131], v156 offset:22528                                                          ;    18/33    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[116:119], v[42:45], a[160:163], v149, v98 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[90:93], v[38:41], a[156:159], v148, v99 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    29/58    ARB_WIN_EX
	ds_read2st64_b32 v[172:173], v68 offset0:36 offset1:37                                              ;    21/31    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[100:103], v[38:41], a[152:155], v148, v99 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[108:111], v[38:41], a[148:151], v149, v99 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    41/76    ARB_WIN_EX
	ds_read2st64_b32 v[68:69], v68 offset0:38 offset1:39                                                ;    17/35    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[116:119], v[38:41], a[144:147], v149, v99 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[90:93], v[34:37], a[140:143], v148, v99 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    35/73    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[100:103], v[34:37], a[136:139], v148, v99 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    31/53    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[108:111], v[34:37], a[132:135], v149, v99 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    26/59    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[116:119], v[34:37], a[128:131], v149, v99 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    34/62    ARB_WIN_EX
	s_waitcnt vmcnt(17)                                                                                 ;    12/12    WAITCNT
	s_barrier                                                                                           ;   118/129   BARRIER
	s_waitcnt lgkmcnt(9)                                                                                ;    14/14    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[18:21], v[58:61], a[124:127], v150, v146 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_mov_b32 m0, s27
	buffer_load_dwordx4 v75, s[8:11], s38 offen lds                                                     ;    62/93    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[22:25], v[58:61], a[120:123], v150, v146 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[26:29], v[58:61], a[116:119], v151, v146 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    33/58    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v76, s[8:11], s38 offen lds                                                     ;    42/82    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[30:33], v[58:61], a[112:115], v151, v146 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(7)                                                                                ;    18/18    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[18:21], v[54:57], a[108:111], v150, v146 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    18/53    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v77, s[8:11], s38 offen lds                                                     ;    37/71    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[22:25], v[54:57], a[104:107], v150, v146 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/23    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[26:29], v[54:57], a[100:103], v151, v146 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    45/69    ALU_DEP
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v78, s[8:11], s38 offen lds                                                     ;    34/63    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[30:33], v[54:57], a[96:99], v151, v146 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    14/46    ALU_DEP
	s_waitcnt lgkmcnt(5)                                                                                ;    15/15    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[18:21], v[50:53], a[92:95], v150, v147 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    20/58    ARB_WIN_EX
	ds_read_b128 v[34:37], v157 offset:32768                                                            ;    16/37    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[22:25], v[50:53], a[88:91], v150, v147 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[26:29], v[50:53], a[84:87], v151, v147 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    20/49    ARB_WIN_EX
	ds_read_b128 v[38:41], v156 offset:32768                                                            ;    19/38    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[30:33], v[50:53], a[80:83], v151, v147 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(5)                                                                                ;    14/14    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[18:21], v[46:49], a[76:79], v150, v147 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    10/43    ARB_WIN_EX
	ds_read_b128 v[18:21], v157 offset:34816                                                            ;    18/37    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[22:25], v[46:49], a[72:75], v150, v147 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     7/49    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[26:29], v[46:49], a[68:71], v151, v147 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    24/50    ARB_WIN_EX
	ds_read_b128 v[22:25], v156 offset:34816                                                            ;    24/40    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[30:33], v[46:49], a[64:67], v151, v147 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_add_i32 s37, s35, 0xffffff80
	s_add_i32 s47, s44, s23
	s_xor_b32 s46, s46, 0x4000
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[2:5], v[62:65], a[124:127], v150, v146 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[26:29], v157 offset:36864                                                            ;    11/19    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[6:9], v[62:65], a[120:123], v150, v146 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[10:13], v[62:65], a[116:119], v151, v146 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    31/60    ARB_WIN_EX
	ds_read_b128 v[30:33], v156 offset:36864                                                            ;    15/29    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[14:17], v[62:65], a[112:115], v151, v146 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[2:5], v[120:123], a[108:111], v150, v146 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    24/63    ARB_WIN_EX
	ds_read_b128 v[42:45], v157 offset:38912                                                            ;    12/22    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[6:9], v[120:123], a[104:107], v150, v146 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[10:13], v[120:123], a[100:103], v151, v146 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    18/53    ARB_WIN_EX
	ds_read_b128 v[132:135], v156 offset:38912                                                          ;    17/29    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[14:17], v[120:123], a[96:99], v151, v146 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[2:5], v[124:127], a[92:95], v150, v147 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    27/48    ARB_WIN_EX
	s_mov_b32 m0, s47
	buffer_load_dwordx4 v84, s[12:15], s22 offen lds                                                    ;    72/101   ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[6:9], v[124:127], a[88:91], v150, v147 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[10:13], v[124:127], a[84:87], v151, v147 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    17/50    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[14:17], v[124:127], a[80:83], v151, v147 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    29/56    ARB_WIN_EX
	s_waitcnt lgkmcnt(10)                                                                               ;    13/13    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[2:5], v[128:131], a[76:79], v150, v147 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    13/50    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[6:9], v[128:131], a[72:75], v150, v147 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    31/51    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[10:13], v[128:131], a[68:71], v151, v147 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    26/51    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[14:17], v[128:131], a[64:67], v151, v147 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    28/57    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[86:89], v[58:61], a[60:63], v148, v146 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    32/66    ARB_WIN_EX
	s_mov_b32 m0, s28
	buffer_load_dwordx4 v71, s[4:7], s37 offen lds                                                      ;    78/99    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[94:97], v[58:61], a[56:59], v148, v146 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[104:107], v[58:61], a[52:55], v149, v146 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    37/66    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v72, s[4:7], s37 offen lds                                                      ;    47/69    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[112:115], v[58:61], a[48:51], v149, v146 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[86:89], v[54:57], a[44:47], v148, v146 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    24/44    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v73, s[4:7], s37 offen lds                                                      ;    53/74    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[94:97], v[54:57], a[40:43], v148, v146 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[104:107], v[54:57], a[36:39], v149, v146 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    21/43    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v74, s[4:7], s37 offen lds                                                      ;    75/110   ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[112:115], v[54:57], a[32:35], v149, v146 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[86:89], v[50:53], a[28:31], v148, v147 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    30/54    ARB_WIN_EX
	ds_read_b128 v[2:5], v159 offset:32768                                                              ;    10/23    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[94:97], v[50:53], a[24:27], v148, v147 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[104:107], v[50:53], a[20:23], v149, v147 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    16/43    ALU_DEP
	ds_read_b128 v[6:9], v158 offset:32768                                                              ;     8/18    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[112:115], v[50:53], a[16:19], v149, v147 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/22    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[86:89], v[46:49], a[12:15], v148, v147 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    29/54    ARB_WIN_EX
	ds_read_b128 v[10:13], v159 offset:34816                                                            ;     8/19    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[94:97], v[46:49], a[8:11], v148, v147 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    10/26    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[104:107], v[46:49], a[4:7], v149, v147 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    32/57    ARB_WIN_EX
	ds_read_b128 v[14:17], v158 offset:34816                                                            ;    17/31    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[112:115], v[46:49], a[0:3], v149, v147 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_add_i32 s43, s35, 0xfff80000
	s_min_u32 s45, s2, 27
	s_add_i32 s44, s44, s24
	v_add_u32_e32 v85, s46, v82
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[90:93], v[62:65], a[60:63], v148, v146 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[50:53], v159 offset:36864                                                            ;     7/19    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[100:103], v[62:65], a[56:59], v148, v146 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[108:111], v[62:65], a[52:55], v149, v146 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    19/38    ARB_WIN_EX
	ds_read_b128 v[86:89], v158 offset:36864                                                            ;     5/18    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[116:119], v[62:65], a[48:51], v149, v146 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[90:93], v[120:123], a[44:47], v148, v146 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    24/55    ARB_WIN_EX
	ds_read_b128 v[54:57], v159 offset:38912                                                            ;     6/18    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[100:103], v[120:123], a[40:43], v148, v146 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[108:111], v[120:123], a[36:39], v149, v146 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    20/47    ARB_WIN_EX
	ds_read_b128 v[94:97], v158 offset:38912                                                            ;    10/22    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[116:119], v[120:123], a[32:35], v149, v146 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[90:93], v[124:127], a[28:31], v148, v147 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    16/42    ARB_WIN_EX
	s_mov_b32 m0, s44
	buffer_load_dwordx4 v83, s[16:19], s22 offen lds                                                    ;    24/52    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[100:103], v[124:127], a[24:27], v148, v147 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/24    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[108:111], v[124:127], a[20:23], v149, v147 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    25/51    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[116:119], v[124:127], a[16:19], v149, v147 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    25/49    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[90:93], v[128:131], a[12:15], v148, v147 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    24/51    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[100:103], v[128:131], a[8:11], v148, v147 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    21/53    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[108:111], v[128:131], a[4:7], v149, v147 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    18/40    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[116:119], v[128:131], a[0:3], v149, v147 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    16/38    ARB_WIN_EX
	s_waitcnt vmcnt(17)                                                                                 ;     6/6     WAITCNT
	s_barrier                                                                                           ;    62/76    BARRIER
	s_waitcnt lgkmcnt(7)                                                                                ;    11/11    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[2:5], v[34:37], a[252:255], v172, v144 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_mov_b32 m0, s29
	buffer_load_dwordx4 v71, s[4:7], s43 offen lds                                                      ;    52/72    ARB_WIN_EX
	s_waitcnt lgkmcnt(5)                                                                                ;     3/3     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[10:13], v[34:37], a[248:251], v172, v144 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(3)                                                                                ;     8/8     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[50:53], v[34:37], a[244:247], v173, v144 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    17/38    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v72, s[4:7], s43 offen lds                                                      ;    11/30    ARB_WIN_EX
	s_waitcnt lgkmcnt(1)                                                                                ;    18/18    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[54:57], v[34:37], a[240:243], v173, v144 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[2:5], v[18:21], a[236:239], v172, v144 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    14/33    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v73, s[4:7], s43 offen lds                                                      ;    36/72    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[10:13], v[18:21], a[232:235], v172, v144 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[50:53], v[18:21], a[228:231], v173, v144 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    21/48    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v74, s[4:7], s43 offen lds                                                      ;    70/86    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[54:57], v[18:21], a[224:227], v173, v144 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/22    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[2:5], v[26:29], a[220:223], v172, v145 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    21/42    ARB_WIN_EX
	ds_read_b128 v[90:93], v159 offset:49152                                                            ;    14/26    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[10:13], v[26:29], a[216:219], v172, v145 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[50:53], v[26:29], a[212:215], v173, v145 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    21/38    ARB_WIN_EX
	ds_read_b128 v[100:103], v158 offset:49152                                                          ;     9/20    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[54:57], v[26:29], a[208:211], v173, v145 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[2:5], v[42:45], a[204:207], v172, v145 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    17/46    ARB_WIN_EX
	ds_read_b128 v[104:107], v159 offset:51200                                                          ;    13/23    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[10:13], v[42:45], a[200:203], v172, v145 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[50:53], v[42:45], a[196:199], v173, v145 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    18/41    ARB_WIN_EX
	ds_read_b128 v[108:111], v158 offset:51200                                                          ;    17/37    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[54:57], v[42:45], a[192:195], v173, v145 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_add_i32 s42, s34, 0xfff80000
	s_lshl_b32 s48, s45, 6
	s_lshl_b32 s45, s45, 13
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[6:9], v[38:41], a[252:255], v172, v144 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[112:115], v159 offset:53248                                                          ;     7/21    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[14:17], v[38:41], a[248:251], v172, v144 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[86:89], v[38:41], a[244:247], v173, v144 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    28/64    ARB_WIN_EX
	ds_read_b128 v[116:119], v158 offset:53248                                                          ;    10/19    ALU_DEP
	s_waitcnt lgkmcnt(6)                                                                                ;    23/23    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[94:97], v[38:41], a[240:243], v173, v144 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[6:9], v[22:25], a[236:239], v172, v144 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    30/46    ARB_WIN_EX
	ds_read_b128 v[120:123], v159 offset:55296                                                          ;     8/25    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[14:17], v[22:25], a[232:235], v172, v144 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[86:89], v[22:25], a[228:231], v173, v144 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    30/58    ARB_WIN_EX
	ds_read_b128 v[124:127], v158 offset:55296                                                          ;     9/18    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[94:97], v[22:25], a[224:227], v173, v144 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[6:9], v[30:33], a[220:223], v172, v145 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    29/41    ALU_DEP
	ds_read2st64_b32 v[98:99], v85 offset1:1                                                            ;    11/22    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[14:17], v[30:33], a[216:219], v172, v145 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[86:89], v[30:33], a[212:215], v173, v145 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    26/50    ARB_WIN_EX
	ds_read2st64_b32 v[146:147], v85 offset0:2 offset1:3                                                ;    11/22    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[94:97], v[30:33], a[208:211], v173, v145 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    14/41    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[6:9], v[132:135], a[204:207], v172, v145 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    21/40    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[14:17], v[132:135], a[200:203], v172, v145 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    18/44    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[86:89], v[132:135], a[196:199], v173, v145 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    24/49    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[94:97], v[132:135], a[192:195], v173, v145 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    25/45    ARB_WIN_EX
	s_waitcnt lgkmcnt(9)                                                                                ;    13/13    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[90:93], v[34:37], a[188:191], v68, v144 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    18/42    ARB_WIN_EX
	s_mov_b32 m0, s30
	buffer_load_dwordx4 v75, s[8:11], s42 offen lds                                                     ;    24/68    ARB_WIN_EX
	s_waitcnt lgkmcnt(7)                                                                                ;    19/19    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[104:107], v[34:37], a[184:187], v68, v144 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(5)                                                                                ;    17/17    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[112:115], v[34:37], a[180:183], v69, v144 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    11/30    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v76, s[8:11], s42 offen lds                                                     ;    27/47    ARB_WIN_EX
	s_waitcnt lgkmcnt(3)                                                                                ;    18/18    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[120:123], v[34:37], a[176:179], v69, v144 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[90:93], v[18:21], a[172:175], v68, v144 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    23/41    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v77, s[8:11], s42 offen lds                                                     ;    48/87    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[104:107], v[18:21], a[168:171], v68, v144 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[112:115], v[18:21], a[164:167], v69, v144 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    28/47    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v78, s[8:11], s42 offen lds                                                     ;    46/67    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[120:123], v[18:21], a[160:163], v69, v144 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[90:93], v[26:29], a[156:159], v68, v145 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    24/53    ARB_WIN_EX
	ds_read_b128 v[18:21], v157 offset:49152                                                            ;    16/26    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[104:107], v[26:29], a[152:155], v68, v145 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[112:115], v[26:29], a[148:151], v69, v145 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    22/48    ARB_WIN_EX
	ds_read_b128 v[128:131], v156 offset:49152                                                          ;    16/36    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[120:123], v[26:29], a[144:147], v69, v145 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[90:93], v[42:45], a[140:143], v68, v145 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    27/60    ARB_WIN_EX
	ds_read_b128 v[26:29], v157 offset:51200                                                            ;    19/35    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[104:107], v[42:45], a[136:139], v68, v145 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[112:115], v[42:45], a[132:135], v69, v145 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    25/51    ARB_WIN_EX
	ds_read_b128 v[136:139], v156 offset:51200                                                          ;    16/31    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[120:123], v[42:45], a[128:131], v69, v145 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_cmp_lt_u64_e64 s[40:41], s[2:3], 28                                                               ;    10/19    ARB_WIN_EX
	s_addk_i32 s48, 0x100                                                                               ;    59/71    ALU_DEP
	s_and_b32 s45, s45, 0x6000
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[100:103], v[38:41], a[188:191], v68, v144 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[140:143], v157 offset:53248                                                          ;    20/31    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[108:111], v[38:41], a[184:187], v68, v144 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[116:119], v[38:41], a[180:183], v69, v144 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    21/50    ARB_WIN_EX
	ds_read_b128 v[160:163], v156 offset:53248                                                          ;    12/35    ALU_DEP
	s_waitcnt lgkmcnt(8)                                                                                ;    13/13    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[124:127], v[38:41], a[176:179], v69, v144 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[100:103], v[22:25], a[172:175], v68, v144 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    24/53    ALU_DEP
	ds_read_b128 v[164:167], v157 offset:55296                                                          ;    11/23    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[108:111], v[22:25], a[168:171], v68, v144 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[116:119], v[22:25], a[164:167], v69, v144 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    19/45    ARB_WIN_EX
	ds_read_b128 v[168:171], v156 offset:55296                                                          ;    15/23    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[124:127], v[22:25], a[160:163], v69, v144 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[100:103], v[30:33], a[156:159], v68, v145 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    29/61    ARB_WIN_EX
	ds_read2st64_b32 v[150:151], v85 offset0:4 offset1:5                                                ;    15/27    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[108:111], v[30:33], a[152:155], v68, v145 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[116:119], v[30:33], a[148:151], v69, v145 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    25/53    ARB_WIN_EX
	ds_read2st64_b32 v[148:149], v85 offset0:6 offset1:7                                                ;    20/33    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[124:127], v[30:33], a[144:147], v69, v145 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[100:103], v[132:135], a[140:143], v68, v145 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    14/43    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[108:111], v[132:135], a[136:139], v68, v145 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    32/60    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[116:119], v[132:135], a[132:135], v69, v145 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    29/56    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[124:127], v[132:135], a[128:131], v69, v145 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    23/47    ARB_WIN_EX
	s_waitcnt vmcnt(17)                                                                                 ;    10/10    WAITCNT
	s_barrier                                                                                           ;    86/107   BARRIER
	s_waitcnt lgkmcnt(9)                                                                                ;    13/13    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[2:5], v[18:21], a[124:127], v172, v66 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_mov_b32 m0, s31
	buffer_load_dwordx4 v75, s[8:11], s34 offen lds                                                     ;    86/114   ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[10:13], v[18:21], a[120:123], v172, v66 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[50:53], v[18:21], a[116:119], v173, v66 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    32/58    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v76, s[8:11], s34 offen lds                                                     ;    41/60    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[54:57], v[18:21], a[112:115], v173, v66 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(7)                                                                                ;    20/20    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[2:5], v[26:29], a[108:111], v172, v66 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    11/34    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v77, s[8:11], s34 offen lds                                                     ;    43/66    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[10:13], v[26:29], a[104:107], v172, v66 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[50:53], v[26:29], a[100:103], v173, v66 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    32/59    ALU_DEP
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v78, s[8:11], s34 offen lds                                                     ;    46/85    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[54:57], v[26:29], a[96:99], v173, v66 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    12/36    ALU_DEP
	s_waitcnt lgkmcnt(5)                                                                                ;    21/21    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[2:5], v[140:143], a[92:95], v172, v67 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    11/45    ARB_WIN_EX
	ds_read_b128 v[62:65], v157                                                                         ;    17/36    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[10:13], v[140:143], a[88:91], v172, v67 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[50:53], v[140:143], a[84:87], v173, v67 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    24/52    ARB_WIN_EX
	ds_read_b128 v[46:49], v156                                                                         ;    15/30    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[54:57], v[140:143], a[80:83], v173, v67 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/44    ARB_WIN_EX
	s_waitcnt lgkmcnt(5)                                                                                ;    19/19    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[2:5], v[164:167], a[76:79], v172, v67 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    15/51    ARB_WIN_EX
	ds_read_b128 v[58:61], v157 offset:2048                                                             ;    13/26    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[10:13], v[164:167], a[72:75], v172, v67 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    14/43    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[50:53], v[164:167], a[68:71], v173, v67 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    34/58    ARB_WIN_EX
	ds_read_b128 v[42:45], v156 offset:2048                                                             ;    13/26    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[54:57], v[164:167], a[64:67], v173, v67 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_and_b64 vcc, exec, s[40:41]
	v_add_lshl_u32 v174, s48, v79, 2
	s_add_i32 s41, s45, s23
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[6:9], v[128:131], a[124:127], v172, v66 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[54:57], v157 offset:4096                                                             ;     7/20    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[14:17], v[128:131], a[120:123], v172, v66 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    20/43    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[86:89], v[128:131], a[116:119], v173, v66 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    29/58    ARB_WIN_EX
	ds_read_b128 v[38:41], v156 offset:4096                                                             ;    12/22    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[94:97], v[128:131], a[112:115], v173, v66 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[6:9], v[136:139], a[108:111], v172, v66 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    30/62    ARB_WIN_EX
	ds_read_b128 v[50:53], v157 offset:6144                                                             ;    10/29    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[14:17], v[136:139], a[104:107], v172, v66 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[86:89], v[136:139], a[100:103], v173, v66 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    40/77    ALU_DEP
	ds_read_b128 v[34:37], v156 offset:6144                                                             ;    12/33    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[94:97], v[136:139], a[96:99], v173, v66 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[6:9], v[160:163], a[92:95], v172, v67 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    23/53    ARB_WIN_EX
	s_mov_b32 m0, s41
	buffer_load_dwordx4 v174, s[12:15], s22 offen lds                                                   ;    39/66    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[14:17], v[160:163], a[88:91], v172, v67 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/26    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[86:89], v[160:163], a[84:87], v173, v67 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    24/62    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[94:97], v[160:163], a[80:83], v173, v67 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    28/52    ARB_WIN_EX
	s_waitcnt lgkmcnt(10)                                                                               ;    17/17    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[6:9], v[168:171], a[76:79], v172, v67 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     6/38    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[14:17], v[168:171], a[72:75], v172, v67 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    34/61    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[86:89], v[168:171], a[68:71], v173, v67 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    27/59    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[94:97], v[168:171], a[64:67], v173, v67 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    33/60    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[90:93], v[18:21], a[60:63], v68, v66 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    23/67    ARB_WIN_EX
	s_mov_b32 m0, s33
	buffer_load_dwordx4 v71, s[4:7], s35 offen lds                                                      ;    34/63    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[104:107], v[18:21], a[56:59], v68, v66 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[112:115], v[18:21], a[52:55], v69, v66 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    36/61    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v72, s[4:7], s35 offen lds                                                      ;    27/53    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[120:123], v[18:21], a[48:51], v69, v66 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[90:93], v[26:29], a[44:47], v68, v66 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    28/55    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v73, s[4:7], s35 offen lds                                                      ;    40/69    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[104:107], v[26:29], a[40:43], v68, v66 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[112:115], v[26:29], a[36:39], v69, v66 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    24/45    ARB_WIN_EX
	s_add_u32 m0, 0x1000, m0
	buffer_load_dwordx4 v74, s[4:7], s35 offen lds                                                      ;    41/66    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[120:123], v[26:29], a[32:35], v69, v66 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/26    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[90:93], v[140:143], a[28:31], v68, v67 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    34/65    ARB_WIN_EX
	ds_read_b128 v[18:21], v159                                                                         ;     5/15    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[104:107], v[140:143], a[24:27], v68, v67 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[112:115], v[140:143], a[20:23], v69, v67 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    29/57    ARB_WIN_EX
	ds_read_b128 v[2:5], v158                                                                           ;    14/20    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[120:123], v[140:143], a[16:19], v69, v67 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[90:93], v[164:167], a[12:15], v68, v67 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    29/65    ARB_WIN_EX
	ds_read_b128 v[22:25], v159 offset:2048                                                             ;    14/28    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[104:107], v[164:167], a[8:11], v68, v67 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[112:115], v[164:167], a[4:7], v69, v67 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;    31/56    ARB_WIN_EX
	ds_read_b128 v[6:9], v158 offset:2048                                                               ;    13/25    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[120:123], v[164:167], a[0:3], v69, v67 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[100:103], v[128:131], a[60:63], v68, v66 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    21/42    ARB_WIN_EX
	ds_read_b128 v[26:29], v159 offset:4096                                                             ;    16/23    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[108:111], v[128:131], a[56:59], v68, v66 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[116:119], v[128:131], a[52:55], v69, v66 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    18/46    ARB_WIN_EX
	ds_read_b128 v[10:13], v158 offset:4096                                                             ;    10/24    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[124:127], v[128:131], a[48:51], v69, v66 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[100:103], v[136:139], a[44:47], v68, v66 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    26/59    ARB_WIN_EX
	ds_read_b128 v[30:33], v159 offset:6144                                                             ;    11/22    ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[108:111], v[136:139], a[40:43], v68, v66 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[116:119], v[136:139], a[36:39], v69, v66 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    22/44    ARB_WIN_EX
	ds_read_b128 v[14:17], v158 offset:6144                                                             ;    18/27    ALU_DEP
	s_addk_i32 s36, 0x4000
	v_add_u32_e32 v84, 0x200, v84
	v_add_u32_e32 v83, 0x200, v83
	s_addk_i32 s34, 0x1000
	s_addk_i32 s35, 0x100
	v_add_lshl_u32 v175, s48, v80, 2
	s_add_i32 s40, s45, s24
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[124:127], v[136:139], a[32:35], v69, v66 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[100:103], v[160:163], a[28:31], v68, v67 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    38/64    ARB_WIN_EX
	s_mov_b32 m0, s40
	buffer_load_dwordx4 v175, s[16:19], s22 offen lds                                                   ;    12/31    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[108:111], v[160:163], a[24:27], v68, v67 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/28    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[116:119], v[160:163], a[20:23], v69, v67 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    14/37    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[124:127], v[160:163], a[16:19], v69, v67 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    27/56    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[100:103], v[168:171], a[12:15], v68, v67 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    24/53    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[108:111], v[168:171], a[8:11], v68, v67 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    22/50    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[116:119], v[168:171], a[4:7], v69, v67 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    26/58    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[124:127], v[168:171], a[0:3], v69, v67 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;    31/71    ARB_WIN_EX
	s_cbranch_vccnz 64152
	v_or_b32_e32 v100, v81, v70                                                                         ;     3/3     NO_INST_AVAIL
	s_waitcnt vmcnt(16)                                                                                 ;     1/1     WAITCNT
	s_barrier                                                                                           ;     5/7     BARRIER
	s_waitcnt lgkmcnt(7)
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[18:21], v[62:65], a[252:255], v150, v98 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[78:81], v159 offset:16384
	s_waitcnt lgkmcnt(6)
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[22:25], v[62:65], a[248:251], v150, v98 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(4)
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[26:29], v[62:65], a[244:247], v151, v98 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[66:69], v158 offset:16384
	s_waitcnt lgkmcnt(3)                                                                                ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[30:33], v[62:65], a[240:243], v151, v98 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[18:21], v[58:61], a[236:239], v150, v98 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[86:89], v159 offset:18432
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[22:25], v[58:61], a[232:235], v150, v98 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[26:29], v[58:61], a[228:231], v151, v98 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/3     ALU_DEP
	ds_read_b128 v[70:73], v158 offset:18432
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[30:33], v[58:61], a[224:227], v151, v98 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[18:21], v[54:57], a[220:223], v150, v99 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[90:93], v159 offset:20480
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[22:25], v[54:57], a[216:219], v150, v99 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[26:29], v[54:57], a[212:215], v151, v99 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	ds_read_b128 v[74:77], v158 offset:20480                                                            ;     1/1     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[30:33], v[54:57], a[208:211], v151, v99 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[18:21], v[50:53], a[204:207], v150, v99 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/5     ARB_WIN_EX
	ds_read_b128 v[94:97], v159 offset:22528
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[22:25], v[50:53], a[200:203], v150, v99 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[26:29], v[50:53], a[196:199], v151, v99 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[82:85], v158 offset:22528
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[30:33], v[50:53], a[192:195], v151, v99 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_or_b32_e32 v101, 0x26000, v100                                                                    ;     4/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[2:5], v[46:49], a[252:255], v150, v98 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[130:133], v157 offset:16384                                                          ;     1/2     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[6:9], v[46:49], a[248:251], v150, v98 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[10:13], v[46:49], a[244:247], v151, v98 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     5/6     ARB_WIN_EX
	ds_read_b128 v[110:113], v156 offset:16384                                                          ;     1/3     ALU_DEP
	s_waitcnt lgkmcnt(10)                                                                               ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[14:17], v[46:49], a[240:243], v151, v98 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[2:5], v[42:45], a[236:239], v150, v98 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/8     ARB_WIN_EX
	ds_read_b128 v[134:137], v157 offset:18432
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[6:9], v[42:45], a[232:235], v150, v98 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[10:13], v[42:45], a[228:231], v151, v98 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/6     ARB_WIN_EX
	ds_read_b128 v[118:121], v156 offset:18432
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[14:17], v[42:45], a[224:227], v151, v98 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[2:5], v[38:41], a[220:223], v150, v99 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/5     ARB_WIN_EX
	ds_read_b128 v[138:141], v157 offset:20480                                                          ;     1/3     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[6:9], v[38:41], a[216:219], v150, v99 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[10:13], v[38:41], a[212:215], v151, v99 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	ds_read_b128 v[122:125], v156 offset:20480
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[14:17], v[38:41], a[208:211], v151, v99 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[2:5], v[34:37], a[204:207], v150, v99 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/3     ARB_WIN_EX
	ds_read_b128 v[142:145], v157 offset:22528                                                          ;     2/2     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[6:9], v[34:37], a[200:203], v150, v99 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[10:13], v[34:37], a[196:199], v151, v99 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/4     ARB_WIN_EX
	ds_read_b128 v[126:129], v156 offset:22528                                                          ;     2/4     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[14:17], v[34:37], a[192:195], v151, v99 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b32 v168, v101                                                                              ;     1/4     ALU_DEP
	v_add_u32_e32 v101, 0x26100, v100
	ds_read_b32 v167, v101
	v_add_u32_e32 v101, 0x26200, v100
	ds_read_b32 v164, v101                                                                              ;     1/1     ALU_DEP
	v_add_u32_e32 v101, 0x26300, v100
	ds_read_b32 v161, v101                                                                              ;     4/5     ALU_DEP
	v_add_u32_e32 v101, 0x26400, v100
	ds_read_b32 v166, v101                                                                              ;     1/3     ALU_DEP
	v_add_u32_e32 v101, 0x26500, v100
	ds_read_b32 v165, v101                                                                              ;     4/4     ALU_DEP
	v_add_u32_e32 v101, 0x26600, v100
	v_add_u32_e32 v100, 0x26700, v100
	ds_read_b32 v163, v101
	ds_read_b32 v162, v100
	s_waitcnt lgkmcnt(14)                                                                               ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[78:81], v[62:65], a[188:191], v148, v98 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[86:89], v[62:65], a[184:187], v148, v98 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[90:93], v[62:65], a[180:183], v149, v98 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[94:97], v[62:65], a[176:179], v149, v98 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[78:81], v[58:61], a[172:175], v148, v98 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     5/9     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[86:89], v[58:61], a[168:171], v148, v98 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[90:93], v[58:61], a[164:167], v149, v98 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/8     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[94:97], v[58:61], a[160:163], v149, v98 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[78:81], v[54:57], a[156:159], v148, v99 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[86:89], v[54:57], a[152:155], v148, v99 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     4/8     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[90:93], v[54:57], a[148:151], v149, v99 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     7/12    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[94:97], v[54:57], a[144:147], v149, v99 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     4/8     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[78:81], v[50:53], a[140:143], v148, v99 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[86:89], v[50:53], a[136:139], v148, v99 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     5/8     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[90:93], v[50:53], a[132:135], v149, v99 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     4/8     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[94:97], v[50:53], a[128:131], v149, v99 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/11    ARB_WIN_EX
	s_load_dwordx2 s[0:1], s[0:1], 0x20
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[66:69], v[46:49], a[188:191], v148, v98 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/7     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[70:73], v[46:49], a[184:187], v148, v98 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     6/10    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[74:77], v[46:49], a[180:183], v149, v98 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/10    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[82:85], v[46:49], a[176:179], v149, v98 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/7     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[66:69], v[42:45], a[172:175], v148, v98 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/9     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[70:73], v[42:45], a[168:171], v148, v98 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[74:77], v[42:45], a[164:167], v149, v98 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     5/10    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[82:85], v[42:45], a[160:163], v149, v98 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[66:69], v[38:41], a[156:159], v148, v99 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     5/9     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[70:73], v[38:41], a[152:155], v148, v99 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/9     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[74:77], v[38:41], a[148:151], v149, v99 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/11    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[82:85], v[38:41], a[144:147], v149, v99 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[66:69], v[34:37], a[140:143], v148, v99 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[70:73], v[34:37], a[136:139], v148, v99 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[74:77], v[34:37], a[132:135], v149, v99 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[82:85], v[34:37], a[128:131], v149, v99 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	s_waitcnt vmcnt(8)                                                                                  ;     9/9     WAITCNT
	s_barrier                                                                                           ;     1/2     BARRIER
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[18:21], v[130:133], a[124:127], v150, v146 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[98:101], v157 offset:32768                                                           ;     1/2     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[22:25], v[130:133], a[120:123], v150, v146 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[26:29], v[130:133], a[116:119], v151, v146 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/5     ARB_WIN_EX
	ds_read_b128 v[42:45], v156 offset:32768                                                            ;     1/1     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[30:33], v[130:133], a[112:115], v151, v146 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(0)                                                                                ;    10/10    WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[18:21], v[134:137], a[108:111], v150, v146 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[102:105], v157 offset:34816                                                          ;     1/2     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[22:25], v[134:137], a[104:107], v150, v146 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[26:29], v[134:137], a[100:103], v151, v146 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/4     ARB_WIN_EX
	ds_read_b128 v[46:49], v156 offset:34816                                                            ;     2/3     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[30:33], v[134:137], a[96:99], v151, v146 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[18:21], v[138:141], a[92:95], v150, v147 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/3     ARB_WIN_EX
	ds_read_b128 v[106:109], v157 offset:36864                                                          ;     3/4     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[22:25], v[138:141], a[88:91], v150, v147 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     4/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[26:29], v[138:141], a[84:87], v151, v147 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[50:53], v156 offset:36864
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[30:33], v[138:141], a[80:83], v151, v147 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[18:21], v[142:145], a[76:79], v150, v147 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/4     ARB_WIN_EX
	ds_read_b128 v[114:117], v157 offset:38912
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[22:25], v[142:145], a[72:75], v150, v147 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[26:29], v[142:145], a[68:71], v151, v147 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	ds_read_b128 v[58:61], v156 offset:38912                                                            ;     2/3     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[30:33], v[142:145], a[64:67], v151, v147 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[2:5], v[110:113], a[124:127], v150, v146 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	ds_read_b128 v[30:33], v159 offset:32768                                                            ;     1/1     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[6:9], v[110:113], a[120:123], v150, v146 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[10:13], v[110:113], a[116:119], v151, v146 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/6     ARB_WIN_EX
	ds_read_b128 v[18:21], v158 offset:32768
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[14:17], v[110:113], a[112:115], v151, v146 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[2:5], v[118:121], a[108:111], v150, v146 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[34:37], v159 offset:34816
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[6:9], v[118:121], a[104:107], v150, v146 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[10:13], v[118:121], a[100:103], v151, v146 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/2     ARB_WIN_EX
	ds_read_b128 v[22:25], v158 offset:34816
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[14:17], v[118:121], a[96:99], v151, v146 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[2:5], v[122:125], a[92:95], v150, v147 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	ds_read_b128 v[38:41], v159 offset:36864                                                            ;     1/1     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[6:9], v[122:125], a[88:91], v150, v147 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[10:13], v[122:125], a[84:87], v151, v147 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	ds_read_b128 v[26:29], v158 offset:36864
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[14:17], v[122:125], a[80:83], v151, v147 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[2:5], v[126:129], a[76:79], v150, v147 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	ds_read_b128 v[54:57], v159 offset:38912                                                            ;     2/2     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[6:9], v[126:129], a[72:75], v150, v147 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[10:13], v[126:129], a[68:71], v151, v147 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/5     ARB_WIN_EX
	ds_read_b128 v[2:5], v158 offset:38912                                                              ;     1/1     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[14:17], v[126:129], a[64:67], v151, v147 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[78:81], v[130:133], a[60:63], v148, v146 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[86:89], v[130:133], a[56:59], v148, v146 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[90:93], v[130:133], a[52:55], v149, v146 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[94:97], v[130:133], a[48:51], v149, v146 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/8     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[78:81], v[134:137], a[44:47], v148, v146 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/10    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[86:89], v[134:137], a[40:43], v148, v146 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     4/7     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[90:93], v[134:137], a[36:39], v149, v146 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[94:97], v[134:137], a[32:35], v149, v146 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[78:81], v[138:141], a[28:31], v148, v147 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[86:89], v[138:141], a[24:27], v148, v147 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/7     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[90:93], v[138:141], a[20:23], v149, v147 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[94:97], v[138:141], a[16:19], v149, v147 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[78:81], v[142:145], a[12:15], v148, v147 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[86:89], v[142:145], a[8:11], v148, v147 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[90:93], v[142:145], a[4:7], v149, v147 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[94:97], v[142:145], a[0:3], v149, v147 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/4     ARB_WIN_EX
	s_mul_i32 s2, s20, s21
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[66:69], v[110:113], a[60:63], v148, v146 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/8     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[70:73], v[110:113], a[56:59], v148, v146 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[74:77], v[110:113], a[52:55], v149, v146 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[82:85], v[110:113], a[48:51], v149, v146 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/7     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[66:69], v[118:121], a[44:47], v148, v146 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[70:73], v[118:121], a[40:43], v148, v146 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     7/12    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[74:77], v[118:121], a[36:39], v149, v146 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[82:85], v[118:121], a[32:35], v149, v146 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[66:69], v[122:125], a[28:31], v148, v147 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[70:73], v[122:125], a[24:27], v148, v147 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[74:77], v[122:125], a[20:23], v149, v147 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[82:85], v[122:125], a[16:19], v149, v147 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[66:69], v[126:129], a[12:15], v148, v147 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[70:73], v[126:129], a[8:11], v148, v147 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[74:77], v[126:129], a[4:7], v149, v147 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[82:85], v[126:129], a[0:3], v149, v147 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	s_waitcnt vmcnt(0)                                                                                  ;    22/22    WAITCNT
	s_barrier                                                                                           ;     2/2     BARRIER
	s_waitcnt lgkmcnt(7)                                                                                ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[30:33], v[98:101], a[252:255], v166, v168 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[62:65], v159 offset:49152
	s_waitcnt lgkmcnt(6)
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[34:37], v[98:101], a[248:251], v166, v168 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(4)
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[38:41], v[98:101], a[244:247], v165, v168 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[6:9], v158 offset:49152
	s_waitcnt lgkmcnt(3)
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[54:57], v[98:101], a[240:243], v165, v168 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[30:33], v[102:105], a[236:239], v166, v168 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	ds_read_b128 v[70:73], v159 offset:51200                                                            ;     1/2     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[34:37], v[102:105], a[232:235], v166, v168 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[38:41], v[102:105], a[228:231], v165, v168 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[10:13], v158 offset:51200
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[54:57], v[102:105], a[224:227], v165, v168 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[30:33], v[106:109], a[220:223], v166, v167 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[74:77], v159 offset:53248                                                            ;     1/3     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[34:37], v[106:109], a[216:219], v166, v167 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[38:41], v[106:109], a[212:215], v165, v167 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[14:17], v158 offset:53248
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[54:57], v[106:109], a[208:211], v165, v167 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[30:33], v[114:117], a[204:207], v166, v167 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	ds_read_b128 v[78:81], v159 offset:55296
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[34:37], v[114:117], a[200:203], v166, v167 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[38:41], v[114:117], a[196:199], v165, v167 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	ds_read_b128 v[66:69], v158 offset:55296
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[54:57], v[114:117], a[192:195], v165, v167 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[18:21], v[42:45], a[252:255], v166, v168 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[110:113], v157 offset:49152
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[22:25], v[42:45], a[248:251], v166, v168 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[26:29], v[42:45], a[244:247], v165, v168 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[82:85], v156 offset:49152
	s_waitcnt lgkmcnt(10)                                                                               ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[2:5], v[42:45], a[240:243], v165, v168 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[18:21], v[46:49], a[236:239], v166, v168 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	ds_read_b128 v[118:121], v157 offset:51200                                                          ;     2/2     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[22:25], v[46:49], a[232:235], v166, v168 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[26:29], v[46:49], a[228:231], v165, v168 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/2     ARB_WIN_EX
	ds_read_b128 v[86:89], v156 offset:51200
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[2:5], v[46:49], a[224:227], v165, v168 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[18:21], v[50:53], a[220:223], v166, v167 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	ds_read_b128 v[122:125], v157 offset:53248
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[22:25], v[50:53], a[216:219], v166, v167 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[26:29], v[50:53], a[212:215], v165, v167 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[90:93], v156 offset:53248
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[2:5], v[50:53], a[208:211], v165, v167 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[18:21], v[58:61], a[204:207], v166, v167 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	ds_read_b128 v[126:129], v157 offset:55296
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[22:25], v[58:61], a[200:203], v166, v167 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[26:29], v[58:61], a[196:199], v165, v167 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	ds_read_b128 v[94:97], v156 offset:55296                                                            ;     1/1     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[2:5], v[58:61], a[192:195], v165, v167 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(14)
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[62:65], v[98:101], a[188:191], v163, v168 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(13)                                                                               ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[70:73], v[98:101], a[184:187], v163, v168 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(11)
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[74:77], v[98:101], a[180:183], v162, v168 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(9)                                                                                ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[78:81], v[98:101], a[176:179], v162, v168 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[62:65], v[102:105], a[172:175], v163, v168 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[70:73], v[102:105], a[168:171], v163, v168 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[74:77], v[102:105], a[164:167], v162, v168 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[78:81], v[102:105], a[160:163], v162, v168 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[62:65], v[106:109], a[156:159], v163, v167 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[70:73], v[106:109], a[152:155], v163, v167 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[74:77], v[106:109], a[148:151], v162, v167 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[78:81], v[106:109], a[144:147], v162, v167 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[62:65], v[114:117], a[140:143], v163, v167 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[70:73], v[114:117], a[136:139], v163, v167 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[74:77], v[114:117], a[132:135], v162, v167 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[78:81], v[114:117], a[128:131], v162, v167 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	s_mov_b32 s3, 0x27000
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[6:9], v[42:45], a[188:191], v163, v168 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[10:13], v[42:45], a[184:187], v163, v168 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[14:17], v[42:45], a[180:183], v162, v168 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/5     ARB_WIN_EX
	s_waitcnt lgkmcnt(8)                                                                                ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[66:69], v[42:45], a[176:179], v162, v168 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[6:9], v[46:49], a[172:175], v163, v168 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[10:13], v[46:49], a[168:171], v163, v168 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     5/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[14:17], v[46:49], a[164:167], v162, v168 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[66:69], v[46:49], a[160:163], v162, v168 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[6:9], v[50:53], a[156:159], v163, v167 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[10:13], v[50:53], a[152:155], v163, v167 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[14:17], v[50:53], a[148:151], v162, v167 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[66:69], v[50:53], a[144:147], v162, v167 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[6:9], v[58:61], a[140:143], v163, v167 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[10:13], v[58:61], a[136:139], v163, v167 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[14:17], v[58:61], a[132:135], v162, v167 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[66:69], v[58:61], a[128:131], v162, v167 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	s_waitcnt lgkmcnt(7)                                                                                ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[30:33], v[110:113], a[124:127], v166, v164 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[34:37], v[110:113], a[120:123], v166, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     5/8     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[38:41], v[110:113], a[116:119], v165, v164 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     4/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[54:57], v[110:113], a[112:115], v165, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	s_waitcnt lgkmcnt(5)                                                                                ;     1/1     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[30:33], v[118:121], a[108:111], v166, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[34:37], v[118:121], a[104:107], v166, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[38:41], v[118:121], a[100:103], v165, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[54:57], v[118:121], a[96:99], v165, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     5/6     ARB_WIN_EX
	s_waitcnt lgkmcnt(3)                                                                                ;     2/2     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[30:33], v[122:125], a[92:95], v166, v161 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[34:37], v[122:125], a[88:91], v166, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     4/8     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[38:41], v[122:125], a[84:87], v165, v161 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[54:57], v[122:125], a[80:83], v165, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/4     ARB_WIN_EX
	s_waitcnt lgkmcnt(1)
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[30:33], v[126:129], a[76:79], v166, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[34:37], v[126:129], a[72:75], v166, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     6/11    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[38:41], v[126:129], a[68:71], v165, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[54:57], v[126:129], a[64:67], v165, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/6     ARB_WIN_EX
	s_lshl_b32 s2, s2, 1
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[18:21], v[82:85], a[124:127], v166, v164 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[22:25], v[82:85], a[120:123], v166, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[26:29], v[82:85], a[116:119], v165, v164 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[2:5], v[82:85], a[112:115], v165, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[18:21], v[86:89], a[108:111], v166, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[22:25], v[86:89], a[104:107], v166, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[26:29], v[86:89], a[100:103], v165, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[2:5], v[86:89], a[96:99], v165, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[18:21], v[90:93], a[92:95], v166, v161 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     5/7     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[22:25], v[90:93], a[88:91], v166, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[26:29], v[90:93], a[84:87], v165, v161 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[2:5], v[90:93], a[80:83], v165, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/6     ARB_WIN_EX
	s_waitcnt lgkmcnt(0)                                                                                ;     3/3     WAITCNT
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[18:21], v[94:97], a[76:79], v166, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[22:25], v[94:97], a[72:75], v166, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/7     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[26:29], v[94:97], a[68:71], v165, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/7     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[2:5], v[94:97], a[64:67], v165, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/6     ARB_WIN_EX
	v_accvgpr_read_b32 v3, a253                                                                         ;     2/4     ARB_WIN_EX
	v_accvgpr_read_b32 v2, a252
	v_cvt_pk_bf16_f32 v4, v2, v3
	v_accvgpr_read_b32 v3, a255
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[62:65], v[110:113], a[60:63], v163, v164 op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[70:73], v[110:113], a[56:59], v163, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/1     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[74:77], v[110:113], a[52:55], v162, v164 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     5/9     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[78:81], v[110:113], a[48:51], v162, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[62:65], v[118:121], a[44:47], v163, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     8/10    ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[70:73], v[118:121], a[40:43], v163, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[74:77], v[118:121], a[36:39], v162, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/7     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[78:81], v[118:121], a[32:35], v162, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[62:65], v[122:125], a[28:31], v163, v161 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/6     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[70:73], v[122:125], a[24:27], v163, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[74:77], v[122:125], a[20:23], v162, v161 op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[78:81], v[122:125], a[16:19], v162, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[62:65], v[126:129], a[12:15], v163, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	v_accvgpr_read_b32 v2, a254
	v_cvt_pk_bf16_f32 v5, v2, v3
	v_accvgpr_read_b32 v3, a249
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[70:73], v[126:129], a[8:11], v163, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/5     ALU_DEP
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[74:77], v[126:129], a[4:7], v162, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     3/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[78:81], v[126:129], a[0:3], v162, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4 ;     2/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[6:9], v[82:85], a[60:63], v163, v164 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[10:13], v[82:85], a[56:59], v163, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[14:17], v[82:85], a[52:55], v162, v164 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[66:69], v[82:85], a[48:51], v162, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/5     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[6:9], v[86:89], a[44:47], v163, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[10:13], v[86:89], a[40:43], v163, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[14:17], v[86:89], a[36:39], v162, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/3     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[66:69], v[86:89], a[32:35], v162, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[6:9], v[90:93], a[28:31], v163, v161 op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[10:13], v[90:93], a[24:27], v163, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     4/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[14:17], v[90:93], a[20:23], v162, v161 op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     2/2     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[66:69], v[90:93], a[16:19], v162, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     3/4     ARB_WIN_EX
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[6:9], v[94:97], a[12:15], v163, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4 ;     1/2     ARB_WIN_EX
	v_accvgpr_read_b32 v2, a248
	v_cvt_pk_bf16_f32 v6, v2, v3
	v_accvgpr_read_b32 v3, a251
	v_lshlrev_b32_e32 v8, 3, v154
	v_accvgpr_read_b32 v2, a250
	v_cvt_pk_bf16_f32 v7, v2, v3
	v_or_b32_e32 v3, v152, v1
	v_lshl_or_b32 v9, v155, 4, v8
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[10:13], v[94:97], a[8:11], v163, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_or_b32_e32 v2, v9, v153                                                                           ;     1/2     ARB_WIN_EX
	v_mul_lo_u32 v10, v3, s21
	s_and_b32 s1, s1, 0xffff
	v_permlane16_swap_b32_e32 v4, v6
	v_permlane16_swap_b32_e32 v5, v7
	v_add_lshl_u32 v11, v2, v10, 1
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[14:17], v[94:97], a[4:7], v162, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[66:69], v[94:97], a[0:3], v162, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	buffer_store_dwordx4 v[4:7], v11, s[0:3], 0 offen                                                   ;     5/5     ARB_WIN_EX
	v_accvgpr_read_b32 v11, a243
	v_and_b32_e32 v0, 16, v0
	v_accvgpr_read_b32 v4, a244
	v_accvgpr_read_b32 v5, a245
	v_cvt_pk_bf16_f32 v4, v4, v5
	v_accvgpr_read_b32 v5, a246
	v_accvgpr_read_b32 v6, a247
	v_cvt_pk_bf16_f32 v5, v5, v6                                                                        ;     1/1     NO_INST_AVAIL
	v_accvgpr_read_b32 v6, a240
	v_accvgpr_read_b32 v7, a241
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a242                                                                         ;     1/1     NO_INST_AVAIL
	v_cvt_pk_bf16_f32 v7, v7, v11
	v_or3_b32 v11, v0, v8, 32
	v_or_b32_e32 v0, v11, v153
	v_permlane16_swap_b32_e32 v4, v6
	v_permlane16_swap_b32_e32 v5, v7
	v_add_lshl_u32 v8, v0, v10, 1
	buffer_store_dwordx4 v[4:7], v8, s[0:3], 0 offen
	v_accvgpr_read_b32 v8, a235
	v_or_b32_e32 v160, 0x80, v153
	v_accvgpr_read_b32 v4, a236
	v_accvgpr_read_b32 v5, a237
	v_cvt_pk_bf16_f32 v4, v4, v5
	v_accvgpr_read_b32 v5, a238
	v_accvgpr_read_b32 v6, a239
	v_cvt_pk_bf16_f32 v5, v5, v6
	v_accvgpr_read_b32 v6, a232
	v_accvgpr_read_b32 v7, a233
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a234
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_or_b32_e32 v8, 16, v3
	v_mul_lo_u32 v12, v8, s21
	v_permlane16_swap_b32_e32 v4, v6
	v_permlane16_swap_b32_e32 v5, v7
	v_add_lshl_u32 v8, v2, v12, 1
	buffer_store_dwordx4 v[4:7], v8, s[0:3], 0 offen                                                    ;     3/3     ALU_DEP
	v_accvgpr_read_b32 v8, a227
	v_add_u32_e32 v1, v152, v1
	v_accvgpr_read_b32 v4, a228
	v_accvgpr_read_b32 v5, a229
	v_cvt_pk_bf16_f32 v4, v4, v5
	v_accvgpr_read_b32 v5, a230
	v_accvgpr_read_b32 v6, a231
	v_cvt_pk_bf16_f32 v5, v5, v6
	v_accvgpr_read_b32 v6, a224
	v_accvgpr_read_b32 v7, a225
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a226
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_permlane16_swap_b32_e32 v4, v6
	s_nop 0                                                                                             ;     1/1     INTERNAL
	v_permlane16_swap_b32_e32 v5, v7
	v_add_lshl_u32 v8, v0, v12, 1
	buffer_store_dwordx4 v[4:7], v8, s[0:3], 0 offen                                                    ;    20/21    ARB_WIN_EX
	v_accvgpr_read_b32 v8, a219
	s_nop 0
	v_accvgpr_read_b32 v4, a220
	v_accvgpr_read_b32 v5, a221
	v_cvt_pk_bf16_f32 v4, v4, v5
	v_accvgpr_read_b32 v5, a222
	v_accvgpr_read_b32 v6, a223
	v_cvt_pk_bf16_f32 v5, v5, v6
	v_accvgpr_read_b32 v6, a216
	v_accvgpr_read_b32 v7, a217
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a218
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_or_b32_e32 v8, 32, v3
	v_mul_lo_u32 v13, v8, s21
	v_permlane16_swap_b32_e32 v4, v6
	v_permlane16_swap_b32_e32 v5, v7
	v_add_lshl_u32 v8, v2, v13, 1
	buffer_store_dwordx4 v[4:7], v8, s[0:3], 0 offen                                                    ;    58/58    ARB_WIN_EX
	v_accvgpr_read_b32 v8, a211
	v_or_b32_e32 v3, 48, v3
	v_accvgpr_read_b32 v4, a212
	v_accvgpr_read_b32 v5, a213
	v_cvt_pk_bf16_f32 v4, v4, v5
	v_accvgpr_read_b32 v5, a214
	v_accvgpr_read_b32 v6, a215
	v_cvt_pk_bf16_f32 v5, v5, v6
	v_accvgpr_read_b32 v6, a208
	v_accvgpr_read_b32 v7, a209
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a210
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_permlane16_swap_b32_e32 v4, v6
	s_nop 0                                                                                             ;     1/1     INTERNAL
	v_permlane16_swap_b32_e32 v5, v7
	v_add_lshl_u32 v8, v0, v13, 1
	buffer_store_dwordx4 v[4:7], v8, s[0:3], 0 offen                                                    ;    57/57    ARB_WIN_EX
	v_accvgpr_read_b32 v8, a203
	v_mul_lo_u32 v14, v3, s21
	v_accvgpr_read_b32 v4, a204
	v_accvgpr_read_b32 v5, a205
	v_cvt_pk_bf16_f32 v4, v4, v5
	v_accvgpr_read_b32 v5, a206
	v_accvgpr_read_b32 v6, a207
	v_cvt_pk_bf16_f32 v5, v5, v6
	v_accvgpr_read_b32 v6, a200
	v_accvgpr_read_b32 v7, a201
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a202                                                                         ;     1/4     NO_INST_AVAIL
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_permlane16_swap_b32_e32 v4, v6
	s_nop 0                                                                                             ;     3/3     INTERNAL
	v_permlane16_swap_b32_e32 v5, v7
	v_add_lshl_u32 v3, v2, v14, 1
	buffer_store_dwordx4 v[4:7], v3, s[0:3], 0 offen                                                    ;    55/55    ARB_WIN_EX
	v_accvgpr_read_b32 v3, a196
	s_nop 0
	v_accvgpr_read_b32 v4, a197
	v_cvt_pk_bf16_f32 v4, v3, v4                                                                        ;     1/1     ARB_WIN_EX
	v_accvgpr_read_b32 v3, a198
	v_accvgpr_read_b32 v5, a199
	v_cvt_pk_bf16_f32 v5, v3, v5
	v_accvgpr_read_b32 v3, a192
	v_accvgpr_read_b32 v6, a193
	v_accvgpr_read_b32 v7, a195
	v_cvt_pk_bf16_f32 v6, v3, v6
	v_accvgpr_read_b32 v3, a194
	v_cvt_pk_bf16_f32 v7, v3, v7
	v_permlane16_swap_b32_e32 v4, v6
	v_permlane16_swap_b32_e32 v5, v7
	v_add_lshl_u32 v3, v0, v14, 1
	buffer_store_dwordx4 v[4:7], v3, s[0:3], 0 offen                                                    ;    22/24    ARB_WIN_EX
	v_accvgpr_read_b32 v3, a188
	s_nop 0
	v_accvgpr_read_b32 v4, a189
	v_cvt_pk_bf16_f32 v4, v3, v4
	v_accvgpr_read_b32 v3, a190
	v_accvgpr_read_b32 v5, a191
	v_cvt_pk_bf16_f32 v5, v3, v5
	v_accvgpr_read_b32 v3, a184
	v_accvgpr_read_b32 v6, a185
	v_cvt_pk_bf16_f32 v6, v3, v6
	v_accvgpr_read_b32 v3, a186
	v_accvgpr_read_b32 v7, a187
	v_cvt_pk_bf16_f32 v7, v3, v7
	v_or_b32_e32 v3, v9, v160
	v_permlane16_swap_b32_e32 v4, v6
	v_permlane16_swap_b32_e32 v5, v7
	v_add_lshl_u32 v8, v3, v10, 1
	buffer_store_dwordx4 v[4:7], v8, s[0:3], 0 offen                                                    ;    23/23    ARB_WIN_EX
	s_nop 1                                                                                             ;     2/2     INTERNAL
	v_accvgpr_read_b32 v4, a180
	v_accvgpr_read_b32 v5, a181
	v_cvt_pk_bf16_f32 v6, v4, v5
	v_accvgpr_read_b32 v4, a182
	v_accvgpr_read_b32 v5, a183
	v_cvt_pk_bf16_f32 v7, v4, v5
	v_accvgpr_read_b32 v4, a176
	v_accvgpr_read_b32 v5, a177
	v_cvt_pk_bf16_f32 v8, v4, v5
	v_accvgpr_read_b32 v4, a178
	v_accvgpr_read_b32 v5, a179
	v_cvt_pk_bf16_f32 v9, v4, v5
	v_or_b32_e32 v4, v11, v160
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v5, v4, v10, 1
	buffer_store_dwordx4 v[6:9], v5, s[0:3], 0 offen                                                    ;    39/40    ARB_WIN_EX
	v_accvgpr_read_b32 v5, a172
	s_nop 0
	v_accvgpr_read_b32 v6, a173
	v_cvt_pk_bf16_f32 v6, v5, v6
	v_accvgpr_read_b32 v5, a174
	v_accvgpr_read_b32 v7, a175
	v_cvt_pk_bf16_f32 v7, v5, v7
	v_accvgpr_read_b32 v5, a168
	v_accvgpr_read_b32 v8, a169
	v_accvgpr_read_b32 v9, a171
	v_cvt_pk_bf16_f32 v8, v5, v8
	v_accvgpr_read_b32 v5, a170
	v_cvt_pk_bf16_f32 v9, v5, v9
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v5, v3, v12, 1
	buffer_store_dwordx4 v[6:9], v5, s[0:3], 0 offen                                                    ;    42/43    ARB_WIN_EX
	v_accvgpr_read_b32 v5, a164
	s_nop 0                                                                                             ;     1/1     INTERNAL
	v_accvgpr_read_b32 v6, a165
	v_cvt_pk_bf16_f32 v6, v5, v6
	v_accvgpr_read_b32 v5, a166
	v_accvgpr_read_b32 v7, a167
	v_cvt_pk_bf16_f32 v7, v5, v7
	v_accvgpr_read_b32 v5, a160
	v_accvgpr_read_b32 v8, a161
	v_accvgpr_read_b32 v9, a163
	v_cvt_pk_bf16_f32 v8, v5, v8
	v_accvgpr_read_b32 v5, a162
	v_cvt_pk_bf16_f32 v9, v5, v9                                                                        ;     2/2     NO_INST_AVAIL
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v5, v4, v12, 1
	buffer_store_dwordx4 v[6:9], v5, s[0:3], 0 offen                                                    ;    46/47    ARB_WIN_EX
	v_accvgpr_read_b32 v5, a156
	s_nop 0                                                                                             ;     1/1     INTERNAL
	v_accvgpr_read_b32 v6, a157
	v_cvt_pk_bf16_f32 v6, v5, v6
	v_accvgpr_read_b32 v5, a158
	v_accvgpr_read_b32 v7, a159
	v_cvt_pk_bf16_f32 v7, v5, v7
	v_accvgpr_read_b32 v5, a152
	v_accvgpr_read_b32 v8, a153
	v_accvgpr_read_b32 v9, a155
	v_cvt_pk_bf16_f32 v8, v5, v8
	v_accvgpr_read_b32 v5, a154
	v_cvt_pk_bf16_f32 v9, v5, v9
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v5, v3, v13, 1
	buffer_store_dwordx4 v[6:9], v5, s[0:3], 0 offen                                                    ;    43/44    ARB_WIN_EX
	v_accvgpr_read_b32 v5, a148
	s_nop 0
	v_accvgpr_read_b32 v6, a149
	v_cvt_pk_bf16_f32 v6, v5, v6
	v_accvgpr_read_b32 v5, a150
	v_accvgpr_read_b32 v7, a151
	v_cvt_pk_bf16_f32 v7, v5, v7
	v_accvgpr_read_b32 v5, a144
	v_accvgpr_read_b32 v8, a145
	v_accvgpr_read_b32 v9, a147                                                                         ;     1/2     NO_INST_AVAIL
	v_cvt_pk_bf16_f32 v8, v5, v8
	v_accvgpr_read_b32 v5, a146
	v_cvt_pk_bf16_f32 v9, v5, v9
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v5, v4, v13, 1
	buffer_store_dwordx4 v[6:9], v5, s[0:3], 0 offen                                                    ;    48/51    ARB_WIN_EX
	v_accvgpr_read_b32 v5, a140
	s_nop 0                                                                                             ;     1/1     INTERNAL
	v_accvgpr_read_b32 v6, a141
	v_cvt_pk_bf16_f32 v6, v5, v6
	v_accvgpr_read_b32 v5, a142
	v_accvgpr_read_b32 v7, a143
	v_cvt_pk_bf16_f32 v7, v5, v7
	v_accvgpr_read_b32 v5, a136
	v_accvgpr_read_b32 v8, a137
	v_accvgpr_read_b32 v9, a139
	v_cvt_pk_bf16_f32 v8, v5, v8
	v_accvgpr_read_b32 v5, a138
	v_cvt_pk_bf16_f32 v9, v5, v9
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v5, v3, v14, 1
	buffer_store_dwordx4 v[6:9], v5, s[0:3], 0 offen                                                    ;    49/51    ARB_WIN_EX
	v_accvgpr_read_b32 v5, a132
	s_nop 0
	v_accvgpr_read_b32 v6, a133
	v_cvt_pk_bf16_f32 v6, v5, v6
	v_accvgpr_read_b32 v5, a134
	v_accvgpr_read_b32 v7, a135
	v_cvt_pk_bf16_f32 v7, v5, v7
	v_accvgpr_read_b32 v5, a128
	v_accvgpr_read_b32 v8, a129
	v_accvgpr_read_b32 v9, a131
	v_cvt_pk_bf16_f32 v8, v5, v8                                                                        ;     2/3     NO_INST_AVAIL
	v_accvgpr_read_b32 v5, a130
	v_cvt_pk_bf16_f32 v9, v5, v9
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v5, v4, v14, 1
	buffer_store_dwordx4 v[6:9], v5, s[0:3], 0 offen                                                    ;    51/52    ARB_WIN_EX
	v_accvgpr_read_b32 v5, a124
	s_nop 0                                                                                             ;     1/1     INTERNAL
	v_accvgpr_read_b32 v6, a125
	v_cvt_pk_bf16_f32 v6, v5, v6
	v_accvgpr_read_b32 v5, a126
	v_accvgpr_read_b32 v7, a127
	v_cvt_pk_bf16_f32 v7, v5, v7
	v_accvgpr_read_b32 v5, a120
	v_accvgpr_read_b32 v8, a121
	v_cvt_pk_bf16_f32 v8, v5, v8
	v_accvgpr_read_b32 v5, a122
	v_accvgpr_read_b32 v9, a123
	v_cvt_pk_bf16_f32 v9, v5, v9
	v_add_u32_e32 v5, 0x80, v1
	v_mul_lo_u32 v5, v5, s21
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v10, v2, v5, 1
	buffer_store_dwordx4 v[6:9], v10, s[0:3], 0 offen                                                   ;    71/71    ARB_WIN_EX
	v_accvgpr_read_b32 v10, a115
	s_nop 0
	v_accvgpr_read_b32 v6, a116
	v_accvgpr_read_b32 v7, a117
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a118
	v_accvgpr_read_b32 v8, a119
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_accvgpr_read_b32 v8, a112
	v_accvgpr_read_b32 v9, a113                                                                         ;     1/2     NO_INST_AVAIL
	v_cvt_pk_bf16_f32 v8, v8, v9
	v_accvgpr_read_b32 v9, a114
	v_cvt_pk_bf16_f32 v9, v9, v10
	v_permlane16_swap_b32_e32 v6, v8
	s_nop 0                                                                                             ;     2/2     INTERNAL
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v10, v0, v5, 1
	buffer_store_dwordx4 v[6:9], v10, s[0:3], 0 offen                                                   ;    58/58    ARB_WIN_EX
	v_accvgpr_read_b32 v10, a107
	s_nop 0                                                                                             ;     1/1     INTERNAL
	v_accvgpr_read_b32 v6, a108
	v_accvgpr_read_b32 v7, a109
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a110
	v_accvgpr_read_b32 v8, a111
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_accvgpr_read_b32 v8, a104
	v_accvgpr_read_b32 v9, a105                                                                         ;     4/5     NO_INST_AVAIL
	v_cvt_pk_bf16_f32 v8, v8, v9
	v_accvgpr_read_b32 v9, a106
	v_cvt_pk_bf16_f32 v9, v9, v10
	v_add_u32_e32 v10, 0x90, v1
	v_mul_lo_u32 v10, v10, s21
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v11, v2, v10, 1
	buffer_store_dwordx4 v[6:9], v11, s[0:3], 0 offen                                                   ;    35/36    ARB_WIN_EX
	v_accvgpr_read_b32 v11, a99
	s_nop 0
	v_accvgpr_read_b32 v6, a100
	v_accvgpr_read_b32 v7, a101
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a102
	v_accvgpr_read_b32 v8, a103
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_accvgpr_read_b32 v8, a96
	v_accvgpr_read_b32 v9, a97
	v_cvt_pk_bf16_f32 v8, v8, v9
	v_accvgpr_read_b32 v9, a98
	v_cvt_pk_bf16_f32 v9, v9, v11
	v_permlane16_swap_b32_e32 v6, v8
	s_nop 0                                                                                             ;     2/2     INTERNAL
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v11, v0, v10, 1
	buffer_store_dwordx4 v[6:9], v11, s[0:3], 0 offen                                                   ;    63/63    ARB_WIN_EX
	v_accvgpr_read_b32 v11, a91
	s_nop 0                                                                                             ;     2/2     INTERNAL
	v_accvgpr_read_b32 v6, a92
	v_accvgpr_read_b32 v7, a93
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a94
	v_accvgpr_read_b32 v8, a95
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_accvgpr_read_b32 v8, a88
	v_accvgpr_read_b32 v9, a89
	v_cvt_pk_bf16_f32 v8, v8, v9
	v_accvgpr_read_b32 v9, a90
	v_cvt_pk_bf16_f32 v9, v9, v11
	v_add_u32_e32 v11, 0xa0, v1
	v_mul_lo_u32 v11, v11, s21
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v12, v2, v11, 1
	buffer_store_dwordx4 v[6:9], v12, s[0:3], 0 offen                                                   ;    45/46    ARB_WIN_EX
	v_accvgpr_read_b32 v12, a83
	v_add_u32_e32 v1, 0xb0, v1
	v_accvgpr_read_b32 v6, a84
	v_accvgpr_read_b32 v7, a85
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a86
	v_accvgpr_read_b32 v8, a87
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_accvgpr_read_b32 v8, a80
	v_accvgpr_read_b32 v9, a81
	v_cvt_pk_bf16_f32 v8, v8, v9
	v_accvgpr_read_b32 v9, a82
	v_cvt_pk_bf16_f32 v9, v9, v12
	v_permlane16_swap_b32_e32 v6, v8
	s_nop 0
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v12, v0, v11, 1
	buffer_store_dwordx4 v[6:9], v12, s[0:3], 0 offen                                                   ;    38/39    ARB_WIN_EX
	v_accvgpr_read_b32 v12, a75
	s_nop 0                                                                                             ;     1/1     INTERNAL
	v_accvgpr_read_b32 v6, a76
	v_accvgpr_read_b32 v7, a77
	v_cvt_pk_bf16_f32 v6, v6, v7
	v_accvgpr_read_b32 v7, a78
	v_accvgpr_read_b32 v8, a79
	v_cvt_pk_bf16_f32 v7, v7, v8
	v_accvgpr_read_b32 v8, a72
	v_accvgpr_read_b32 v9, a73
	v_cvt_pk_bf16_f32 v8, v8, v9
	v_accvgpr_read_b32 v9, a74
	v_cvt_pk_bf16_f32 v9, v9, v12
	v_mul_lo_u32 v12, v1, s21
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v1, v2, v12, 1
	buffer_store_dwordx4 v[6:9], v1, s[0:3], 0 offen                                                    ;    60/61    ARB_WIN_EX
	v_accvgpr_read_b32 v1, a68
	v_accvgpr_read_b32 v2, a69
	v_cvt_pk_bf16_f32 v6, v1, v2
	v_accvgpr_read_b32 v1, a70
	v_accvgpr_read_b32 v2, a71
	v_cvt_pk_bf16_f32 v7, v1, v2
	v_accvgpr_read_b32 v1, a64
	v_accvgpr_read_b32 v2, a65
	v_cvt_pk_bf16_f32 v8, v1, v2
	v_accvgpr_read_b32 v1, a66
	v_accvgpr_read_b32 v2, a67
	v_cvt_pk_bf16_f32 v9, v1, v2
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v0, v0, v12, 1
	buffer_store_dwordx4 v[6:9], v0, s[0:3], 0 offen                                                    ;    62/62    ARB_WIN_EX
	v_accvgpr_read_b32 v0, a60
	v_accvgpr_read_b32 v1, a61
	v_cvt_pk_bf16_f32 v6, v0, v1
	v_accvgpr_read_b32 v0, a62
	v_accvgpr_read_b32 v1, a63
	v_cvt_pk_bf16_f32 v7, v0, v1
	v_accvgpr_read_b32 v0, a56
	v_accvgpr_read_b32 v1, a57
	v_cvt_pk_bf16_f32 v8, v0, v1
	v_accvgpr_read_b32 v0, a58
	v_accvgpr_read_b32 v1, a59
	v_cvt_pk_bf16_f32 v9, v0, v1
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v0, v3, v5, 1
	buffer_store_dwordx4 v[6:9], v0, s[0:3], 0 offen                                                    ;    50/51    ARB_WIN_EX
	v_accvgpr_read_b32 v0, a52
	v_accvgpr_read_b32 v1, a53
	v_cvt_pk_bf16_f32 v6, v0, v1
	v_accvgpr_read_b32 v0, a54
	v_accvgpr_read_b32 v1, a55
	v_cvt_pk_bf16_f32 v7, v0, v1
	v_accvgpr_read_b32 v0, a48
	v_accvgpr_read_b32 v1, a49
	v_cvt_pk_bf16_f32 v8, v0, v1
	v_accvgpr_read_b32 v0, a50
	v_accvgpr_read_b32 v1, a51
	v_cvt_pk_bf16_f32 v9, v0, v1
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v0, v4, v5, 1
	buffer_store_dwordx4 v[6:9], v0, s[0:3], 0 offen                                                    ;    82/85    ARB_WIN_EX
	v_accvgpr_read_b32 v0, a44
	v_accvgpr_read_b32 v1, a45
	v_cvt_pk_bf16_f32 v6, v0, v1
	v_accvgpr_read_b32 v0, a46
	v_accvgpr_read_b32 v1, a47
	v_cvt_pk_bf16_f32 v7, v0, v1
	v_accvgpr_read_b32 v0, a40
	v_accvgpr_read_b32 v1, a41
	v_cvt_pk_bf16_f32 v8, v0, v1
	v_accvgpr_read_b32 v0, a42
	v_accvgpr_read_b32 v1, a43
	v_cvt_pk_bf16_f32 v9, v0, v1
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v0, v3, v10, 1
	buffer_store_dwordx4 v[6:9], v0, s[0:3], 0 offen                                                    ;    68/68    ARB_WIN_EX
	v_accvgpr_read_b32 v0, a36
	v_accvgpr_read_b32 v1, a37
	v_cvt_pk_bf16_f32 v6, v0, v1
	v_accvgpr_read_b32 v0, a38
	v_accvgpr_read_b32 v1, a39
	v_cvt_pk_bf16_f32 v7, v0, v1
	v_accvgpr_read_b32 v0, a32
	v_accvgpr_read_b32 v1, a33
	v_cvt_pk_bf16_f32 v8, v0, v1
	v_accvgpr_read_b32 v0, a34
	v_accvgpr_read_b32 v1, a35
	v_cvt_pk_bf16_f32 v9, v0, v1
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v0, v4, v10, 1
	buffer_store_dwordx4 v[6:9], v0, s[0:3], 0 offen                                                    ;    40/40    ARB_WIN_EX
	v_accvgpr_read_b32 v0, a28
	v_accvgpr_read_b32 v1, a29
	v_cvt_pk_bf16_f32 v6, v0, v1
	v_accvgpr_read_b32 v0, a30
	v_accvgpr_read_b32 v1, a31
	v_cvt_pk_bf16_f32 v7, v0, v1
	v_accvgpr_read_b32 v0, a24
	v_accvgpr_read_b32 v1, a25
	v_cvt_pk_bf16_f32 v8, v0, v1
	v_accvgpr_read_b32 v0, a26
	v_accvgpr_read_b32 v1, a27
	v_cvt_pk_bf16_f32 v9, v0, v1
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v0, v3, v11, 1
	buffer_store_dwordx4 v[6:9], v0, s[0:3], 0 offen                                                    ;    47/48    ARB_WIN_EX
	v_accvgpr_read_b32 v0, a20
	v_accvgpr_read_b32 v1, a21
	v_cvt_pk_bf16_f32 v6, v0, v1
	v_accvgpr_read_b32 v0, a22
	v_accvgpr_read_b32 v1, a23
	v_cvt_pk_bf16_f32 v7, v0, v1
	v_accvgpr_read_b32 v0, a16
	v_accvgpr_read_b32 v1, a17
	v_cvt_pk_bf16_f32 v8, v0, v1
	v_accvgpr_read_b32 v0, a18
	v_accvgpr_read_b32 v1, a19
	v_cvt_pk_bf16_f32 v9, v0, v1
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v0, v4, v11, 1
	buffer_store_dwordx4 v[6:9], v0, s[0:3], 0 offen                                                    ;    54/56    ARB_WIN_EX
	v_accvgpr_read_b32 v0, a12
	v_accvgpr_read_b32 v1, a13
	v_cvt_pk_bf16_f32 v6, v0, v1
	v_accvgpr_read_b32 v0, a14
	v_accvgpr_read_b32 v1, a15
	v_cvt_pk_bf16_f32 v7, v0, v1
	v_accvgpr_read_b32 v0, a8
	v_accvgpr_read_b32 v1, a9
	v_cvt_pk_bf16_f32 v8, v0, v1
	v_accvgpr_read_b32 v0, a10
	v_accvgpr_read_b32 v1, a11
	v_cvt_pk_bf16_f32 v9, v0, v1
	v_permlane16_swap_b32_e32 v6, v8
	v_permlane16_swap_b32_e32 v7, v9
	v_add_lshl_u32 v0, v3, v12, 1
	buffer_store_dwordx4 v[6:9], v0, s[0:3], 0 offen                                                    ;    37/40    ARB_WIN_EX
	v_accvgpr_read_b32 v0, a4
	v_accvgpr_read_b32 v1, a5
	v_cvt_pk_bf16_f32 v0, v0, v1
	v_accvgpr_read_b32 v1, a6
	v_accvgpr_read_b32 v2, a7
	v_cvt_pk_bf16_f32 v1, v1, v2
	v_accvgpr_read_b32 v2, a0
	v_accvgpr_read_b32 v3, a1
	v_cvt_pk_bf16_f32 v2, v2, v3
	v_accvgpr_read_b32 v3, a2
	v_accvgpr_read_b32 v5, a3
	v_cvt_pk_bf16_f32 v3, v3, v5
	v_permlane16_swap_b32_e32 v0, v2
	v_permlane16_swap_b32_e32 v1, v3
	v_add_lshl_u32 v4, v4, v12, 1
	buffer_store_dwordx4 v[0:3], v4, s[0:3], 0 offen                                                    ;    42/42    ARB_WIN_EX
	s_endpgm
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
	s_nop 0
