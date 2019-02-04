global main

section .data
    pass        db  'B060R.', 0
    askpass     db  'Enter password: ', 0
    correct     db  'Good day, mate!', 10, 0
    wrong       db  'Wrong password!', 10, 0

section .bss
    input       resb 80

section .text
    main:       ; write(stdout, askpass, len)
                mov eax, 4
                mov ebx, 1
                mov ecx, askpass
                mov edx, 16
                int 0x80

                ; read(stdin, input, len)
                mov eax, 3
                mov ebx, 0
                mov ecx, input
                mov edx, 80
                int 0x80

                ; compare
                mov esi, pass
                mov edi, input
                mov ecx, 6
                repe cmpsb
                jecxz .correct

                ; write(stdout, resp, len)
                ; exit(status)

    .wrong:     mov eax, 4
                mov ebx, 1
                mov ecx, wrong
                mov edx, 16
                int 0x80
                mov eax, 1
                mov ebx, 1
                int 0x80

    .correct:   mov eax, 4
                mov ebx, 1
                mov ecx, correct
                mov edx, 16
                int 0x80
                mov eax, 1
                mov ebx, 0
                int 0x80
