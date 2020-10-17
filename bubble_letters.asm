;;; csc231.asm
;;; Sivan Nachum
;;; 
;;; Prints "CSC 231" to stdout as bubble letters!
;;;
;;; to assemble and run:
;;;
;;;     nasm -f elf csc231.asm
;;;     ld -melf_i386 -o csc231 csc231.o
;;;     ./csc231
;;; -------------------------------------------------------------------

 
        
    ;; ------------------------------------------------------------
	;; data areas
	;; ------------------------------------------------------------

	section	.data
	;; String variable
	;; The 10's indicate where linebreaks should be
	msg db "  ____ ____   ____   ____  _____ _ ", 10
	    db " / ___/ ___| / ___| |___ \|___ // |", 10
	    db "| | \___ \| |         __) | |_ \| |", 10
	    db "| |___ ___) | |___   / __/ ___) | |", 10
	    db " \____|____/ \____| |_____|____/|_|", 10
	;; Length between that spot and earlier label
	MSGLEN equ $-msg

	;; ------------------------------------------------------------
	;; code area
	;; ------------------------------------------------------------

	section	.text
	global	_start

_start:
	;; Code to output the string
    mov eax, 4
	mov ebx, 1
	;; Print the string
	mov ecx, msg 	; use the same name as the string in the data section
	mov edx, MSGLEN	; number of chars in string
	int 0x80

	;; exit()

	mov	eax,1
	mov	ebx,0
	int	0x80		; final system call
