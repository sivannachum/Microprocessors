;; Sample inputs:
;; 1
;; 2824443240

;; 4
;; 3075841372
;; 2894057575
;; 2757336163
;; 3810316394

;;; ; ; endianness_and_words_2.asm
;;; ; ;
;;; ; ; To assemble, link, and run:
;;; ; ; nasm -f elf endianness_and_words_2.asm
;;; ; ; ld -melf_i386 -o endianness_and_words_2 endianness_and_words_2.o 231Lib.o
;;; ; ; ./endianness_and_words_2
;;; ; ;
	extern _printString
	extern _println
	extern _getInput
	section .data
	prompt db "> "
	n dd 0
;;; ; ; this keeps track of where we are in thestring
	offset dd 0

;;; ; ; save enough space for at least 64 ints
;;; ; ; (each int is 4 bytes, or a double word)
	section .bss
	thestring resd 64
	
	section .text
	global _start
_start:
;;; ; ; display prompt for n
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, 2
	int 0x80
;;; ; ; get 32-bit integer, as a decimal
	call _getInput
;;; ; ; now int entered by user is in eax. Save in n
	mov dword[n], eax

;;; ; ; if the int is zero or negative, just exit
	cmp dword[n], 0
	jle noloop

;;; ; ; we will go through the loop section prompting for int inputs n times
	mov ecx, dword[n]

loopsection:
;;; ; ; need ecx for the prompt, but its current value is needed for looping
;;; ; ; so save it on the stack
	push ecx
;;; ; ; display prompt
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, 2
	int 0x80
;;; ; ; get 32-bit integer, as a decimal
	call _getInput
;;; ; ; now int entered by user is in eax. Save in thestring+a
;;; ; ; need to put a in ebx to be able to use it
	mov ebx, dword[offset]
	mov dword[thestring+ebx], eax
	
;;; ; ; flip lower 4 bits of the input
	xor byte[thestring+ebx], 0b00001111
;;; ; ; flip upper 4 bits of the input + 1
	xor byte[thestring+ebx+1], 0b11110000
;;; ; ; flip middle 4 bits of the input + 2
	xor byte[thestring+ebx+2], 0b00111100
;;; ; ; flip top leftmost 2 bits and bottom rightmost 2 bits of the input + 3
	xor byte[thestring+ebx+3], 0b11000011
;;; ; ; increase a by four bytes to prepare for the next input
	add dword[offset], 4
;;; ; ; get ecx off the stack for looping purposes
	pop ecx

	loop loopsection
	
;;; ; ; display thestring as a string of 4n ascii chars
	mov eax, 4
	mov ebx, 1
	mov ecx, thestring 	; address of "string"
	mov edx, dword[n] 	; number of chars: n ints = 4n bytes
	add edx, dword[n]
	add edx, dword[n]
	add edx, dword[n]
	int 0x80
	call _println 		; print a line-feed

noloop:	
;;; ; ; exit
	mov ebx, 0
	mov eax, 1
	int 0x80
	
