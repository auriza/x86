global main

section .text
    main:
            mov eax, 100
            mov ecx, 200
            mov edx, 300
            mov ebx, 400

            pusha
            pushf                       ; 0x246 [.I.Z..P.]

            mov eax, 500
            mov ecx, 600
            sub edx, ecx                ; 0x283 [.IS....C]

            popf                        ; 0x246 [.I.Z..P.]
            popa

            ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80


