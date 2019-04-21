; Degree to Radian
; ================

global main
extern scanf, printf

section .data
    fmt_out     db      "%.5f", 10, 0
    deg         dd      45.0
    pi_rad      dd      180.0

section .bss
    rad         resq    1

section .text
    main:
                ; rad = deg * π / 180
                finit
                fldpi                           ; π
                fmul    dword [deg]             ; deg * π
                fdiv    dword 180.0          ; deg * π / 180
                fstp    qword [rad]

                ; printf("%.5f\n", rad)
                push    dword [rad+4]
                push    dword [rad]
                push    fmt_out
                call    printf                  ; %f --> double
                add     esp, 12

                ; return 0
                mov     eax, 0
                ret
