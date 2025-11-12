section .data
  title db "--- Calculadora baśica (dígito único) ---", 0xa, 0xa
  len_title equ $ - title

  msg1 db "Digite o primeiro número: ", 0xa
  len1 equ $ - msg1 
  
  msg2 db "Digite o segundo número: ", 0xa
  len2 equ $ - msg2
  
  menu db 0xa, "Insira a opção da operação desejada:", 0Ah, \
     "1- Soma", 0Ah, \
     "2- Subtração", 0Ah, \
     "3- Multiplicação", 0Ah, \
     "4- Divisão", 0Ah, \
     "", 0Ah, \
     "0- Sair", 0Ah, 0
  len_menu equ $ - menu
  
  res_msg db 0xa, "--- Resultado ---", 0xa 
  len_res equ $ - res_msg
  
  soma_msg db 0xa, "soma: "
  len_soma equ $ - soma_msg
  
  sub_msg db 0xa, "subtração: "
  len_sub equ $ - sub_msg
  
  mul_msg db 0xa, "multiplicaçao: "
  len_mul equ $ - mul_msg
  
  div_msg db 0xa, "divisão inteira: "
  len_div equ $ - div_msg
  
  sep db 0xa,  "----------------------------------------"
  len_sep equ $ - sep
  
  erro db 0xa, "Opção Inválida! Selecione uma das opções: "
  len_erro equ $ - erro
  
  menu_final_msg db 0xa, "Selecione uma opção: ", 0Ah, \
            "1- Realizar outra operação", 0Ah, \
            "0- Sair", 0Ah, 0
  len_final_msg equ $ - menu_final_msg
  
  exit_msg db 0xa, "Fim do programa."
  len_exit equ $ - exit_msg
  
section .bss
  num1 resb 3 
  num2 resb 3 
  resposta resb 2
  opcao resb 2

section .text
	global _start
	
_start:
  ; titulo
    mov eax, 4; sys_write
    mov ebx, 1; saída padrão
    mov ecx, title
    mov edx, len_title
    int 0x80; executa a sys_call 

  ; primeiro numero
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 0x80
	
	mov eax, 3; sys_read
	mov ebx, 0; entrada padrão 
	mov ecx, num1 
	mov edx, 2
	int 0x80
	
	; segundo numero
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 0x80
	
	mov eax, 3
	mov ebx, 0 
	mov ecx, num2
	mov edx, 2
	int 0x80
	
	; separador
	mov eax, 4
	mov ebx, 1
	mov ecx, sep
	mov edx, len_sep
	int 0x80
	jmp menu_selecao
	
menu_selecao:
	mov eax, 4 
	mov ebx, 1
	mov ecx, menu
	mov edx, len_menu
	int 0x80
	
	mov eax, 3
	mov ebx, 0
	mov ecx, opcao
	mov edx, 2
	int 0x80
	
comparacao:
    mov al, [opcao]
    cmp al, "1"
    je soma
    
    cmp al, "2"
    je subtracao
    
    cmp al, "3"
    je multiplicacao
    
    cmp al, "4"
    je divisao
    
    cmp al, "0"
    je exit
    
    jmp msg_erro
    
msg_erro:
    mov eax, 4
    mov ebx, 1
    mov ecx, erro
    mov edx, len_erro
    int 0x80
    jmp menu_selecao
    
menu_final:
    mov eax, 4
    mov ebx, 1
    mov ecx, sep
    mov edx, len_sep
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, menu_final_msg
    mov edx, len_final_msg
    int 0x80
    
    mov eax, 3
    mov ebx, 0 
    mov ecx, opcao
    mov edx, 2
    int 0x80
    
    mov al, [opcao]
    cmp al, "1"
    je _start
    
    jmp exit
	
soma:
  mov al, [num1]
  mov bl, [num2]
  sub al, '0'
  sub bl, '0'
  add al, bl
  add al, '0'
  mov [resposta], al
  
  mov eax ,4
  mov ebx, 1
  mov ecx, res_msg
  mov edx, len_res
  int 0x80
  
  mov eax, 4
  mov ebx, 1
  mov ecx, soma_msg
  mov edx, len_soma
  int 0x80
  
  mov eax, 4
  mov ebx, 1
  mov ecx, resposta
  mov edx, 2
  int 0x80
  jmp menu_final
  
subtracao:
  mov al, [num1]
  mov bl, [num2]
  sub al, '0'
  sub bl, '0'
  sub al, bl
  add al, '0'
  mov [resposta], al
  
  mov eax, 4
  mov ebx, 1
  mov ecx, sub_msg
  mov edx, len_sub
  int 0x80
 
  mov eax, 4
  mov ebx, 1
  mov ecx, resposta
  mov edx, 2
  int 0x80
  jmp menu_final
  
multiplicacao:
  mov al, [num1]
  mov bl, [num2]
  sub al, '0'
  sub bl, '0'
  mul bl
  add al, '0'
  mov [resposta], al
  
  mov eax, 4
  mov ebx, 1
  mov ecx, mul_msg
  mov edx, len_mul
  int 0x80
  
  mov eax, 4
  mov ebx, 1
  mov ecx, resposta
  mov edx, 2
  int 0x80 
  jmp menu_final
  
divisao:
  mov ah, 0
  mov al, [num1]
  mov bl, [num2]
  sub al, '0'
  sub bl, '0'
  div bl
  add al, '0'
  mov [resposta], al
  
  mov eax, 4
  mov ebx, 1
  mov ecx, div_msg
  mov edx, len_div
  int 0x80
  
  mov eax, 4
  mov ebx, 1
  mov ecx, resposta
  mov edx, 2
  int 0x80
  
  mov eax, 4
  mov ebx, 1
  mov ecx, sep
  mov edx, len_sep
  int 0x80
  jmp menu_final

exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, exit_msg
    mov edx, len_exit
    int 0x80

    mov eax, 1 
    mov ebx, 0
    int 0x80
