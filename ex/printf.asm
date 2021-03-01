global main
extern printf

section .data
    fmt     db  "%d", 10, 0
    x       dd  5000

section .text
    main:
            ; printf(fmt, x);
            push dword [x]
            push fmt
            call printf
            add esp, 8          ; pop, pop

            ; return 0
            mov eax, 0
            ret
