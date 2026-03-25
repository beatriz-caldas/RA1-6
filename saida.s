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

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_2
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_3
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VDIV.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_1
    VSTR.F64 d0, [r0]

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_4
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_5
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VDIV.F64 d2, d0, d1
    VCVT.S32.F64 s0, d2
    VCVT.F64.S32 d2, s0
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_2
    VSTR.F64 d0, [r0]

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_6
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_7
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
    LDR r0, =res_3
    VSTR.F64 d0, [r0]

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_8
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_9
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VMOV.F64 d2, d0
    VCVT.S32.F64 s0, d1
    VMOV r1, s0

pow_loop_0:
    SUB r1, r1, #1
    CMP r1, #0
    BEQ pow_end_0
    VMUL.F64 d2, d2, d0
    B pow_loop_0
pow_end_0:
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_4
    VSTR.F64 d0, [r0]

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_10
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d0}
    LDR r0, =var_MEM
    VSTR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d0}
    LDR r0, =res_5
    VSTR.F64 d0, [r0]

    @ NOVA EXPRESSAO RPN
    LDR r0, =var_MEM
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d0}
    LDR r0, =res_6
    VSTR.F64 d0, [r0]

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_11
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =res_5
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d0}
    LDR r0, =res_7
    VSTR.F64 d0, [r0]

    @ NOVA EXPRESSAO RPN
    LDR r0, =var_MEM
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_12
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VSUB.F64 d2, d0, d1
    VPUSH {d2}
    LDR r0, =const_num_13
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VMUL.F64 d2, d0, d1
    VPUSH {d2}
    LDR r0, =const_num_14
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VSUB.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_8
    VSTR.F64 d0, [r0]

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_15
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_16
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VDIV.F64 d2, d0, d1
    VPUSH {d2}
    LDR r0, =const_num_17
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_18
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d1}
    VPOP {d0}
    VMUL.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_9
    VSTR.F64 d0, [r0]

    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_19
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    LDR r0, =const_num_20
    VLDR.F64 d0, [r0]
    VPUSH {d0}
    VPOP {d1}
    VPOP {d0}
    VADD.F64 d2, d0, d1
    VPUSH {d2}
    VPOP {d0}
    LDR r0, =res_10
    VSTR.F64 d0, [r0]

fim:
    B fim

.data
const_num_0: .double 2.5
const_num_1: .double 2.5
const_num_2: .double 100
const_num_3: .double 10
const_num_4: .double 7
const_num_5: .double 2
const_num_6: .double 7
const_num_7: .double 2
const_num_8: .double 3
const_num_9: .double 3
const_num_10: .double 55.5
const_num_11: .double 2
const_num_12: .double 0.5
const_num_13: .double 2
const_num_14: .double 10
const_num_15: .double 10
const_num_16: .double 2
const_num_17: .double 3
const_num_18: .double 1
const_num_19: .double 10
const_num_20: .double 10

.bss
res_0: .space 8
res_5: .space 8
res_2: .space 8
res_4: .space 8
var_MEM: .space 8
res_10: .space 8
res_3: .space 8
res_6: .space 8
res_9: .space 8
res_1: .space 8
res_7: .space 8
res_8: .space 8