.386
.model flat, stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib
BSIZE equ 8
.data 
ifmt db '%d',0
buf db BSIZE dup(?)
stdout dd ?
cWritten dd ?
.code
start:
invoke GetStdHandle, STD_OUTPUT_HANDLE 
mov ebx,11111111b ; our register
mov edx,0 ; here we will stored amount
mov ecx,9 ; counter
check:
sub ecx,1
cmp ecx,0
je exit
shr ebx,1
jc one
jmp check
one:
inc edx
jmp check
exit:
mov stdout,eax
invoke wsprintf,ADDR buf,ADDR ifmt,edx
invoke WriteConsoleA,stdout,ADDR buf,BSIZE,ADDR cWritten,NULL
invoke ExitProcess,0
end start 