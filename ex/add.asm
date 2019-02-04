global main

section .data
    a       dd  25
    b       dd  20

section .text
    main:
            mov eax, 12
            mov ecx, 13

            add eax, ecx                ; eax = 25
            add [a], eax                ; [a] = 50
            add ecx, [b]                ; ecx = 33
            add eax, 300                ; eax = 325
            add ecx, 200                ; ecx = 233
            add dword [b], 500          ; [b] = 520

            ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80
