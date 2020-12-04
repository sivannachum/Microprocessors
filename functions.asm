;;; ; ------------------------------------------------------
;;; ; functions.asm
;;; ; Sivan Nachum
;;; ; ------------------------------------------------------
	global f1, f2, f3, f4

;;; ; This function receives the address of a string s as well as its length
;;; ; both passed as 32-bit parameters on the stack
;;; ; Converts the string to uppercase in place
f1:
;;; ; Save the value of ebp, reset it
	push ebp
	mov ebp, esp
;;; ; Save the values of eax and ebx
	push eax
	push ebx
;;; ; Set ebx to hold the starting address of the string
	mov ebx, [ebp+12]
;;; ; Set eax to hold the end address of the string
;;; ; (more particularly the first address not part of the string)
;;; ; Which is the length of the string + the starting address of the string
	mov eax, [ebp+8]
;;; ; Before adding to ebx, check if the length is zero
;;; ; If so, skip the loop
	cmp eax, 0
	jz stoploopf1
	add eax, ebx	
;;; ; ; now if eax equals ebx, we stop looping

loopsectionf1:
;;; ; ; check if this is a lowercase alphabet character
;;; ; ; if it is, make it uppercase
	cmp byte[ebx], 97
	jl checkloopf1
	cmp byte[ebx], 122
	jg checkloopf1
;;; ; ; if lowercase, the corresponding uppercase character is 32 less
;;; ; ; (as an int)
	sub byte[ebx], 32

;;; ; ; check if we should still be looping
checkloopf1:
;;; ; ; increment ebx by 1 byte and
;;; ; ; stop looping if ebx has reached the end of the string
	inc ebx
	cmp eax, ebx
	jz stoploopf1
	jmp loopsectionf1

stoploopf1:
;;; ; ; Pop off the stack in the reverse order of pushing
	pop ebx
	pop eax
	pop ebp
;;; ; ; Take off the 8 bytes of the parameters when the function returns
	ret 8

	
;;; ; ; This function receives three 32-bit integer parameters in the stack
;;; ; ; And computes 4*(a+b)+3*c and returns the result in eax
f2:
;;; ; ; Save ebp on the stack so we can use it
	push ebp
	mov ebp, esp
;;; ; ; Save ebx and ecx on the stack so we can use them
;;; ; ; I am not pushing eax because this function returns in eax
;;; ; ; So the user should not expect the contents of eax to be preserved
	push ebx
	push ecx

;;; ; ; eax stores a, ebx stores b, and ecx stores c
	mov eax, [ebp+16]
	mov ebx, [ebp+12]
	mov ecx, [ebp+8]

	add eax, ebx 		; 1(a+b) -> eax
	mov ebx, eax
	add eax, ebx		; 2(a+b) -> eax
	add eax, ebx 		; 3(a+b) -> eax
	add eax, ebx		; 4(a+b) -> eax

	mov ebx, ecx
	add ebx, ecx		; 2c -> ebx
	add ebx, ecx		; 3c -> ebx
	add eax, ebx 		; 4(a+b) + 3c -> eax 

;;; ; ; Pop off the stack in the reverse order of pushing
	pop ecx
	pop ebx
	pop ebp
;;; ; ; Take off the 12 bytes of the parameters when the function returns
	ret 12

	
;;; ; ; This function receives the address of an array of 32-bit integers
;;; ; ; and the number of integers in the array.
;;; ; ; These are passed as 32-bit integers on the stack.
;;; ; ; The function returns in eax
;;; ; ; the number of negative integers in the array
f3:
;;; ; ; Save ebp on the stack so we can use it
	push ebp
	mov ebp, esp
;;; ; ; push ebx and ecx so we can use them
;;; ; ; I am not pushing eax because this function returns in eax
;;; ; ; So the user should not expect the contents of eax to be preserved
	push ebx
	push ecx

;;; ; ; Initialize eax to zero
	mov eax, 0

;;; ; ; ecx will hold the number of elements in the array, for loop purposes
	mov ecx, [ebp+8]
;;; ; ; If the number of elements in the array is 0, skip the loop
	cmp ecx, 0
	jz donef3
	
;;; ; ; ebx will hold the address of the array element we are on
	mov ebx, [ebp+12]

loopsectionf3:
;;; ; ; Look at the element at the address held in ebx
;;; ; ; If it is negative, increment eax
	cmp dword[ebx], 0
	jge checkloopf3
	inc eax
checkloopf3:
;;; ; ; Increment ebx by 4 (bytes) and loop
	add ebx, 4
	loop loopsectionf3

donef3:	
;;; ; ; Pop off the stack in the reverse order of pushing
	pop ecx
	pop ebx
	pop ebp
;;; ; ; Take off the 8 bytes of the parameters when the function returns
	ret 8


;;; ; ; This function receives three 32-bit non-negative integers in the stack
;;; ; ; and returns the smallest of the three in eax
f4:
;;; ; ; Save ebp on the stack so we can use it
        push ebp
        mov ebp, esp
;;; ; ; I am not pushing eax because this function returns in eax
;;; ; ; So the user should not expect the contents of eax to be preserved
	
;;; ; ; eax will store one of the inputs
	mov eax, [ebp+8]
;;; ; ; compare it to another one
	cmp eax, [ebp+12]
;;; ; ; if it is less than or equal to this one,
;;; ; ;	there is no change and we can move on to the next comparison
	jle nextcompare
;;; ; ; otherwise we must update eax
	mov eax, [ebp+12]

nextcompare:
;;; ; ; Compare it to the final input
	cmp eax, [ebp+16]
;;; ; ; if it is less than or equal to this one,
;;; ; ; there is no change and we can finish the function
	jle donef4
;;; ; ; otherwise we must update eax
	mov eax, [ebp+16]
	
donef4:	
;;; ; ; Pop off the stack in the reverse order of pushing
	pop ebp
;;; ; ; Take off the 12 bytes of the parameters when the function returns
	ret 12
