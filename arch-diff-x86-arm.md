## C

```c
int triple(int n) {
    return n * 3;
}
```


## x86

```asm
triple:
        push    ebp
        mov     ebp, esp
        imul    eax, dword ptr [ebp], 3
        pop     ebp
        ret     0

```

## x86-64
```asm
triple:
        push    rbp
        mov     rbp, rsp
        mov     dword ptr [rbp - 4], edi
        imul    eax, dword ptr [rbp - 4], 3
        pop     rbp
        ret
```



## ARM64

```asm
triple:
        sub     sp, sp, #16
        str     w0, [sp, 12]
        ldr     w1, [sp, 12]
        mov     w0, w1
        lsl     w0, w0, 1
        add     w0, w0, w1
        add     sp, sp, 16
        ret
```


