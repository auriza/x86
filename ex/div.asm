global main

section .data
    a       dd  356
    b       dd  7

section .text
    main:
            ; eax = [a] / [b]
            mov eax, [a]                    ;     eax = 356
            cdq                             ; edx:eax = 356
            div dword [b]                   ;     eax = eax / [b] = 50
                                            ;     edx = eax % [b] = 6

            ; return 0
            mov eax, 0
            ret
