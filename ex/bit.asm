global main
extern printf

section .data
    a       dd  0x1111
    debug   db  "debug mode", 10, 0

section .text
    main:
            xor eax, eax                ; eax           = 0
            or  eax, 1010b              ; eax =   1010b = 10
            and eax, 1000b              ; eax =   1000b = 8
            shl eax, 2                  ; eax = 100000b = 32
            shr eax, 1                  ; eax = 010000b = 16
            not eax                     ; eax = 0xffff_ffef

            mov eax, 0x5555             ; eax =     0x_5555
            xor eax, [a]                ; eax =     0x_4444
            ror eax, 8                  ; eax = 0x4400_0044
            rol eax, 8                  ; eax =     0x_4444
            xor eax, [a]                ; eax =     0x_5555

            mov eax, 0xefbe_adde
            bswap eax                   ; eax = 0xdead_beef

            pushf
            bt  dword [esp], 8          ; check TF (trap/debug flag)
            jnc .exit

            push debug
            call printf
            add esp, 4

    .exit:  ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80



