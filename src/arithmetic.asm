# Basic Arithmetic Operations
# Demonstrates fundamental x86-64 arithmetic instructions

.section .data
number_a:
    .quad 42

number_b:
    .quad 13

result:
    .quad 0

.section .text
.globl _start

_start:
    # Load numbers
    mov number_a(%rip), %rax        # Load first number into rax
    mov number_b(%rip), %rbx        # Load second number into rbx

    # Addition
    add %rbx, %rax                  # rax = rax + rbx

    # Store result
    mov %rax, result(%rip)

    # Multiplication example
    mov number_a(%rip), %rax
    imul number_b(%rip), %rax       # rax = rax * number_b

    # exit(0)
    mov $60, %rax                   # syscall number for exit
    xor %rdi, %rdi                  # exit code 0
    syscall
