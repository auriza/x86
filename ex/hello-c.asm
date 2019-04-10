; build: yasm %f -f elf32 && gcc -o %e -m32 %e.o

global main
extern printf

segment .data
    hello       db      'Hello world!', 10, 0

segment .text
    main:
                ; printf(hello)
                push    hello
                call    printf
                add     esp, 4

                ; return 0
                mov     eax, 0
                ret
