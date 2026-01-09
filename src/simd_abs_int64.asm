.globl _start

.section .data
msg:
  .asciz "Result: [%d, %d]\n"

.align 16
.vector:
  .quad 0x0000000000000010, 0xFFFFFFFFFFFFFFF0
.ctrl:
  .quad 0x0, 0x0

.section .text
.type abs_avx512, @function
abs_avx512:
  push %rbp
  mov %rsp, %rbp

  # Calculate absolute value on AVX-512F
  vpabsq %xmm0, %xmm0

  pop %rbp
  ret

# Absolute value for SSE4.1. Note that PABS is not available for 64 bit integers
.type abs_sse41, @function
abs_sse41:
  push %rbp
  mov %rsp, %rbp

  movdqa .ctrl, %xmm1   # Clear xmm1
  pcmpgtq %xmm0, %xmm1  # Create a mask
  pxor %xmm1, %xmm0     # Flip the bits if negative
  psubq %xmm1, %xmm0    # Subtract mask (-1) if negative

  pop %rbp
  ret

# Absolute value for SSE2. Note that PABSQ nor PCMPGT are available
abs_sse2:
  push %rbp
  mov %rsp, %rbp

  # Calculate absolute value on SSE2.
  pshufd $0xF5, %xmm0, %xmm1 # Copy high bits to lower bits
  psrad $31, %xmm1           # Create a mask
  pxor %xmm1, %xmm0          # Flip the bits if negative
  psubq %xmm1, %xmm0         # Subtract mask (-1) if negative

  pop %rbp
  ret

_start:
  # Fill the vector
  movdqa .vector, %xmm0

  # Calculate the absolute value
  call abs_sse2

  # Extract the vector
  pextrq $0, %xmm0, %rsi
  pextrq $1, %xmm0, %rdx

  # Call printf
  movq $msg, %rdi
  callq printf

  # Exit with success
  movq $0, %rdi
  movq $60, %rax
  syscall
