;;; ; hw8_2.asm
;;; ;
;;; ; Capitalizes letters in a given string and
;;; ; changes periods to exclamation points
;;; ; To assemble, link, and run:
;;; ; nasm -f elf hw8_2.asm
;;; ; ld -melf_i386 -o hw8_2 hw8_2.o 231Lib.o
;;; ; ./hw8_2
;;; ;
	extern _println
	extern _getString
	section .data
	prompt db "> "

	section .text
	global _start
_start:
;;; ; ; display prompt
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, 2
	int 0x80
;;; ; ; get 32-bit integer, as a decimal
	call _getString
;;; ; ; now the address of the string entered by user is in ecx
;;; ; ; and the number of chars read in is in edx

;;; ; ; No need to go through the loop if the input string has length zero
	cmp edx, 0
	jz stoploop
;;; ; ; copy the address of the string to ebx,
;;; ; ; to change it during the loop
	mov ebx, ecx

;;; ; ; store end address of string in eax
;;; ; ;	(more particularly the first address not part of the string)
	mov eax, ecx
	add eax, edx
;;; ; ; now if eax equals ebx, we stop looping

loopsection:
;;; ; ; check if this is a lowercase alphabet character
;;; ; ; if it is, make it uppercase
	cmp byte[ebx], 97
	jl  notlowercase
	cmp byte[ebx], 122
	jg notlowercase
;;; ; ; if lowercase, the corresponding uppercase character is 32 less
;;; ; ; (as an int)
	sub byte[ebx], 32
	jmp checkloop
	
notlowercase:	
;;; ; ; check if this is a period
;;; ; ; if it is, make it an exclamation point
	cmp byte[ebx], 46
	jnz checkloop
	mov byte[ebx], 33
	
;;; ; ; check if we should still be looping
checkloop:
;;; ; ; increment ebx by 1 byte and
;;; ; ; stop looping if ebx has reached the end of the string
	inc ebx
	cmp eax, ebx
	jz stoploop
	jmp loopsection

stoploop:
;;; ; ; display string 
        mov eax, 4
        mov ebx, 1
;;; ; ; recall ecx already has the address of the string
;;; ; ; and edx already has the length of the string
        int 0x80
	call _println
	
;;; ; ; exit
	mov ebx, 0
	mov eax, 1
	int 0x80
