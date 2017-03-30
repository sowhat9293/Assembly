INCLUDE Irvine32.inc
Str_cmp PROTO,
		string1:PTR BYTE, string2:PTR BYTE
.data
string_1 BYTE "ABCDEFGH", 0
string_2 BYTE "ABCDEF", 0
.code
main PROC
	call Clrscr
	
	INVOKE Str_cmp,	ADDR string_1, ADDR string_2

	call DumpRegs
	call Crlf
	exit

main ENDP
Str_cmp PROC USES eax edx esi edi,
		string1:PTR BYTE, string2:PTR BYTE

	mov esi, string1
	mov edi, string2
L1 :
	mov al, [esi]
	mov dl, [edi]
	cmp al, 0
	jne L2
	cmp dl, 0
	jne L2
	jmp L3
L2 :
	inc esi
	inc edi
	cmp al, dl
	je L1
L3 :
	ret
Str_cmp ENDP
END main

// cmp 명령어
   Destination < source 이면 ZF =0, CF=1 (1인 이유는 값이 음수가되므로)
   Destination > source 이면 ZF =0, CF =0 
   Destination = source 이면 ZF =1, CF = 0