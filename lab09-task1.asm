%include 'in_out.asm'

SECTION .data
    prompt: DB 'Enter x: ',0
    result: DB 'f(x)=x^2+2x+1=',0

SECTION .bss
    x: RESB 80
    res: RESB 80

SECTION .text
GLOBAL _start
_start:
    ; --- Main program ---
    mov eax, prompt
    call sprint
    
    mov ecx, x
    mov edx, 80
    call sread
    
    mov eax, x
    call atoi          ; eax = x (integer)
    
    call _calculate    ; call subroutine
    
    ; Output result
    mov eax, result
    call sprint
    mov eax, [res]
    call iprintLF
    
    call quit

; --- Subroutine: Calculate f(x) = x^2 + 2x + 1 ---
; Input: eax = x
; Output: [res] = result
_calculate:
    push ebx
    push ecx
    
    ; Save x
    mov ebx, eax      ; ebx = x
    
    ; Calculate x^2
    mul ebx           ; eax = x^2
    mov ecx, eax      ; ecx = x^2
    
    ; Calculate 2x
    mov eax, ebx      ; eax = x
    mov edx, 2
    mul edx           ; eax = 2x
    
    ; Sum: x^2 + 2x + 1
    add ecx, eax      ; ecx = x^2 + 2x
    add ecx, 1        ; ecx = x^2 + 2x + 1
    
    ; Save result
    mov [res], ecx
    
    pop ecx
    pop ebx
    ret
