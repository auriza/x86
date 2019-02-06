global main
extern printf, scanf

section .data
    input   db  "%d %d", 0
    equal   db  "%u is equal %u", 10, 0
    below   db  "%u is below %u", 10, 0
    above   db  "%u is above %u", 10, 0

section .bss
    a       resd 1
    b       resd 1

section .text
    main:
            ; scanf(input, a, b)
            push b
            push a
            push input
            call scanf
            add esp, 12

            ; printf(equal/below/above, [a], [b])
            push dword [b]
            push dword [a]

            mov eax, [a]
            cmp eax, [b]
            je .equal
            jb .below
            ja .above

    .equal  push equal
            jmp .print
    .below  push below
            jmp .print
    .above  push above

    .print  call printf
            add esp, 12

    .exit:  ; exit(0)
            mov eax, 1
            mov ebx, 0
            int 0x80



