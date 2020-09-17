BITS 64

global _start

section .rodata
  message_loop db "[*]Nice loop buddy!", 10, 0x0
  message_loop_len equ $-message_loop

section .text

  _start:
    mov rcx, 10
    jmp for_loop

  ; ----------------------------

  for_loop:
    ; PUSH THE CURRENT RCX COUNTER
    push rcx

    ; PRINT MESSAGE
    mov rax, 1 ; sys_write
    mov rdi, 0x1 ; fd
    mov rsi, message_loop ; buf
    mov rdx, message_loop_len ; count
    syscall


    ; POP THE RCX COUNTER
    pop rcx

    ; EQUAL TO 0 ?
    cmp rcx, 0
    
    ; YES GOTO EXIT | NO LOOP THIS FUNCTION
    je _exit
    loop for_loop

  ; ----------------------------

  _exit:
    mov rax, 60 ; sys_exit
    xor rdi, rdi ; error code
    syscall