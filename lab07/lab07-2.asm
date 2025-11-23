%include 'in_out.asm'
section .data
msg1 db 'Введите B: ',0h
msg2 db "Наибольшее число: ",0h
A dd 20
C dd 50

section .bss
B resb 10
max resd 1

section .text
global _start
_start:
    mov eax, msg1
    call sprint
    
    mov ecx, B
    mov edx, 10
    call sread
    
    mov eax, B
    call atoi
    mov [B], eax
    
    mov eax, [A]
    mov [max], eax
    
    mov eax, [max]
    cmp eax, [C]
    jg check_B
    mov eax, [C]
    mov [max], eax
    
check_B:
    mov eax, [max]
    cmp eax, [B]
    jg fin
    mov eax, [B]
    mov [max], eax
    
fin:
    mov eax, msg2
    call sprint
    mov eax, [max]
    call iprintLF
    call quit
