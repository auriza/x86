global main
extern printf

section .data
    a       dd  5
    b       dd  3
    fmt     db  "%u", 10, 0

section .text
    main:
            ; edx:eax = a*a*b
            mov eax, [a]                    ;       eax = 5
            mul eax                         ; eax * eax = 25
            mul dword [b]                   ; eax * [b] = 75

            ; printf(fmt, eax)
            push eax
            push fmt
            call printf
            add esp, 8

            ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80
