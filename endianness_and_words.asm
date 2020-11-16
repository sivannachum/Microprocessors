;; Sample inputs:
;; 3108409701
;; 3109389662
;; 2824443240
;; 2790760293
;; 2722795845
;; 2823722341
;; 2890309485

;;; ; hw7_3.asm
;;; ;
;;; ; To assemble, link, and run:
;;; ; nasm -f elf hw7_3.asm
;;; ; ld -melf_i386 -o hw7_3 hw7_3.o 231Lib.o
;;; ; ./hw7_3
;;; ;
	extern _printString
	extern _println
	extern _getInput
	section .data
	prompt db "> "
	x dd 0
	section .text
	global _start
_start:
;;; ; display prompt
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, 2
	int 0x80
;;; ; get 32-bit integer, as a decimal
	call _getInput
;;; ; now int entered by user is in eax. Save in x
	mov dword[x], eax
;;; ; flip lower 4 bits of x
	xor byte[x], 0b00001111
;;; ; flip upper 4 bits of x+1
	xor byte[x+1], 0b11110000
;;; ; flip middle 4 bits of x+2
	xor byte[x+2], 0b00111100
;;; ; flip top leftmost 2 bits and bottom rightmost 2 bits of x+3
	xor byte[x+3], 0b11000011
;;; ; display x as a string of 4 ascii chars
	mov eax, 4
	mov ebx, 1
	mov ecx, x 		; address of "string"
	mov edx, 4 		; number of chars: 1 int = 4 bytes
	int 0x80
	call _println 		; print a line-feed
;;; ; exit
	mov ebx, 0
	mov eax, 1
	int 0x80
