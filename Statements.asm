BITS 64

global _start

section .rodata
    equal db "The two numbers are equals", 10, 0x0
    equal_len equ $-equal

    notequal db "The two numbers are not equals", 10, 0x0
    notequal_len equ $-notequal


section .text

  _start:
    mov rax, 0x1337
    cmp rax, 0x1337
    je _equal
    jne _notequal

  _equal:
    mov rax, 0x1 ;sys_write
    mov rdi, 0x1 ; fd
    mov rsi, equal ; buf
    mov rdx, equal_len ;count
    syscall

    jmp _exit

  _notequal:
    mov rax, 0x1 ;sys_write
    mov rdi, 0x1 ; fd
    mov rsi, notequal ; buf
    mov rdx, notequal_len ; count
    syscall

    jmp _exit

  _exit:
   mov rax, 60 ;sys_exit
   xor rdi, rdi ;error code
   syscall