%include 'in_out.asm'

SECTION .data
    input_msg: DB 'Enter student ID: ',0
    result_msg: DB 'Your variant: ',0

SECTION .bss
    student_id: RESB 80

SECTION .text
    GLOBAL _start

_start:
    mov eax, input_msg
    call sprint
    
    mov ecx, student_id
    mov edx, 80
    call sread
    
    mov eax, student_id
    call atoi
    
    xor edx, edx
    mov ebx, 20
    div ebx
    inc edx
    
    mov eax, result_msg
    call sprint
    mov eax, edx
    call iprintLF

    call quit
