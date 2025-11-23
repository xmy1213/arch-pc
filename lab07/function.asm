%include 'in_out.asm'
section .data
msg_x db "Введите x: ",0h
msg_a db "Введите a: ",0h
msg_result db "f(x) = ",0h

section .bss
x resd 1
a resd 1

section .text
global _start
_start:
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    mov eax, x
    call atoi
    mov [x], eax
    
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    mov eax, a
    call atoi
    mov [a], eax
    
    mov eax, [x]
    mov ebx, [a]
    cmp eax, ebx
    jg case1
    
    mov eax, 15
    jmp output
    
case1:
    sub eax, ebx
    mov ebx, 2
    mul ebx
    
output:
    mov ebx, eax
    mov eax, msg_result
    call sprint
    mov eax, ebx
    call iprintLF
    call quit
