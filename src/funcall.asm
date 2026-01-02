.globl _start

.section .data
msg:
  .asciz "Result: %d\n"

.section .text
_start:
  # Call printf
  movq $0, %rsi
  movq $msg, %rdi
  callq printf

  # Exit with success
  movq $0, %rdi
  movq $60, %rax
  syscall

