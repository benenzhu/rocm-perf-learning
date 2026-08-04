	.amdgcn_target "amdgcn-amd-amdhsa--gfx950"
	.amdhsa_code_object_version 6
	.text
	.globl	kernel_gemm_0
	.p2align	8
	.type	kernel_gemm_0,@function
kernel_gemm_0:
	s_load_dwordx2 s[28:29], s[0:1], 0x4c
	s_load_dword s33, s[0:1], 0x64
	v_lshrrev_b32_e32 v2, 6, v0
	v_and_b32_e32 v5, 64, v0
	v_lshlrev_b32_e32 v6, 3, v2
	s_waitcnt lgkmcnt(0)
	s_add_i32 s3, s29, 0xff
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
	s_add_i32 s3, s28, 0xff
	s_ashr_i32 s4, s3, 31
	s_lshr_b32 s4, s4, 24
	s_add_i32 s4, s3, s4
	s_ashr_i32 s13, s4, 8
	s_and_b32 s4, s4, 0xffffff00
	s_cmp_lg_u32 s3, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[6:7], s[6:7], s[4:5]
	s_subb_u32 s3, s13, 0
	s_abs_i32 s4, s12
	v_cvt_f32_u32_e32 v1, s4
	s_sub_i32 s8, 0, s4
	s_mul_i32 s15, s12, s3
	s_ashr_i32 s3, s2, 31
	v_rcp_iflag_f32_e32 v1, v1
	s_ashr_i32 s5, s12, 31
	s_xor_b32 s14, s3, s5
	s_abs_i32 s5, s2
	v_mul_f32_e32 v1, 0x4f7ffffe, v1
	v_cvt_u32_f32_e32 v1, v1
	v_and_b32_e32 v7, 7, v0
	v_lshlrev_b32_e32 v8, 4, v7
	s_mov_b32 s40, 0x10000
	v_readfirstlane_b32 s9, v1
	s_mul_i32 s8, s8, s9
	s_mul_hi_u32 s8, s9, s8
	s_add_i32 s9, s9, s8
	s_mul_hi_u32 s8, s5, s9
	s_mul_i32 s9, s8, s4
	s_sub_i32 s5, s5, s9
	s_add_i32 s9, s8, 1
	s_sub_i32 s10, s5, s4
	s_cmp_ge_u32 s5, s4
	s_cselect_b32 s8, s9, s8
	s_cselect_b32 s5, s10, s5
	s_add_i32 s9, s8, 1
	s_cmp_ge_u32 s5, s4
	s_cselect_b32 s4, s9, s8
	s_xor_b32 s16, s4, s14
	s_sub_i32 s4, s16, s14
	s_mul_i32 s17, s4, s12
	s_cmp_lg_u32 s2, s17
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[8:9], -1, 0
	s_xor_b32 s10, s12, s2
	s_cmp_lt_i32 s10, 0
	s_cselect_b64 s[10:11], -1, 0
	s_and_b64 s[4:5], s[10:11], s[4:5]
	s_subb_u32 s19, s16, s14
	s_lshr_b32 s3, s3, 29
	s_add_i32 s3, s2, s3
	s_sub_i32 s20, s2, s17
	s_ashr_i32 s10, s3, 3
	s_and_b32 s3, s3, -8
	s_cmp_lg_u32 s2, s3
	s_cselect_b64 s[4:5], -1, 0
	s_and_b64 s[4:5], s[8:9], s[4:5]
	s_subb_u32 s10, s10, 0
	s_sub_i32 s11, s2, s3
	s_ashr_i32 s2, s15, 31
	s_lshr_b32 s2, s2, 29
	s_add_i32 s2, s15, s2
	s_ashr_i32 s8, s2, 3
	s_and_b32 s2, s2, -8
	s_cmp_lg_u32 s15, s2
	s_cselect_b64 s[2:3], -1, 0
	s_cmp_lt_i32 s15, 0
	s_cselect_b64 s[4:5], -1, 0
	s_and_b64 s[2:3], s[4:5], s[2:3]
	s_subb_u32 s2, s8, 0
	s_lshl_b32 s3, s12, 2
	s_abs_i32 s14, s3
	v_cvt_f32_u32_e32 v1, s14
	s_mul_i32 s2, s2, s11
	s_add_i32 s16, s10, s2
	s_sub_i32 s10, 0, s14
	v_rcp_iflag_f32_e32 v1, v1
	s_xor_b32 s2, s16, s3
	s_ashr_i32 s17, s2, 31
	s_abs_i32 s2, s16
	v_mul_f32_e32 v1, 0x4f7ffffe, v1
	v_cvt_u32_f32_e32 v1, v1
	v_lshlrev_b32_e32 v126, 10, v2
	v_or_b32_e32 v130, 0x10000, v126
	s_movk_i32 s39, 0xf0
	v_readfirstlane_b32 s11, v1
	s_mul_i32 s10, s10, s11
	s_mul_hi_u32 s10, s11, s10
	s_add_i32 s11, s11, s10
	s_mul_hi_u32 s10, s2, s11
	s_mul_i32 s11, s10, s14
	s_sub_i32 s2, s2, s11
	s_add_i32 s11, s10, 1
	s_sub_i32 s18, s2, s14
	s_cmp_ge_u32 s2, s14
	s_cselect_b32 s10, s11, s10
	s_cselect_b32 s2, s18, s2
	s_add_i32 s11, s10, 1
	s_cmp_ge_u32 s2, s14
	s_cselect_b32 s2, s11, s10
	s_xor_b32 s14, s2, s17
	s_sub_i32 s2, s14, s17
	s_mul_i32 s18, s2, s3
	s_cmp_lg_u32 s16, s18
	s_cselect_b64 s[2:3], -1, 0
	s_xor_b32 s10, s16, s12
	s_cmp_lt_i32 s10, 0
	s_cselect_b64 s[10:11], -1, 0
	s_and_b64 s[2:3], s[10:11], s[2:3]
	s_subb_u32 s2, s14, s17
	s_sub_i32 s10, s16, s18
	s_lshl_b32 s11, s2, 2
	s_cmp_lg_u64 s[6:7], 0
	s_subb_u32 s6, s13, s11
	s_min_i32 s2, s6, 4
	s_abs_i32 s3, s2
	v_cvt_f32_u32_e32 v1, s3
	s_sub_i32 s22, 0, s3
	s_xor_b32 s7, s10, s2
	s_ashr_i32 s21, s7, 31
	v_rcp_iflag_f32_e32 v1, v1
	s_abs_i32 s7, s10
	s_load_dwordx2 s[12:13], s[0:1], 0x0
	s_load_dword s14, s[0:1], 0x8
	s_load_dwordx2 s[16:17], s[0:1], 0x10
	s_load_dword s18, s[0:1], 0x18
	v_or_b32_e32 v134, 0x14000, v126
	v_mul_f32_e32 v1, 0x4f7ffffe, v1
	v_cvt_u32_f32_e32 v1, v1
	v_or_b32_e32 v138, 0x4000, v126
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s26, s18
	v_or_b32_e32 v142, 0x8000, v126
	v_readfirstlane_b32 s23, v1
	s_mul_i32 s22, s22, s23
	s_mul_hi_u32 s22, s23, s22
	s_add_i32 s23, s23, s22
	s_mul_hi_u32 s22, s7, s23
	s_mul_i32 s23, s22, s3
	s_sub_i32 s7, s7, s23
	s_add_i32 s23, s22, 1
	s_sub_i32 s24, s7, s3
	s_cmp_ge_u32 s7, s3
	s_cselect_b32 s22, s23, s22
	s_cselect_b32 s7, s24, s7
	s_add_i32 s23, s22, 1
	s_cmp_ge_u32 s7, s3
	s_cselect_b32 s3, s23, s22
	s_xor_b32 s22, s3, s21
	s_sub_i32 s3, s22, s21
	s_mul_i32 s23, s2, s3
	s_cmp_lg_u32 s10, s23
	s_cselect_b64 s[2:3], -1, 0
	s_xor_b32 s6, s6, s10
	s_cmp_lt_i32 s6, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[2:3], s[6:7], s[2:3]
	s_subb_u32 s21, s22, s21
	s_sub_i32 s2, s10, s23
	s_add_i32 s11, s11, s2
	s_cmpk_lt_i32 s15, 0x400
	s_cselect_b64 s[2:3], -1, 0
	s_and_b32 s6, s15, 7
	s_cselect_b64 s[6:7], -1, 0
	s_or_b64 s[2:3], s[2:3], s[6:7]
	s_and_b64 s[2:3], s[2:3], exec
	s_cselect_b32 s3, s20, s21
	v_lshl_or_b32 v150, s3, 8, v5
	v_bfe_u32 v5, v0, 3, 3
	v_or_b32_e32 v5, v5, v6
	s_cselect_b32 s2, s19, s11
	s_bfe_u32 s33, s33, 0xa0006
	v_lshlrev_b32_e32 v9, 3, v5
	v_and_b32_e32 v9, 0x70, v9
	v_lshlrev_b32_e32 v10, 12, v5
	s_lshl_b32 s36, s33, 3
	v_bitop3_b32 v118, v9, v10, v8 bitop3:0xde
	v_add_u32_e32 v10, s36, v5
	v_lshlrev_b32_e32 v11, 3, v10
	v_and_b32_e32 v11, 0x70, v11
	v_lshlrev_b32_e32 v10, 12, v10
	s_lshl_b32 s37, s33, 4
	s_mul_i32 s38, s33, 24
	v_bitop3_b32 v119, v11, v10, v8 bitop3:0xde
	v_add_lshl_u32 v10, s37, v5, 12
	v_add_u32_e32 v5, s38, v5
	v_bitop3_b32 v120, v10, v9, v8 bitop3:0xf6
	v_lshlrev_b32_e32 v9, 3, v5
	v_and_b32_e32 v9, 0x70, v9
	v_lshlrev_b32_e32 v5, 12, v5
	v_bitop3_b32 v121, v9, v5, v8 bitop3:0xde
	v_or_b32_e32 v5, v6, v7
	v_lshlrev_b32_e32 v9, 5, v0
	v_lshlrev_b32_e32 v7, 9, v0
	v_lshlrev_b32_e32 v8, 4, v5
	v_and_b32_e32 v10, 0x400, v9
	v_and_b32_e32 v8, 0xf0, v8
	v_and_b32_e32 v11, 0x300, v9
	v_and_or_b32 v7, v7, s40, v10
	v_or3_b32 v122, v7, v11, v8
	v_add_u32_e32 v7, s36, v5
	v_add_lshl_u32 v6, s37, v6, 12
	s_mov_b32 s36, 0x7ff0400
	v_bitop3_b32 v6, v9, s36, v6 bitop3:0xc8
	v_readfirstlane_b32 s36, v126
	s_mov_b32 m0, s36
	s_lshl_b32 s36, s33, 10
	v_add_u32_e32 v127, s36, v126
	s_lshl_b32 s30, s2, 20
	s_mov_b32 s15, 0x27000
	s_and_b32 s13, s13, 0xffff
	v_readfirstlane_b32 s37, v127
	v_lshl_add_u32 v128, s33, 11, v126
	buffer_load_dwordx4 v118, s[12:15], s30 offen lds
	s_mov_b32 m0, s37
	v_readfirstlane_b32 s33, v128
	v_add_u32_e32 v129, s36, v128
	v_lshlrev_b32_e32 v12, 12, v7
	buffer_load_dwordx4 v119, s[12:15], s30 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v129
	s_and_b32 s17, s17, 0xffff
	v_and_b32_e32 v12, 0x3ff0000, v12
	v_lshlrev_b32_e32 v7, 4, v7
	v_add_u32_e32 v5, s38, v5
	buffer_load_dwordx4 v120, s[12:15], s30 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v130
	v_add_u32_e32 v131, 0x10000, v127
	s_lshl_b32 s31, s3, 20
	s_mov_b32 s24, s16
	s_mov_b32 s25, s17
	s_mov_b32 s27, s15
	v_and_or_b32 v7, v7, s39, v12
	v_or3_b32 v124, v6, v11, v8
	v_lshlrev_b32_e32 v6, 12, v5
	buffer_load_dwordx4 v121, s[12:15], s30 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v131
	v_add_u32_e32 v132, 0x10000, v128
	v_or3_b32 v123, v7, v10, v11
	v_and_b32_e32 v6, 0xfff0000, v6
	v_lshlrev_b32_e32 v5, 4, v5
	buffer_load_dwordx4 v122, s[24:27], s31 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v132
	v_add_u32_e32 v133, 0x10000, v129
	v_and_or_b32 v5, v5, s39, v6
	buffer_load_dwordx4 v123, s[24:27], s31 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v133
	v_or3_b32 v125, v5, v10, v11
	buffer_load_dwordx4 v124, s[24:27], s31 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v134
	v_add_u32_e32 v135, 0x14000, v127
	s_or_b32 s35, s31, 0x80000
	buffer_load_dwordx4 v125, s[24:27], s31 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v135
	v_add_u32_e32 v136, 0x14000, v128
	buffer_load_dwordx4 v122, s[24:27], s35 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v136
	v_add_u32_e32 v137, 0x14000, v129
	buffer_load_dwordx4 v123, s[24:27], s35 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v137
	buffer_load_dwordx4 v124, s[24:27], s35 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v138
	v_add_u32_e32 v139, 0x4000, v127
	s_or_b32 s34, s30, 0x80000
	buffer_load_dwordx4 v125, s[24:27], s35 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v139
	v_add_u32_e32 v140, 0x4000, v128
	buffer_load_dwordx4 v118, s[12:15], s34 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v140
	v_add_u32_e32 v141, 0x4000, v129
	buffer_load_dwordx4 v119, s[12:15], s34 offen lds
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s33, v141
	buffer_load_dwordx4 v120, s[12:15], s34 offen lds
	s_mov_b32 m0, s33
	v_add_u32_e32 v143, 0x8000, v127
	buffer_load_dwordx4 v121, s[12:15], s34 offen lds
	v_readfirstlane_b32 s34, v142
	s_or_b32 s33, s30, 0x80
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v143
	v_add_u32_e32 v144, 0x8000, v128
	buffer_load_dwordx4 v118, s[12:15], s33 offen lds
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v144
	v_add_u32_e32 v145, 0x8000, v129
	buffer_load_dwordx4 v119, s[12:15], s33 offen lds
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v145
	v_or_b32_e32 v167, 0x18000, v126
	buffer_load_dwordx4 v120, s[12:15], s33 offen lds
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v167
	v_add_u32_e32 v168, 0x18000, v127
	buffer_load_dwordx4 v121, s[12:15], s33 offen lds
	s_or_b32 s33, s31, 0x800
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v168
	v_add_u32_e32 v169, 0x18000, v128
	buffer_load_dwordx4 v122, s[24:27], s33 offen lds
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v169
	v_add_u32_e32 v170, 0x18000, v129
	buffer_load_dwordx4 v123, s[24:27], s33 offen lds
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v170
	v_or_b32_e32 v171, 0x1c000, v126
	buffer_load_dwordx4 v124, s[24:27], s33 offen lds
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v171
	v_add_u32_e32 v172, 0x1c000, v127
	buffer_load_dwordx4 v125, s[24:27], s33 offen lds
	s_or_b32 s33, s31, 0x80800
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v172
	v_add_u32_e32 v173, 0x1c000, v128
	buffer_load_dwordx4 v122, s[24:27], s33 offen lds
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v173
	v_add_u32_e32 v174, 0x1c000, v129
	v_lshrrev_b32_e32 v1, 1, v0
	buffer_load_dwordx4 v123, s[24:27], s33 offen lds
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s34, v174
	s_load_dwordx2 s[4:5], s[0:1], 0x30
	s_load_dwordx2 s[8:9], s[0:1], 0x40
	v_and_b32_e32 v4, 64, v1
	buffer_load_dwordx4 v124, s[24:27], s33 offen lds
	s_mov_b32 m0, s34
	v_or_b32_e32 v175, 0xc000, v126
	v_lshl_or_b32 v1, s2, 8, v4
	buffer_load_dwordx4 v125, s[24:27], s33 offen lds
	v_readfirstlane_b32 s25, v175
	v_add_u32_e32 v176, 0xc000, v127
	v_and_b32_e32 v147, 15, v0
	v_or_b32_e32 v146, 0x80, v1
	s_or_b32 s24, s30, 0x80080
	s_mov_b32 m0, s25
	v_readfirstlane_b32 s25, v176
	v_add_u32_e32 v177, 0xc000, v128
	v_and_b32_e32 v66, 63, v0
	buffer_load_dwordx4 v118, s[12:15], s24 offen lds
	s_mov_b32 m0, s25
	v_readfirstlane_b32 s25, v177
	v_add_u32_e32 v178, 0xc000, v129
	v_or_b32_e32 v2, v4, v147
	v_lshlrev_b32_e32 v4, 3, v0
	v_lshlrev_b32_e32 v156, 6, v1
	v_lshlrev_b32_e32 v155, 6, v146
	v_and_b32_e32 v3, 48, v0
	s_mov_b32 s6, -1
	s_waitcnt lgkmcnt(0)
	s_and_b32 s5, s5, 0xffff
	buffer_load_dwordx4 v119, s[12:15], s24 offen lds
	s_mov_b32 m0, s25
	v_readfirstlane_b32 s25, v178
	v_and_b32_e32 v4, 0x70, v4
	v_lshlrev_b32_e32 v2, 7, v2
	v_or_b32_e32 v68, v156, v66
	v_or_b32_e32 v70, v155, v66
	s_mov_b32 s20, s4
	s_mov_b32 s21, s5
	s_mov_b32 s22, s6
	s_mov_b32 s23, s15
	v_or_b32_e32 v148, 0x80, v150
	buffer_load_dwordx4 v120, s[12:15], s24 offen lds
	s_mov_b32 m0, s25
	v_bitop3_b32 v151, v2, v4, v3 bitop3:0xf6
	v_or_b32_e32 v34, 64, v3
	v_lshlrev_b32_e32 v68, 2, v68
	v_lshlrev_b32_e32 v70, 2, v70
	buffer_load_dwordx4 v121, s[12:15], s24 offen lds
	;;#ASMSTART
	s_waitcnt vmcnt(28)
s_barrier
	;;#ASMEND
	v_bitop3_b32 v152, v2, v34, v4 bitop3:0xf6
	ds_read_b128 v[30:33], v151
	ds_read_b128 v[26:29], v151 offset:2048
	ds_read_b128 v[14:17], v152
	ds_read_b128 v[10:13], v152 offset:2048
	ds_read_b128 v[22:25], v151 offset:4096
	ds_read_b128 v[18:21], v151 offset:6144
	ds_read_b128 v[6:9], v152 offset:4096
	ds_read_b128 v[2:5], v152 offset:6144
	;;#ASMSTART
	s_waitcnt vmcnt(24)
s_barrier
	;;#ASMEND
	v_or_b32_e32 v69, 0x2000, v68
	v_or_b32_e32 v71, 0x2000, v70
	buffer_load_dword v166, v68, s[20:23], 0 offen
	buffer_load_dword v165, v69, s[20:23], 0 offen
	buffer_load_dword v162, v70, s[20:23], 0 offen
	buffer_load_dword v159, v71, s[20:23], 0 offen
	v_lshlrev_b32_e32 v158, 6, v150
	v_lshlrev_b32_e32 v157, 6, v148
	v_or_b32_e32 v68, v158, v66
	v_or_b32_e32 v70, v157, v66
	s_and_b32 s9, s9, 0xffff
	s_mov_b32 s10, s6
	s_mov_b32 s11, s15
	v_lshlrev_b32_e32 v68, 2, v68
	v_lshlrev_b32_e32 v70, 2, v70
	v_or_b32_e32 v69, 0x2000, v68
	v_or_b32_e32 v71, 0x2000, v70
	buffer_load_dword v164, v68, s[8:11], 0 offen
	buffer_load_dword v163, v69, s[8:11], 0 offen
	buffer_load_dword v161, v70, s[8:11], 0 offen
	buffer_load_dword v160, v71, s[8:11], 0 offen
	v_lshlrev_b32_e32 v35, 4, v0
	v_lshlrev_b32_e32 v67, 7, v0
	v_and_b32_e32 v35, 0x70, v35
	s_movk_i32 s24, 0x2400
	v_bfe_u32 v149, v0, 4, 2
	v_and_or_b32 v35, v67, s24, v35
	v_lshl_or_b32 v153, v149, 7, v35
	v_lshl_or_b32 v154, v34, 3, v35
	v_or_b32_e32 v179, 0x10000, v153
	v_or_b32_e32 v38, 0x10800, v153
	v_or_b32_e32 v39, 0x10800, v154
	v_or_b32_e32 v42, 0x11000, v153
	v_or_b32_e32 v43, 0x11000, v154
	v_or_b32_e32 v46, 0x11800, v153
	v_or_b32_e32 v47, 0x11800, v154
	v_or_b32_e32 v180, 0x10000, v154
	ds_read_b128 v[50:53], v179
	ds_read_b128 v[34:37], v180
	ds_read_b128 v[54:57], v38
	ds_read_b128 v[38:41], v39
	ds_read_b128 v[58:61], v42
	ds_read_b128 v[42:45], v43
	ds_read_b128 v[62:65], v46
	ds_read_b128 v[46:49], v47
	v_lshlrev_b32_e32 v181, 2, v66
	v_lshlrev_b32_e32 v66, 8, v0
	v_and_b32_e32 v66, 0x4000, v66
	v_lshl_or_b32 v182, s3, 16, v66
	v_and_b32_e32 v66, 0x4000, v67
	v_lshl_or_b32 v183, s2, 16, v66
	v_mov_b32_e32 v66, 0
	s_mov_b32 s19, s15
	s_mov_b32 s7, s15
	s_or_b32 s20, s31, 0x81800
	s_or_b32 s21, s30, 0x80180
	s_mov_b64 s[2:3], -2
	v_or_b32_e32 v184, 0x14000, v153
	v_or_b32_e32 v185, 0x14000, v154
	v_add_u32_e32 v186, 0x14800, v153
	v_add_u32_e32 v187, 0x14800, v154
	v_add_u32_e32 v188, 0x15000, v153
	v_add_u32_e32 v189, 0x15000, v154
	v_add_u32_e32 v190, 0x15800, v153
	v_add_u32_e32 v191, 0x15800, v154
	v_or_b32_e32 v192, 0x18000, v153
	v_or_b32_e32 v193, 0x18000, v154
	v_add_u32_e32 v194, 0x18800, v153
	v_add_u32_e32 v195, 0x18800, v154
	v_add_u32_e32 v196, 0x19000, v153
	v_add_u32_e32 v197, 0x19000, v154
	v_add_u32_e32 v198, 0x19800, v153
	v_add_u32_e32 v199, 0x19800, v154
	v_or_b32_e32 v200, 0x1c000, v153
	v_or_b32_e32 v201, 0x1c000, v154
	v_add_u32_e32 v202, 0x1c800, v153
	v_add_u32_e32 v203, 0x1c800, v154
	v_add_u32_e32 v204, 0x1d000, v153
	v_add_u32_e32 v205, 0x1d000, v154
	v_add_u32_e32 v206, 0x1d800, v153
	v_add_u32_e32 v207, 0x1d800, v154
	v_add_u32_e32 v208, 0x10800, v153
	v_add_u32_e32 v209, 0x10800, v154
	v_add_u32_e32 v210, 0x11000, v153
	v_add_u32_e32 v211, 0x11000, v154
	v_add_u32_e32 v212, 0x11800, v153
	v_add_u32_e32 v213, 0x11800, v154
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
.LBB0_1:
	v_add_u32_e32 v66, v181, v183
	v_add_u32_e32 v67, v181, v182
	s_mov_b32 s10, s6
	s_mov_b32 s11, s7
	v_add_u32_e32 v116, 0x2000, v66
	v_add_u32_e32 v117, 0x8000, v66
	v_add_u32_e32 v242, 0xa000, v66
	v_add_u32_e32 v244, 0x2000, v67
	v_add_u32_e32 v245, 0x8000, v67
	v_add_u32_e32 v246, 0xa000, v67
	buffer_load_dword v247, v66, s[4:7], 0 offen offset:256
	buffer_load_dword v248, v116, s[4:7], 0 offen offset:256
	buffer_load_dword v217, v117, s[4:7], 0 offen offset:256
	buffer_load_dword v214, v242, s[4:7], 0 offen offset:256
	buffer_load_dword v249, v244, s[8:11], 0 offen offset:256
	buffer_load_dword v216, v245, s[8:11], 0 offen offset:256
	buffer_load_dword v215, v246, s[8:11], 0 offen offset:256
	v_readfirstlane_b32 s26, v126
	s_add_i32 s25, s21, 0xfff7ff80
	v_readfirstlane_b32 s27, v127
	s_mov_b32 m0, s26
	v_readfirstlane_b32 s30, v128
	buffer_load_dword v243, v67, s[8:11], 0 offen offset:256
	;;#ASMSTART
	s_waitcnt vmcnt(16)
s_barrier
	;;#ASMEND
	s_waitcnt vmcnt(11) lgkmcnt(7)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[30:33], v[50:53], a[252:255], v166, v164 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v118, s[12:15], s25 offen lds
	s_mov_b32 m0, s27
	v_readfirstlane_b32 s31, v129
	s_waitcnt lgkmcnt(5)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[30:33], v[54:57], a[248:251], v166, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v119, s[12:15], s25 offen lds
	s_mov_b32 m0, s30
	v_readfirstlane_b32 s33, v130
	s_waitcnt vmcnt(12) lgkmcnt(3)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[30:33], v[58:61], a[244:247], v166, v163 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v120, s[12:15], s25 offen lds
	s_mov_b32 m0, s31
	s_add_i32 s24, s20, 0xfff7f800
	v_readfirstlane_b32 s34, v131
	s_waitcnt lgkmcnt(1)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[30:33], v[62:65], a[240:243], v166, v163 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v121, s[12:15], s25 offen lds
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[26:29], v[50:53], a[236:239], v166, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[68:71], v184
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[26:29], v[54:57], a[232:235], v166, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[72:75], v185
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[26:29], v[58:61], a[228:231], v166, v163 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[76:79], v186
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[26:29], v[62:65], a[224:227], v166, v163 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[80:83], v187
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[22:25], v[50:53], a[220:223], v165, v164 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[84:87], v188
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[22:25], v[54:57], a[216:219], v165, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[88:91], v189
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[22:25], v[58:61], a[212:215], v165, v163 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[92:95], v190
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[22:25], v[62:65], a[208:211], v165, v163 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[96:99], v191
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[18:21], v[50:53], a[204:207], v165, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[18:21], v[54:57], a[200:203], v165, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[18:21], v[58:61], a[196:199], v165, v163 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[18:21], v[62:65], a[192:195], v165, v163 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_mov_b32 m0, s33
	v_readfirstlane_b32 s35, v132
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[14:17], v[34:37], a[252:255], v166, v164 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[14:17], v[38:41], a[248:251], v166, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[14:17], v[42:45], a[244:247], v166, v163 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(8)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[14:17], v[46:49], a[240:243], v166, v163 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[10:13], v[34:37], a[236:239], v166, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[10:13], v[38:41], a[232:235], v166, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[10:13], v[42:45], a[228:231], v166, v163 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[10:13], v[46:49], a[224:227], v166, v163 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[6:9], v[34:37], a[220:223], v165, v164 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[6:9], v[38:41], a[216:219], v165, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[6:9], v[42:45], a[212:215], v165, v163 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[6:9], v[46:49], a[208:211], v165, v163 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[2:5], v[34:37], a[204:207], v165, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[2:5], v[38:41], a[200:203], v165, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[2:5], v[42:45], a[196:199], v165, v163 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[2:5], v[46:49], a[192:195], v165, v163 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt vmcnt(13) lgkmcnt(7)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[30:33], v[68:71], a[188:191], v166, v161 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v122, s[16:19], s24 offen lds
	s_mov_b32 m0, s34
	v_readfirstlane_b32 s36, v133
	s_waitcnt lgkmcnt(5)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[30:33], v[76:79], a[184:187], v166, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v123, s[16:19], s24 offen lds
	s_mov_b32 m0, s35
	v_readfirstlane_b32 s37, v134
	s_waitcnt vmcnt(14) lgkmcnt(3)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[30:33], v[84:87], a[180:183], v166, v160 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v124, s[16:19], s24 offen lds
	s_mov_b32 m0, s36
	s_add_i32 s23, s20, 0xfffff800
	v_readfirstlane_b32 s38, v135
	s_waitcnt lgkmcnt(1)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[30:33], v[92:95], a[176:179], v166, v160 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v125, s[16:19], s24 offen lds
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[26:29], v[68:71], a[172:175], v166, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[30:33], v151 offset:16384
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[26:29], v[76:79], a[168:171], v166, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[100:103], v152 offset:16384
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[26:29], v[84:87], a[164:167], v166, v160 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[104:107], v151 offset:18432
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[26:29], v[92:95], a[160:163], v166, v160 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[26:29], v152 offset:18432
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[22:25], v[68:71], a[156:159], v165, v161 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[108:111], v151 offset:20480
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[22:25], v[76:79], a[152:155], v165, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[112:115], v152 offset:20480
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[22:25], v[84:87], a[148:151], v165, v160 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[218:221], v151 offset:22528
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[22:25], v[92:95], a[144:147], v165, v160 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[22:25], v152 offset:22528
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[18:21], v[68:71], a[140:143], v165, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[18:21], v[76:79], a[136:139], v165, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[18:21], v[84:87], a[132:135], v165, v160 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[18:21], v[92:95], a[128:131], v165, v160 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_mov_b32 m0, s37
	v_readfirstlane_b32 s39, v136
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[14:17], v[72:75], a[188:191], v166, v161 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[14:17], v[80:83], a[184:187], v166, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[14:17], v[88:91], a[180:183], v166, v160 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(8)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[14:17], v[96:99], a[176:179], v166, v160 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[10:13], v[72:75], a[172:175], v166, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[10:13], v[80:83], a[168:171], v166, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[10:13], v[88:91], a[164:167], v166, v160 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[10:13], v[96:99], a[160:163], v166, v160 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[6:9], v[72:75], a[156:159], v165, v161 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[6:9], v[80:83], a[152:155], v165, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[6:9], v[88:91], a[148:151], v165, v160 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[6:9], v[96:99], a[144:147], v165, v160 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[2:5], v[72:75], a[140:143], v165, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[2:5], v[80:83], a[136:139], v165, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[2:5], v[88:91], a[132:135], v165, v160 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[2:5], v[96:99], a[128:131], v165, v160 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	s_waitcnt vmcnt(16)
s_barrier
	;;#ASMEND
	s_waitcnt lgkmcnt(7)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[30:33], v[50:53], a[124:127], v162, v164 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v122, s[16:19], s23 offen lds
	s_mov_b32 m0, s38
	v_readfirstlane_b32 s40, v137
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[30:33], v[54:57], a[120:123], v162, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v123, s[16:19], s23 offen lds
	s_mov_b32 m0, s39
	v_readfirstlane_b32 s41, v138
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[30:33], v[58:61], a[116:119], v162, v163 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v124, s[16:19], s23 offen lds
	s_mov_b32 m0, s40
	s_add_i32 s22, s21, 0xffffff80
	v_readfirstlane_b32 s42, v139
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[30:33], v[62:65], a[112:115], v162, v163 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v125, s[16:19], s23 offen lds
	s_waitcnt lgkmcnt(5)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[104:107], v[50:53], a[108:111], v162, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[2:5], v151 offset:32768
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[104:107], v[54:57], a[104:107], v162, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[6:9], v152 offset:32768
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[104:107], v[58:61], a[100:103], v162, v163 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[10:13], v151 offset:34816
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[104:107], v[62:65], a[96:99], v162, v163 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[14:17], v152 offset:34816
	s_waitcnt lgkmcnt(7)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[108:111], v[50:53], a[92:95], v159, v164 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[18:21], v151 offset:36864
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[108:111], v[54:57], a[88:91], v159, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[222:225], v152 offset:36864
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[108:111], v[58:61], a[84:87], v159, v163 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[226:229], v151 offset:38912
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[108:111], v[62:65], a[80:83], v159, v163 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[230:233], v152 offset:38912
	s_waitcnt lgkmcnt(9)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[218:221], v[50:53], a[76:79], v159, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[218:221], v[54:57], a[72:75], v159, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[218:221], v[58:61], a[68:71], v159, v163 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[218:221], v[62:65], a[64:67], v159, v163 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_mov_b32 m0, s41
	v_readfirstlane_b32 s43, v140
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[100:103], v[34:37], a[124:127], v162, v164 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[100:103], v[38:41], a[120:123], v162, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[100:103], v[42:45], a[116:119], v162, v163 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[100:103], v[46:49], a[112:115], v162, v163 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[26:29], v[34:37], a[108:111], v162, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[26:29], v[38:41], a[104:107], v162, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[26:29], v[42:45], a[100:103], v162, v163 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[26:29], v[46:49], a[96:99], v162, v163 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[112:115], v[34:37], a[92:95], v159, v164 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[112:115], v[38:41], a[88:91], v159, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[112:115], v[42:45], a[84:87], v159, v163 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[112:115], v[46:49], a[80:83], v159, v163 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(8)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[22:25], v[34:37], a[76:79], v159, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[22:25], v[38:41], a[72:75], v159, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[22:25], v[42:45], a[68:71], v159, v163 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[22:25], v[46:49], a[64:67], v159, v163 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[30:33], v[68:71], a[60:63], v162, v161 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v118, s[12:15], s22 offen lds
	s_mov_b32 m0, s42
	v_readfirstlane_b32 s44, v141
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[30:33], v[76:79], a[56:59], v162, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v119, s[12:15], s22 offen lds
	s_mov_b32 m0, s43
	v_readfirstlane_b32 s47, v142
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[30:33], v[84:87], a[52:55], v162, v160 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v120, s[12:15], s22 offen lds
	s_mov_b32 m0, s44
	s_add_i32 s46, s21, 0xfff80000
	v_readfirstlane_b32 s48, v143
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[30:33], v[92:95], a[48:51], v162, v160 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v121, s[12:15], s22 offen lds
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[104:107], v[68:71], a[44:47], v162, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[34:37], v192
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[104:107], v[76:79], a[40:43], v162, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[42:45], v193
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[104:107], v[84:87], a[36:39], v162, v160 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[50:53], v194
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[104:107], v[92:95], a[32:35], v162, v160 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[54:57], v195
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[108:111], v[68:71], a[28:31], v159, v161 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[58:61], v196
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[108:111], v[76:79], a[24:27], v159, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[62:65], v197
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[108:111], v[84:87], a[20:23], v159, v160 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[234:237], v198
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[108:111], v[92:95], a[16:19], v159, v160 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[238:241], v199
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[218:221], v[68:71], a[12:15], v159, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[218:221], v[76:79], a[8:11], v159, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[218:221], v[84:87], a[4:7], v159, v160 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[218:221], v[92:95], a[0:3], v159, v160 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_mov_b32 m0, s47
	v_readfirstlane_b32 s49, v144
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[100:103], v[72:75], a[60:63], v162, v161 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[100:103], v[80:83], a[56:59], v162, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[100:103], v[88:91], a[52:55], v162, v160 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[100:103], v[96:99], a[48:51], v162, v160 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[26:29], v[72:75], a[44:47], v162, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[26:29], v[80:83], a[40:43], v162, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[26:29], v[88:91], a[36:39], v162, v160 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[26:29], v[96:99], a[32:35], v162, v160 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[112:115], v[72:75], a[28:31], v159, v161 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[112:115], v[80:83], a[24:27], v159, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[112:115], v[88:91], a[20:23], v159, v160 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[112:115], v[96:99], a[16:19], v159, v160 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[22:25], v[72:75], a[12:15], v159, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[22:25], v[80:83], a[8:11], v159, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[22:25], v[88:91], a[4:7], v159, v160 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[22:25], v[96:99], a[0:3], v159, v160 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dword v166, v66, s[4:7], 0 offen offset:512
	buffer_load_dword v165, v116, s[4:7], 0 offen offset:512
	buffer_load_dword v162, v117, s[4:7], 0 offen offset:512
	buffer_load_dword v159, v242, s[4:7], 0 offen offset:512
	buffer_load_dword v164, v67, s[8:11], 0 offen offset:512
	buffer_load_dword v163, v244, s[8:11], 0 offen offset:512
	buffer_load_dword v161, v245, s[8:11], 0 offen offset:512
	buffer_load_dword v160, v246, s[8:11], 0 offen offset:512
	;;#ASMSTART
	s_waitcnt vmcnt(16)
s_barrier
	;;#ASMEND
	s_waitcnt vmcnt(24) lgkmcnt(7)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[2:5], v[34:37], a[252:255], v247, v243 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v118, s[12:15], s46 offen lds
	s_mov_b32 m0, s48
	v_readfirstlane_b32 s50, v145
	s_waitcnt lgkmcnt(5)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[2:5], v[50:53], a[248:251], v247, v243 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v119, s[12:15], s46 offen lds
	s_mov_b32 m0, s49
	v_readfirstlane_b32 s51, v167
	s_waitcnt lgkmcnt(3)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[2:5], v[58:61], a[244:247], v247, v249 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v120, s[12:15], s46 offen lds
	s_mov_b32 m0, s50
	s_add_i32 s45, s20, 0xfff80000
	v_readfirstlane_b32 s52, v168
	s_waitcnt lgkmcnt(1)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[2:5], v[234:237], a[240:243], v247, v249 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v121, s[12:15], s46 offen lds
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[10:13], v[34:37], a[236:239], v247, v243 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[82:85], v200
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[10:13], v[50:53], a[232:235], v247, v243 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[66:69], v201
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[10:13], v[58:61], a[228:231], v247, v249 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[86:89], v202
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[10:13], v[234:237], a[224:227], v247, v249 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[70:73], v203
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[18:21], v[34:37], a[220:223], v248, v243 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[90:93], v204
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[18:21], v[50:53], a[216:219], v248, v243 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[74:77], v205
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[18:21], v[58:61], a[212:215], v248, v249 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[94:97], v206
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[18:21], v[234:237], a[208:211], v248, v249 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[78:81], v207
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[226:229], v[34:37], a[204:207], v248, v243 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[226:229], v[50:53], a[200:203], v248, v243 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[226:229], v[58:61], a[196:199], v248, v249 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[226:229], v[234:237], a[192:195], v248, v249 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_mov_b32 m0, s51
	v_readfirstlane_b32 s53, v169
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[6:9], v[42:45], a[252:255], v247, v243 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[6:9], v[54:57], a[248:251], v247, v243 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[6:9], v[62:65], a[244:247], v247, v249 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(8)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[6:9], v[238:241], a[240:243], v247, v249 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[14:17], v[42:45], a[236:239], v247, v243 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[14:17], v[54:57], a[232:235], v247, v243 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[14:17], v[62:65], a[228:231], v247, v249 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[14:17], v[238:241], a[224:227], v247, v249 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[222:225], v[42:45], a[220:223], v248, v243 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[222:225], v[54:57], a[216:219], v248, v243 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[222:225], v[62:65], a[212:215], v248, v249 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[222:225], v[238:241], a[208:211], v248, v249 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[230:233], v[42:45], a[204:207], v248, v243 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[230:233], v[54:57], a[200:203], v248, v243 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[230:233], v[62:65], a[196:199], v248, v249 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[230:233], v[238:241], a[192:195], v248, v249 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(7)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[2:5], v[82:85], a[188:191], v247, v216 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v122, s[16:19], s45 offen lds
	s_mov_b32 m0, s52
	v_readfirstlane_b32 s54, v170
	s_waitcnt lgkmcnt(5)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[2:5], v[86:89], a[184:187], v247, v216 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v123, s[16:19], s45 offen lds
	s_mov_b32 m0, s53
	v_readfirstlane_b32 s55, v171
	s_waitcnt lgkmcnt(3)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[2:5], v[90:93], a[180:183], v247, v215 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v124, s[16:19], s45 offen lds
	s_mov_b32 m0, s54
	v_readfirstlane_b32 s56, v172
	s_waitcnt lgkmcnt(1)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[2:5], v[94:97], a[176:179], v247, v215 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v125, s[16:19], s45 offen lds
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[10:13], v[82:85], a[172:175], v247, v216 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[218:221], v151 offset:49152
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[10:13], v[86:89], a[168:171], v247, v216 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[110:113], v152 offset:49152
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[10:13], v[90:93], a[164:167], v247, v215 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[38:41], v151 offset:51200
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[10:13], v[94:97], a[160:163], v247, v215 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[98:101], v152 offset:51200
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[18:21], v[82:85], a[156:159], v248, v216 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[46:49], v151 offset:53248
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[18:21], v[86:89], a[152:155], v248, v216 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[102:105], v152 offset:53248
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[18:21], v[90:93], a[148:151], v248, v215 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[114:117], v151 offset:55296
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[18:21], v[94:97], a[144:147], v248, v215 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[106:109], v152 offset:55296
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[226:229], v[82:85], a[140:143], v248, v216 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[226:229], v[86:89], a[136:139], v248, v216 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[226:229], v[90:93], a[132:135], v248, v215 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[226:229], v[94:97], a[128:131], v248, v215 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_mov_b32 m0, s55
	v_readfirstlane_b32 s57, v173
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[6:9], v[66:69], a[188:191], v247, v216 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[6:9], v[70:73], a[184:187], v247, v216 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[6:9], v[74:77], a[180:183], v247, v215 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(8)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[6:9], v[78:81], a[176:179], v247, v215 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[14:17], v[66:69], a[172:175], v247, v216 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[14:17], v[70:73], a[168:171], v247, v216 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[14:17], v[74:77], a[164:167], v247, v215 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[14:17], v[78:81], a[160:163], v247, v215 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[222:225], v[66:69], a[156:159], v248, v216 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[222:225], v[70:73], a[152:155], v248, v216 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[222:225], v[74:77], a[148:151], v248, v215 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[222:225], v[78:81], a[144:147], v248, v215 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[230:233], v[66:69], a[140:143], v248, v216 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[230:233], v[70:73], a[136:139], v248, v216 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[230:233], v[74:77], a[132:135], v248, v215 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[230:233], v[78:81], a[128:131], v248, v215 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	s_waitcnt vmcnt(16)
s_barrier
	;;#ASMEND
	s_waitcnt lgkmcnt(7)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[218:221], v[34:37], a[124:127], v217, v243 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v122, s[16:19], s20 offen lds
	s_mov_b32 m0, s56
	v_readfirstlane_b32 s58, v174
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[218:221], v[50:53], a[120:123], v217, v243 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v123, s[16:19], s20 offen lds
	s_mov_b32 m0, s57
	v_readfirstlane_b32 s59, v175
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[218:221], v[58:61], a[116:119], v217, v249 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v124, s[16:19], s20 offen lds
	s_mov_b32 m0, s58
	v_readfirstlane_b32 s60, v176
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[218:221], v[234:237], a[112:115], v217, v249 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v125, s[16:19], s20 offen lds
	s_waitcnt lgkmcnt(5)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[38:41], v[34:37], a[108:111], v217, v243 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[30:33], v151
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[38:41], v[50:53], a[104:107], v217, v243 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[14:17], v152
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[38:41], v[58:61], a[100:103], v217, v249 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[26:29], v151 offset:2048
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[38:41], v[234:237], a[96:99], v217, v249 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[10:13], v152 offset:2048
	s_waitcnt lgkmcnt(7)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[46:49], v[34:37], a[92:95], v214, v243 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[22:25], v151 offset:4096
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[46:49], v[50:53], a[88:91], v214, v243 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[6:9], v152 offset:4096
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[46:49], v[58:61], a[84:87], v214, v249 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[18:21], v151 offset:6144
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[46:49], v[234:237], a[80:83], v214, v249 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[2:5], v152 offset:6144
	s_waitcnt lgkmcnt(9)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[114:117], v[34:37], a[76:79], v214, v243 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[114:117], v[50:53], a[72:75], v214, v243 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[114:117], v[58:61], a[68:71], v214, v249 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[114:117], v[234:237], a[64:67], v214, v249 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_mov_b32 m0, s59
	v_readfirstlane_b32 s61, v177
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[110:113], v[42:45], a[124:127], v217, v243 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[110:113], v[54:57], a[120:123], v217, v243 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[110:113], v[62:65], a[116:119], v217, v249 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[110:113], v[238:241], a[112:115], v217, v249 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[98:101], v[42:45], a[108:111], v217, v243 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[98:101], v[54:57], a[104:107], v217, v243 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[98:101], v[62:65], a[100:103], v217, v249 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[98:101], v[238:241], a[96:99], v217, v249 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[102:105], v[42:45], a[92:95], v214, v243 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[102:105], v[54:57], a[88:91], v214, v243 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[102:105], v[62:65], a[84:87], v214, v249 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[102:105], v[238:241], a[80:83], v214, v249 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(8)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[106:109], v[42:45], a[76:79], v214, v243 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[106:109], v[54:57], a[72:75], v214, v243 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[106:109], v[62:65], a[68:71], v214, v249 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[106:109], v[238:241], a[64:67], v214, v249 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[218:221], v[82:85], a[60:63], v217, v216 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v118, s[12:15], s21 offen lds
	s_mov_b32 m0, s60
	v_readfirstlane_b32 s62, v178
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[218:221], v[86:89], a[56:59], v217, v216 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dwordx4 v119, s[12:15], s21 offen lds
	s_mov_b32 m0, s61
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[218:221], v[90:93], a[52:55], v217, v215 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_add_u32 s2, s2, 2
	buffer_load_dwordx4 v120, s[12:15], s21 offen lds
	s_mov_b32 m0, s62
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[218:221], v[94:97], a[48:51], v217, v215 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_addc_u32 s3, s3, 0
	buffer_load_dwordx4 v121, s[12:15], s21 offen lds
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[38:41], v[82:85], a[44:47], v217, v216 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[50:53], v179
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[38:41], v[86:89], a[40:43], v217, v216 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[34:37], v180
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[38:41], v[90:93], a[36:39], v217, v215 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[54:57], v208
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[38:41], v[94:97], a[32:35], v217, v215 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[38:41], v209
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[46:49], v[82:85], a[28:31], v214, v216 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[58:61], v210
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[46:49], v[86:89], a[24:27], v214, v216 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[42:45], v211
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[46:49], v[90:93], a[20:23], v214, v215 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[62:65], v212
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[46:49], v[94:97], a[16:19], v214, v215 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[46:49], v213
	v_cmp_lt_u64_e64 s[22:23], s[2:3], 28
	v_add_u32_e32 v182, 0x200, v182
	v_add_u32_e32 v183, 0x200, v183
	s_and_b64 vcc, exec, s[22:23]
	s_addk_i32 s20, 0x1000
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[114:117], v[82:85], a[12:15], v214, v216 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[114:117], v[86:89], a[8:11], v214, v216 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[114:117], v[90:93], a[4:7], v214, v215 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[114:117], v[94:97], a[0:3], v214, v215 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_addk_i32 s21, 0x100
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[110:113], v[66:69], a[60:63], v217, v216 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[110:113], v[70:73], a[56:59], v217, v216 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[110:113], v[74:77], a[52:55], v217, v215 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[110:113], v[78:81], a[48:51], v217, v215 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[98:101], v[66:69], a[44:47], v217, v216 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[98:101], v[70:73], a[40:43], v217, v216 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[98:101], v[74:77], a[36:39], v217, v215 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[98:101], v[78:81], a[32:35], v217, v215 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[102:105], v[66:69], a[28:31], v214, v216 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[102:105], v[70:73], a[24:27], v214, v216 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[102:105], v[74:77], a[20:23], v214, v215 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[102:105], v[78:81], a[16:19], v214, v215 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[106:109], v[66:69], a[12:15], v214, v216 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[106:109], v[70:73], a[8:11], v214, v216 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[106:109], v[74:77], a[4:7], v214, v215 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[106:109], v[78:81], a[0:3], v214, v215 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_cbranch_vccnz .LBB0_1
	v_or_b32_e32 v66, 0x14000, v153
	v_or_b32_e32 v67, 0x14000, v154
	v_add_u32_e32 v70, 0x14800, v153
	v_add_u32_e32 v71, 0x14800, v154
	v_add_u32_e32 v74, 0x15000, v153
	v_add_u32_e32 v75, 0x15000, v154
	v_add_u32_e32 v78, 0x15800, v153
	v_add_u32_e32 v79, 0x15800, v154
	;;#ASMSTART
	s_waitcnt vmcnt(16)
s_barrier
	;;#ASMEND
	ds_read_b128 v[98:101], v66
	ds_read_b128 v[66:69], v67
	ds_read_b128 v[102:105], v70
	ds_read_b128 v[70:73], v71
	ds_read_b128 v[106:109], v74
	ds_read_b128 v[74:77], v75
	ds_read_b128 v[110:113], v78
	ds_read_b128 v[78:81], v79
	s_waitcnt vmcnt(19) lgkmcnt(14)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[30:33], v[50:53], a[252:255], v166, v164 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(13)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[30:33], v[54:57], a[248:251], v166, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt vmcnt(18) lgkmcnt(11)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[30:33], v[58:61], a[244:247], v166, v163 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(9)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[30:33], v[62:65], a[240:243], v166, v163 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[26:29], v[50:53], a[236:239], v166, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[26:29], v[54:57], a[232:235], v166, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[26:29], v[58:61], a[228:231], v166, v163 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[26:29], v[62:65], a[224:227], v166, v163 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[22:25], v[50:53], a[220:223], v165, v164 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[22:25], v[54:57], a[216:219], v165, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[22:25], v[58:61], a[212:215], v165, v163 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[22:25], v[62:65], a[208:211], v165, v163 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[18:21], v[50:53], a[204:207], v165, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[18:21], v[54:57], a[200:203], v165, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[18:21], v[58:61], a[196:199], v165, v163 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[18:21], v[62:65], a[192:195], v165, v163 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_load_dwordx2 s[0:1], s[0:1], 0x20
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[14:17], v[34:37], a[252:255], v166, v164 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[14:17], v[38:41], a[248:251], v166, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[14:17], v[42:45], a[244:247], v166, v163 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(0)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[14:17], v[46:49], a[240:243], v166, v163 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[10:13], v[34:37], a[236:239], v166, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[10:13], v[38:41], a[232:235], v166, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[10:13], v[42:45], a[228:231], v166, v163 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[10:13], v[46:49], a[224:227], v166, v163 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[6:9], v[34:37], a[220:223], v165, v164 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[6:9], v[38:41], a[216:219], v165, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[6:9], v[42:45], a[212:215], v165, v163 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[6:9], v[46:49], a[208:211], v165, v163 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[2:5], v[34:37], a[204:207], v165, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[2:5], v[38:41], a[200:203], v165, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[2:5], v[42:45], a[196:199], v165, v163 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[2:5], v[46:49], a[192:195], v165, v163 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[142:145], v151 offset:16384
	ds_read_b128 v[138:141], v151 offset:18432
	ds_read_b128 v[126:129], v152 offset:16384
	ds_read_b128 v[122:125], v152 offset:18432
	ds_read_b128 v[134:137], v151 offset:20480
	ds_read_b128 v[130:133], v151 offset:22528
	ds_read_b128 v[118:121], v152 offset:20480
	ds_read_b128 v[114:117], v152 offset:22528
	s_waitcnt vmcnt(17)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[30:33], v[98:101], a[188:191], v166, v161 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[30:33], v[102:105], a[184:187], v166, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt vmcnt(16)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[30:33], v[106:109], a[180:183], v166, v160 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[30:33], v[110:113], a[176:179], v166, v160 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[26:29], v[98:101], a[172:175], v166, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[26:29], v[102:105], a[168:171], v166, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[26:29], v[106:109], a[164:167], v166, v160 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[26:29], v[110:113], a[160:163], v166, v160 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[22:25], v[98:101], a[156:159], v165, v161 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[22:25], v[102:105], a[152:155], v165, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[22:25], v[106:109], a[148:151], v165, v160 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[22:25], v[110:113], a[144:147], v165, v160 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[18:21], v[98:101], a[140:143], v165, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[18:21], v[102:105], a[136:139], v165, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[18:21], v[106:109], a[132:135], v165, v160 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[18:21], v[110:113], a[128:131], v165, v160 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	v_add_u32_e32 v18, 0x19000, v153
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[14:17], v[66:69], a[188:191], v166, v161 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[14:17], v[70:73], a[184:187], v166, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[14:17], v[74:77], a[180:183], v166, v160 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[14:17], v[78:81], a[176:179], v166, v160 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[10:13], v[66:69], a[172:175], v166, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[10:13], v[70:73], a[168:171], v166, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[10:13], v[74:77], a[164:167], v166, v160 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[10:13], v[78:81], a[160:163], v166, v160 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[6:9], v[66:69], a[156:159], v165, v161 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[6:9], v[70:73], a[152:155], v165, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[6:9], v[74:77], a[148:151], v165, v160 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[6:9], v[78:81], a[144:147], v165, v160 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[2:5], v[66:69], a[140:143], v165, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[2:5], v[70:73], a[136:139], v165, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[2:5], v[74:77], a[132:135], v165, v160 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[2:5], v[78:81], a[128:131], v165, v160 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	s_waitcnt vmcnt(8)
s_barrier
	;;#ASMEND
	ds_read_b128 v[94:97], v151 offset:32768
	ds_read_b128 v[90:93], v151 offset:34816
	ds_read_b128 v[30:33], v152 offset:32768
	ds_read_b128 v[22:25], v152 offset:34816
	ds_read_b128 v[86:89], v151 offset:36864
	ds_read_b128 v[82:85], v151 offset:38912
	ds_read_b128 v[6:9], v152 offset:36864
	ds_read_b128 v[2:5], v152 offset:38912
	s_waitcnt lgkmcnt(14)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[142:145], v[50:53], a[124:127], v162, v164 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[142:145], v[54:57], a[120:123], v162, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[142:145], v[58:61], a[116:119], v162, v163 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[142:145], v[62:65], a[112:115], v162, v163 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[138:141], v[50:53], a[108:111], v162, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[138:141], v[54:57], a[104:107], v162, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[138:141], v[58:61], a[100:103], v162, v163 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[138:141], v[62:65], a[96:99], v162, v163 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(11)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[134:137], v[50:53], a[92:95], v159, v164 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[134:137], v[54:57], a[88:91], v159, v164 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[134:137], v[58:61], a[84:87], v159, v163 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[134:137], v[62:65], a[80:83], v159, v163 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(10)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[130:133], v[50:53], a[76:79], v159, v164 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	v_or_b32_e32 v50, v156, v0
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[130:133], v[54:57], a[72:75], v159, v164 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[130:133], v[58:61], a[68:71], v159, v163 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[130:133], v[62:65], a[64:67], v159, v163 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	v_or_b32_e32 v10, 0x18000, v153
	v_or_b32_e32 v11, 0x18000, v154
	v_add_u32_e32 v14, 0x18800, v153
	v_add_u32_e32 v15, 0x18800, v154
	v_add_u32_e32 v19, 0x19000, v154
	v_add_u32_e32 v26, 0x19800, v153
	v_add_u32_e32 v27, 0x19800, v154
	v_lshlrev_b32_e32 v50, 2, v50
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[126:129], v[34:37], a[124:127], v162, v164 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[126:129], v[38:41], a[120:123], v162, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[126:129], v[42:45], a[116:119], v162, v163 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[126:129], v[46:49], a[112:115], v162, v163 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[122:125], v[34:37], a[108:111], v162, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[122:125], v[38:41], a[104:107], v162, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[122:125], v[42:45], a[100:103], v162, v163 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[122:125], v[46:49], a[96:99], v162, v163 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(9)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[118:121], v[34:37], a[92:95], v159, v164 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[118:121], v[38:41], a[88:91], v159, v164 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[118:121], v[42:45], a[84:87], v159, v163 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[118:121], v[46:49], a[80:83], v159, v163 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(8)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[114:117], v[34:37], a[76:79], v159, v164 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[114:117], v[38:41], a[72:75], v159, v164 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[114:117], v[42:45], a[68:71], v159, v163 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[114:117], v[46:49], a[64:67], v159, v163 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	ds_read_b128 v[34:37], v10
	ds_read_b128 v[10:13], v11
	ds_read_b128 v[38:41], v14
	ds_read_b128 v[14:17], v15
	ds_read_b128 v[42:45], v18
	ds_read_b128 v[18:21], v19
	ds_read_b128 v[46:49], v26
	ds_read_b128 v[26:29], v27
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[142:145], v[98:101], a[60:63], v162, v161 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[142:145], v[102:105], a[56:59], v162, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[142:145], v[106:109], a[52:55], v162, v160 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[142:145], v[110:113], a[48:51], v162, v160 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[138:141], v[98:101], a[44:47], v162, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[138:141], v[102:105], a[40:43], v162, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[138:141], v[106:109], a[36:39], v162, v160 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[138:141], v[110:113], a[32:35], v162, v160 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[134:137], v[98:101], a[28:31], v159, v161 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[134:137], v[102:105], a[24:27], v159, v161 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[134:137], v[106:109], a[20:23], v159, v160 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[134:137], v[110:113], a[16:19], v159, v160 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[130:133], v[98:101], a[12:15], v159, v161 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[130:133], v[102:105], a[8:11], v159, v161 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[130:133], v[106:109], a[4:7], v159, v160 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[130:133], v[110:113], a[0:3], v159, v160 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	v_or_b32_e32 v51, 0x1f00, v50
	v_or_b32_e32 v50, 0x3f00, v50
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[126:129], v[66:69], a[60:63], v162, v161 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[126:129], v[70:73], a[56:59], v162, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[126:129], v[74:77], a[52:55], v162, v160 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[126:129], v[78:81], a[48:51], v162, v160 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[122:125], v[66:69], a[44:47], v162, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[122:125], v[70:73], a[40:43], v162, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[122:125], v[74:77], a[36:39], v162, v160 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[122:125], v[78:81], a[32:35], v162, v160 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[118:121], v[66:69], a[28:31], v159, v161 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[118:121], v[70:73], a[24:27], v159, v161 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[118:121], v[74:77], a[20:23], v159, v160 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[118:121], v[78:81], a[16:19], v159, v160 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[114:117], v[66:69], a[12:15], v159, v161 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[114:117], v[70:73], a[8:11], v159, v161 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[114:117], v[74:77], a[4:7], v159, v160 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[114:117], v[78:81], a[0:3], v159, v160 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	buffer_load_dword v130, v51, s[4:7], 0 offen
	buffer_load_dword v133, v50, s[4:7], 0 offen
	v_or_b32_e32 v51, v158, v0
	v_lshlrev_b32_e32 v51, 2, v51
	v_or_b32_e32 v50, v157, v0
	v_or_b32_e32 v52, 0x1f00, v51
	v_or_b32_e32 v51, 0x3f00, v51
	v_lshlrev_b32_e32 v50, 2, v50
	v_or_b32_e32 v0, v155, v0
	buffer_load_dword v131, v52, s[8:11], 0 offen
	buffer_load_dword v132, v51, s[8:11], 0 offen
	v_or_b32_e32 v51, 0x1f00, v50
	v_or_b32_e32 v50, 0x3f00, v50
	v_lshlrev_b32_e32 v0, 2, v0
	buffer_load_dword v134, v51, s[8:11], 0 offen
	buffer_load_dword v135, v50, s[8:11], 0 offen
	v_or_b32_e32 v50, 0x1f00, v0
	v_or_b32_e32 v0, 0x3f00, v0
	buffer_load_dword v136, v50, s[4:7], 0 offen
	s_nop 0
	buffer_load_dword v0, v0, s[4:7], 0 offen
	v_or_b32_e32 v50, 0x1c000, v153
	v_or_b32_e32 v51, 0x1c000, v154
	v_add_u32_e32 v54, 0x1c800, v153
	v_add_u32_e32 v55, 0x1c800, v154
	v_add_u32_e32 v58, 0x1d000, v153
	v_add_u32_e32 v59, 0x1d000, v154
	;;#ASMSTART
	s_waitcnt vmcnt(0)
s_barrier
	;;#ASMEND
	ds_read_b128 v[98:101], v50
	ds_read_b128 v[50:53], v51
	ds_read_b128 v[102:105], v54
	ds_read_b128 v[54:57], v55
	ds_read_b128 v[106:109], v58
	ds_read_b128 v[58:61], v59
	v_add_u32_e32 v62, 0x1d800, v153
	v_add_u32_e32 v63, 0x1d800, v154
	ds_read_b128 v[110:113], v62
	ds_read_b128 v[62:65], v63
	ds_read_b128 v[126:129], v151 offset:49152
	ds_read_b128 v[122:125], v151 offset:51200
	ds_read_b128 v[78:81], v152 offset:49152
	ds_read_b128 v[74:77], v152 offset:51200
	ds_read_b128 v[118:121], v151 offset:53248
	ds_read_b128 v[114:117], v151 offset:55296
	ds_read_b128 v[70:73], v152 offset:53248
	ds_read_b128 v[66:69], v152 offset:55296
	s_waitcnt vmcnt(5) lgkmcnt(14)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[94:97], v[34:37], a[252:255], v130, v131 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[94:97], v[38:41], a[248:251], v130, v131 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt vmcnt(4)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[94:97], v[42:45], a[244:247], v130, v132 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[94:97], v[46:49], a[240:243], v130, v132 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[90:93], v[34:37], a[236:239], v130, v131 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[90:93], v[38:41], a[232:235], v130, v131 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[90:93], v[42:45], a[228:231], v130, v132 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[90:93], v[46:49], a[224:227], v130, v132 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[86:89], v[34:37], a[220:223], v133, v131 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[86:89], v[38:41], a[216:219], v133, v131 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[86:89], v[42:45], a[212:215], v133, v132 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[86:89], v[46:49], a[208:211], v133, v132 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[82:85], v[34:37], a[204:207], v133, v131 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[82:85], v[38:41], a[200:203], v133, v131 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[82:85], v[42:45], a[196:199], v133, v132 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[82:85], v[46:49], a[192:195], v133, v132 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_mul_i32 s2, s28, s29
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[252:255], v[30:33], v[10:13], a[252:255], v130, v131 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[248:251], v[30:33], v[14:17], a[248:251], v130, v131 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[244:247], v[30:33], v[18:21], a[244:247], v130, v132 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[240:243], v[30:33], v[26:29], a[240:243], v130, v132 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[236:239], v[22:25], v[10:13], a[236:239], v130, v131 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[232:235], v[22:25], v[14:17], a[232:235], v130, v131 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[228:231], v[22:25], v[18:21], a[228:231], v130, v132 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[224:227], v[22:25], v[26:29], a[224:227], v130, v132 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[220:223], v[6:9], v[10:13], a[220:223], v133, v131 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[216:219], v[6:9], v[14:17], a[216:219], v133, v131 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[212:215], v[6:9], v[18:21], a[212:215], v133, v132 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[208:211], v[6:9], v[26:29], a[208:211], v133, v132 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[204:207], v[2:5], v[10:13], a[204:207], v133, v131 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[200:203], v[2:5], v[14:17], a[200:203], v133, v131 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[196:199], v[2:5], v[18:21], a[196:199], v133, v132 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[192:195], v[2:5], v[26:29], a[192:195], v133, v132 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt vmcnt(3)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[94:97], v[98:101], a[188:191], v130, v134 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(13)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[94:97], v[102:105], a[184:187], v130, v134 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt vmcnt(2) lgkmcnt(11)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[94:97], v[106:109], a[180:183], v130, v135 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(9)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[94:97], v[110:113], a[176:179], v130, v135 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[90:93], v[98:101], a[172:175], v130, v134 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[90:93], v[102:105], a[168:171], v130, v134 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[90:93], v[106:109], a[164:167], v130, v135 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[90:93], v[110:113], a[160:163], v130, v135 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[86:89], v[98:101], a[156:159], v133, v134 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[86:89], v[102:105], a[152:155], v133, v134 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[86:89], v[106:109], a[148:151], v133, v135 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[86:89], v[110:113], a[144:147], v133, v135 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[82:85], v[98:101], a[140:143], v133, v134 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[82:85], v[102:105], a[136:139], v133, v134 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[82:85], v[106:109], a[132:135], v133, v135 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[82:85], v[110:113], a[128:131], v133, v135 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_lshl_b32 s2, s2, 1
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[188:191], v[30:33], v[50:53], a[188:191], v130, v134 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[184:187], v[30:33], v[54:57], a[184:187], v130, v134 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[180:183], v[30:33], v[58:61], a[180:183], v130, v135 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(8)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[176:179], v[30:33], v[62:65], a[176:179], v130, v135 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[172:175], v[22:25], v[50:53], a[172:175], v130, v134 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[168:171], v[22:25], v[54:57], a[168:171], v130, v134 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[164:167], v[22:25], v[58:61], a[164:167], v130, v135 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[160:163], v[22:25], v[62:65], a[160:163], v130, v135 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[156:159], v[6:9], v[50:53], a[156:159], v133, v134 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[152:155], v[6:9], v[54:57], a[152:155], v133, v134 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[148:151], v[6:9], v[58:61], a[148:151], v133, v135 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[144:147], v[6:9], v[62:65], a[144:147], v133, v135 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[140:143], v[2:5], v[50:53], a[140:143], v133, v134 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[136:139], v[2:5], v[54:57], a[136:139], v133, v134 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[132:135], v[2:5], v[58:61], a[132:135], v133, v135 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[128:131], v[2:5], v[62:65], a[128:131], v133, v135 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt vmcnt(1) lgkmcnt(7)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[126:129], v[34:37], a[124:127], v136, v131 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[126:129], v[38:41], a[120:123], v136, v131 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[126:129], v[42:45], a[116:119], v136, v132 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[126:129], v[46:49], a[112:115], v136, v132 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(6)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[122:125], v[34:37], a[108:111], v136, v131 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[122:125], v[38:41], a[104:107], v136, v131 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[122:125], v[42:45], a[100:103], v136, v132 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[122:125], v[46:49], a[96:99], v136, v132 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt vmcnt(0) lgkmcnt(3)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[118:121], v[34:37], a[92:95], v0, v131 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[118:121], v[38:41], a[88:91], v0, v131 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[118:121], v[42:45], a[84:87], v0, v132 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[118:121], v[46:49], a[80:83], v0, v132 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(2)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[114:117], v[34:37], a[76:79], v0, v131 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[114:117], v[38:41], a[72:75], v0, v131 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[114:117], v[42:45], a[68:71], v0, v132 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[114:117], v[46:49], a[64:67], v0, v132 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	v_lshlrev_b32_e32 v9, 2, v149
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[124:127], v[78:81], v[10:13], a[124:127], v136, v131 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[120:123], v[78:81], v[14:17], a[120:123], v136, v131 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[116:119], v[78:81], v[18:21], a[116:119], v136, v132 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[112:115], v[78:81], v[26:29], a[112:115], v136, v132 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[108:111], v[74:77], v[10:13], a[108:111], v136, v131 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[104:107], v[74:77], v[14:17], a[104:107], v136, v131 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[100:103], v[74:77], v[18:21], a[100:103], v136, v132 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[96:99], v[74:77], v[26:29], a[96:99], v136, v132 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(1)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[92:95], v[70:73], v[10:13], a[92:95], v0, v131 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[88:91], v[70:73], v[14:17], a[88:91], v0, v131 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[84:87], v[70:73], v[18:21], a[84:87], v0, v132 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[80:83], v[70:73], v[26:29], a[80:83], v0, v132 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	s_waitcnt lgkmcnt(0)
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[76:79], v[66:69], v[10:13], a[76:79], v0, v131 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[72:75], v[66:69], v[14:17], a[72:75], v0, v131 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[68:71], v[66:69], v[18:21], a[68:71], v0, v132 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[64:67], v[66:69], v[26:29], a[64:67], v0, v132 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[126:129], v[98:101], a[60:63], v136, v134 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[126:129], v[102:105], a[56:59], v136, v134 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[126:129], v[106:109], a[52:55], v136, v135 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[126:129], v[110:113], a[48:51], v136, v135 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[122:125], v[98:101], a[44:47], v136, v134 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[122:125], v[102:105], a[40:43], v136, v134 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[122:125], v[106:109], a[36:39], v136, v135 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[122:125], v[110:113], a[32:35], v136, v135 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[118:121], v[98:101], a[28:31], v0, v134 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[118:121], v[102:105], a[24:27], v0, v134 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[118:121], v[106:109], a[20:23], v0, v135 op_sel:[0,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[118:121], v[110:113], a[16:19], v0, v135 op_sel:[0,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[114:117], v[98:101], a[12:15], v0, v134 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[114:117], v[102:105], a[8:11], v0, v134 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[114:117], v[106:109], a[4:7], v0, v135 op_sel:[1,0,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[114:117], v[110:113], a[0:3], v0, v135 op_sel:[1,1,0] op_sel_hi:[0,0,0] cbsz:4 blgp:4
	;;#ASMEND
	v_or_b32_e32 v5, v1, v9
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[60:63], v[78:81], v[50:53], a[60:63], v136, v134 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[56:59], v[78:81], v[54:57], a[56:59], v136, v134 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[52:55], v[78:81], v[58:61], a[52:55], v136, v135 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[48:51], v[78:81], v[62:65], a[48:51], v136, v135 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[44:47], v[74:77], v[50:53], a[44:47], v136, v134 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[40:43], v[74:77], v[54:57], a[40:43], v136, v134 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[36:39], v[74:77], v[58:61], a[36:39], v136, v135 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[32:35], v[74:77], v[62:65], a[32:35], v136, v135 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[28:31], v[70:73], v[50:53], a[28:31], v0, v134 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[24:27], v[70:73], v[54:57], a[24:27], v0, v134 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[20:23], v[70:73], v[58:61], a[20:23], v0, v135 op_sel:[0,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[16:19], v[70:73], v[62:65], a[16:19], v0, v135 op_sel:[0,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[12:15], v[66:69], v[50:53], a[12:15], v0, v134 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[8:11], v[66:69], v[54:57], a[8:11], v0, v134 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[4:7], v[66:69], v[58:61], a[4:7], v0, v135 op_sel:[1,0,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	;;#ASMSTART
	v_mfma_scale_f32_16x16x128_f8f6f4 a[0:3], v[66:69], v[62:65], a[0:3], v0, v135 op_sel:[1,1,0] op_sel_hi:[1,1,0] cbsz:4 blgp:4
	;;#ASMEND
	v_or_b32_e32 v0, v150, v147
	v_accvgpr_read_b32 v2, a252
	v_mul_lo_u32 v10, v5, s29
	s_and_b32 s1, s1, 0xffff
	s_mov_b32 s3, 0x27000
	v_cvt_pk_bf16_f32 v2, v2, s0
	v_add_lshl_u32 v3, v0, v10, 1
	buffer_store_short v2, v3, s[0:3], 0 offen
	v_or_b32_e32 v3, 1, v5
	v_accvgpr_read_b32 v2, a253
	v_mul_lo_u32 v11, v3, s29
	v_cvt_pk_bf16_f32 v2, v2, s0
	v_add_lshl_u32 v3, v0, v11, 1
	buffer_store_short v2, v3, s[0:3], 0 offen
	v_or_b32_e32 v3, 2, v5
	v_accvgpr_read_b32 v2, a254
	v_mul_lo_u32 v12, v3, s29
	v_cvt_pk_bf16_f32 v2, v2, s0
	v_add_lshl_u32 v3, v0, v12, 1
	buffer_store_short v2, v3, s[0:3], 0 offen
	v_or_b32_e32 v3, 3, v5
	v_accvgpr_read_b32 v2, a255
	v_mul_lo_u32 v13, v3, s29
	v_cvt_pk_bf16_f32 v2, v2, s0
	v_add_lshl_u32 v3, v0, v13, 1
	buffer_store_short v2, v3, s[0:3], 0 offen
	v_or_b32_e32 v2, 16, v0
	v_accvgpr_read_b32 v3, a248
	v_cvt_pk_bf16_f32 v3, v3, s0
	v_add_lshl_u32 v4, v2, v10, 1
	buffer_store_short v3, v4, s[0:3], 0 offen
	v_accvgpr_read_b32 v3, a249
	v_cvt_pk_bf16_f32 v3, v3, s0
	v_add_lshl_u32 v4, v2, v11, 1
	buffer_store_short v3, v4, s[0:3], 0 offen
	v_accvgpr_read_b32 v3, a250
	v_cvt_pk_bf16_f32 v3, v3, s0
	v_add_lshl_u32 v4, v2, v12, 1
	buffer_store_short v3, v4, s[0:3], 0 offen
	v_accvgpr_read_b32 v3, a251
	v_cvt_pk_bf16_f32 v3, v3, s0
	v_add_lshl_u32 v4, v2, v13, 1
	buffer_store_short v3, v4, s[0:3], 0 offen
	v_or_b32_e32 v3, 32, v0
	v_accvgpr_read_b32 v4, a244
	v_cvt_pk_bf16_f32 v4, v4, s0
	v_add_lshl_u32 v6, v3, v10, 1
	buffer_store_short v4, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v4, a245
	v_cvt_pk_bf16_f32 v4, v4, s0
	v_add_lshl_u32 v6, v3, v11, 1
	buffer_store_short v4, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v4, a246
	v_cvt_pk_bf16_f32 v4, v4, s0
	v_add_lshl_u32 v6, v3, v12, 1
	buffer_store_short v4, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v4, a247
	v_cvt_pk_bf16_f32 v4, v4, s0
	v_add_lshl_u32 v6, v3, v13, 1
	buffer_store_short v4, v6, s[0:3], 0 offen
	v_or_b32_e32 v4, 48, v0
	v_accvgpr_read_b32 v6, a240
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v10, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a241
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v11, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a242
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v12, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a243
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v13, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_or_b32_e32 v6, 16, v5
	v_accvgpr_read_b32 v7, a236
	v_mul_lo_u32 v14, v6, s29
	v_cvt_pk_bf16_f32 v7, v7, s0
	v_add_lshl_u32 v6, v0, v14, 1
	buffer_store_short v7, v6, s[0:3], 0 offen
	v_or_b32_e32 v7, 17, v5
	v_accvgpr_read_b32 v6, a237
	v_mul_lo_u32 v15, v7, s29
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v0, v15, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_or_b32_e32 v7, 18, v5
	v_accvgpr_read_b32 v6, a238
	v_mul_lo_u32 v16, v7, s29
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v0, v16, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_or_b32_e32 v7, 19, v5
	v_accvgpr_read_b32 v6, a239
	v_mul_lo_u32 v17, v7, s29
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v0, v17, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a232
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v2, v14, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a233
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v2, v15, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a234
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v2, v16, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a235
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v2, v17, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a228
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v3, v14, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a229
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v3, v15, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a230
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v3, v16, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a231
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v3, v17, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a224
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v14, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a225
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v15, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a226
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v16, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a227
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v17, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_or_b32_e32 v6, 32, v5
	v_accvgpr_read_b32 v7, a220
	v_mul_lo_u32 v18, v6, s29
	v_cvt_pk_bf16_f32 v7, v7, s0
	v_add_lshl_u32 v6, v0, v18, 1
	buffer_store_short v7, v6, s[0:3], 0 offen
	v_or_b32_e32 v7, 33, v5
	v_accvgpr_read_b32 v6, a221
	v_mul_lo_u32 v19, v7, s29
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v0, v19, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_or_b32_e32 v7, 34, v5
	v_accvgpr_read_b32 v6, a222
	v_mul_lo_u32 v20, v7, s29
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v0, v20, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_or_b32_e32 v7, 35, v5
	v_accvgpr_read_b32 v6, a223
	v_mul_lo_u32 v21, v7, s29
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v0, v21, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a216
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v2, v18, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a217
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v2, v19, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a218
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v2, v20, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a219
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v2, v21, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a212
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v3, v18, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a213
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v3, v19, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a214
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v3, v20, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a215
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v3, v21, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a208
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v18, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a209
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v19, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a210
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v20, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a211
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v4, v21, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_or_b32_e32 v6, 48, v5
	v_accvgpr_read_b32 v7, a204
	v_mul_lo_u32 v22, v6, s29
	v_cvt_pk_bf16_f32 v7, v7, s0
	v_add_lshl_u32 v6, v0, v22, 1
	buffer_store_short v7, v6, s[0:3], 0 offen
	v_or_b32_e32 v7, 49, v5
	v_accvgpr_read_b32 v6, a205
	v_mul_lo_u32 v23, v7, s29
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v0, v23, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_or_b32_e32 v7, 50, v5
	v_accvgpr_read_b32 v6, a206
	v_mul_lo_u32 v24, v7, s29
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v0, v24, 1
	v_or_b32_e32 v5, 51, v5
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a207
	v_mul_lo_u32 v25, v5, s29
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v5, v0, v25, 1
	buffer_store_short v6, v5, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a200
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v2, v22, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a201
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v2, v23, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a202
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v2, v24, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a203
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v2, v25, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a196
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v3, v22, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a197
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v3, v23, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a198
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v3, v24, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a199
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v3, v25, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a192
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v4, v22, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a193
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v4, v23, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a194
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v4, v24, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_accvgpr_read_b32 v5, a195
	v_cvt_pk_bf16_f32 v5, v5, s0
	v_add_lshl_u32 v6, v4, v25, 1
	buffer_store_short v5, v6, s[0:3], 0 offen
	v_or_b32_e32 v5, v148, v147
	v_accvgpr_read_b32 v6, a188
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v5, v10, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a189
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v5, v11, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a190
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v5, v12, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_accvgpr_read_b32 v6, a191
	v_cvt_pk_bf16_f32 v6, v6, s0
	v_add_lshl_u32 v7, v5, v13, 1
	buffer_store_short v6, v7, s[0:3], 0 offen
	v_or_b32_e32 v6, 0x90, v0
	v_accvgpr_read_b32 v7, a184
	v_cvt_pk_bf16_f32 v7, v7, s0
	v_add_lshl_u32 v8, v6, v10, 1
	buffer_store_short v7, v8, s[0:3], 0 offen
	v_accvgpr_read_b32 v7, a185
	v_cvt_pk_bf16_f32 v7, v7, s0
	v_add_lshl_u32 v8, v6, v11, 1
	buffer_store_short v7, v8, s[0:3], 0 offen
	v_accvgpr_read_b32 v7, a186
	v_cvt_pk_bf16_f32 v7, v7, s0
	v_add_lshl_u32 v8, v6, v12, 1
	buffer_store_short v7, v8, s[0:3], 0 offen
	v_accvgpr_read_b32 v7, a187
	v_cvt_pk_bf16_f32 v7, v7, s0
	v_add_lshl_u32 v8, v6, v13, 1
	buffer_store_short v7, v8, s[0:3], 0 offen
	v_or_b32_e32 v7, 0xa0, v0
	v_accvgpr_read_b32 v8, a180
	v_cvt_pk_bf16_f32 v8, v8, s0
	v_add_lshl_u32 v26, v7, v10, 1
	buffer_store_short v8, v26, s[0:3], 0 offen
	v_accvgpr_read_b32 v8, a181
	v_cvt_pk_bf16_f32 v8, v8, s0
	v_add_lshl_u32 v26, v7, v11, 1
	buffer_store_short v8, v26, s[0:3], 0 offen
	v_accvgpr_read_b32 v8, a182
	v_cvt_pk_bf16_f32 v8, v8, s0
	v_add_lshl_u32 v26, v7, v12, 1
	buffer_store_short v8, v26, s[0:3], 0 offen
	v_accvgpr_read_b32 v8, a183
	v_cvt_pk_bf16_f32 v8, v8, s0
	v_add_lshl_u32 v26, v7, v13, 1
	buffer_store_short v8, v26, s[0:3], 0 offen
	v_or_b32_e32 v8, 0xb0, v0
	v_accvgpr_read_b32 v26, a176
	v_cvt_pk_bf16_f32 v26, v26, s0
	v_add_lshl_u32 v10, v8, v10, 1
	buffer_store_short v26, v10, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a177
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v11, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a178
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v12, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a179
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v13, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a172
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v14, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a173
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v15, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a174
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v16, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a175
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v17, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a168
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v14, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a169
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v15, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a170
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v16, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a171
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v17, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a164
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v14, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a165
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v15, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a166
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v16, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a167
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v17, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a160
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v14, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a161
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v15, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a162
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v16, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a163
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v17, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a156
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v18, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a157
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v19, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a158
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v20, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a159
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v21, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a152
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v18, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a153
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v19, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a154
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v20, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a155
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v21, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a148
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v18, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a149
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v19, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a150
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v20, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a151
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v21, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a144
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v18, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a145
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v19, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a146
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v20, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a147
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v21, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a140
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v22, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a141
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v23, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a142
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v24, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a143
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v5, v25, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a136
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v22, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a137
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v23, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a138
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v24, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a139
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v6, v25, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a132
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v22, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a133
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v23, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a134
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v24, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a135
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v7, v25, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a128
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v22, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a129
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v23, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a130
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v24, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_accvgpr_read_b32 v10, a131
	v_cvt_pk_bf16_f32 v10, v10, s0
	v_add_lshl_u32 v11, v8, v25, 1
	buffer_store_short v10, v11, s[0:3], 0 offen
	v_or_b32_e32 v10, v146, v9
	v_accvgpr_read_b32 v11, a124
	v_mul_lo_u32 v12, v10, s29
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v13, v0, v12, 1
	buffer_store_short v11, v13, s[0:3], 0 offen
	v_or_b32_e32 v13, 1, v10
	v_accvgpr_read_b32 v11, a125
	v_mul_lo_u32 v13, v13, s29
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v14, v0, v13, 1
	buffer_store_short v11, v14, s[0:3], 0 offen
	v_or_b32_e32 v14, 2, v10
	v_accvgpr_read_b32 v11, a126
	v_mul_lo_u32 v14, v14, s29
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v0, v14, 1
	v_or_b32_e32 v10, 3, v10
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a127
	v_mul_lo_u32 v10, v10, s29
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v0, v10, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a120
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v2, v12, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a121
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v2, v13, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a122
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v2, v14, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a123
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v2, v10, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a116
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v3, v12, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a117
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v3, v13, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a118
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v3, v14, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a119
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v3, v10, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a112
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v4, v12, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a113
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v4, v13, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a114
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v4, v14, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a115
	v_add_u32_e32 v1, v1, v9
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v4, v10, 1
	v_add_u32_e32 v9, 0x90, v1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a108
	v_mul_lo_u32 v9, v9, s29
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v15, v0, v9, 1
	buffer_store_short v11, v15, s[0:3], 0 offen
	v_add_u32_e32 v15, 0x91, v1
	v_accvgpr_read_b32 v11, a109
	v_mul_lo_u32 v15, v15, s29
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v16, v0, v15, 1
	buffer_store_short v11, v16, s[0:3], 0 offen
	v_add_u32_e32 v16, 0x92, v1
	v_accvgpr_read_b32 v11, a110
	v_mul_lo_u32 v16, v16, s29
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v17, v0, v16, 1
	buffer_store_short v11, v17, s[0:3], 0 offen
	v_add_u32_e32 v17, 0x93, v1
	v_accvgpr_read_b32 v11, a111
	v_mul_lo_u32 v17, v17, s29
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v0, v17, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a104
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v2, v9, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a105
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v2, v15, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a106
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v2, v16, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a107
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v2, v17, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a100
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v3, v9, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a101
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v3, v15, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a102
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v3, v16, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a103
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v3, v17, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a96
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v4, v9, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a97
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v4, v15, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a98
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v4, v16, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_accvgpr_read_b32 v11, a99
	v_cvt_pk_bf16_f32 v11, v11, s0
	v_add_lshl_u32 v18, v4, v17, 1
	buffer_store_short v11, v18, s[0:3], 0 offen
	v_add_u32_e32 v11, 0xa0, v1
	v_accvgpr_read_b32 v18, a92
	v_mul_lo_u32 v11, v11, s29
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v19, v0, v11, 1
	buffer_store_short v18, v19, s[0:3], 0 offen
	v_add_u32_e32 v19, 0xa1, v1
	v_accvgpr_read_b32 v18, a93
	v_mul_lo_u32 v19, v19, s29
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v20, v0, v19, 1
	buffer_store_short v18, v20, s[0:3], 0 offen
	v_add_u32_e32 v20, 0xa2, v1
	v_accvgpr_read_b32 v18, a94
	v_mul_lo_u32 v20, v20, s29
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v21, v0, v20, 1
	buffer_store_short v18, v21, s[0:3], 0 offen
	v_add_u32_e32 v21, 0xa3, v1
	v_accvgpr_read_b32 v18, a95
	v_mul_lo_u32 v21, v21, s29
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v0, v21, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a88
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v2, v11, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a89
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v2, v19, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a90
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v2, v20, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a91
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v2, v21, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a84
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v3, v11, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a85
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v3, v19, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a86
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v3, v20, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a87
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v3, v21, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a80
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v4, v11, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a81
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v4, v19, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a82
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v4, v20, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v18, a83
	v_cvt_pk_bf16_f32 v18, v18, s0
	v_add_lshl_u32 v22, v4, v21, 1
	buffer_store_short v18, v22, s[0:3], 0 offen
	v_add_u32_e32 v18, 0xb0, v1
	v_accvgpr_read_b32 v22, a76
	v_mul_lo_u32 v18, v18, s29
	v_cvt_pk_bf16_f32 v22, v22, s0
	v_add_lshl_u32 v23, v0, v18, 1
	buffer_store_short v22, v23, s[0:3], 0 offen
	v_add_u32_e32 v23, 0xb1, v1
	v_accvgpr_read_b32 v22, a77
	v_mul_lo_u32 v23, v23, s29
	v_cvt_pk_bf16_f32 v22, v22, s0
	v_add_lshl_u32 v24, v0, v23, 1
	buffer_store_short v22, v24, s[0:3], 0 offen
	v_add_u32_e32 v24, 0xb2, v1
	v_accvgpr_read_b32 v22, a78
	v_mul_lo_u32 v24, v24, s29
	v_cvt_pk_bf16_f32 v22, v22, s0
	v_add_lshl_u32 v25, v0, v24, 1
	v_add_u32_e32 v1, 0xb3, v1
	buffer_store_short v22, v25, s[0:3], 0 offen
	v_accvgpr_read_b32 v22, a79
	v_mul_lo_u32 v1, v1, s29
	v_cvt_pk_bf16_f32 v22, v22, s0
	v_add_lshl_u32 v0, v0, v1, 1
	buffer_store_short v22, v0, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a72
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v22, v2, v18, 1
	buffer_store_short v0, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a73
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v22, v2, v23, 1
	buffer_store_short v0, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a74
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v22, v2, v24, 1
	buffer_store_short v0, v22, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a75
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v2, v1, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a68
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v3, v18, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a69
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v3, v23, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a70
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v3, v24, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a71
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v3, v1, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a64
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v4, v18, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a65
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v4, v23, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a66
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v4, v24, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a67
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v4, v1, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a60
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v12, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a61
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v13, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a62
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v14, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a63
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v10, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a56
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v12, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a57
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v13, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a58
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v14, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a59
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v10, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a52
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v12, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a53
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v13, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a54
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v14, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a55
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v10, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a48
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v12, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a49
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v13, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a50
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v14, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a51
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v10, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a44
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v9, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a45
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v15, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a46
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v16, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a47
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v17, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a40
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v9, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a41
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v15, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a42
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v16, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a43
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v17, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a36
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v9, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a37
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v15, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a38
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v16, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a39
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v17, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a32
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v9, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a33
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v15, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a34
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v16, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a35
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v17, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a28
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v11, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a29
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v19, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a30
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v20, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a31
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v21, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a24
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v11, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a25
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v19, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a26
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v20, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a27
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v21, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a20
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v11, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a21
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v19, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a22
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v20, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a23
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v21, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a16
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v11, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a17
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v19, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a18
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v20, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a19
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v21, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a12
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v18, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a13
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v23, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a14
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v24, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a15
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v5, v1, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a8
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v18, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a9
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v23, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a10
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v24, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a11
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v6, v1, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a4
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v18, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a5
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v23, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a6
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v24, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a7
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v7, v1, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a0
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v18, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a1
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v23, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a2
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v2, v8, v24, 1
	buffer_store_short v0, v2, s[0:3], 0 offen
	v_accvgpr_read_b32 v0, a3
	v_cvt_pk_bf16_f32 v0, v0, s0
	v_add_lshl_u32 v1, v8, v1, 1
	buffer_store_short v0, v1, s[0:3], 0 offen
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel kernel_gemm_0
		.amdhsa_group_segment_fixed_size 131072
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 344
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_kernarg_preload_length 0
		.amdhsa_user_sgpr_kernarg_preload_offset 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 508
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 252
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_tg_split 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end0:
	.size	kernel_gemm_0, .Lfunc_end0-kernel_gemm_0

	.set kernel_gemm_0.num_vgpr, 250
	.set kernel_gemm_0.num_agpr, 256
	.set kernel_gemm_0.numbered_sgpr, 63
	.set kernel_gemm_0.num_named_barrier, 0
	.set kernel_gemm_0.private_seg_size, 0
	.set kernel_gemm_0.uses_vcc, 1
	.set kernel_gemm_0.uses_flat_scratch, 0
	.set kernel_gemm_0.has_dyn_sized_stack, 0
	.set kernel_gemm_0.has_recursion, 0
	.set kernel_gemm_0.has_indirect_call, 0
	.p2alignl 6, 3212836864
	.fill 256, 4, 3212836864
	.section	.AMDGPU.gpr_maximums,"",@progbits
	.set amdgpu.max_num_vgpr, 0
	.set amdgpu.max_num_agpr, 0
	.set amdgpu.max_num_sgpr, 0
	.set amdgpu.max_num_named_barrier, 0
	.text
	.section	".note.GNU-stack","",@progbits
	.amdgpu_metadata
---
amdhsa.kernels:
  - .agpr_count:     256
    .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .offset:         8
        .size:           4
        .value_kind:     by_value
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .address_space:  global
        .offset:         32
        .size:           8
        .value_kind:     global_buffer
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .address_space:  global
        .offset:         48
        .size:           8
        .value_kind:     global_buffer
      - .offset:         56
        .size:           4
        .value_kind:     by_value
      - .address_space:  global
        .offset:         64
        .size:           8
        .value_kind:     global_buffer
      - .offset:         72
        .size:           4
        .value_kind:     by_value
      - .offset:         76
        .size:           4
        .value_kind:     by_value
      - .offset:         80
        .size:           4
        .value_kind:     by_value
      - .offset:         88
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         92
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         96
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         100
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         102
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         104
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         106
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         108
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         110
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         128
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         136
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         144
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         152
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 131072
    .kernarg_segment_align: 8
    .kernarg_segment_size: 344
    .max_flat_workgroup_size: 256
    .name:           kernel_gemm_0
    .private_segment_fixed_size: 0
    .sgpr_count:     69
    .sgpr_spill_count: 0
    .symbol:         kernel_gemm_0.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     508
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa--gfx950
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
