section .data
  msg1 db "Digite o primeiro número: ", 0xa
  len1 equ $ - msg1 
  
  msg2 db "Digite o segundo número: ", 0xa
  len2 equ $ - msg2
  
  res_msg db "Resultado: ", 0xa  
  len_res equ $ - res_msg
  
  soma_msg db "soma: "
  len_soma equ $ - soma_msg
  
  sub_msg db 0xa, "subtração: "
  len_sub equ $ - sub_msg
  
  mul_msg db 0xa, "multiplicaçao: "
  len_mul equ $ - mul_msg
  
  div_msg db 0xa, "divisão: "
  len_div equ $ - div_msg
  
section .bss
  num1 resb 2 
  num2 resb 2 
  resposta resb 2

section .text
	global _start
	
_start:
  ; primeiro numero
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 0x80
	
	mov eax, 3
	mov ebx, 0 
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
	
soma:
  mov al, [num1]
  mov bl, [num2]
  sub al, '0'
  sub bl, '0'
  add al, bl
  add al, '0'
  mov [resposta], al
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
  
subtracao:
  mov al, [num1]
  mov bl, [num2]
  sub al, '0'
  sub bl, '0'
  sub al, bl
  add al, '0'
  mov [resposta], al
  int 0x80
  
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
  
multiplicacao:
  mov al, [num1]
  mov bl, [num2]
  sub al, '0'
  sub bl, '0'
  mul bl
  add al, '0'
  mov [resposta], al
  int 0x80
  
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
  
divisao:
  mov al, [num1]
  mov bl, [num2]
  sub al, '0'
  sub bl, '0'
  div bl
  add al, '0'
  mov [resposta], al
  int 0x80
  
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

exit:
  mov eax, 1 
  mov ebx, 0
  int 0x80
