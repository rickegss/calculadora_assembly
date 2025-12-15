# Calculadora de Inteiros em Assembly x86 (Linux)

Este repositório contém o código-fonte de uma calculadora básica desenvolvida em **Assembly NASM** para a arquitetura **IA-32 (x86)**, utilizando chamadas de sistema (syscalls) do kernel Linux.

O projeto foi desenvolvido como parte da avaliação prática da disciplina de **Arquitetura e Organização de Computadores** (2º Período) da **UNIFAN**.

## 📋 Visão Geral

O programa opera em baixo nível, manipulando diretamente registradores e memória para realizar operações aritméticas com números de um dígito. O fluxo de controle é gerenciado através de saltos condicionais e interrupções de software (`int 0x80`).

### Funcionalidades Implementadas

O sistema apresenta um menu interativo que permite ao usuário selecionar:

1.  **Soma (+)**
2.  **Subtração (-)**
3.  **Multiplicação (*)**
4.  **Divisão Inteira (/)**

### 🔄 Requisito Adicional: Manipulação de Memória (Loop)

Conforme solicitado na especificação da atividade, foi implementada uma rotina de repetição (`loop_`) ao final de cada operação matemática.

Esta rotina tem a função de:
* Capturar o resultado da operação armazenado em memória;
* **Incrementar este valor duas vezes consecutivas**;
* Exibir os caracteres ASCII subsequentes ao resultado original na saída padrão.

Este trecho demonstra o uso prático de contadores (`contador`), comparação de registradores e laços de repetição em Assembly.

## 🛠️ Tecnologias e Ferramentas

* **Linguagem:** Assembly (Intel Syntax)
* **Compilador/Montador:** NASM (Netwide Assembler)
* **Linker:** GNU ld
* **Plataforma:** Linux

## 🚀 Como Compilar e Executar

Como o código utiliza a arquitetura de 32 bits, é necessário utilizar as flags de compatibilidade `elf32` e `elf_i386` durante a montagem e linkedição.

Execute os comandos abaixo no terminal:

**1. Montar o código objeto:**
```bash
nasm -f elf32 calc.asm -o calc.o
```
**2. Linkar o executável:**
```bash

ld -m elf_i386 calc.o -o calc
```
**3. Executar o programa:**
```bash
./calc
```

### ⚠️ Notas de Utilização
 **Entrada:** O programa foi projetado para aceitar entradas de um único dígito (0-9).

 **Saída:** Devido à manipulação direta da tabela ASCII sem rotinas complexas de conversão de string-to-int, os resultados são exibidos corretamente quando resultam em um único dígito. Resultados maiores que 9 exibirão o caractere correspondente na tabela ASCII.
