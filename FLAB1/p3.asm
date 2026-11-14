section .data
    prompt_name     db 'Enter student name: ', 0
    len_p_name      equ $ - prompt_name
    prompt_id       db 'Enter student ID: ', 0
    len_p_id        equ $ - prompt_id
    prompt_grade    db 'Enter grade: ', 0
    len_p_grade     equ $ - prompt_grade

    lbl_name        db 'Student Name: ', 0
    len_l_name      equ $ - lbl_name
    lbl_id          db 'Student ID: ', 0
    len_l_id        equ $ - lbl_id
    lbl_grade       db 'Grade: ', 0
    len_l_grade     equ $ - lbl_grade
    lbl_class       db 'Classification: ', 0
    len_l_class     equ $ - lbl_class

    cls_exc         db 'Excellent', 10, 0
    len_exc         equ $ - cls_exc
    cls_vgood       db 'Very Good', 10, 0
    len_vgood       equ $ - cls_vgood
    cls_good        db 'Good', 10, 0
    len_good        equ $ - cls_good
    cls_pass        db 'Passed', 10, 0
    len_pass        equ $ - cls_pass
    cls_fail        db 'Failed', 10, 0
    len_fail        equ $ - cls_fail
    cls_inv         db 'INVALID GRADE', 10, 0
    len_inv         equ $ - cls_inv
    newline         db 10

section .bss
    name_buf        resb 100
    name_len        resd 1
    id_buf          resb 32
    id_len          resd 1
    grade_buf       resb 16

section .text
    global _start

_start:
    ; Read Student Name
    mov ecx, prompt_name
    mov edx, len_p_name
    call print_str

    mov ecx, name_buf
    mov edx, 100
    call read_line
    mov [name_len], eax

    ; Read Student ID (as text to preserve leading zeros)
    mov ecx, prompt_id
    mov edx, len_p_id
    call print_str

    mov ecx, id_buf
    mov edx, 32
    call read_line
    mov [id_len], eax

    ; Read Grade String
    mov ecx, prompt_grade
    mov edx, len_p_grade
    call print_str

    mov ecx, grade_buf
    mov edx, 16
    call read_line

    ; Display Entered Details
    mov ecx, lbl_name
    mov edx, len_l_name
    call print_str
    mov ecx, name_buf
    mov edx, [name_len]
    call print_str
    call print_nl

    mov ecx, lbl_id
    mov edx, len_l_id
    call print_str
    mov ecx, id_buf
    mov edx, [id_len]
    call print_str
    call print_nl

    mov ecx, lbl_grade
    mov edx, len_l_grade
    call print_str
    mov esi, grade_buf
    call str_len
    mov ecx, grade_buf
    call print_str
    call print_nl

    ; Convert & Validate Grade (0-100)
    mov ecx, lbl_class
    mov edx, len_l_class
    call print_str

    mov esi, grade_buf
    call ascii_to_int
    cmp ebx, 1                  ; Check validation flag (1 = invalid)
    je .invalid_grade

    cmp eax, 0
    jl .invalid_grade
    cmp eax, 100
    jg .invalid_grade

    ; Grade Classification (Descending checks)
    cmp eax, 90
    jge .excellent
    cmp eax, 85
    jge .very_good
    cmp eax, 80
    jge .good
    cmp eax, 75
    jge .passed
    jmp .failed

.excellent:
    mov ecx, cls_exc
    mov edx, len_exc
    call print_str
    jmp .exit

.very_good:
    mov ecx, cls_vgood
    mov edx, len_vgood
    call print_str
    jmp .exit

.good:
    mov ecx, cls_good
    mov edx, len_good
    call print_str
    jmp .exit

.passed:
    mov ecx, cls_pass
    mov edx, len_pass
    call print_str
    jmp .exit

.failed:
    mov ecx, cls_fail
    mov edx, len_fail
    call print_str
    jmp .exit

.invalid_grade:
    mov ecx, cls_inv
    mov edx, len_inv
    call print_str

.exit:
    mov eax, 1                 
    xor ebx, ebx
    int 0x80

; --- Procedures ---

print_str:
    mov eax, 4                 
    mov ebx, 1               
    int 0x80
    ret

print_nl:
    mov ecx, newline
    mov edx, 1
    call print_str
    ret

read_line:
    mov eax, 3                
    mov ebx, 0               
    int 0x80
    test eax, eax
    jle .done
    dec eax
    cmp byte [ecx + eax], 10    ; Check for '\n'
    jne .restore
    mov byte [ecx + eax], 0     ; Null-terminate
    ret
.restore:
    inc eax
.done:
    ret

str_len:
    xor edx, edx
.loop:
    cmp byte [esi + edx], 0
    je .done
    inc edx
    jmp .loop
.done:
    ret

ascii_to_int:
    xor eax, eax
    xor ebx, ebx
    cmp byte [esi], 0           ; Empty input check
    je .error
.next_char:
    movzx ecx, byte [esi]
    test cl, cl
    jz .done
    cmp cl, '0'
    jl .error
    cmp cl, '9'
    jg .error
    sub cl, '0'
    imul eax, eax, 10
    add eax, ecx
    inc esi
    jmp .next_char
.error:
    mov ebx, 1
.done:
    ret