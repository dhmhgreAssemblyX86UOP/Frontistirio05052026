TITLE Introduction to Stack Frames
Include Irvine32.inc

.data
a DWORD 5
b DWORD 6
result1 DWORD ?

.code

TestFunction PROC
; prologue
push ebp   ; save main's EBP pointer
mov ebp,esp ; ebp now points to TestFunction stack frame
sub esp,8  ; reserve space in stack for local variable
		   ; 8 bytes were reserved for h and g local variables
pushad     ; saves all registers to stack
; h variable is at [EBP-4]
; g variable is at [EBP-8]
mov [EBP-4], DWORD PTR 5d
mov [EBP-8], DWORD PTR 6d


; What function does.
mov eax, [EBP+8]   ; read variable a
add eax, [EBP+12]  ; read and add variable b to a
add eax, [EBP-4]   ; add h variable to the sum
add eax, [EBP-8]   ; add g variable to the sum
; by now we have sum = a+b+h+g;


mov esi, [EBP+16]  ; move result address to esi
				   ; ESI works as a pointer to result
mov [esi],eax	   ; move sum to result address


;epilogue
popad			; restore registers
mov esp,ebp     ; deallocate local variables
pop ebp			; restore main's EBP pointer
ret 12			; return and clear arguments from stack
TestFunction ENDP


main PROC

;prepare arguments
;unsigned int TestFunction(unsigned int a, 
;						unsigned int b)
;unsigned int TestFunction(unsigned int a, [EBP+8] 
;						unsigned int b, [EBP+12]
;						unsigned int *res) [EBP+16]
;  int h = 5;
;  int g = 6;
push OFFSET result1  ;100
push b				 ;96
push a               ;92
;call function
call TestFunction
;cdecl convention : clean arguments
;add esp,12  clear arguments in cdecl conventions

mov eax, result1
call WriteInt

exit
main ENDP
END main 