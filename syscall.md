# System Call


Operasi yang berhubungan langsung dengan *hardware* memerlukan bantuan sistem
operasi (SO). Misalnya: menulis ke *file*, menghapus *file*, membuat direktori,
dan sebagainya. *System call* digunakan untuk memanggil layanan SO secara langsung,
tanpa bantuan dari pustaka C `libc`. Hal ini berguna jika kita ingin menghasilkan
program yang kecil dan cepat tanpa tergantung pustaka C.


## Cara Pemanggilan *System Call*

| Arsitektur    | x86        | x86-64    | arm/EABI  | arm64    |
| :------------ | :--------- | :-------- | :-------- | :------- |
| Instruksi     | `INT 0x80` | `SYSCALL` | `SWI 0x0` | `SVC #0` |
| Nomor syscall | `EAX`      | `RAX`     | `R7`      | `X8`     |
| Return value  | `EAX`      | `RAX`     | `R0`      | `X0`     |
| Parameter 1   | `EBX`      | `RDI`     | `R0`      | `X0`     |
| Parameter 2   | `ECX`      | `RSI`     | `R1`      | `X1`     |
| Parameter 3   | `EDX`      | `RDX`     | `R2`      | `X2`     |
| Parameter 4   | `ESI`      | `R10`     | `R3`      | `X3`     |
| Parameter 5   | `EDI`      | `R8`      | `R4`      | `X4`     |
| Parameter 6   | `EBP`      | `R9`      | `R5`      | `X5`     |
| Parameter 7   | `-`        | `-`       | `R6`      | `-`      |


## Nomor *System Call* pada Linux x86

Nomor *syscall* lengkap dapat dilihat pada *file* `/usr/include/asm/unistd_32.h`.
Info lengkap tiap *syscall* dapat dilihat pada manual bagian 2, misalnya jika
ingin melihat definisi *syscall* `read`, maka ketikkan perintah `man 2 read`.

| No  | Nama     | Pemakaian                          | Deskripsi                       |
| --- | :------- | :--------------------------------- | :------------------------------ |
| 1   | `exit`   | `exit(status)`                     | Mengakhiri proses               |
| 2   | `fork`   | `pid  = fork()`                    | Menduplikasi proses             |
| 3   | `read`   | `size = read(fd, buffer, count)`   | Membaca dari *file descriptor*  |
| 4   | `write`  | `size = write(fd, buffer, count)`  | Menulis ke *file descriptor*    |
| 5   | `open`   | `fd   = open(path, flags)`         | Membuka *file*                  |
| 6   | `close`  | `err  = close(fd)`                 | Menutup *file descriptor*       |
| 8   | `creat`  | `fd   = creat(path, mode)`         | Membuat *file* baru             |
| 10  | `unlink` | `err  = unlink(path)`              | Menghapus *file*                |
| 19  | `lseek`  | `offs = lseek(fd, offset, whence)` | Reposisi *pointer* *read/write* |
| 38  | `rename` | `err  = rename(oldpath, newpath)`  | Mengganti nama *file*           |
| 39  | `mkdir`  | `err  = mkdir(path, mode)`         | Membuat direktori baru          |
| 40  | `rmdir`  | `err  = rmdir(path)`               | Menghapus direktori kosong      |
| 122 | `uname`  | `err  = uname(buffer)`             | Mendapatkan informasi kernel    |


### *Flags* untuk `open`

| Nilai | Nama       | Deskripsi    |
| :---- | :--------- | :----------- |
| 0     | `O_RDONLY` | *Read-only*  |
| 1     | `O_WRONLY` | *Write-only* |
| 2     | `O_RDWR`   | *Read/write* |

### *Whence* untuk `lseek`

| Nilai | Nama       | Deskripsi                           |
| :---- | :--------- | :---------------------------------- |
| 0     | `SEEK_SET` | Relatif dari awal *file*            |
| 1     | `SEEK_CUR` | Relatif dari posisi *file* saat ini |
| 2     | `SEEK_END` | Relatif dari akhir *file*           |

### Mode *permission* untuk *file*

| Oktal | Nama      | Deskripsi                  |
| :---- | :-------- | :------------------------- |
| 400   | `S_IRUSR` | *Read by owner*            |
| 200   | `S_IWUSR` | *Write by owner*           |
| 100   | `S_IXUSR` | *Execute/search by owner*  |
| 040   | `S_IRGRP` | *Read by group*            |
| 020   | `S_IWGRP` | *Write by group*           |
| 010   | `S_IXGRP` | *Execute/search by group*  |
| 004   | `S_IROTH` | *Read by others*           |
| 002   | `S_IWOTH` | *Write by others*          |
| 001   | `S_IXOTH` | *Execute/search by others* |


## Contoh

[syscall-creat.asm](ex/syscall-creat.asm)

```nasm
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

                ; exit(0)
                mov     eax, 1
                mov     ebx, 0
                int     0x80
```
