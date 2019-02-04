---
title: x86 Instruction Set
author: Auriza Akbar
date: 2019
---

# Register

## General Purpose Register

0. `EAX`: *accumulator*
1. `ECX`: *counter*
2. `EDX`: *data*
3. `EBX`: *base*
4. `ESP`: *stack pointer*
5. `EBP`: *base pointer*
6. `ESI`: *source index*
7. `EDI`: *destination index*

## Flags Register

```
EFLAGS    11  10  9   8   7   6   5   4   3   2   1   0
       -+---+---+---+---+---+---+---+---+---+---+---+---+
   .... | O   D   I   T | S   Z   -   A | -   P   -   C |
       -+---------------+---------------+---------------+
```

- `CF`: *carry flag*
- `PF`: *parity even flag*
- `AF`: *auxiliary carry flag*
- `ZF`: *zero flag*
- `SF`: *sign flag*
- `IF`: *interrupt enable flag*
- `DF`: *direction flag*
- `OF`: *overflow flag*

## Other Register

- `ST{0-7}`: *floating point stack register* (80-bit)
- `XMM{0-7}`: *SSE register* (128-bit)


# Instruction Set


| Transfer         | Arith         |                 | Bitwise        | Branch         |       | Loop     | Control | String  | FP     |         |
|------------------|---------------|-----------------|----------------|----------------|-------|----------|---------|---------|--------|---------|
| [`MOV`](#mov)    | [`ADD`](#add) |                 | [`AND`](#and)  | [`JMP`](#jmp)  |       | [`LOOP`](#loop)   | [`INT`](#int)   | [`CMPSB`](#cmpsb) | [`FINIT`](#finit)|         |
| [`XCHG`](#xchg)  | [`SUB`](#sub) |                 | [`OR`](#or)    | [`JB`](#jb)    | [`JL`](#jl)  | [`LOOPE`](#loope)  | [`CALL`](#call)  | [`SCASB`](#scasb) | [`FLD`](#fld)  | [`FILD`](#fild)  |
| [`PUSH`](#push)  | [`INC`](#inc) |                 | [`NOT`](#not)  | [`JBE`](#jbe)  | [`JLE`](#jle) | [`LOOPNE`](#loopne) | [`RET`](#ret)   | [`MOVSB`](#movsb) | [`FST`](#fst)  | [`FIST`](#fist)  |
| [`PUSHA`](#pusha)| [`DEC`](#dec) |                 | [`XOR`](#xor)  | [`JE`](#je)    |       | [`REP`](#rep)    | [`CLD`](#cld)   | [`LODSB`](#lodsb) | [`FADD`](#fadd) | [`FIADD`](#fiadd) |
| [`PUSHF`](#pushf)| [`MUL`](#mul) | [`IMUL`](#imul) | [`SHL`](#shl)  | [`JNE`](#jne)  |       | [`REPE`](#repe)   | [`STD`](#std)   | [`STOSB`](#stosb) | [`FSUB`](#fsub) | [`FISUB`](#fisub) |
| [`POP`](#pop)    | [`DIV`](#div) | [`IDIV`](#idiv) | [`SHR`](#shr)  | [`JAE`](#jae)  | [`JGE`](#jge) | [`REPNE`](#repne)  | [`NOP`](#nop)   |         | [`FMUL`](#fmul) | [`FIMUL`](#fimul) |
| [`POPA`](#popa)  | [`CDQ`](#cdq) |                 | [`ROR`](#ror)  | [`JA`](#ja)    | [`JG`](#jg)  |          |         |         | [`FDIV`](#fdiv) | [`FIDIV`](#fidiv) |
| [`POPF`](#popf)  | [`NEG`](#neg) |                 | [`ROL`](#rol)  | [`JC`](#jc)    |       |          |         |         | [`FCOMI`](#fcomi)|         |
| [`LEA`](#lea)    | [`CMP`](#cmp) |                 | [`BT`](#bt)    | [`JNC`](#jnc)  |       |          |         |         | [`FSQRT`](#fsqrt)|         |
|                  |               |                 | [`BSWAP`](#bswap)| [`JECXZ`](#jecxz)|       |          |         |         | [`FABS`](#fabs) |         |
|                  |               |                 |                |                |       |          |         |         | [`FLDPI`](#fldpi)|         |


## `ADD`

*Add Integers*
: Menambahkan nilai sumber ke tujuan, *flag* `OSZAPC` berubah sesuai hasil
    operasi.

```asm
ADD dst, src        ; dst += src                                [O.SZAPC]

ADD r/m, reg        ; 01 /r
ADD reg, r/m        ; 03 /r
ADD EAX, imm        ; 05 id
ADD r/m, imm        ; 81 /0 id
```

## `AND`

*Bitwise AND*
: Melakukan operasi *bitwise* AND antara dua nilai dan menyimpan hasilnya ke
    tujuan.

```asm
AND dst, src        ; dst &= src                                [O.SZ.PC]

AND r/m, reg        ; 21 /r
AND reg, r/m        ; 23 /r
AND EAX, imm        ; 25 id
AND r/m, imm        ; 81 /4 id
```

## `CDQ`

*Change Double to Quad*
: Memanjangkan (*sign-extend*) nilai di `EAX` menjadi `EDX:EAX`, biasanya
    dilakukan sebelum operasi [`DIV`](#div) atau [`IDIV`](#idiv).

```asm
CDQ                 ; EAX --> EDX:EAX

CDQ                 ; 99
```

## `CMP`

*Compare Integers*
: Melakukan pengurangan, namun hasilnya tidak disimpan dan hanya *flag* yang
    berubah.

```asm
CMP dst, src        ; dst - src                                 [O.SZAPC]

CMP r/m, reg        ; 39 /r
CMP reg, r/m        ; 3B /r
CMP EAX, imm        ; 3D id
CMP r/m, imm        ; 81 /0 id
```

## `DEC`

*Decrement Integer*
: Mengurangkan nilai 1 dari tujuan, *flag* berubah sesuai hasil operasi.
    *Lihat juga* [`INC`](#inc).

```asm
DEC dst             ; dst -= 1                                  [O.SZAP.]

DEC reg             ; 48+r
DEC mem             ; FF /1
```

## `DIV`

*Divide Unsigned Integer*
: Melakukan pembagian *unsigned integer* antara `EDX:EAX` dengan pembagi, hasil
    bagi disimpan ke `EAX` dan sisa bagi disimpan ke `EDX`. Untuk pembagian
    *signed integer*, *lihat* [`IDIV`](#idiv).

```asm
DIV div             ; EAX = EDX:EAX / div
                    ; EDX = EDX:EAX % div

DIV r/m             ; F7 /6
```

## `IDIV`

*Divide Signed Integer*
: Melakukan pembagian *signed integer* antara `EDX:EAX` dengan pembagi, hasil
    bagi disimpan ke `EAX` dan sisa bagi disimpan ke `EDX`. Untuk pembagian
    *unsigned integer*, *lihat* [`DIV`](#div).

```asm
IDIV div            ; EAX = EDX:EAX / div
                    ; EDX = EDX:EAX % div

IDIV r/m            ; F7 /7
```

## `IMUL`

*Multiply Signed Integer*
: Melakukan perkalian *signed integer* antara `EAX` dengan pengali, hasilnya
    disimpan ke `EDX:EAX`. Untuk perkalian *unsigned integer*, *lihat*
    [`MUL`](#mul).

```asm
IMUL mul            ; EDX:EAX = EAX * mul                       [O.....C]
IMUL dst, mul       ;     dst = dst * mul
IMUL dst, src, mul  ;     dst = src * mul

IMUL r/m            ; F7 /5
IMUL reg, r/m       ; 0F AF /r
IMUL reg, imm       ; 69 /r id
IMUL reg, r/m, imm  ; 69 /r id
```

## `INC`

*Increment Integer*
: Menambahkan nilai 1 ke tujuan, *flag* berubah sesuai hasil operasi.
    *Lihat juga* [`DEC`](#dec).

```asm
INC dst             ; dst += 1                                  [O.SZAP.]

INC reg             ; 40+r
INC mem             ; FF /0
```


## `LEA`

*Load Effective Addres*
: Menghitung alamat efektif memori yang diberikan dan menyimpannya ke register
    tujuan, misal: `LEA EAX, [EBX + ECX*4 + 80]`{.asm}.

```asm
LEA dst, src        ; dst = addr(src)

LEA reg, mem        ; 8D \r
```

## `MOV`

*Move*
: Menyalin isi dari sumber ke tujuan.

```asm
MOV dst, src        ; dst = src

MOV r/m, reg        ; 89 /r
MOV reg, r/m        ; 8B /r
MOV reg, imm        ; B8+r id
MOV r/m, imm        ; C7 /0 id
MOV EAX, ofs        ; A1 od
MOV ofs, EAX        ; A3 od
```

Contoh:

```asm
section .data                           ; 0x5655_7008
    a       dd  100
    b       dd  200

section .text
    main:   ; immediate addressing
            mov eax, 7                  ; eax = 7
            mov ecx, 5                  ; ecx = 5
            mov edi, a                  ; edi = 0x5655_7008

            ; register addressing
            mov edx, eax                ; edx = 7
            mov ebx, ecx                ; ebx = 5

            ; direct memory addressing
            mov [a], eax                ; [a] = 7
            mov edx, [b]                ; edx = 200

            ; indirect memory addressing
            mov [edi], dword 32         ; [a] = 32
            mov ecx, [edi+4]            ; ecx = 200
```

## `MUL`

*Multiply Unsigned Integer*
: Melakukan perkalian *unsigned integer* antara `EAX` dengan pengali, hasilnya
    disimpan ke `EDX:EAX`. Untuk perkalian *signed integer*, *lihat*
    [`IMUL`](#imul).

```asm
MUL mul             ; EDX:EAX = EAX * mul                       [O.....C]

MUL r/m             ; F7 /4
```

## `NEG`

*Negate: Two's Complement*
: Mengganti nilai sebelumnya dengan negasi komplemen dua.

```asm
NEG dst             ; dst = -dst                                [O.SZAPC]

NEG r/m             ; F7 /3
```

## `NOT`

*Bitwise NOT: One's Complement*
: Mengganti nilai sebelumnya dengan balikan komplemen satu.

```asm
NOT dst             ; dst = ~dst

NOT r/m             ; F7 /2
```

## `OR`

*Bitwise OR*
: Melakukan operasi *bitwise* OR antara dua nilai dan menyimpan hasilnya ke
    tujuan.

```asm
OR dst, src         ; dst |= src                                [O.SZ.PC]

OR r/m, reg         ; 09 /r
OR reg, r/m         ; 0B /r
OR EAX, imm         ; 0D id
OR r/m, imm         ; 81 /1 id
```

## `POP`

*Pop Data from Stack*
: Mengambil data dari *stack* (`[ESP]`) ke tujuan, lalu menambah nilai `ESP`
    sebesar 4.

```asm
POP dst             ; dst = [ESP];  ESP += 4

POP reg             ; 58+r
POP mem             ; BF /0
```

## `POPA`

*Pop All General-Purpose Register*
: Mengambil data dari *stack* ke `EDI`, `ESI`, `EBP`, kosong, `EBX`, `EDX`,
    `ECX`, dan `EAX`. Balikan dari operasi [`PUSHA`](#pusha), namun nilai `ESP`
    tidak dikembalikan.

```asm
POPA                ; POP {EDI,ESI,EBP,---,EBX,EDX,ECX,EAX}

POPA                ; 61
```

## `POPF`

*Pop Flags Register*
: Mengambil data dari *stack* ke register `EFLAGS`, *lihat juga* [`PUSHF`](#pushf).

```asm
POPF                ; POP EFLAGS

POPF                ; 9D
```

## `PUSH`

*Push Data on Stack*
: Mengurangi nilai `ESP` sebesar 4, lalu menyimpan data sumber ke dalam *stack*
    (`[ESP]`).

```asm
PUSH src            ; ESP -= 4;  [ESP] = data

PUSH reg            ; 50+r
PUSH mem            ; FF /6
PUSH imm            ; 68 id
```

## `PUSHA`

*Push All General-Purpose Registers*
: Menyimpan nilai register `EAX`, `ECX`, `EDX`, `EBX`, `ESP`, `EBP`, `ESI`, dan
    `EDI` ke dalam *stack*, lalu mengurangi nilai `ESP` sebanyak 32. Nilai `ESP`
    yang di-*push* adalah nilai aslinya sebelum instruksi ini dijalankan.
    *Lihat juga* [`POPA`](#popa).

```asm
PUSHA               ; PUSH {EAX,ECX,EDX,EBX,ESP,EBP,ESI,EDI}

PUSHA               ; 60
```

## `PUSHF`

*Push Flags Register*
: Menyimpan nilai register `EFLAGS` ke dalam *stack*, *lihat juga* [`POPF`](#popf).

```asm
PUSHF               ; PUSH EFLAGS

PUSHF               ; 9C
```

## `ROL`

*Rotate Left*
: Melakukan operasi *bitwise left rotation* pada nilai yang diberikan. Jumlah
    bit yang diputar ditentukan oleh operand kedua.

```asm
ROL dst, n          ;                                           [O.SZAPC]

ROL r/m, 1          ; D1 /0
ROL r/m, CL         ; D3 /0
ROL r/m, imm        ; C1 /0 ib
```

## `ROR`

*Rotate Right*
: Melakukan operasi *bitwise right rotation* pada nilai yang diberikan. Jumlah
    bit yang diputar ditentukan oleh operand kedua.

```asm
ROR dst, n          ;                                           [O.SZAPC]

ROR r/m, 1          ; D1 /1
ROR r/m, CL         ; D3 /1
ROR r/m, imm        ; C1 /1 ib
```

## `SHL`

*Shift Left*
: Melakukan operasi *logical left shift* pada nilai yang diberikan, bit yang
    ditinggalkan diisi nol. Jumlah bit yang digeser ditentukan oleh operand kedua.

```asm
SHL dst, n          ; dst <<= n                                 [O.SZ.PC]

SHL r/m, 1          ; D1 /4
SHL r/m, CL         ; D3 /4
SHL r/m, imm        ; C1 /4 ib
```

## `SHR`

*Shift Right*
: Melakukan operasi *logical right shift* pada nilai yang diberikan, bit yang
    ditinggalkan diisi nol. Jumlah bit yang digeser ditentukan oleh operand kedua.

```asm
SHR dst, n          ; dst >>= n                                 [O.SZ.PC]

SHR r/m, 1          ; D1 /5
SHR r/m, CL         ; D3 /5
SHR r/m, imm        ; C1 /5 ib
```

## `SUB`

*Subtract Integers*
: Mengurangkan nilai sumber ke tujuan. *Flag* berubah sesuai hasil operasi.

```asm
SUB dst, src        ; dst -= src                                [O.SZAPC]

SUB r/m, reg        ; 29 /r
SUB reg, r/m        ; 2B /r
SUB EAX, imm        ; 2D id
SUB r/m, imm        ; 81 /5 id
```

## `XCHG`

*Exchange*
: Menukar data antara dua lokasi.

```asm
XCHG dst, src       ; dst, src = src, dst

XCHG r/m, reg       ; 87 /r
XCHG EAX, reg       ; 90+r
```

## `XOR`

*Bitwise XOR*
: Melakukan operasi *bitwise* XOR antara dua nilai dan menyimpan hasilnya ke
    tujuan.

```asm
XOR dst, src        ; dst ^= src                                [O.SZ.PC]

XOR r/m, reg        ; 31 /r
XOR reg, r/m        ; 33 /r
XOR EAX, imm        ; 35 id
XOR r/m, imm        ; 81 /6 id
```

<!--
# Geany Build

```sh
# assemble
yasm '%f' -f elf32 -g dwarf2 -l '%e.lst'

# build (gcc)
gcc -o '%e' -m32 '%e.o'

# build (ld)
ld  -o '%e' -e main -m elf_i386 '%e.o'

# debug
ddd '%e'
nemiver '%e'

# disassemble
nm '%e'
objdump -dM intel '%e'
gdb -batch '%e' -ex 'disassemble main'
radare2 '%e' -c 'aa; s main; vp'
```
-->
