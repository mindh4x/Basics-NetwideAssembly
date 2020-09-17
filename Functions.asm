BITS 64

global _start

section .rodata
  wonderful: db "aaaaaaaaaaaaaa"
  wonderful_len equ $-wonderful

section .text
  
  _start:
    mov rbx, wonderful
    push rbx
    
    call myfunction
    
    jmp _exit

  myfunction:
    ; Calling Conventions
    push rbp
    mov rbp, rsp
    
    mov rax, 1 ; sys_write
    mov rdi, 0x1 ; fd
    mov rsi, [rbp + 16] ; buf
    mov rdx, wonderful_len ; count
    syscall

  _exit:
    mov rax, 60 ; sys_exit
    xor rdi, rdi ; error code
    syscall