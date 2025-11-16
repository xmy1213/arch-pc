%include 'in_out.asm'

SECTION .data
    expression: DB 'f(x) = 10 + (31x - 5)',0
    input_msg: DB 'Введите x: ',0

SECTION .bss
    x_value: RESB 80

SECTION .text
    GLOBAL _start

_start:
    ; Вывод выражения
    mov eax, expression
    call sprintLF
    
    ; Ввод x
    mov eax, input_msg
    call sprint
    mov ecx, x_value
    mov edx, 80
    call sread
    
    ; Преобразование и вычисление
    mov eax, x_value
    call atoi           ; EAX = x
    
    ; f(x) = 10 + (31x - 5)
    mov ebx, 31
    mul ebx             ; EAX = 31*x
    sub eax, 5          ; EAX = 31x - 5  
    add eax, 10         ; EAX = 10 + (31x - 5)
    
    ; Вывод результата (результат уже в EAX)
    call iprintLF
    
    call quit
