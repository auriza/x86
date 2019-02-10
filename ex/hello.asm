global main

segment .data
    hello   db  'Hello world!', 10, 0

segment .text
    main:
            ; write(fd, buf, count)
            mov eax, 4          ; write
            mov ebx, 1          ; fd (stdout = 1)
            mov ecx, hello      ; buf
            mov edx, 14         ; count
            int 0x80

            ; exit(status)
            mov eax, 1          ; exit
            mov ebx, 0          ; status
            int 0x80
