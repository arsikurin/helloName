; ----------------------------------------------------------------------------------------
; 64-bit Linux only.
; To assemble and run:
;     nasm -f elf64 main.asm -o main.o && ld main.o -o main && ./main
; ----------------------------------------------------------------------------------------


section .data
    greeting: db   "What is your name? ", 10
    hello:    db   "Hello, ", 10
;    text1Len:   equ  $ - text1
;    text2Len:   equ  $ - text2


section .bss
    name:  resb  16


section .text
    global    _start

_start:
    call _printGreeting
    call _getName
    call _printHello
    call _printName

    jmp  _exit

_printGreeting:
    mov       rax, 1                ; system call for write
    mov       rdi, 1                ; file handle 1 is stdout
    mov       rsi, greeting         ; address of string to output
    mov       rdx, 19               ; number of bytes
    syscall                         ; invoke operating system to do the write
    ret

_printHello:
    mov       rax, 1                ; system call for write
    mov       rdi, 1                ; file handle 1 is stdout
    mov       rsi, hello            ; address of string to output
    mov       rdx, 7                ; number of bytes
    syscall                         ; invoke operating system to do the write
    ret

_printName:
    mov       rax, 1                ; system call for write
    mov       rdi, 1                ; file handle 1 is stdout
    mov       rsi, name             ; address of string to output
    mov       rdx, 16               ; number of bytes
    syscall                         ; invoke operating system to do the write
    ret

_getName:
    xor       rax, rax              ; system call for input
    xor       rdi, rdi              ; file handle 0 is stdin
    mov       rsi, name             ; address of string to input
    mov       rdx, 16               ; number of bytes
    syscall                         ; invoke operating system to do the write
    ret

_exit:
    mov       rax, 60               ; system call for exit
    xor       rdi, rdi              ; exit code 0
    syscall                         ; invoke operating system to exit
