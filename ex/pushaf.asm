global main

section .text
    main:
            mov eax, 100
            mov ecx, 200

            ; save context
            pusha                       ; eax = 100, ecx = 200, ...
            pushf                       ; eflags = 0x246

            mov eax, 500
            mov ecx, 600
            sub eax, ecx                ; eflags = 0x297
                                        ; eax = -100, ecx = 600

            ; restore context
            popf                        ; eflags = 0x246
            popa                        ; eax = 100, ecx = 200, ...

            ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80


