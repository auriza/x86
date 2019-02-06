---
title: x86 Instruction Set
author: Auriza Akbar
date: 2019
---

# Register

## General-Purpose Register

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
 31 ... 11  10   9   8   7   6   5   4   3   2   1   0
+---~~~+---------------+---------------+---------------+
|   ...  O   D   I   T   S   Z   -   A   -   P   -   C |
+---~~~+---------------+---------------+---------------+
```

- `CF`: *__carry__ flag*
- `PF`: *parity even flag*
- `AF`: *auxiliary carry flag*
- `ZF`: *__zero__ flag*
- `SF`: *__sign__ flag*
- `TF`: *trap flag*
- `IF`: *interrupt enable flag*
- `DF`: *direction flag*
- `OF`: *__overflow__ flag*

## Other Register

- `ST{0-7}`: *floating point stack register* (80-bit)
- `XMM{0-7}`: *SSE register* (128-bit)


# Instruction Set


| Transfer         | Arith         |                 | Bitwise        | Branch         |               | Loop               | Control         | String            | FP               |                   |
|------------------|---------------|-----------------|----------------|----------------|---------------|--------------------|-----------------|-------------------|------------------|-------------------|
| [`MOV`](#mov)    | [`ADD`](#add) |                 | [`AND`](#and)  | [`JMP`](#jmp)  |               | [`LOOP`](#loop)    | [`INT`](#int)   | [`CMPSB`](#cmpsb) | [`FINIT`](#finit)|                   |
| [`XCHG`](#xchg)  | [`SUB`](#sub) |                 | [`OR`](#or)    | [`JB`](#jcc)   | [`JL`](#jcc)  | [`LOOPE`](#loope)  | [`CALL`](#call) | [`SCASB`](#scasb) | [`FLD`](#fld)    | [`FILD`](#fild)   |
| [`PUSH`](#push)  | [`INC`](#inc) |                 | [`NOT`](#not)  | [`JBE`](#jcc)  | [`JLE`](#jcc) | [`LOOPNE`](#loopne)| [`RET`](#ret)   | [`MOVSB`](#movsb) | [`FST`](#fst)    | [`FIST`](#fist)   |
| [`PUSHA`](#pusha)| [`DEC`](#dec) |                 | [`XOR`](#xor)  | [`JE`](#jc)    |               | [`REP`](#rep)      | [`CLD`](#cld)   | [`LODSB`](#lodsb) | [`FADD`](#fadd)  | [`FIADD`](#fiadd) |
| [`PUSHF`](#pushf)| [`MUL`](#mul) | [`IMUL`](#imul) | [`SHL`](#shl)  | [`JNE`](#jcc)  |               | [`REPE`](#repe)    | [`STD`](#std)   | [`STOSB`](#stosb) | [`FSUB`](#fsub)  | [`FISUB`](#fisub) |
| [`POP`](#pop)    | [`DIV`](#div) | [`IDIV`](#idiv) | [`SHR`](#shr)  | [`JAE`](#jcc)  | [`JGE`](#jcc) | [`REPNE`](#repne)  | [`NOP`](#nop)   |                   | [`FMUL`](#fmul)  | [`FIMUL`](#fimul) |
| [`POPA`](#popa)  | [`NEG`](#neg) |                 | [`ROR`](#ror)  | [`JA`](#jcc)   | [`JG`](#jcc)  |                    |                 |                   | [`FDIV`](#fdiv)  | [`FIDIV`](#fidiv) |
| [`POPF`](#popf)  | [`CMP`](#cmp) |                 | [`ROL`](#rol)  | [`JC`](#jcc)   |               |                    |                 |                   | [`FCOMI`](#fcomi)|                   |
| [`LEA`](#lea)    |               |                 | [`BT`](#bt)    | [`JNC`](#jcc)  |               |                    |                 |                   | [`FSQRT`](#fsqrt)|                   |
| [`CDQ`](#cdq)    |               |                 | [`BSWAP`](#bswap)| [`JECXZ`](#jecxz)|           |                    |                 |                   | [`FABS`](#fabs)  |                   |
|                  |               |                 |                |                |               |                    |                 |                   | [`FLDPI`](#fldpi)|                   |


## `ADD`

*Add Integers*
: Menambahkan nilai sumber ke tujuan, *flag* berubah sesuai hasil operasi.
    [\[contoh\]](ex/add.asm)

```nasm
ADD dst, src        ; dst += src                                [OSZAPC]

ADD r/m, reg        ; 01 /r
ADD reg, r/m        ; 03 /r
ADD EAX, imm        ; 05 id
ADD r/m, imm        ; 81 /0 id
```

## `AND`

*Bitwise AND*
: Melakukan operasi *bitwise* AND antara dua nilai dan menyimpan hasilnya ke
    tujuan. [\[contoh\]](ex/bit.asm)

```nasm
AND dst, src        ; dst &= src                                [OSZ.PC]

AND r/m, reg        ; 21 /r
AND reg, r/m        ; 23 /r
AND EAX, imm        ; 25 id
AND r/m, imm        ; 81 /4 id
```

## `BSWAP`

*Byte Swap*
: Menukar urutan *byte* dari *little-endian* ke *big-endian* atau sebaliknya.
    [\[contoh\]](ex/bit.asm)

```nasm
BSWAP dst           ; dst[0,1,2,3] = dst[3,2,1,0]

BSWAP reg           ; 0F C8+r
```

## `BT`

*Bit Test*
: Menguji satu bit dari sumber data pada indeks yang diberikan oleh operand
    kedua, dan menyimpan hasilnya ke *carry flag*. [\[contoh\]](ex/bit.asm)

```nasm
BT  src, idx        ; CF = src[idx]                             [.....C]

BT  r/m, reg        ; 0F A3 /r
BT  r/m, imm        ; 0F BA /4 ib
```

## `CDQ`

*Change Double to Quad*
: Memanjangkan (*sign-extend*) nilai di `EAX` menjadi `EDX:EAX`, biasanya
    dilakukan sebelum operasi [`DIV`](#div) atau [`IDIV`](#idiv).
    [\[contoh\]](ex/div.asm)

```nasm
CDQ                 ; EAX --> EDX:EAX

CDQ                 ; 99
```

## `CMP`

*Compare Integers*
: Melakukan pengurangan, namun hasilnya tidak disimpan dan hanya *flag* yang
    berubah.

```nasm
CMP dst, src        ; dst - src                                 [OSZAPC]

CMP r/m, reg        ; 39 /r
CMP reg, r/m        ; 3B /r
CMP EAX, imm        ; 3D id
CMP r/m, imm        ; 81 /0 id
```

## `DEC`

*Decrement Integer*
: Mengurangkan nilai 1 dari tujuan, *flag* status (kecuali `CF`) berubah sesuai
    hasil operasi, *lihat juga* [`INC`](#inc). [\[contoh\]](ex/add.asm)

```nasm
DEC dst             ; dst -= 1                                  [OSZAP.]

DEC reg             ; 48+r
DEC mem             ; FF /1
```

## `DIV`

*Divide Unsigned Integer*
: Melakukan pembagian *unsigned integer* antara `EDX:EAX` dengan pembagi, hasil
    bagi disimpan ke `EAX` dan sisa bagi disimpan ke `EDX`. Untuk pembagian
    *signed integer*, *lihat* [`IDIV`](#idiv). [\[contoh\]](ex/div.asm)

```nasm
DIV n               ; EAX = EDX:EAX / n
                    ; EDX = EDX:EAX % n

DIV r/m             ; F7 /6
```

## `IDIV`

*Divide Signed Integer*
: Melakukan pembagian *signed integer* antara `EDX:EAX` dengan pembagi, hasil
    bagi disimpan ke `EAX` dan sisa bagi disimpan ke `EDX`. Untuk pembagian
    *unsigned integer*, *lihat* [`DIV`](#div).

```nasm
IDIV n              ; EAX = EDX:EAX / n
                    ; EDX = EDX:EAX % n

IDIV r/m            ; F7 /7
```

## `IMUL`

*Multiply Signed Integer*
: Melakukan perkalian *signed integer* antara `EAX` dengan pengali, hasilnya
    disimpan ke `EDX:EAX`. Untuk perkalian *unsigned integer*, *lihat*
    [`MUL`](#mul).

```nasm
IMUL n              ; EDX:EAX = EAX * n                         [O....C]
IMUL dst, n         ;     dst = dst * n
IMUL dst, src, n    ;     dst = src * n

IMUL r/m            ; F7 /5
IMUL reg, r/m       ; 0F AF /r
IMUL reg, imm       ; 69 /r id
IMUL reg, r/m, imm  ; 69 /r id
```

## `INC`

*Increment Integer*
: Menambahkan nilai 1 ke tujuan, *flag* status (kecuali `CF`) berubah sesuai
    hasil operasi, *lihat juga* [`DEC`](#dec). [\[contoh\]](ex/add.asm)

```nasm
INC dst             ; dst += 1                                  [OSZAP.]

INC reg             ; 40+r
INC mem             ; FF /0
```

## `Jcc`

*Jump if Condition*
: Lompat ke alamat relatif (satu segmen) yang diberikan jika kondisi `cc`
    terpenuhi. Berikut rincian kondisi dan *flag* yang memicunya. Sebagai
    contoh, `JZ` akan lompat hanya jika `ZF` bernilai 1.
    [\[contoh\]](ex/jmp.asm)

| `cc` | *Mnemonic* | Kondisi             | *Flag*                 |
| ---- | :--------- | :------------------ | :--------------------- |
| `0`  | `O`        | Overflow            | `OF=1`                 |
| `1`  | `NO`       | NoOverflow          | `OF=0`                 |
| `2`  | `B`, `C`   | Below, Carry        | `CF=1`                 |
| `3`  | `AE`, `NC` | AboveEqual, NoCarry | `CF=0`                 |
| `4`  | `E`, `Z`   | Equal, Zero         | `ZF=1`                 |
| `5`  | `NE`, `NZ` | NotEqual, NoZero    | `ZF=0`                 |
| `6`  | `BE`       | BelowEqual          | `ZF=1 \|\| CF=1`       |
| `7`  | `A`        | Above               | `ZF=0 && CF=0`         |
| `8`  | `S`        | Sign                | `SF=1`                 |
| `9`  | `NS`       | NoSign              | `SF=0`                 |
| `10` | `P`, `PE`  | Parity, ParityEven  | `PF=1`                 |
| `11` | `NP`, `PO` | NoParity, ParityOdd | `PF=0`                 |
| `12` | `L`        | Lower               | `SF != OF`             |
| `13` | `GE`       | GreaterEqual        | `SF == OF`             |
| `14` | `LE`       | LowerEqual          | `ZF=1 \|\| (SF != OF)` |
| `15` | `G`        | Greater             | `ZF=0 && (SF == OF)`   |

```nasm
Jcc rel             ; if (cc) EIP += rel

Jcc imm             ; 70+cc rb
Jcc NEAR imm        ; 0F 80+cc rd
```

## `JECXZ`

*Jump if ECX Zero*
: Lompat pendek ke alamat relatif yang diberikan hanya jika `ECX` bernilai 0.

```nasm
JECXZ rel           ; if (ECX == 0) EIP += rel

JECXZ imm           ; E3 rb
```


## `JMP`

*Jump*
: Lompat ke alamat yang diberikan, baik alamat relatif (satu segmen) atau alamat
    absolut (segmen:offset). [\[contoh\]](ex/jmp.asm)

```nasm
JMP rel             ; EIP += rel
JMP abs             ; EIP  = abs

JMP imm             ; EB rb
JMP NEAR imm        ; E9 rd
JMP imm:imm         ; EA id iw
JMP r/m             ; FF /4
JMP FAR mem         ; FF /5
```


## `LEA`

*Load Effective Addres*
: Menghitung alamat efektif memori yang diberikan dan menyimpannya ke register
    tujuan, misal: `LEA EAX, [EBX + ECX*4 + 80]`{.asm}.

```nasm
LEA dst, src        ; dst = addr(src)

LEA reg, mem        ; 8D \r
```

## `MOV`

*Move*
: Menyalin isi dari sumber ke tujuan. [\[contoh\]](ex/mov.asm)

```nasm
MOV dst, src        ; dst = src

MOV r/m, reg        ; 89 /r
MOV reg, r/m        ; 8B /r
MOV reg, imm        ; B8+r id
MOV r/m, imm        ; C7 /0 id
MOV EAX, ofs        ; A1 od
MOV ofs, EAX        ; A3 od
```

## `MUL`

*Multiply Unsigned Integer*
: Melakukan perkalian *unsigned integer* antara `EAX` dengan pengali, hasilnya
    disimpan ke `EDX:EAX`. Untuk perkalian *signed integer*, *lihat*
    [`IMUL`](#imul). [\[contoh\]](ex/mul.asm)

```nasm
MUL n               ; EDX:EAX = EAX * n                         [O....C]

MUL r/m             ; F7 /4
```

## `NEG`

*Negate: Two's Complement*
: Mengganti nilai sebelumnya dengan negasi komplemen dua.

```nasm
NEG dst             ; dst = -dst                                [OSZAPC]

NEG r/m             ; F7 /3
```

## `NOT`

*Bitwise NOT: One's Complement*
: Mengganti nilai sebelumnya dengan balikan komplemen satu.
    [\[contoh\]](ex/bit.asm)

```nasm
NOT dst             ; dst = ~dst

NOT r/m             ; F7 /2
```

## `OR`

*Bitwise OR*
: Melakukan operasi *bitwise* OR antara dua nilai dan menyimpan hasilnya ke
    tujuan. [\[contoh\]](ex/bit.asm)

```nasm
OR dst, src         ; dst |= src                                [OSZ.PC]

OR r/m, reg         ; 09 /r
OR reg, r/m         ; 0B /r
OR EAX, imm         ; 0D id
OR r/m, imm         ; 81 /1 id
```

## `POP`

*Pop Data from Stack*
: Mengambil data dari *stack* (`[ESP]`) ke tujuan, lalu menambah nilai `ESP`
    sebesar 4. [\[contoh\]](ex/push.asm)

```nasm
POP dst             ; dst = [ESP];  ESP += 4

POP reg             ; 58+r
POP mem             ; BF /0
```

## `POPA`

*Pop All General-Purpose Register*
: Mengambil data dari *stack* ke `EDI`, `ESI`, `EBP`, kosong, `EBX`, `EDX`,
    `ECX`, dan `EAX`. Balikan dari operasi [`PUSHA`](#pusha), namun nilai `ESP`
    yang sebelumnya tidak dikembalikan. [\[contoh\]](ex/pushaf.asm)

```nasm
POPA                ; POP {EDI,ESI,EBP,---,EBX,EDX,ECX,EAX}

POPA                ; 61
```

## `POPF`

*Pop Flags Register*
: Mengambil data dari *stack* ke register `EFLAGS`, *lihat juga*
    [`PUSHF`](#pushf). [\[contoh\]](ex/pushaf.asm)

```nasm
POPF                ; POP EFLAGS

POPF                ; 9D
```

## `PUSH`

*Push Data on Stack*
: Mengurangi nilai `ESP` sebesar 4, lalu menyimpan data sumber ke dalam *stack*
    (`[ESP]`). [\[contoh\]](ex/push.asm)

```nasm
PUSH src            ; ESP -= 4;  [ESP] = data

PUSH reg            ; 50+r
PUSH mem            ; FF /6
PUSH imm            ; 68 id
```

## `PUSHA`

*Push All General-Purpose Registers*
: Menyimpan nilai register `EAX`, `ECX`, `EDX`, `EBX`, `ESP`, `EBP`, `ESI`, dan
    `EDI` ke dalam *stack*, lalu mengurangi nilai `ESP` sebanyak 32. Nilai `ESP`
    yang di-*push* adalah nilai aslinya sebelum instruksi ini dijalankan,
    *lihat juga* [`POPA`](#popa). [\[contoh\]](ex/pushaf.asm)

```nasm
PUSHA               ; PUSH {EAX,ECX,EDX,EBX,ESP,EBP,ESI,EDI}

PUSHA               ; 60
```

## `PUSHF`

*Push Flags Register*
: Menyimpan nilai register `EFLAGS` ke dalam *stack*, *lihat juga*
    [`POPF`](#popf). [\[contoh\]](ex/pushaf.asm)

```nasm
PUSHF               ; PUSH EFLAGS

PUSHF               ; 9C
```

## `ROL`

*Rotate Left*
: Melakukan operasi *bitwise left rotation* pada nilai yang diberikan. Jumlah
    bit yang diputar ditentukan oleh operand kedua. [\[contoh\]](ex/bit.asm)

```nasm
ROL dst, n          ;                                           [OSZAPC]

ROL r/m, 1          ; D1 /0
ROL r/m, CL         ; D3 /0
ROL r/m, imm        ; C1 /0 ib
```

## `ROR`

*Rotate Right*
: Melakukan operasi *bitwise right rotation* pada nilai yang diberikan. Jumlah
    bit yang diputar ditentukan oleh operand kedua. [\[contoh\]](ex/bit.asm)

```nasm
ROR dst, n          ;                                           [OSZAPC]

ROR r/m, 1          ; D1 /1
ROR r/m, CL         ; D3 /1
ROR r/m, imm        ; C1 /1 ib
```

## `SHL`

*Shift Left*
: Melakukan operasi *logical left shift* pada nilai yang diberikan, bit yang
    ditinggalkan diisi nol. Jumlah bit yang digeser ditentukan oleh operand
    kedua. [\[contoh\]](ex/bit.asm)

```nasm
SHL dst, n          ; dst <<= n                                 [OSZ.PC]

SHL r/m, 1          ; D1 /4
SHL r/m, CL         ; D3 /4
SHL r/m, imm        ; C1 /4 ib
```

## `SHR`

*Shift Right*
: Melakukan operasi *logical right shift* pada nilai yang diberikan, bit yang
    ditinggalkan diisi nol. Jumlah bit yang digeser ditentukan oleh operand
    kedua. [\[contoh\]](ex/bit.asm)

```nasm
SHR dst, n          ; dst >>= n                                 [OSZ.PC]

SHR r/m, 1          ; D1 /5
SHR r/m, CL         ; D3 /5
SHR r/m, imm        ; C1 /5 ib
```

## `SUB`

*Subtract Integers*
: Mengurangkan nilai sumber ke tujuan, *flag* berubah sesuai hasil operasi.
    [\[contoh\]](ex/add.asm)

```nasm
SUB dst, src        ; dst -= src                                [OSZAPC]

SUB r/m, reg        ; 29 /r
SUB reg, r/m        ; 2B /r
SUB EAX, imm        ; 2D id
SUB r/m, imm        ; 81 /5 id
```

## `XCHG`

*Exchange*
: Menukar data antara dua lokasi.

```nasm
XCHG dst, src       ; dst, src = src, dst

XCHG r/m, reg       ; 87 /r
XCHG EAX, reg       ; 90+r
```

## `XOR`

*Bitwise XOR*
: Melakukan operasi *bitwise* XOR antara dua nilai dan menyimpan hasilnya ke
    tujuan. [\[contoh\]](ex/bit.asm)

```nasm
XOR dst, src        ; dst ^= src                                [OSZ.PC]

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
