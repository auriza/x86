global main

section .data
    filename    db      "test.txt", 0
    hello       db      "Hello, world!", 10, 0

section .bss
    fd          dd      1

section .text
    main:
                ; fd = creat(path, mode)        --> create new file
                mov     eax, 8
                mov     ebx, filename
                mov     ecx, 644o               ; rw-r--r--
                int     0x80
                mov     [fd], eax

                ; write(fd, buffer, count)
                mov     eax, 4
                mov     ebx, [fd]
                mov     ecx, hello
                mov     edx, 14
                int     0x80

                ; close(fd)
                mov     eax, 6
                mov     ebx, [fd]
                int     0x80

                ; return 0
                mov     eax, 0
                ret
