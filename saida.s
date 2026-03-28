@ Beatriz Caldas
@ Eduardo Pianovski
@ Lucas Gasperin
@ Lucas Sotomaior
@ Grupo: RA1 6
@ Link Repositorio: https://github.com/beatriz-caldas/RA1-6

.text
.global _start
_start:
    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_0
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_1
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VMUL.F64 d2, d0, d1
    VPUSH {d2}
    LDR r0, =const_num_2
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_3
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_0
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_0
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_4
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_0
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_0:
    MOV r6, r10
    MOV r5, #0
mod_dec_1:
    CMP r6, #10
    BLT mod_dec_end_1
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_1
mod_dec_end_1:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_2:
    CMP r6, #10
    BLT div_end_2
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_2
div_end_2:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_3:
    CMP r6, #10
    BLT div_end_3
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_3
div_end_3:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_4:
    CMP r6, #10
    BLT div_end_4
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_4
div_end_4:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_5
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_5:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_0
.ltorg
ltorg_skip_0:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_5
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_6
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VDIV.F64 d2, d0, d1
    VPUSH {d2}
    LDR r0, =const_num_7
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_8
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VSUB.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VMUL.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_1
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_1
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_9
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_6
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_6:
    MOV r6, r10
    MOV r5, #0
mod_dec_7:
    CMP r6, #10
    BLT mod_dec_end_7
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_7
mod_dec_end_7:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_8:
    CMP r6, #10
    BLT div_end_8
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_8
div_end_8:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_9:
    CMP r6, #10
    BLT div_end_9
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_9
div_end_9:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_10:
    CMP r6, #10
    BLT div_end_10
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_10
div_end_10:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_11
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_11:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_1
.ltorg
ltorg_skip_1:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_10
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_11
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VDIV.F64 d2, d0, d1
    VCVT.S32.F64 s0, d2
    VCVT.F64.S32 d2, s0
    VPUSH {d2}
    LDR r0, =const_num_12
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_13
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VSUB.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_2
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_2
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_14
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_12
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_12:
    MOV r6, r10
    MOV r5, #0
mod_dec_13:
    CMP r6, #10
    BLT mod_dec_end_13
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_13
mod_dec_end_13:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_14:
    CMP r6, #10
    BLT div_end_14
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_14
div_end_14:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_15:
    CMP r6, #10
    BLT div_end_15
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_15
div_end_15:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_16:
    CMP r6, #10
    BLT div_end_16
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_16
div_end_16:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_17
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_17:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_2
.ltorg
ltorg_skip_2:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_15
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_16
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VCVT.S32.F64 s0, d0
    VCVT.S32.F64 s2, d1
    VCVT.F64.S32 d0, s0
    VCVT.F64.S32 d1, s2
    VDIV.F64 d3, d0, d1
    VCVT.S32.F64 s4, d3
    VCVT.F64.S32 d3, s4
    VMUL.F64 d3, d3, d1
    VSUB.F64 d2, d0, d3
    VPUSH {d2}
    LDR r0, =const_num_17
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_18
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VMUL.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_3
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_3
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_19
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_18
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_18:
    MOV r6, r10
    MOV r5, #0
mod_dec_19:
    CMP r6, #10
    BLT mod_dec_end_19
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_19
mod_dec_end_19:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_20:
    CMP r6, #10
    BLT div_end_20
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_20
div_end_20:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_21:
    CMP r6, #10
    BLT div_end_21
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_21
div_end_21:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_22:
    CMP r6, #10
    BLT div_end_22
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_22
div_end_22:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_23
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_23:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_3
.ltorg
ltorg_skip_3:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_20
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_21
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VMOV.F64 d2, d0
    VCVT.S32.F64 s0, d1
    VMOV r1, s0
pow_loop_24:
    SUB r1, r1, #1
    CMP r1, #0
    BEQ pow_end_24
    VMUL.F64 d2, d2, d0
    B pow_loop_24
pow_end_24:
    VPUSH {d2}
    LDR r0, =const_num_22
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_23
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VDIV.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_4
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_4
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_24
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_25
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_25:
    MOV r6, r10
    MOV r5, #0
mod_dec_26:
    CMP r6, #10
    BLT mod_dec_end_26
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_26
mod_dec_end_26:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_27:
    CMP r6, #10
    BLT div_end_27
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_27
div_end_27:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_28:
    CMP r6, #10
    BLT div_end_28
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_28
div_end_28:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_29:
    CMP r6, #10
    BLT div_end_29
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_29
div_end_29:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_30
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_30:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_4
.ltorg
ltorg_skip_4:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_25
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =res_3
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d0}
    LDR r0, =var_CALC
    VSTR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d0}
    LDR r0, =res_5
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_5
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_26
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_31
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_31:
    MOV r6, r10
    MOV r5, #0
mod_dec_32:
    CMP r6, #10
    BLT mod_dec_end_32
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_32
mod_dec_end_32:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_33:
    CMP r6, #10
    BLT div_end_33
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_33
div_end_33:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_34:
    CMP r6, #10
    BLT div_end_34
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_34
div_end_34:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_35:
    CMP r6, #10
    BLT div_end_35
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_35
div_end_35:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_36
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_36:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_5
.ltorg
ltorg_skip_5:

    @ NOVA EXPRESSAO RPN
    LDR r0, =var_CALC
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_27
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_28
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VSUB.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_6
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_6
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_29
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_37
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_37:
    MOV r6, r10
    MOV r5, #0
mod_dec_38:
    CMP r6, #10
    BLT mod_dec_end_38
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_38
mod_dec_end_38:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_39:
    CMP r6, #10
    BLT div_end_39
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_39
div_end_39:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_40:
    CMP r6, #10
    BLT div_end_40
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_40
div_end_40:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_41:
    CMP r6, #10
    BLT div_end_41
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_41
div_end_41:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_42
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_42:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_6
.ltorg
ltorg_skip_6:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_30
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =res_6
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_31
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_32
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VMOV.F64 d2, d0
    VCVT.S32.F64 s0, d1
    VMOV r1, s0
pow_loop_43:
    SUB r1, r1, #1
    CMP r1, #0
    BEQ pow_end_43
    VMUL.F64 d2, d2, d0
    B pow_loop_43
pow_end_43:
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VMUL.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_7
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_7
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_33
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_44
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_44:
    MOV r6, r10
    MOV r5, #0
mod_dec_45:
    CMP r6, #10
    BLT mod_dec_end_45
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_45
mod_dec_end_45:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_46:
    CMP r6, #10
    BLT div_end_46
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_46
div_end_46:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_47:
    CMP r6, #10
    BLT div_end_47
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_47
div_end_47:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_48:
    CMP r6, #10
    BLT div_end_48
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_48
div_end_48:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_49
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_49:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_7
.ltorg
ltorg_skip_7:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_34
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_35
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    LDR r0, =const_num_36
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_37
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VSUB.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VMUL.F64 d2, d0, d1
    VPUSH {d2}
    LDR r0, =const_num_38
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_39
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VDIV.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_8
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_8
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_40
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_50
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_50:
    MOV r6, r10
    MOV r5, #0
mod_dec_51:
    CMP r6, #10
    BLT mod_dec_end_51
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_51
mod_dec_end_51:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_52:
    CMP r6, #10
    BLT div_end_52
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_52
div_end_52:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_53:
    CMP r6, #10
    BLT div_end_53
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_53
div_end_53:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_54:
    CMP r6, #10
    BLT div_end_54
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_54
div_end_54:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_55
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_55:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_8
.ltorg
ltorg_skip_8:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_41
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =res_7
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_42
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_43
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VCVT.S32.F64 s0, d0
    VCVT.S32.F64 s2, d1
    VCVT.F64.S32 d0, s0
    VCVT.F64.S32 d1, s2
    VDIV.F64 d3, d0, d1
    VCVT.S32.F64 s4, d3
    VCVT.F64.S32 d3, s4
    VMUL.F64 d3, d3, d1
    VSUB.F64 d2, d0, d3
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VSUB.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_9
    VSTR.F64 d0, [r0]
    VCVT.S32.F64 s0, d0
    VMOV r1, s0
    CMP r1, #0
    RSBLT r1, r1, #0
    LDR r2, =0xFF200000
    STR r1, [r2]
    VCVT.S32.F64 s0, d0
    VMOV r11, s0
    LDR r0, =res_9
    VLDR.F64 d0, [r0]
    LDR r0, =const_num_44
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_56
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_56:
    MOV r6, r10
    MOV r5, #0
mod_dec_57:
    CMP r6, #10
    BLT mod_dec_end_57
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_57
mod_dec_end_57:
    MOV r9, r6
    LDR r7, =tabela_7seg
    MOV r12, #0
    MOV r14, #0
    LDRB r8, [r7, r9]
    ORR r12, r12, r8
    MOV r8, #0x08
    LSL r8, r8, #8
    ORR r12, r12, r8
    MOV r5, #0
    MOV r6, r11
div_loop_58:
    CMP r6, #10
    BLT div_end_58
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_58
div_end_58:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_59:
    CMP r6, #10
    BLT div_end_59
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_59
div_end_59:
    LDRB r8, [r7, r6]
    LSL r8, r8, #24
    ORR r12, r12, r8
    MOV r11, r5
    MOV r5, #0
    MOV r6, r11
div_loop_60:
    CMP r6, #10
    BLT div_end_60
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_60
div_end_60:
    LDRB r8, [r7, r6]
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_61
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_61:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_9
.ltorg
ltorg_skip_9:

.ltorg
fim:
    B fim

.data
const_num_0: .double 4.0
const_num_1: .double 2.0
const_num_2: .double 3
const_num_3: .double 1
const_num_4: .double 10.0
const_num_5: .double 10
const_num_6: .double 4
const_num_7: .double 2.0
const_num_8: .double 1.0
const_num_9: .double 10.0
const_num_10: .double 8
const_num_11: .double 3
const_num_12: .double 2
const_num_13: .double 1
const_num_14: .double 10.0
const_num_15: .double 5
const_num_16: .double 2
const_num_17: .double 1.5
const_num_18: .double 3.0
const_num_19: .double 10.0
const_num_20: .double 3.0
const_num_21: .double 4
const_num_22: .double 5.0
const_num_23: .double 2.0
const_num_24: .double 10.0
const_num_25: .double 2
const_num_26: .double 10.0
const_num_27: .double 3.0
const_num_28: .double 2.0
const_num_29: .double 10.0
const_num_30: .double 1
const_num_31: .double 4
const_num_32: .double 2
const_num_33: .double 10.0
const_num_34: .double 3.0
const_num_35: .double 2.0
const_num_36: .double 4
const_num_37: .double 1
const_num_38: .double 2
const_num_39: .double 1
const_num_40: .double 10.0
const_num_41: .double 2
const_num_42: .double 5
const_num_43: .double 3
const_num_44: .double 10.0
tabela_7seg:
    .byte 0x3F
    .byte 0x06
    .byte 0x5B
    .byte 0x4F
    .byte 0x66
    .byte 0x6D
    .byte 0x7D
    .byte 0x07
    .byte 0x7F
    .byte 0x6F

.bss
var_CALC: .space 8
res_9: .space 8
res_4: .space 8
res_2: .space 8
res_6: .space 8
res_1: .space 8
res_0: .space 8
res_3: .space 8
res_7: .space 8
res_5: .space 8
res_8: .space 8