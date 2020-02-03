global main

section .data                           ; 0x5655_7008
    a       dd  100
    b       dd  200

section .text
    main:   ; immediate addressing
            mov eax, 7                  ; eax = 7
            mov ecx, 5                  ; ecx = 5
            mov edi, a                  ; edi = 0x5655_7008

            ; register addressing
            mov edx, eax                ; edx = 7
            mov ebx, ecx                ; ebx = 5

            ; direct memory addressing
            mov [a], eax                ; [a] = 7
            mov edx, [b]                ; edx = 200

            ; indirect memory addressing
            mov [edi], dword 32         ; [a] = 32
            mov ecx, [edi+4]            ; ecx = 200
            shl ecx, 1

            ; return 0
            mov eax, 0
            ret
