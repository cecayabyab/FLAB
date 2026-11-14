section .data
    p_name  db "What is your name? ", 0
    l_pname equ $ - p_name
    p_age   db "How old are you? ", 0
    l_page  equ $ - p_age
    p_yr    db "What is your year level? ", 0
    l_pyr   equ $ - p_yr

    m_hello db "Hello, ", 0
    l_mhell equ $ - m_hello
    m_age   db "! You are ", 0
    l_mage  equ $ - m_age
    m_yrs   db " years old", 10, 0
    l_myrs  equ $ - m_yrs

    c_fresh db "Freshman", 10, 0
    l_cfres equ $ - c_fresh
    c_soph  db "Sophomore", 10, 0
    l_csoph equ $ - c_soph
    c_jun   db "Junior", 10, 0
    l_cjun  equ $ - c_jun
    c_sen   db "Senior", 10, 0
    l_csen  equ $ - c_sen
    c_inv   db "INVALID YEAR LEVEL", 10, 0
    l_cinv  equ $ - c_inv

section .bss
    name_buf resb 64
    age_buf  resb 16
    yr_buf   resb 8

section .text
    global _start

_start:
    ; Read Name
    mov eax, 4
    mov ebx, 1
    mov ecx, p_name
    mov edx, l_pname
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, name_buf
    mov edx, 64
    int 0x80

    call strip_nl

    ; Read Age
    mov eax, 4
    mov ebx, 1
    mov ecx, p_age
    mov edx, l_page
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, age_buf
    mov edx, 16
    int 0x80

    call strip_nl

    ; Read Year Level
    mov eax, 4
    mov ebx, 1
    mov ecx, p_yr
    mov edx, l_pyr
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, yr_buf
    mov edx, 8
    int 0x80

    call strip_nl

    ; Print Hello <name>
    mov eax, 4
    mov ebx, 1
    mov ecx, m_hello
    mov edx, l_mhell
    int 0x80

    call print_name_str

    ; Print You are <age> years old
    mov eax, 4
    mov ebx, 1
    mov ecx, m_age
    mov edx, l_mage
    int 0x80

    call print_age_str

    mov eax, 4
    mov ebx, 1
    mov ecx, m_yrs
    mov edx, l_myrs
    int 0x80

    ; Evaluate Year Level ('1', '2', '3', '4')
    mov al, [yr_buf]
    cmp al, '1'
    je lvl_1
    cmp al, '2'
    je lvl_2
    cmp al, '3'
    je lvl_3
    cmp al, '4'
    je lvl_4
    jmp lvl_inv

lvl_1:
    mov eax, 4
    mov ebx, 1
    mov ecx, c_fresh
    mov edx, l_cfres
    int 0x80

    jmp exit_p2
lvl_2:
    mov eax, 4
    mov ebx, 1
    mov ecx, c_soph
    mov edx, l_csoph
    int 0x80

    jmp exit_p2
lvl_3:
    mov eax, 4
    mov ebx, 1
    mov ecx, c_jun
    mov edx, l_cjun
    int 0x80

    jmp exit_p2
lvl_4:
    mov eax, 4
    mov ebx, 1
    mov ecx, c_sen
    mov edx, l_csen
    int 0x80

    jmp exit_p2
lvl_inv:
    mov eax, 4
    mov ebx, 1
    mov ecx, c_inv
    mov edx, l_cinv
    int 0x80

exit_p2:
    mov eax, 1
    xor ebx, ebx
    int 0x80

strip_nl:
    mov edi, ecx
.sloop:
    mov al, [edi]
    cmp al, 10
    je .sdone
    cmp al, 13
    je .sdone
    cmp al, 0
    je .sdone
    inc edi
    jmp .sloop
.sdone:
    mov byte [edi], 0
    ret

print_name_str:
    mov edi, name_buf
    xor ecx, ecx
.ploop:
    mov al, [edi + ecx]
    cmp al, 0
    je .pout
    inc ecx
    jmp .ploop
.pout:
    mov edx, ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, name_buf
    int 0x80
    ret

print_age_str:
    mov edi, age_buf
    xor ecx, ecx
.aloop:
    mov al, [edi + ecx]
    cmp al, 0
    je .aout
    inc ecx
    jmp .aloop
.aout:
    mov edx, ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, age_buf
    int 0x80
    ret