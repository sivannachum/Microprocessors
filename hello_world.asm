;;; program_name.asm
;;; your name
;;; 
;;; a description of the program
;;;
;;; to assemble and run:
;;;
;;;     nasm -f elf -F  stabs program.asm
;;;     ld -melf_i386  -o program program.o
;;;     ./program
;;; -------------------------------------------------------------------

;%include files here...

 
        
  ;; ------------------------------------------------------------
	;; data areas
	;; ------------------------------------------------------------

	section	.data
	;; String variable
	;; The 10's indicate where linebreaks should be
	msg db "* Welcome to CSC231             *", 10
	    db "* Home of the Assembly Language *", 10
	;; Length between that spot and earlier label
	MSGLEN equ $-msg
	msg2 db "*********************************", 10
	MSGLEN2 equ $-msg2

	;; ------------------------------------------------------------
	;; code area
	;; ------------------------------------------------------------

	section	.text
	global	_start

_start:
	;; Code to output the string
	;; Names of registers in the CPU machine that executes the instructions

	;; Need to supply data to them
	;; Registers are different from main men and RAM
  mov eax, 4
	mov ebx, 1
	;; Print the *** string
	mov ecx, msg2
	mov edx, MSGLEN2
	;; Necessary before moving on to the next part of the string
	int 0x80

	mov eax, 4
	mov ebx, 1
	;; Print the core of the string
	mov ecx, msg 	; use the same name as the string in the data section
	mov edx, MSGLEN	; number of chars in string
	int 0x80

	mov eax, 4
	mov ebx, 1
	;; Print the *** string again
	mov ecx, msg2
	mov edx, MSGLEN2
	int 0x80

	;; exit()

	mov	eax,1
	mov	ebx,0
	int	0x80		; final system call
