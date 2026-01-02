# Hello World in x86-64 assembly
# This is a simple program that prints "Hello, World!" to stdout

.section .data
msg:
    .ascii "Hello, World!\n"
    msg_len = . - msg

.section .text
.globl _start

_start:
    # write(1, msg, msg_len)
    mov $1, %rax            # syscall number for write
    mov $1, %rdi            # file descriptor 1 (stdout)
    lea msg(%rip), %rsi     # pointer to message
    mov $msg_len, %rdx      # message length
    syscall

    # exit(0)
    mov $60, %rax           # syscall number for exit
    xor %rdi, %rdi          # exit code 0
    syscall
