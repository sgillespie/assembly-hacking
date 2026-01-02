# SIMD Vector Operations Example
# Demonstrates basic SSE/AVX vector operations
# This example adds two vectors of 4 integers each

.section .data
.align 16
vector_a:
    .long 1, 2, 3, 4

.align 16
vector_b:
    .long 5, 6, 7, 8

.align 16
result:
    .long 0, 0, 0, 0

.section .text
.globl _start

_start:
    # Load vectors into XMM registers
    movdqa vector_a(%rip), %xmm0    # Load vector_a into xmm0
    movdqa vector_b(%rip), %xmm1    # Load vector_b into xmm1

    # Add vectors (parallel integer addition)
    paddd %xmm1, %xmm0              # xmm0 = xmm0 + xmm1

    # Store result
    movdqa %xmm0, result(%rip)

    # exit(0)
    mov $60, %rax                   # syscall number for exit
    xor %rdi, %rdi                  # exit code 0
    syscall
