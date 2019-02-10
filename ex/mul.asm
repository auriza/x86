global main

section .data
    a       dd  5
    b       dd  3

section .text
    main:
            ; edx:eax = [a] * [b]
            mov eax, [a]                    ;       eax = 5
            mul dword [b]                   ; eax * [b] = 15

            ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80
