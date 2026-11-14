section .data
    prompt_name     db 'Enter account name: ', 0
    len_p_name      equ $ - prompt_name
    prompt_pin      db 'Enter PIN: ', 0
    len_p_pin       equ $ - prompt_pin
    prompt_amt      db 'Enter withdrawal amount: ', 0
    len_p_amt       equ $ - prompt_amt

    msg_denied      db 'ACCESS DENIED', 10, 0
    len_denied      equ $ - msg_denied
    msg_granted     db 'ACCESS GRANTED', 10, 0
    len_granted     equ $ - msg_granted
    msg_cur_bal     db 'Current Balance: PHP ', 0
    len_cur_bal     equ $ - msg_cur_bal

    msg_inv_amt     db 'INVALID AMOUNT', 10, 0
    len_inv_amt     equ $ - msg_inv_amt
    msg_insuff      db 'INSUFFICIENT FUNDS', 10, 0
    len_insuff      equ $ - msg_insuff
    msg_mult100     db 'AMOUNT MUST BE A MULTIPLE OF 100', 10, 0
    len_mult100     equ $ - msg_mult100

    msg_success     db 'WITHDRAWAL SUCCESSFUL', 10, 0
    len_success     equ $ - msg_success
    msg_withdrawn   db 'Amount Withdrawn: PHP ', 0
    len_withdrawn   equ $ - msg_withdrawn
    msg_rem_bal     db 'Remaining Balance: PHP ', 0
    len_rem_bal     equ $ - msg_rem_bal
    newline         db 10

    balance         dd 10000
    valid_pin       dd 1234

section .bss
    name_buf        resb 100
    pin_buf         resb 16
    amt_buf         resb 16
    num_buf         resb 16
    withdraw_amt    resd 1

section .text
    global _start

_start:
    ; Read Account Name
    mov ecx, prompt_name
    mov edx, len_p_name
    call print_str

    mov ecx, name_buf
    mov edx, 100
    call read_line

    ; Read & Verify PIN
    mov ecx, prompt_pin
    mov edx, len_p_pin
    call print_str

    mov ecx, pin_buf
    mov edx, 16
    call read_line

    mov esi, pin_buf
    call ascii_to_int
    cmp ebx, 1                  ; Non-numeric PIN check
    je .access_denied
    cmp eax, [valid_pin]        ; Compare against 1234
    jne .access_denied

    ; Access Granted & Show Balance
    mov ecx, msg_granted
    mov edx, len_granted
    call print_str

    mov ecx, msg_cur_bal
    mov edx, len_cur_bal
    call print_str
    mov eax, [balance]
    call print_int
    call print_nl

    ; Read Withdrawal Amount
    mov ecx, prompt_amt
    mov edx, len_p_amt
    call print_str

    mov ecx, amt_buf
    mov edx, 16
    call read_line

    mov esi, amt_buf
    call ascii_to_int
    cmp ebx, 1                  ; Non-numeric amount check
    je .invalid_amount
    cmp eax, 0                  ; Amount <= 0 check
    jle .invalid_amount

    mov [withdraw_amt], eax

    ; Check Sufficient Funds (Amount <= Balance)
    cmp eax, [balance]
    jg .insufficient_funds

    ; Check Multiple of 100 (Amount % 100 == 0)
    xor edx, edx                
    mov ecx, 100
    div ecx                    
    test edx, edx               
    jnz .not_multiple_100

    ; Process Withdrawal
    mov eax, [balance]
    sub eax, [withdraw_amt]     ; Deduct withdrawal amount
    mov [balance], eax

    mov ecx, msg_success
    mov edx, len_success
    call print_str

    mov ecx, msg_withdrawn
    mov edx, len_withdrawn
    call print_str
    mov eax, [withdraw_amt]
    call print_int
    call print_nl

    mov ecx, msg_rem_bal
    mov edx, len_rem_bal
    call print_str
    mov eax, [balance]
    call print_int
    call print_nl
    jmp .exit

.access_denied:
    mov ecx, msg_denied
    mov edx, len_denied
    call print_str
    jmp .exit

.invalid_amount:
    mov ecx, msg_inv_amt
    mov edx, len_inv_amt
    call print_str
    jmp .exit

.insufficient_funds:
    mov ecx, msg_insuff
    mov edx, len_insuff
    call print_str
    jmp .exit

.not_multiple_100:
    mov ecx, msg_mult100
    mov edx, len_mult100
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
    cmp byte [ecx + eax], 10
    jne .restore
    mov byte [ecx + eax], 0
    ret
.restore:
    inc eax
.done:
    ret

ascii_to_int:
    xor eax, eax
    xor ebx, ebx
    cmp byte [esi], 0
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

print_int:
    mov edi, num_buf + 15
    mov byte [edi], 0
    mov ebx, 10
.convert_loop:
    xor edx, edx
    div ebx                     
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz .convert_loop

    mov ecx, edi
    mov edx, num_buf + 15
    sub edx, edi                
    call print_str
    ret