section .data
    ; --- Welcome Banner ---
    welcome_msg     db "=======================================", 10
                    db "       THE MYSTIC ZODIAC ORACLE", 10
                    db "=======================================", 10
                    db "             *       *", 10
                    db "          *     /\     *", 10
                    db "               /  \", 10
                    db "         *    /____\    *", 10
                    db "               |  |", 10
                    db "           *   |__|   *", 10
                    db "       DISCOVER YOUR DESTINY!", 10
                    db "=======================================", 10, 0
    len_welcome     equ $ - welcome_msg

    ; --- Prompts & Error Messages ---
    prompt_name     db 10, "Enter your name: ", 0
    len_p_name      equ $ - prompt_name
    prompt_month    db "Enter birth month (1-12): ", 0
    len_p_month     equ $ - prompt_month
    prompt_day      db "Enter birth day (1-31): ", 0
    len_p_day       equ $ - prompt_day

    err_month       db "Invalid month! Please enter a value between 1 and 12.", 10, 0
    len_err_month   equ $ - err_month
    err_date        db "Invalid date for the given month! Please try again.", 10, 0
    len_err_date    equ $ - err_date
    err_menu        db "Invalid selection! Please choose 1-6.", 10, 0
    len_err_menu    equ $ - err_menu

    msg_hello       db 10, "Welcome, ", 0
    len_hello       equ $ - msg_hello
    msg_bang        db "!", 10, 0
    len_bang        equ $ - msg_bang

    zodiac_header   db 10, "=======================================", 10
                    db "         YOUR ZODIAC SIGN", 10
                    db "=======================================", 10, 0
    len_z_hdr       equ $ - zodiac_header

    ; --- Horoscope Menu ---
    menu_msg        db 10, "Horoscope Menu:", 10
                    db "[1] Love and Relationships", 10
                    db "[2] Career and Studies", 10
                    db "[3] Health and Wellness", 10
                    db "[4] Lucky Number and Color", 10
                    db "[5] View Zodiac Information", 10
                    db "[6] Exit", 10
                    db "Enter your choice: ", 0
    len_menu        equ $ - menu_msg

    prompt_return   db 10, "Return to menu? (Y/N): ", 0
    len_p_return    equ $ - prompt_return

    msg_goodbye     db 10, "May the stars guide your path. Goodbye!", 10, 0
    len_goodbye     equ $ - msg_goodbye
    newline         db 10

    ; --- Days per Month Lookup Table (1-indexed via offset) ---
    days_in_month   db 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

    ; --- Zodiac ASCII Art & Details (IDs 0 to 11) ---
    ; 0: Capricorn (Dec 22 - Jan 19)
    art_cap         db "              _.._ ", 10
                    db "             /    \ ", 10
                    db "            | (__) |  (Sea-Goat)", 10
                    db "             \____/ ", 10
                    db "Zodiac Sign: CAPRICORN", 10
                    db "Element: Earth", 10
                    db "Symbol: Sea-Goat", 10
                    db "Personality: Disciplined, responsible, ambitious.", 10, 0
    len_cap         equ $ - art_cap

    ; 1: Aquarius (Jan 20 - Feb 18)
    art_aqu         db "             ~ ~ ~ ~", 10
                    db "             ~ ~ ~ ~  (Water Bearer)", 10
                    db "             ~ ~ ~ ~", 10
                    db "Zodiac Sign: AQUARIUS", 10
                    db "Element: Air", 10
                    db "Symbol: Water Bearer", 10
                    db "Personality: Innovative, independent, humanitarian.", 10, 0
    len_aqu         equ $ - art_aqu

    ; 2: Pisces (Feb 19 - Mar 20)
    art_pis         db "             ><(((('>", 10
                    db "             <')))><  (Two Fish)", 10
                    db "Zodiac Sign: PISCES", 10
                    db "Element: Water", 10
                    db "Symbol: Fish", 10
                    db "Personality: Compassionate, artistic, intuitive.", 10, 0
    len_pis         equ $ - art_pis

    ; 3: Aries (Mar 21 - Apr 19)
    art_ari         db "              .---. ", 10
                    db "             /     \  (Ram Horns)", 10
                    db "            (       )", 10
                    db "Zodiac Sign: ARIES", 10
                    db "Element: Fire", 10
                    db "Symbol: Ram", 10
                    db "Personality: Bold, energetic, courageous.", 10, 0
    len_ari         equ $ - art_ari

    ; 4: Taurus (Apr 20 - May 20)
    art_tau         db "             \     /", 10
                    db "              (o o)   (Bull)", 10
                    db "               (_) ", 10
                    db "Zodiac Sign: TAURUS", 10
                    db "Element: Earth", 10
                    db "Symbol: Bull", 10
                    db "Personality: Reliable, patient, devoted.", 10, 0
    len_tau         equ $ - art_tau

    ; 5: Gemini (May 21 - Jun 20)
    art_gem         db "             II   II", 10
                    db "             II   II  (Twins)", 10
                    db "             II   II", 10
                    db "Zodiac Sign: GEMINI", 10
                    db "Element: Air", 10
                    db "Symbol: Twins", 10
                    db "Personality: Curious, adaptable, expressive.", 10, 0
    len_gem         equ $ - art_gem

    ; 6: Cancer (Jun 21 - Jul 22)
    art_can         db "              _.-._", 10
                    db "            ( (o o) ) (Crab)", 10
                    db "             '-._.-'", 10
                    db "Zodiac Sign: CANCER", 10
                    db "Element: Water", 10
                    db "Symbol: Crab", 10
                    db "Personality: Nurturing, loyal, protective.", 10, 0
    len_can         equ $ - art_can

    ; 7: Leo (Jul 23 - Aug 22)
    art_leo         db "              /\_/\", 10
                    db "             ( o.o )", 10
                    db "              > ^ <", 10
                    db "Zodiac Sign: LEO", 10
                    db "Element: Fire", 10
                    db "Symbol: Lion", 10
                    db "Personality: Confident, creative, courageous.", 10, 0
    len_leo         equ $ - art_leo

    ; 8: Virgo (Aug 23 - Sep 22)
    art_vir         db "              ( * )", 10
                    db "              /| |\   (Maiden)", 10
                    db "               / \", 10
                    db "Zodiac Sign: VIRGO", 10
                    db "Element: Earth", 10
                    db "Symbol: Maiden", 10
                    db "Personality: Analytical, kind, hardworking.", 10, 0
    len_vir         equ $ - art_vir

    ; 9: Libra (Sep 23 - Oct 22)
    art_lib         db "              __|__", 10
                    db "             /     \  (Scales)", 10
                    db "            ---   ---", 10
                    db "Zodiac Sign: LIBRA", 10
                    db "Element: Air", 10
                    db "Symbol: Scales", 10
                    db "Personality: Diplomatic, fair-minded, social.", 10, 0
    len_lib         equ $ - art_lib

    ; 10: Scorpio (Oct 23 - Nov 21)
    art_sco         db "             _.._", 10
                    db "            (____)--> (Scorpion)", 10
                    db "Zodiac Sign: SCORPIO", 10
                    db "Element: Water", 10
                    db "Symbol: Scorpion", 10
                    db "Personality: Passionate, resourceful, determined.", 10, 0
    len_sco         equ $ - art_sco

    ; 11: Sagittarius (Nov 22 - Dec 21)
    art_sag         db "                /|", 10
                    db "             --/---->", 10
                    db "                \|    (Archer)", 10
                    db "Zodiac Sign: SAGITTARIUS", 10
                    db "Element: Fire", 10
                    db "Symbol: Archer", 10
                    db "Personality: Optimistic, adventurous, honest.", 10, 0
    len_sag         equ $ - art_sag

    ; --- Horoscope Category Texts ---
    horo_love       db 10, "LOVE AND RELATIONSHIPS HOROSCOPE", 10
                    db "Open communication brings warmth and clarity to your close", 10
                    db "connections today. Listen with patience and trust your heart.", 10, 0
    len_h_love      equ $ - horo_love

    horo_career     db 10, "CAREER AND STUDIES HOROSCOPE", 10
                    db "Your creativity and discipline will help you solve a difficult", 10
                    db "problem today. Stay focused and confident in your abilities!", 10, 0
    len_h_career    equ $ - horo_career

    horo_health     db 10, "HEALTH AND WELLNESS HOROSCOPE", 10
                    db "Balance your energy with proper rest and hydration.", 10
                    db "A short walk outdoors will refresh both mind and body.", 10, 0
    len_h_health    equ $ - horo_health

    horo_lucky      db 10, "LUCKY NUMBER AND COLOR", 10
                    db "Lucky Number: 7", 10
                    db "Lucky Color: Royal Gold", 10, 0
    len_h_lucky     equ $ - horo_lucky

section .bss
    name_buf        resb 64
    name_len        resd 1
    num_buf         resb 16
    choice_buf      resb 8
    birth_month     resd 1
    birth_day       resd 1
    zodiac_id       resd 1      ; 0=Capricorn .. 11=Sagittarius

section .text
    global _start

_start:
    call display_welcome
    call get_user_info
    call determine_zodiac
    call display_zodiac_art

.menu_loop:
    call display_menu
    call show_horoscope
    jmp .menu_loop

; ==============================================================================
; PROCEDURE 1: display_welcome
; Display welcome ASCII art
; ==============================================================================
display_welcome:
    mov ecx, welcome_msg
    mov edx, len_welcome
    call print_str
    ret

; ==============================================================================
; PROCEDURE 2: get_user_info
; Read name and birth date
; ==============================================================================
get_user_info:
    ; Read Name
    mov ecx, prompt_name
    mov edx, len_p_name
    call print_str

    mov ecx, name_buf
    mov edx, 64
    call read_line
    mov [name_len], eax

.read_date_loop:
    ; Read Month
    mov ecx, prompt_month
    mov edx, len_p_month
    call print_str

    mov ecx, num_buf
    mov edx, 16
    call read_line

    mov esi, num_buf
    call ascii_to_int
    cmp ebx, 1
    je .invalid_month
    mov [birth_month], eax

    ; Read Day
    mov ecx, prompt_day
    mov edx, len_p_day
    call print_str

    mov ecx, num_buf
    mov edx, 16
    call read_line

    mov esi, num_buf
    call ascii_to_int
    cmp ebx, 1
    je .invalid_day
    mov [birth_day], eax

    ; Validate Month and Day via procedure
    call validate_birthdate
    cmp eax, 1                  ; 1 = valid, 0 = invalid month, 2 = invalid day
    je .date_valid
    cmp eax, 0
    je .invalid_month

.invalid_day:
    mov ecx, err_date
    mov edx, len_err_date
    call print_str
    jmp .read_date_loop

.invalid_month:
    mov ecx, err_month
    mov edx, len_err_month
    call print_str
    jmp .read_date_loop

.date_valid:
    mov ecx, msg_hello
    mov edx, len_hello
    call print_str

    mov ecx, name_buf
    mov edx, [name_len]
    call print_str

    mov ecx, msg_bang
    mov edx, len_bang
    call print_str
    ret

; ==============================================================================
; PROCEDURE 3: validate_birthdate
; Check date validity
; ==============================================================================
validate_birthdate:
    mov ecx, [birth_month]
    cmp ecx, 1
    jl .bad_month
    cmp ecx, 12
    jg .bad_month

    mov edx, [birth_day]
    cmp edx, 1
    jl .bad_day

    movzx eax, byte [days_in_month + ecx]
    cmp edx, eax
    jg .bad_day

    mov eax, 1
    ret

.bad_month:
    xor eax, eax
    ret

.bad_day:
    mov eax, 2
    ret

; ==============================================================================
; PROCEDURE 4: determine_zodiac
; Identify Zodiac Sign
; ==============================================================================
determine_zodiac:
    mov eax, [birth_month]
    mov ebx, [birth_day]

    cmp eax, 1
    je .jan
    cmp eax, 2
    je .feb
    cmp eax, 3
    je .mar
    cmp eax, 4
    je .apr
    cmp eax, 5
    je .may
    cmp eax, 6
    je .jun
    cmp eax, 7
    je .jul
    cmp eax, 8
    je .aug
    cmp eax, 9
    je .sep
    cmp eax, 10
    je .oct
    cmp eax, 11
    je .nov
    jmp .dec

.jan:
    cmp ebx, 19
    jle .set_cap
    jmp .set_aqu
.feb:
    cmp ebx, 18
    jle .set_aqu
    jmp .set_pis
.mar:
    cmp ebx, 20
    jle .set_pis
    jmp .set_ari
.apr:
    cmp ebx, 19
    jle .set_ari
    jmp .set_tau
.may:
    cmp ebx, 20
    jle .set_tau
    jmp .set_gem
.jun:
    cmp ebx, 20
    jle .set_gem
    jmp .set_can
.jul:
    cmp ebx, 22
    jle .set_can
    jmp .set_leo
.aug:
    cmp ebx, 22
    jle .set_leo
    jmp .set_vir
.sep:
    cmp ebx, 22
    jle .set_vir
    jmp .set_lib
.oct:
    cmp ebx, 22
    jle .set_lib
    jmp .set_sco
.nov:
    cmp ebx, 21
    jle .set_sco
    jmp .set_sag
.dec:
    cmp ebx, 21
    jle .set_sag
    jmp .set_cap

.set_cap: mov dword [zodiac_id], 0
          ret
.set_aqu: mov dword [zodiac_id], 1
          ret
.set_pis: mov dword [zodiac_id], 2
          ret
.set_ari: mov dword [zodiac_id], 3
          ret
.set_tau: mov dword [zodiac_id], 4
          ret
.set_gem: mov dword [zodiac_id], 5
          ret
.set_can: mov dword [zodiac_id], 6
          ret
.set_leo: mov dword [zodiac_id], 7
          ret
.set_vir: mov dword [zodiac_id], 8
          ret
.set_lib: mov dword [zodiac_id], 9
          ret
.set_sco: mov dword [zodiac_id], 10
          ret
.set_sag: mov dword [zodiac_id], 11
          ret

; ==============================================================================
; PROCEDURE 5: display_zodiac_art
; Display sign-specific ASCII art
; ==============================================================================
display_zodiac_art:
    mov ecx, zodiac_header
    mov edx, len_z_hdr
    call print_str

    mov eax, [zodiac_id]
    cmp eax, 0
    je .p_cap
    cmp eax, 1
    je .p_aqu
    cmp eax, 2
    je .p_pis
    cmp eax, 3
    je .p_ari
    cmp eax, 4
    je .p_tau
    cmp eax, 5
    je .p_gem
    cmp eax, 6
    je .p_can
    cmp eax, 7
    je .p_leo
    cmp eax, 8
    je .p_vir
    cmp eax, 9
    je .p_lib
    cmp eax, 10
    je .p_sco
    jmp .p_sag

.p_cap: mov ecx, art_cap
        mov edx, len_cap
        jmp .do_print
.p_aqu: mov ecx, art_aqu
        mov edx, len_aqu
        jmp .do_print
.p_pis: mov ecx, art_pis
        mov edx, len_pis
        jmp .do_print
.p_ari: mov ecx, art_ari
        mov edx, len_ari
        jmp .do_print
.p_tau: mov ecx, art_tau
        mov edx, len_tau
        jmp .do_print
.p_gem: mov ecx, art_gem
        mov edx, len_gem
        jmp .do_print
.p_can: mov ecx, art_can
        mov edx, len_can
        jmp .do_print
.p_leo: mov ecx, art_leo
        mov edx, len_leo
        jmp .do_print
.p_vir: mov ecx, art_vir
        mov edx, len_vir
        jmp .do_print
.p_lib: mov ecx, art_lib
        mov edx, len_lib
        jmp .do_print
.p_sco: mov ecx, art_sco
        mov edx, len_sco
        jmp .do_print
.p_sag: mov ecx, art_sag
        mov edx, len_sag

.do_print:
    call print_str
    ret

; ==============================================================================
; PROCEDURE 6: display_menu
; Display horoscope choices
; ==============================================================================
display_menu:
    mov ecx, menu_msg
    mov edx, len_menu
    call print_str
    ret

; ==============================================================================
; PROCEDURE 7: show_horoscope
; Select and show prediction
; ==============================================================================
show_horoscope:
    mov ecx, choice_buf
    mov edx, 8
    call read_line

    mov esi, choice_buf
    call ascii_to_int
    cmp ebx, 1
    je .bad_choice

    cmp eax, 1
    je .opt_love
    cmp eax, 2
    je .opt_career
    cmp eax, 3
    je .opt_health
    cmp eax, 4
    je .opt_lucky
    cmp eax, 5
    je .opt_info
    cmp eax, 6
    je .opt_exit

.bad_choice:
    mov ecx, err_menu
    mov edx, len_err_menu
    call print_str
    ret

.opt_love:
    mov ecx, horo_love
    mov edx, len_h_love
    call print_str
    jmp .ask_return

.opt_career:
    mov ecx, horo_career
    mov edx, len_h_career
    call print_str
    jmp .ask_return

.opt_health:
    mov ecx, horo_health
    mov edx, len_h_health
    call print_str
    jmp .ask_return

.opt_lucky:
    mov ecx, horo_lucky
    mov edx, len_h_lucky
    call print_str
    jmp .ask_return

.opt_info:
    call display_zodiac_art
    jmp .ask_return

.opt_exit:
    call exit_program

.ask_return:
    mov ecx, prompt_return
    mov edx, len_p_return
    call print_str

    mov ecx, choice_buf
    mov edx, 8
    call read_line

    mov al, [choice_buf]
    cmp al, 'N'
    je .opt_exit
    cmp al, 'n'
    je .opt_exit
    ret

; ==============================================================================
; PROCEDURE 8: exit_program
; Terminate program
; ==============================================================================
exit_program:
    mov ecx, msg_goodbye
    mov edx, len_goodbye
    call print_str

    mov eax, 1                  ; sys_exit
    xor ebx, ebx                ; status 0
    int 0x80


print_str:
    mov eax, 4                  ; sys_write
    mov ebx, 1                  ; stdout
    int 0x80
    ret

read_line:
    mov eax, 3                  ; sys_read
    mov ebx, 0                  ; stdin
    int 0x80
    test eax, eax
    jle .done
    dec eax
    cmp byte [ecx + eax], 10    ; Strip trailing newline
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
    je .err
.loop:
    movzx ecx, byte [esi]
    test cl, cl
    jz .ok
    cmp cl, '0'
    jl .err
    cmp cl, '9'
    jg .err
    sub cl, '0'
    imul eax, eax, 10
    add eax, ecx
    inc esi
    jmp .loop
.err:
    mov ebx, 1
.ok:
    ret