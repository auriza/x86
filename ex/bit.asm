global main

section .data
    a       dd  0x1111

section .text
    main:
            mov eax, 0                  ; eax           = 0
            or  eax, 1010b              ; eax =   1010b = 10
            and eax, 1000b              ; eax =   1000b = 8
            shl eax, 2                  ; eax = 100000b = 32
            shr eax, 1                  ; eax = 010000b = 16
            not eax                     ; eax = 0xffff_ffef = -17

            mov eax, 0x5555             ; eax =     0x_5555
            xor eax, [a]                ; eax =     0x_4444
            ror eax, 8                  ; eax = 0x4400_0044
            rol eax, 8                  ; eax =     0x_4444
            xor eax, [a]                ; eax =     0x_5555

            mov eax, 0xefbe_adde
            bswap eax                   ; eax = 0xdead_beef

            pushf
            bt dword [esp], 8           ; check debug flag --> CF = TF
            popf

            ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80
