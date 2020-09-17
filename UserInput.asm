BITS 64

global _start

section .rodata
  ask_name_string db "What is your name?", 10, 0x0
  ask_name_len equ $-ask_name_string

section .bss
  name_len equ 40
  name_buffer: resb name_len

section .text
  _start:
    call ask_name
    call get_input
    call show_name
    jmp _exit
    
  ask_name:
    mov rax, 1 ; sys_write
    mov rdi, 0x1 ; fd
    mov rsi, ask_name_string ; buf
    mov rdx, ask_name_len ; count
    syscall
    ret

  get_input:
    mov rax, 0 ; sys_read
    mov rdi, 0x0 ; fd
    mov rsi, name_buffer ; buf
    mov rdx, name_len ; count
    syscall
    ret

  show_name:
    mov rax, 1 ; sys_write
    mov rdi, 0x1 ; fd
    mov rsi, name_buffer ; buf
    mov rdx, name_len ; count
    syscall
    ret

  _exit:
    mov rax, 60 ; sys_exit
    xor rdi, rdi ; error code
    syscall
