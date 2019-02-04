global main
extern printf

section .data
    a       dd  5000
    b       dd  4000
    fmt     db  "%llu", 10, 0

section .text
    main:
            ; edx:eax = a*a*b
            mov eax, [a]                    ; eax = 5k
            mul eax                         ; eax * eax = 25M
            mul dword [b]                   ; eax * [b] = 100G

            ; printf(fmt, edx:eax)
            push edx
            push eax
            push fmt
            call printf
            add  esp, 12

            ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80
