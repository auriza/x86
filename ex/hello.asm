; build: yasm %f -f elf32 && ld -o %e -e main -m elf_i386 %e.o

global main

segment .data
    hello       db      'Hello world!', 10, 0

segment .text
    main:
                ; write(fd, buf, count)
                mov     eax, 4
                mov     ebx, 1
                mov     ecx, hello
                mov     edx, 14
                int     0x80

                ; exit(status)
                mov     eax, 1
                mov     ebx, 0
                int     0x80
