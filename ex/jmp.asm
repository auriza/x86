global main
extern printf, scanf

section .data
    fmt_in      db  "%d %d", 0
    fmt_out     db  "%u %c %u", 10, 0

section .bss
    a           resd 1
    b           resd 1

section .text
    main:
                ; scanf(fmt_in, a, b)
                push b
                push a
                push fmt_in
                call scanf
                add esp, 12

                ; compare [a] and [b]
                mov eax, [a]
                cmp eax, [b]
                jb  below
                ja  above
                mov ebx, "="
                jmp print
    below:      mov ebx, "<"
                jmp print
    above:      mov ebx, ">"

    print:      ; printf(fmt_out, [a], ebx, [b])
                push dword [b]
                push ebx
                push dword [a]
                push fmt_out
                call printf
                add esp, 16

                ; return 0
                mov eax, 0
                ret
