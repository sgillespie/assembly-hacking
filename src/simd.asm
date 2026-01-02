.globl _start

.section .data
msg:
  .asciz "Result: [%d, %d, %d, %d]\n"

.align 16
.vector:
  .long 1, -4, -16, 25

.section .text
_start:
  # Fill the vector
  movdqa .vector, %xmm0

  # Calculate absolute value
  pabsd %xmm0, %xmm0

  # Extract the vector
  movd %xmm0, %esi

  pshufd $0x39, %xmm0, %xmm1
  movd %xmm1, %edx

  pshufd $0x39, %xmm1, %xmm2
  movd %xmm2, %ecx

  pshufd $0x39, %xmm2, %xmm3
  movd %xmm3, %r8

  # Call printf
  movq $msg, %rdi
  callq printf

  # Exit with success
  movq $0, %rdi
  movq $60, %rax
  syscall
