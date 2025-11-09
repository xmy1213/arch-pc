slen:
    push ebx
    mov ebx, eax
nextchar:
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextchar
finished:
    sub eax, ebx
    pop ebx
    ret

sprint:
    push edx
    push ecx
    push ebx
    push eax
    call slen
    mov edx, eax
    pop eax
    mov ecx, eax
    mov ebx, 1
    mov eax, 4
    int 0x80
    pop ebx
    pop ecx
    pop edx
    ret

sprintLF:
    call sprint
    push eax
    mov eax, 0AH
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

sread:
    push ecx
    push edx
    mov ecx, eax
    mov edx, ebx
    mov eax, 3
    mov ebx, 0
    int 0x80
    pop edx
    pop ecx
    ret

quit:
    mov eax, 1
    mov ebx, 0
    int 0x80
    ret
