global main

section .data                           ; 0x5655_7008
    a       dd  30

section .text                           ;                   esp =
    main:                               ;                       0xffff_dffc
            mov  eax, 10
            push eax                    ;                       0xffff_dff8
            push 20                     ;                       0xffff_dff4
            push dword [a]              ;                       0xffff_dff0
            push a                      ;                       0xffff_dfec

            pop esi                     ; esi = 0x5655_7008     0xffff_dff0
            pop eax                     ; eax = 30              0xffff_dff4
            pop edx                     ; edx = 20              0xffff_dff8
            pop dword [a]               ; [a] = 10              0xffff_dffc

            ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80
