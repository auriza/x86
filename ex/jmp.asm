global main

section .data
    a           dd      5
    str_pos     db      "positive", 10, 0
    str_neg     db      "negative", 10, 0

section .text
    main:
                ; if (a >= 0)
                ;     ecx = str_pos
                ; else
                ;     ecx = str_neg
                cmp     dword [a], 0
                jge     positive
                jl      negative
    positive:   mov     ecx, str_pos
                jmp     endif
    negative:   mov     ecx, str_neg
                jmp     endif
    endif:
                ; write(stdout, str, len)
                mov     eax, 4
                mov     ebx, 1
                mov     edx, 9
                int     0x80

                ; exit(0)
                mov     eax, 1
                mov     ebx, 0
                int     0x80
