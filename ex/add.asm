global main

section .data
    a       dd  25
    b       dd  20

section .text
    main:
            xor eax, eax                ; eax = 0
            inc eax                     ; eax = 1
            dec eax                     ; eax = 0       --> ZF=1
            add eax, [b]                ; eax = 20
            sub eax, [a]                ; eax = -5      --> SF=1

            mov eax, 0x_8000_0000
            add eax, 0x_8000_0000       ; eax = 0x_1_0000_0000
                                        ;     = 0       --> ZF=1 CF=1 OF=1

            ; return 0
            mov eax, 0
            ret
