; in_out.asm - 输入输出函数库
; 用于 NASM 汇编语言

; -----------------------------------------------------------
; 字符串输出函数 (不带换行)
; 输入: eax = 字符串地址
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen          ; 计算字符串长度
    
    mov     edx, eax      ; 长度
    pop     eax           ; 字符串地址
    mov     ecx, eax      ; 字符串地址
    mov     ebx, 1        ; 标准输出
    mov     eax, 4        ; sys_write
    int     0x80          ; 系统调用
    
    pop     ebx
    pop     ecx
    pop     edx
    ret

; -----------------------------------------------------------
; 字符串输出函数 (带换行)
; 输入: eax = 字符串地址
sprintLF:
    call    sprint
    push    eax
    mov     eax, 0xA      ; 换行符
    push    eax
    mov     eax, esp      ; 栈顶地址
    call    sprint
    pop     eax
    pop     eax
    ret

; -----------------------------------------------------------
; 计算字符串长度
; 输入: eax = 字符串地址
; 输出: eax = 字符串长度
slen:
    push    ebx
    mov     ebx, eax
    
nextchar:
    cmp     byte [ebx], 0
    jz      finished
    inc     ebx
    jmp     nextchar
    
finished:
    sub     ebx, eax
    mov     eax, ebx
    pop     ebx
    ret

; -----------------------------------------------------------
; 整数输出函数 (不带换行)
; 输入: eax = 整数
iprint:
    push    eax
    push    ecx
    push    edx
    push    esi
    mov     ecx, 0
    
divideLoop:
    inc     ecx
    mov     edx, 0
    mov     esi, 10
    idiv    esi
    add     edx, 48
    push    edx
    cmp     eax, 0
    jnz     divideLoop
    
printLoop:
    dec     ecx
    mov     eax, esp
    call    sprint
    pop     eax
    cmp     ecx, 0
    jnz     printLoop
    
    pop     esi
    pop     edx
    pop     ecx
    pop     eax
    ret

; -----------------------------------------------------------
; 整数输出函数 (带换行)
; 输入: eax = 整数
iprintLF:
    call    iprint
    push    eax
    mov     eax, 0xA      ; 换行符
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret

; -----------------------------------------------------------
; 字符串输入函数
; 输入: ecx = 缓冲区地址, edx = 缓冲区大小
; 输出: 缓冲区包含输入的字符串
sread:
    push    eax
    push    ebx
    mov     eax, 3        ; sys_read
    mov     ebx, 0        ; 标准输入
    int     0x80
    pop     ebx
    pop     eax
    ret

; -----------------------------------------------------------
; ASCII 转整数
; 输入: eax = 字符串地址
; 输出: eax = 整数
atoi:
    push    ebx
    push    ecx
    push    edx
    push    esi
    mov     esi, eax
    mov     eax, 0
    mov     ecx, 0
    
.multiplyLoop:
    xor     ebx, ebx
    mov     bl, [esi+ecx]
    cmp     bl, 48
    jl      .finished
    cmp     bl, 57
    jg      .finished
    
    sub     bl, 48
    add     eax, ebx
    mov     ebx, 10
    mul     ebx
    inc     ecx
    jmp     .multiplyLoop
    
.finished:
    mov     ebx, 10
    div     ebx
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    ret

; -----------------------------------------------------------
; 程序退出函数
quit:
    mov     eax, 1        ; sys_exit
    mov     ebx, 0        ; 退出码 0
    int     0x80
    ret
