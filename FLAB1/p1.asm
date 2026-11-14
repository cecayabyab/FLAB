section .data
    prompt_name db "What is your name? ", 0
    len_pname   equ $ - prompt_name
    prompt_age  db "How old are you? ", 0
    len_page    equ $ - prompt_age
    prompt_gen  db "What is your gender? ", 0
    len_pgen    equ $ - prompt_gen

    msg_hello   db "Hello, ", 0
    len_mhello  equ $ - msg_hello
    msg_age     db "! You are ", 0
    len_mage    equ $ - msg_age
    msg_yrs     db " years old", 10, 0
    len_myrs    equ $ - msg_yrs

    ans_m       db "Hello", 10, 0
    len_am      equ $ - ans_m
    ans_w       db "World", 10, 0
    len_aw      equ $ - ans_w
    ans_inv     db "INVALID", 10, 0
    len_ainv    equ $ - ans_inv

section .bss
    name_buf    resb 64
    age_buf     resb 16
    gen_buf     resb 8

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_name
    mov edx, len_pname
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, name_buf
    mov edx, 64
    int 0x80
    mov esi, eax            

    call strip_newline

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_age
    mov edx, len_page
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, age_buf
    mov edx, 16
    int 0x80
    call strip_newline

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_gen
    mov edx, len_pgen
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, gen_buf
    mov edx, 8
    int 0x80
    call strip_newline

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_hello
    mov edx, len_mhello
    int 0x80

    call print_name

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_age
    mov edx, len_mage
    int 0x80

    call print_age

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_yrs
    mov edx, len_myrs
    int 0x80

    mov al, [gen_buf]
    cmp al, 'M'
    je is_male
    cmp al, 'm'
    je is_male
    cmp al, 'F'
    je is_female
    cmp al, 'f'
    je is_female
    jmp is_invalid

is_male:
    mov eax, 4
    mov ebx, 1
    mov ecx, ans_m
    mov edx, len_am
    int 0x80
    jmp exit_prog

is_female:
    mov eax, 4
    mov ebx, 1
    mov ecx, ans_w
    mov edx, len_aw
    int 0x80
    jmp exit_prog

is_invalid:
    mov eax, 4
    mov ebx, 1
    mov ecx, ans_inv
    mov edx, len_ainv
    int 0x80

exit_prog:
    mov eax, 1
    xor ebx, ebx
    int 0x80

strip_newline:
    mov edi, ecx            
.find_nl:
    mov al, [edi]
    cmp al, 10
    je .found
    cmp al, 13
    je .found
    cmp al, 0
    je .done
    inc edi
    jmp .find_nl
.found:
    mov byte [edi], 0
.done:
    ret

print_name:
    mov edi, name_buf
    xor ecx, ecx
.count_loop:
    mov al, [edi + ecx]
    cmp al, 0
    je .print_out
    inc ecx
    jmp .count_loop
.print_out:
    mov edx, ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, name_buf
    int 0x80
    ret

print_age:
    mov edi, age_buf
    xor ecx, ecx
.count_age:
    mov al, [edi + ecx]
    cmp al, 0
    je .print_age_out
    inc ecx
    jmp .count_age
.print_age_out:
    mov edx, ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, age_buf
    int 0x80
    ret