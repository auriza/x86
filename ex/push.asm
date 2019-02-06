global main
extern printf

section .data                           ; 0x5655_7008
    a       dd  30
    fmt     db  "eax = %d", 10, 0

section .text                           ;                       ESP:
    main:                               ;                       0xffff_d66c
            mov  eax, 10
            push eax                    ;                       0xffff_d668
            push 20                     ;                       0xffff_d664
            push dword [a]              ;                       0xffff_d660
            push a                      ;                       0xffff_d65c

            pop esi                     ; esi = 0x5655_7008     0xffff_d660
            pop eax                     ; eax = 30              0xffff_d664
            pop edx                     ; edx = 20              0xffff_d668
            pop dword [a]               ; [a] = 10              0xffff_d66c

    ; printf(fmt, eax)
            push eax                    ;                       0xffff_d668
            push fmt                    ;                       0xffff_d664
            call printf
            add esp, 8                  ;                       0xffff_d66c

    ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80
