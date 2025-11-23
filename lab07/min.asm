%include 'in_out.asm'
section .data
msg db "Наименьшее число: ",0h
a dd 54
b dd 62
c dd 87

section .bss
min resd 1

section .text
global _start
_start:
    mov eax, [a]
    mov [min], eax
    
    cmp eax, [b]
    jl check_c
    mov eax, [b]
    mov [min], eax
    
check_c:
    mov eax, [min]
    cmp eax, [c]
    jl finish
    mov eax, [c]
    mov [min], eax
    
finish:
    mov eax, msg
    call sprint
    mov eax, [min]
    call iprintLF
    call quit
