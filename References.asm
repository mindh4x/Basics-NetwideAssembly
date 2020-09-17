; Sections:
; text -> code to be executed.
; bss -> variables w/o being init
; rodata -> variables w/ values

; Etiquettes (like main function):
; global _start:

; Syscalls:

; Debugging:
; objdump -d binary
; gdb binary

; Stack:
; en.wikibooks.org/wiki/X86_Disassembly/The_Stack
; cdn.discordapp.com/attachments/647454655193808907/651500283410645022/20-08-16-LIFO_EBP_ESP.jpg

; Registries :
; rax == accumulator register : utilisé dans les operations arithmétiques
; rcx == counter register : utilisé dans les instructions et les boucles
; rdx == data register == utilisé dans les opérations arithmétiques et les opérations io (input, output)
; rbx == base register : utilisé comme un pointeur sur une donnée
; rsp == stack pointer register : utilisé comme un pointeur au sommet de la pile
; rbp == base pointer register : utilisé comme pointeur de base de la stack 
; rsi == source index register : utilisé comme un pointeur sur une source dans les operations de diffusion
; rdi == destination index register : utilisé comme un pointeur sur une destinations des operations de diffusion
; rip == extended instruction pointer register : c'est un registre qui contient l'adresse de la prochaine instruction a lire dans notre programme, ce registre est ro (read-only)
; cdn.discordapp.com/attachments/647454655193808907/651489376173293588/19-26-01-N0KnG.png

; Useful stuffs:
; -------------------
; Add a value to a register:
; mov <destination>, <source>
; -------------------
; Kernel call:
; Syscalls (blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
; -------------------
; Opcodes list:
; ref.x86asm.net/coder32.html
; -------------------
; Create a variable:
; DB - Define Byte. 8 bits
; DW - Define Word. Generally 2 bytes on a typical x86 32-bit system
; DD - Define double word. Generally 4 bytes on a typical x86 32-bit system
; stackoverflow.com/questions/44860003/how-many-bytes-do-resb-resw-resd-resq-allocate-in-nasm
; -------------------
; Jumps: 
; cdn.discordapp.com/attachments/647454655193808907/651540832599670804/22-50-06-assembly-language-lecture-5-15-728.jpg
; https://en.wikipedia.org/wiki/JMP_(x86_instruction)
; en.wikibooks.org/wiki/X86_Assembly/Control_Flow#Unconditional_Jumps
; -------------------
; Stacks commands:
; push (source)
; pop (destination)
; -------------------

; Architectures:
; Intel & AT&T

BITS 64 ; Specify that we are in a 64bits system

global _start

section .rodata

    ; 0x10 -> \n | 0x0 -> nullbyte
    helloworld db "Hello, World !", 10, 0x0
    helloworld_len equ $-helloworld

section .text

  _start:
    mov rax, 1 ;syscall code for write
    mov rdi, 0x1 ;stdin=0 stdout=1 stderr=2
    mov rsi, helloworld ;variable
    mov rdx, helloworld_len ;variable len
    syscall

    jmp _exit

  _exit:
    mov rax, 60 ;syscall code for exit
    xor rdi, rdi ;error code
    syscall