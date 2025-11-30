%include 'in_out.asm'

SECTION .data
    msg db "Результат: ", 0
    func_msg db "Функция: f(x)=4x+3", 0

SECTION .text
    global _start

_start:
    ; Обработка аргументов командной строки
    pop ecx         ; Количество аргументов
    pop edx         ; Имя программы (пропускаем)
    sub ecx, 1      ; Убираем имя программы из подсчета
    mov esi, 0      ; Инициализация суммы
    
    ; Вывод сообщения о функции
    mov eax, func_msg
    call sprintLF

    ; Проверка на наличие аргументов
    cmp ecx, 0
    jz _no_args

next:
    cmp ecx, 0      ; Проверяем, остались ли аргументы
    jz _end
    
    pop eax         ; Извлекаем аргумент
    call atoi       ; Преобразуем в число
    
    ; Вычисляем f(x) = 4x + 3
    mov ebx, eax    ; Сохраняем x в ebx
    shl eax, 2      ; Умножаем на 4 (x * 4) - БЫСТРЕЕ чем imul
    add eax, 3      ; Добавляем 3 (4x + 3)
    
    ; Добавляем к общей сумме
    add esi, eax
    
    ; Уменьшаем счетчик и переходим
    dec ecx
    jmp next

_no_args:
    mov eax, msg
    call sprint
    mov eax, 0
    call iprintLF
    call quit

_end:
    ; Вывод результата
    mov eax, msg
    call sprint
    mov eax, esi
    call iprintLF
    call quit
