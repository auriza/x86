; Cylinder Surface Area
; =====================

global main
extern scanf, printf

section .data
    fmt_in      db      "%f %f", 0
    fmt_out     db      "%f", 10, 0

section .bss
    radius      resd    1
    height      resd    1
    area        resq    1

section .text
    main:
                ; scanf("%f %f", &radius, &height)
                push    height
                push    radius
                push    fmt_in
                call    scanf                   ; %f --> float
                add     esp, 12

                ; A = 2πr(h + r)
                finit                           ; ST0           ST1
                fldpi                           ; π
                fadd    st0                     ; 2π
                fmul    dword [radius]          ; 2πr
                fld     dword [height]          ; h             2πr
                fadd    dword [radius]          ; h+r           2πr
                fmulp                           ; 2πr(h+r)
                fstp    qword [area]            ;

                ; printf("%f\n", area)
                push    dword [area+4]
                push    dword [area]
                push    fmt_out
                call    printf                  ; %f --> double
                add     esp, 12

                ; return 0
                mov     eax, 0
                ret
