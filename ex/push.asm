global main
extern printf

section .data                           ; 0x5655_7008
    a       dd  0xdead_beef
    fmt     db  "eax = %x", 10, 0

section .text                           ; 0x5655_5510        ; esp = 0xffff_d62c
    main:
            mov  eax, 0x_cab_ba9e
            push eax                                         ; esp = 0xffff_d628
            push 0x_1234                                     ; esp = 0xffff_d624
            push dword [a]                                   ; esp = 0xffff_d620
            push a                                           ; esp = 0xffff_d61c

            pop  esi                    ; esi = 0x5655_7008  ; esp = 0xffff_d620
            pop  eax                    ; eax = 0xdead_beef  ; esp = 0xffff_d624
            pop  edx                    ; edx = 0x0000_1234  ; esp = 0xffff_d628
            pop  dword [a]              ; [a] = 0x0cab_ba9e  ; esp = 0xffff_d62c

    ; printf(fmt, eax)
            push eax                                         ; esp = 0xffff_d628
            push fmt                                         ; esp = 0xffff_d624
            call printf
            add  esp, 8                                      ; esp = 0xffff_d62c

    ; exit(0)
            mov  eax, 1
            mov  ebx, 0
            int  0x80
