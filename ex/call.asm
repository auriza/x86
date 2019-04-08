global main
extern printf

section .data
    fmt_out     db      '%d', 10, 0


section .text

    sum:
                push    ebp                     ; save old ebp
                mov     ebp, esp                ; this new ebp (as reference to parameter and local variable)
                sub     esp, 8                  ; allocate 2 local variables

                mov     dword [ebp-4], 15       ; d = 15
                mov     dword [ebp-8], 20       ; e = 20

                mov     eax, 0                  ; eax  = 0
                add     eax, dword [ebp+8]      ; eax += a
                add     eax, dword [ebp+12]     ; eax += b
                add     eax, dword [ebp+16]     ; eax += c
                add     eax, dword [ebp-4]      ; eax += d
                add     eax, dword [ebp-8]      ; eax += e

                mov     esp, ebp                ; deallocate local variables
                pop     ebp                     ; restore old ebp
                ret

    main:
                push    dword 5                 ; sum(25, 10, 5)
                push    dword 10
                push    dword 25
                call    sum                     ; eax = 75
                add     esp, 12

                push    eax                     ; printf("%d\n", eax)
                push    fmt_out
                call    printf
                add     esp, 8

                mov     eax, 0                  ; return 0
                ret
