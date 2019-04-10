global main

section .data
    filename    db      "/etc/os-release", 0

section .bss
    fd          dd      1
    buffer      db      52

section .text
    main:
                ; fd = open(path, flags)
                mov     eax, 5
                mov     ebx, filename
                mov     ecx, 0
                int     0x80
                mov     [fd], eax

                ; read(fd, buffer, count)
                mov     eax, 3
                mov     ebx, [fd]
                mov     ecx, buffer
                mov     edx, 52
                int     0x80

                ; close(fd)
                mov     eax, 6
                mov     ebx, [fd]
                int     0x80

                ; write(fd, buffer, count)
                mov     eax, 4
                mov     ebx, 1                      ; 1 = stdout
                mov     ecx, buffer
                mov     edx, 52
                int     0x80

                ; exit(0)
                mov     eax, 1
                mov     ebx, 0
                int     0x80
