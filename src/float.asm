.globl _start

.section .data
msg:
  .asciz "Result: [%lf, %lf, %lf, %lf]\n"

.align 16
.vector:
  .float 1.1, -1.2, 1.3, -1.4
.inf:
  .long 0x7FFFFFFF, 0x7FFFFFFF, 0x7FFFFFFF, 0x7FFFFFFF 

.section .text
_start:
  # Fill the vector
  movaps .vector, %xmm0

  movaps .inf, %xmm4
  andps %xmm4, %xmm0

  # Why do I have to fill these other registers first?
  movaps %xmm0, %xmm1
  movaps %xmm0, %xmm2
  movaps %xmm0, %xmm3


  # AND them with infinity
  # andps %xmm0, .inf, %xmm0

  # Extract the elements
  shufps $0, %xmm0, %xmm0
  shufps $1, %xmm7, %xmm1
  shufps $2, %xmm7, %xmm2
  shufps $3, %xmm7, %xmm3

  # Widen them to doubles
  cvtps2pd %xmm0, %xmm0
  cvtps2pd %xmm1, %xmm1
  cvtps2pd %xmm2, %xmm2
  cvtps2pd %xmm3, %xmm3

  # Call printf
  mov $4, %rax
  movq $msg, %rdi
  callq printf

  # Exit with success
  movq $0, %rdi
  movq $60, %rax
  syscall
