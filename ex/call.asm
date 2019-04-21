global main
extern printf

section .data
    fmt_out     db      "%d", 10, 0

section .text
                ; int sum_double(int a, int b) {
                ;     int c = 2;
                ;     return (a + b) * c;
                ; }
    sum_double:
                push    ebp                     ; save old ebp
                mov     ebp, esp                ; set new ebp

                sub     esp, 4                  ; allocate 1 local vars
                mov     dword [ebp-4], 2        ; c = 2

                mov     eax, [ebp+8]            ; eax = a   --> a
                add     eax, [ebp+12]           ; eax += b  --> a + b
                mul     dword [ebp-4]           ; eax *= c  --> (a + b) * c

                mov     esp, ebp                ; deallocate local vars
                pop     ebp                     ; restore old ebp
                ret
    main:
                ; sum_double(10, 5) --> eax = 30
                push    dword 5
                push    dword 10
                call    sum_double
                add     esp, 8

                ; printf("%d\n", eax)
                push    eax
                push    fmt_out
                call    printf
                add     esp, 8

                ; return 0
                mov     eax, 0
                ret
