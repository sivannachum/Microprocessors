;;; ; ; compute ans = f(n) = f(n-1) + f(n-2) + f(n-3) if n > 3
;;; ; ; where f(1) = 1, f(2) = 1, and f(3) = 1

	        extern  _printDec
	        extern  _printString
	        extern  _println
	        extern  _getInput

		section	.data
	prompt		db	"> "
	promptLen	equ	$-prompt

	n		dd	0
	ans		dd	0

		section	.text
		global	_start
_start:
;;; ;  display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
;;; ;  get n that the user wants (as in f(n))
		call	_getInput
		mov	dword[n], eax

;;; ;  -----------------------------------
;;; ;  computation: ans = f(n) = f(n-1) + f(n-2) + f(n-3)
;;; ;  -----------------------------------

;;; ; mov n to ecx
		mov ecx, dword[n]
;;; ; subtract 3
		sub ecx, 3
;;; ; store f(1) in eax, f(2) in ebx, and f(3) in edx
;;; ; over the loop these will be f(n-3), f(n-2), and f(n-1), respectively
;;; ; ans will store f(n)
		mov eax, 1
		mov ebx, 1
		mov edx, 1

;;; ; loop code: calculate f(n), update f(n-3), f(n-2), and f(n-1)
L1:		mov dword[ans], eax
		add dword[ans], ebx
		add dword[ans], edx

		mov eax, ebx
		mov ebx, edx
		mov edx, dword[ans]

		loop L1

;;; ;  -----------------------------------
;;; ;  display ans variable
;;; ;  -----------------------------------
		mov	eax, dword[ans]
		call	_printDec
		call	_println

;;; ; ; exit
		mov	ebx, 0
		mov	eax, 1
		int     0x80
