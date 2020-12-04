;;; To run:
;;; nasm -f elf test_functions.asm
;;; nasm -f elf functions.asm
;;; nasm -f elf 231Lib.asm
;;; ld -melf_i386 -o test_functions test_functions.o functions.o 231Lib.o
;;; ./test_functions

;;;------------------------------------------------------------
;;; test_functions.asm
;;; tests the functions in functions.asm by calling each one
;;; and printing its result.
;;; This is a skeleton test program!
;;;------------------------------------------------------------
section .data
tag1 db "Testing f1", 10
tag2 db "Testing f2", 10
tag3 db "Testing f3", 10
tag4 db "Testing f4", 10
tagLen equ $-tag4
;;; -----------------------------------------------------
;;; test data for f1
s1 db "Hello there! 'az' AZ ~!@#<>?/ 1234578890 "
s1Len equ $-s1
;;; -----------------------------------------------------
;;; test data for f2
x dd 2
y dd 5
z dd 10
;;; -----------------------------------------------------
;;; test data for f3 (number of negative ints)
Table1 dd 1, -21, 33, 303, 1001, 2001
Table1Len equ ($-Table1)/4
;;; -----------------------------------------------------
;;; test data for f4 (find smallest)
x1 dd 10
x2 dd 20
x3 dd 15
section .text
extern _printString, _println, _printInt, _printRegs
extern f1, f2, f3, f4
global _start
_start:
;;; -----------------------------------------------------
;;; test f1
testF1:
mov ecx, tag1
mov edx, tagLen
call _printString
mov eax, s1 ; pass s1 to f1
push eax
mov eax, s1Len
push eax
call f1
mov ecx, s1
mov edx, s1Len
call _printString
call _println
;;; -----------------------------------------------------
;;; test f2: computes 4*(a + b) + 3*c
;;; a = 2 b = 5 c = 10
;;; should return 4(2+5)+3.10 = 28 + 30 = 58
testF2:
mov ecx, tag2
mov edx, tagLen
call _printString
push dword[x] ; pass x as a, y as b, z as c to f2
push dword[y]
push dword[z]
call f2
call _printInt
call _println
;;; -----------------------------------------------------
;;; test f3
testF3:
mov ecx, tag3
mov edx, tagLen
call _printString
mov eax, Table1 ; pass Table and length to f3
push eax
mov eax, Table1Len
push eax
call f3
call _printInt
call _println
;;; -----------------------------------------------------
;;; ; test f4
testF4:
mov ecx, tag4
mov edx, tagLen
call _printString
push dword[x1]
push dword[x2]
push dword[x3]
call f4
call _printInt
call _println
;;; ; exit
exit:
mov ebx, 0
mov eax, 1
int 0x80
