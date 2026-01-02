.globl _start

.section .data
msg:
  .ascii "Hello, Assembly!\n"

.section .text
_start:
  movq $1, %rax
  movq $msg, %rsi
  movq $17, %rdx
  syscall

  movq $60, %rax
  movq $0, %rdi
  syscall

