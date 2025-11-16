%include 'in_out.asm'

SECTION .data
    result_msg: DB 'Result: ',0
    remainder_msg: DB 'Remainder: ',0

SECTION .text
    GLOBAL _start

_start:
    ; --- Вычисление выражения f(x) = (5 * 2 + 3)/3 ---
    mov eax, 5
    mov ebx, 2
    mul ebx
    add eax, 3
    xor edx, edx
    mov ebx, 3
    div ebx
    mov edi, eax

    mov eax, result_msg
    call sprint
    mov eax, edi
    call iprintLF

    mov eax, remainder_msg
    call sprint
    mov eax, edx
    call iprintLF

    call quit
