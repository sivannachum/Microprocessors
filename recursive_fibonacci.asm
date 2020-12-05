;;; ; ; ------------------------------------------------------
;;; ; ; recursive_fibonacci.asm
;;; ; ; Sivan Nachum
;;; ; ; ------------------------------------------------------
	global fib3

;;; ; ; This function receives a number n passed as a
;;; ; ; 32-bit parameter on the stack
;;; ; ; and calculates f(n) = f(n-1) + f(n-2) + f(n-3)
;;; ; ; where f(1) = 1, f(2) = 1, and f(3) = 1 ; also if n <= 0, f(n) = 0
fib3:
;;; ; ; Save ebp on the stack so we can use it
	push ebp
	mov ebp, esp
;;; ; ; I am not pushing eax because this function returns in eax
;;; ; ; So the user should not expect the contents of eax to be preserved
	push ebx
	push ecx

;;; ; ; Put the parameter in eax
	mov eax, [ebp+8]

;;; ; ; Check if the parameter is <=0 ; if so, return 0
        cmp eax, 0
        jle negative
	
;;; ; ; Check if the parameter is >0 and <=3 ; if so, return 1
        cmp eax, 3
        jle first
	
;;; ; ; If the function gets here, then the parameter is >= 4
;;; ; ; Store f(n-3) in ecx, f(n-2) in ebx, and f(n-1) in eax
	sub eax, 3
	push eax
	call fib3
	mov ecx, eax
	
	mov eax, [ebp+8]
	sub eax, 2
	push eax
	call fib3
	mov ebx, eax

	mov eax, [ebp+8]
	sub eax, 1
	push eax
	call fib3

;;; ; ; Then calculate f(n) = f(n-1) + f(n-2) + f(n-3) in eax
	add eax, ebx
	add eax, ecx
	jmp done

first:
        mov eax, 1
	jmp done

negative:
	mov eax, 0

done:	
;;; ; ; Pop off the stack in the reverse order of pushing
	pop ecx
	pop ebx
	pop ebp
;;; ; ; Take off the 4 bytes of the parameter when the function returns
	ret 4
