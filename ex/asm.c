/* Inline assembly using 'asm' keywords,
 * note the AT&T syntax and 64-bit syscall.
 */

int main()
{
    // exit(42)
    asm("movq   $60, %rax\n\t"
        "movq   $42, %rdi\n\t"
        "syscall");
}
