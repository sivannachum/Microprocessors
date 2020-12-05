;;; ; To run:
;;; ; nasm -f elf test_fib.asm
;;; ; nasm -f elf recursive_fibonacci.asm
;;; ; nasm -f elf 231Lib.asm
;;; ; ld -melf_i386 -o test_fib test_fib.o recursive_fibonacci.o 231Lib.o
;;; ; ./test_fib

;;; ;------------------------------------------------------------
;;; ; test_functions.asm
;;; ; tests the functions in functions.asm by calling each one
;;; ; and printing its result.
;;; ; This is a skeleton test program!
;;; ;------------------------------------------------------------
	section .data
;;; ; -----------------------------------------------------
;;; ; test data for fib3
	n dd -10

	section .text
	extern _printString, _println, _printInt, _printRegs
	extern fib3
	global _start
_start:
;;; ; -----------------------------------------------------
;;; ; test fib3
testF1:
	mov eax, dword[n] 		; pass n to fib3
	push eax
	call fib3
	call _printInt
	call _println
;;; ; ; exit
exit:
	mov ebx, 0
	mov eax, 1
	int 0x80
