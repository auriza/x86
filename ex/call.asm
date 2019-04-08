global main
extern printf

section .data
    fmt_out     db      "%d", 10, 0


section .text

                ; int sum(int a, int b, int c) {
                ;     int d = 15, e = 20;
                ;     return a + b + c + d + e;
                ; }
    sum:
                push    ebp                     ; save old ebp
                mov     ebp, esp                ; this new ebp
                sub     esp, 8                  ; allocate 2 local vars

                mov     dword [ebp-4], 15       ; d = 15
                mov     dword [ebp-8], 20       ; e = 20

                mov     eax, 0                  ; eax  = 0
                add     eax, [ebp+8]            ; eax += a
                add     eax, [ebp+12]           ; eax += b
                add     eax, [ebp+16]           ; eax += c
                add     eax, [ebp-4]            ; eax += d
                add     eax, [ebp-8]            ; eax += e

                mov     esp, ebp                ; deallocate local vars
                pop     ebp                     ; restore old ebp
                ret

    main:
                push    dword 5
                push    dword 10
                push    dword 25
                call    sum                     ; sum(25, 10, 5) --> eax = 75
                add     esp, 12

                push    eax
                push    fmt_out
                call    printf                  ; printf("%d\n", eax)
                add     esp, 8

                mov     eax, 0                  ; return 0
                ret
