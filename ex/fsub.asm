; Floating-Point Subtraction
; ==========================

global main
extern scanf, printf

section .data
    fmt_out     db      "%f", 10, 0
    a           dd      2.25
    b           dd      1.12

section .bss
    c           resq    1

section .text
    print_out:
                ; printf("%f\n", c)
                push    dword [c+4]
                push    dword [c]
                push    fmt_out
                call    printf                  ; %f --> double
                add     esp, 12
                ret

    main:
                ; c = a - b
                finit                           ; ST0       ST1
                fld     dword [a]               ; a
                fsub    dword [b]               ; a-b
                fstp    qword [c]               ;
                call    print_out

                ; c = a - b
                finit                           ; ST0       ST1
                fld     dword [a]               ; a
                fld     dword [b]               ; b         a
                fsubp                           ; a-b
                fstp    qword [c]               ;
                call    print_out

                ; return 0
                mov     eax, 0
                ret
