;;; hw6_5_skel.asm
;;; D. Thiebaut, J. Macbeth, S. Nachum
;;; computes ans = 3*((t-1)+2*(y-t)) - 3*(x-10);
;;; 

	
	        extern  _printDec
		extern  _printInt
	        extern  _printString
	        extern  _println
	        extern  _getInput
	
		section	.data
prompt		db	"> "
promptLen	equ	$-prompt	
ansStr          db      "ans = "
ansStrLen	equ	$-ansStr	

;;; declare 5 16-bit short ints
x		dw	1       ; leave these values in
y		dw	2	; the different variables.
z		dw	3	; Moodle will use this to
t		dw	4	; verify that you haven't
ans		dw	5	; modified the original data
				; segment
	
		section	.text
		global	_start
_start:
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get x
		call	_getInput
		mov	word[x], ax

	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get y
		call	_getInput
		mov	word[y], ax
	
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get z
		call	_getInput
		mov	word[z], ax

	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get t
		call	_getInput
		mov	word[t], ax
	
;; -----------------------------------
;; computation: ans = 3*((t-1)+2*(y-t)) - 3*(x-10)  
;; -----------------------------------


	;; *** YOUR CODE GOES HERE *** 
	mov ax, 0
	;; add (t-1) + 2(y-t) once
	add ax, word[t]
	sub ax, 1
	add ax, word[y]
	add ax, word[y]
	sub ax, word[t]
	sub ax, word[t]

	;; add (t-1) + 2(y-t) a second time
	add ax, word[t]
	sub ax, 1
	add ax, word[y]
	add ax, word[y]
	sub ax, word[t]
	sub ax, word[t]

	;; add (t-1) + 2(y-t) a third time
	add ax, word[t]
	sub ax, 1
	add ax, word[y]
	add ax, word[y]
	sub ax, word[t]
	sub ax, word[t]
	
	;; adding -3(x-10) = performing -3x + 30
	sub ax, word[x]
	sub ax, word[x]
	sub ax, word[x]
	add ax, 30

	;; Store the result in ans
	mov word[ans], ax

	
	
;; -----------------------------------
;; display "ans = "
;; -----------------------------------
		mov	ecx, ansStr
		mov	edx, ansStrLen
		call	_printString

;; -----------------------------------
;; display ans variable
;; -----------------------------------
		mov	eax, 0
		mov	ax, word[ans]
		call	_printInt
		call	_println
		call	_println
	
;;; exit
		mov	ebx, 0
		mov	eax, 1
		int     0x80
