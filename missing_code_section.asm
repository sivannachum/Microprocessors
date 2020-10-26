;;; ; ; hw6_2.asm
;;; ; ; your name(s) here
;;; ; ;
;;; ; ; a description of the program
;;; ; ;
;;; ; ; to assemble and run:
;;; ; ;
;;; ; ; nasm -f elf hw6_2.asm
;;; ; ; ld -melf_i386 -o hw6_2 hw6_2.o
;;; ; ; ./hw6_2
;;; ; ; -------------------------------------------------------------------
;;; ; ------------------------------------------------------------
;;; ; data areas
;;; ; ------------------------------------------------------------
	section .data
plus db "+ | "
msg1 db "Assembly"
message db "hello there", 10, 10
	db "******--------------------------------*****"
msg2 db "CSC231a"
lf db 10
msg3 db " Language"
msg4 db "|"


;;; ; ------------------------------------------------------------
;;; ; code area
;;; ; ------------------------------------------------------------
	section .text
	global _start
_start:
;;; ; ---- DO NOT EDIT ABOVE THIS LINE
	;; Print "+"
	mov eax, 4
	mov ebx, 1
	mov ecx, plus
	mov edx, 1
	int 0x80

	;; Print the "---" string
	mov eax, 4
	mov ebx, 1
	mov ecx, message+19
	mov edx, 19
	int 0x80

	;; Print "+"
	mov eax, 4
	mov ebx, 1
	mov ecx, plus
	mov edx, 1
	int 0x80

	;; Print a line break
	mov eax, 4
	mov ebx, 1
	mov ecx, lf
	mov edx, 1
	int 0x80

	;; Print "| "
	mov eax, 4
	mov ebx, 1
	mov ecx, plus+2
	mov edx, 2
	int 0x80

	;; Print "Assembly"
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, 8
	int 0x80

	;; Print "Language"
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, 9
	int 0x80

	;; Print " |"
	mov eax, 4
	mov ebx, 1
	mov ecx, plus+1
	mov edx, 2
	int 0x80
	
	;; Print a line break
	mov eax, 4
	mov ebx, 1
	mov ecx, lf
	mov edx, 1
	int 0x80

	;;  Print "+"
	mov eax, 4
	mov ebx, 1
	mov ecx, plus
	mov edx, 1
	int 0x80

	;;  Print the "---" string
	mov eax, 4
	mov ebx, 1
	mov ecx, message+19
	mov edx, 19
	int 0x80

	;;  Print "+"
	mov eax, 4
	mov ebx, 1
	mov ecx, plus
	mov edx, 1
	int 0x80

	;;  Print a line break
	mov eax, 4
	mov ebx, 1
	mov ecx, lf
	mov edx, 1
	int 0x80
	
;;; ; ---- DO NOT EDIT BELOW THIS LINE
;;; ; exit()
	mov eax,1
	mov ebx,0
	int 0x80 		; final system call
