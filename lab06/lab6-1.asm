%include 'in_out.asm'

SECTION .bss
    buf1: RESB 80

SECTION .text
    GLOBAL _start

_start:
    ; --- Первая часть: работа с символами ---
    mov eax, '6'        ; Записываем в eax символ '6'
    mov ebx, '4'        ; Записываем в ebx символ '4'
    add eax, ebx        ; Складываем коды символов
    mov [buf1], eax     ; Сохраняем результат в buf1
    mov eax, buf1       ; Загружаем адрес buf1 в eax
    call sprintLF       ; Выводим строку

    call quit           ; Завершаем программу
