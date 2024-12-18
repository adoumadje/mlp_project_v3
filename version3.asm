SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1


%macro write_string 2
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

%macro read_string 2
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

section .data
    menu db "Select an option: ", 0xA
         db "1-addition(+)", 0xA
         db "2-substraction(-)", 0xA
         db "3-multiplication(*)", 0xA
         db "4-division(/)", 0xA
         db "5-increment(++)", 0xA
         db "6-decrement(--)", 0xA
         db "7-modulo(%)", 0xA
         db "8-exit", 0xA
         db "Your option: "
    len_menu equ $ - menu

    start_banner db "############# Start Operation ############", 0xA
    len_start_ban equ $ - start_banner

    end_banner db "############# End Operation ############", 0xA
    len_end_ban equ $ - end_banner

    num_prompt db "num = "
    len_num_prompt equ $ - num_prompt

    num1_prompt db "num1 = "
    len_num1_prompt equ $ - num1_prompt 

    num2_prompt db "num2 = "
    len_num2_prompt equ $ - num2_prompt 

    add_res db "num1 + num2 = "
    len_add_res equ $ - add_res

    sub_res db "num1 - num2 = "
    len_sub_res equ $ - sub_res

    mul_res db "num1 * num2 = "
    len_mul_res equ $ - mul_res

    div_res db "num1 / num2 = "
    len_div_res equ $ - div_res

    inc_res db "++num = "
    len_inc_res equ $ - inc_res

    dec_res db "--num = "
    len_dec_res equ $ - dec_res

    mod_res db "num1 % num2 = "
    len_mod_res equ $ - mod_res

section .bss
    option resb 2
    num resb 2
    num1 resb 2
    num2 resb 2
    res resb 2

section .text
    global _start 

_start

l0:
    write_string menu, len_menu
    read_string option, 2

    mov al, [option]

    cmp al, '1'
    je addition

    cmp al, '2'
    je substraction

    cmp al, '3'
    je multiplication

    cmp al, '4'
    je division

    cmp al, '5'
    je increment

    cmp al, '6'
    je decrement

    cmp al, '7'
    je modulo

    cmp al, '8'
    je _exit

    loop l0

addition:
    write_string start_banner, len_start_ban
    write_string num1_prompt, len_num1_prompt
    read_string num1, 2
    write_string num2_prompt, len_num2_prompt
    read_string num2, 2

    mov esi, 4      ;pointer
    mov ecx, 5      ;size
    clc

add_loop:
    mov al, [num1 + esi]
    adc al, [num2 + esi]
    aaa

    pushf

    or al, 30h

    popf

    mov [res + esi], al
    dec esi
    loop add_loop

    write_string add_res, len_add_res
    write_string res, 2
    ret

substraction:


multiplication:


division:


increment:
    

decrement:
    

modulo:


_exit:
    mov eax, SYS_EXIT
    int 0x80
