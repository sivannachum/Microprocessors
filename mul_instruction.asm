;;; ; compute ans = 4*(a^2 + b^2) + c

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
;;;  display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
;;;  get a
		call	_getInput
		mov	dword[a], eax

;;;  display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
;;;  get b
		call	_getInput
		mov	dword[b], eax

;;;  display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
;;;  get c
		call	_getInput
		mov	dword[c], eax

;;;  -----------------------------------
;;;  computation: ans =  4*(a^2 + b^2) + c
;;;  -----------------------------------

;;; mov a to eax
		mov eax, dword[a]
;;; Produce a^2
		mul dword[a]
;;; Store a^2 in ebx
		mov ebx, eax

		mov eax, dword[b]
;;; Produce b^2 and add to ebx
		mul dword[b]
		add ebx, eax
;;; Now have a^2 + b^2
		mov eax, ebx 	; 1*(a^2 + b^2)
		add eax, ebx 	; 2*(a^2 + b^2)
		add eax, ebx	; 3*(a^2 + b^2)
		add eax, ebx	; 4*(a^2 + b^2)
;;; Now add c to get the final answer
		add eax, dword[c]

		
;;;  Move the result of the calculation, 4*(a^2 + b^2)+c, to ans
		mov dword[ans], eax


;;;  -----------------------------------
;;;  display "ans ="
;;;  -----------------------------------
		mov	ecx, ansStr
		mov	edx, ansStrLen
		call	_printString

;;;  -----------------------------------
;;;  display ans variable
;;;  -----------------------------------
		mov	eax, dword[ans]
		call	_printDec
		call	_println
		call	_println

;;; ; exit
		mov	ebx, 0
		mov	eax, 1
		int     0x80
