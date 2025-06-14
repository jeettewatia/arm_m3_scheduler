// systick_handler registers
.equ systick_csr, 0xe000e010    //control and status register ... need to program 7
.equ systick_rvr, 0xe000e014    // reload value register
.equ systick_cvr, 0xe000e018      // current value register
.equ systick_calib, 0xe000e01c
.equ timeout, 0x00ffffff // 24 bits are set

.section .vectors
vector_table:
    .word 0x20001000
    .word reset_handler
.org 0x3c
    .word systick_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    mov r5, #0

    ldr r0, =systick_csr
    ldr r1, =systick_rvr
    ldr r2, =systick_cvr
    ldr r3, =timeout

    str r3, [r1] // store r3 value at memory address [r1]
    mov r3, #0
    str r3, [r2]
    mov r3, #7
    str r3, [r0] // jb timer 0 hoga, tb ISR krne jaaega (systick)

    b .

    .section .text
    .align 1
    .type systick_handler, %function
systick_handler:
    add r5, r5, #1
rukk_jao_yaha:
    bx lr // link register


//Users/piyush/Movies/obs/ARM-M - Baremetal Assembly/3. Assembly Programs/3.1 Booting the Processor and First Assembly Program/map.ld