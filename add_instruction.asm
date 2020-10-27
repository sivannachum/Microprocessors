;;; hw6_4.asm
;;; D. Thiebaut, J. Macbeth, S. Nachum
;;; compute ans = 4*(2*a+b+c) + 2*(c+1)


	        extern  _printDec
	        extern  _printString
	        extern  _println
	        extern  _getInput
	
		section	.data
prompt		db	"> "
promptLen	equ	$-prompt	
ansStr          db      "ans = "
ansStrLen	equ	$-ansStr	

a		dd	0
b		dd	0
c		dd	0
ans		dd	0
	
		section	.text
		global	_start
_start:
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get a
		call	_getInput
		mov	dword[a], eax

	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get b
		call	_getInput
		mov	dword[b], eax
	
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get c
		call	_getInput
		mov	dword[c], eax
	
;; -----------------------------------
;; computation: ans =  4*(2*a+b+c) + 2*(c+1) 
;; -----------------------------------

	;; *** YOUR CODE GOES HERE ***
		  mov     eax, 0
		  ;; add 2*a+b+c once
	    add     eax, dword[a]
	    add     eax, dword[a]
	    add     eax, dword[b]
	    add     eax, dword[c]
		
		  ;; add 2*a+b+c a second time
		  add     eax, dword[a]
	    add     eax, dword[a]
	    add     eax, dword[b]
	    add     eax, dword[c]

		  ;; add 2*a+b+c a third time
		  add     eax, dword[a]
      add     eax, dword[a]
	    add     eax, dword[b]
	    add     eax, dword[c]

	  	;; add 2*a+b+c a fourth time
		  add     eax, dword[a]
	    add     eax, dword[a]
	    add     eax, dword[b]
      add     eax, dword[c]
		
	  	;; add c twice
		  add     eax, dword[c]
		  add     eax, dword[c]
		  ;; add 2
		  add	eax, 2

		  ;; Move the result of the calculation, 4*(2*a+b+c) + 2*(c+1), to ans
	    mov     dword[ans], eax 	

	
;; -----------------------------------
;; display "ans ="
;; -----------------------------------
		mov	ecx, ansStr
		mov	edx, ansStrLen
		call	_printString

;; -----------------------------------
;; display ans variable
;; -----------------------------------
		mov	eax, dword[ans]
		call	_printDec
		call	_println
		call	_println
	
;;; exit
		mov	ebx, 0
		mov	eax, 1
		int     0x80
