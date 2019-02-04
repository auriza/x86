global main
extern printf

section .data
    a       dd  356
    b       dd  7
    fmt     db  "%u / %u = %u sisa %u", 10, 0

section .text
    main:
            ; eax = a / b
            mov eax, [a]                    ;     eax = 356
            cdq                             ; edx:eax = 356
            div dword [b]                   ;     eax = a / b = 50
                                            ;     edx = a % b = 6

            ; printf(fmt, [a], [b], eax, edx)
            push edx
            push eax
            push dword [b]
            push dword [a]
            push fmt
            call printf
            add  esp, 20

            ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80
