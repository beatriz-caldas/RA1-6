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
    LDR r0, =const_num_2
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
    LDR r0, =const_num_3
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d0}
    LDR r0, =var_MEM
    VSTR.F64 d0, [r0]
    VPUSH {d0}
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
    LDR r0, =const_num_4
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
    LDR r0, =const_num_5
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_6
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VMUL.F64 d2, d0, d1
    VPUSH {d2}
    LDR r0, =const_num_7
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_8
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VMUL.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VDIV.F64 d2, d0, d1
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
    LDR r0, =const_num_9
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
    LDR r0, =var_MEM
    VLDR.F64 d0, [r0]
    VPUSH {d0}
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
    LDR r0, =const_num_10
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
    LDR r0, =const_num_11
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =res_2
    VLDR.F64 d0, [r0]
    VPUSH {d0}
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
    LDR r0, =const_num_12
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_24
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_24:
    MOV r6, r10
    MOV r5, #0
mod_dec_25:
    CMP r6, #10
    BLT mod_dec_end_25
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_25
mod_dec_end_25:
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
div_loop_26:
    CMP r6, #10
    BLT div_end_26
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_26
div_end_26:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
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
    LSL r8, r8, #24
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
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_29
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_29:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_4
.ltorg
ltorg_skip_4:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_13
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_14
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VDIV.F64 d2, d0, d1
    VCVT.S32.F64 s0, d2
    VCVT.F64.S32 d2, s0
    VPUSH {d2}
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
    LDR r0, =const_num_15
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_30
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_30:
    MOV r6, r10
    MOV r5, #0
mod_dec_31:
    CMP r6, #10
    BLT mod_dec_end_31
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_31
mod_dec_end_31:
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
div_loop_32:
    CMP r6, #10
    BLT div_end_32
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_32
div_end_32:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
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
    LSL r8, r8, #24
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
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_35
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_35:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_5
.ltorg
ltorg_skip_5:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_16
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_17
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
    LDR r0, =const_num_18
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_36
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_36:
    MOV r6, r10
    MOV r5, #0
mod_dec_37:
    CMP r6, #10
    BLT mod_dec_end_37
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_37
mod_dec_end_37:
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
div_loop_38:
    CMP r6, #10
    BLT div_end_38
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_38
div_end_38:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
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
    LSL r8, r8, #24
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
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_41
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_41:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_6
.ltorg
ltorg_skip_6:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_19
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_20
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VMOV.F64 d2, d0
    VCVT.S32.F64 s0, d1
    VMOV r1, s0
pow_loop_42:
    SUB r1, r1, #1
    CMP r1, #0
    BEQ pow_end_42
    VMUL.F64 d2, d2, d0
    B pow_loop_42
pow_end_42:
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
    LDR r0, =const_num_21
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_43
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_43:
    MOV r6, r10
    MOV r5, #0
mod_dec_44:
    CMP r6, #10
    BLT mod_dec_end_44
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_44
mod_dec_end_44:
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
div_loop_45:
    CMP r6, #10
    BLT div_end_45
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_45
div_end_45:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
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
    LSL r8, r8, #24
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
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_48
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_48:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_7
.ltorg
ltorg_skip_7:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_22
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_23
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VSUB.F64 d2, d0, d1
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
    LDR r0, =const_num_24
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_49
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_49:
    MOV r6, r10
    MOV r5, #0
mod_dec_50:
    CMP r6, #10
    BLT mod_dec_end_50
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_50
mod_dec_end_50:
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
div_loop_51:
    CMP r6, #10
    BLT div_end_51
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_51
div_end_51:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
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
    LSL r8, r8, #24
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
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_54
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_54:
    LDR r3, =0xFF200020
    STR r12, [r3]
    LDR r3, =0xFF200030
    STR r14, [r3]
    B ltorg_skip_8
.ltorg
ltorg_skip_8:

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_25
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =res_8
    VLDR.F64 d0, [r0]
    VPUSH {d0}
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
    LDR r0, =const_num_26
    VLDR.F64 d5, [r0]
    VMUL.F64 d5, d0, d5
    VCVT.S32.F64 s10, d5
    VMOV r10, s10
    MOV r4, #0
    CMP r11, #0
    BGE pos_55
    RSB r11, r11, #0
    RSB r10, r10, #0
    MOV r4, #1
pos_55:
    MOV r6, r10
    MOV r5, #0
mod_dec_56:
    CMP r6, #10
    BLT mod_dec_end_56
    SUB r6, r6, #10
    ADD r5, r5, #1
    B mod_dec_56
mod_dec_end_56:
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
div_loop_57:
    CMP r6, #10
    BLT div_end_57
    SUB r6, r6, #10
    ADD r5, r5, #1
    B div_loop_57
div_end_57:
    LDRB r8, [r7, r6]
    LSL r8, r8, #16
    ORR r12, r12, r8
    MOV r11, r5
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
    LSL r8, r8, #24
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
    ORR r14, r14, r8
    MOV r11, r5
    CMP r4, #1
    BNE end_sign_60
    MOV r8, #0x40
    LSL r8, r8, #8
    ORR r14, r14, r8
end_sign_60:
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
const_num_0: .double 3.14
const_num_1: .double 2.0
const_num_2: .double 10.0
const_num_3: .double 5.0
const_num_4: .double 10.0
const_num_5: .double 2
const_num_6: .double 3
const_num_7: .double 4
const_num_8: .double 5
const_num_9: .double 10.0
const_num_10: .double 10.0
const_num_11: .double 2
const_num_12: .double 10.0
const_num_13: .double 10
const_num_14: .double 2
const_num_15: .double 10.0
const_num_16: .double 10
const_num_17: .double 3
const_num_18: .double 10.0
const_num_19: .double 2
const_num_20: .double 4
const_num_21: .double 10.0
const_num_22: .double 10.5
const_num_23: .double 2.5
const_num_24: .double 10.0
const_num_25: .double 1
const_num_26: .double 10.0
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
res_7: .space 8
res_5: .space 8
res_2: .space 8
res_6: .space 8
res_4: .space 8
var_MEM: .space 8
res_0: .space 8
res_3: .space 8
res_9: .space 8
res_1: .space 8
res_8: .space 8