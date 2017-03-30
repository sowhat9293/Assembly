INCLUDE Irvine32.inc

Str_trimm PROTO,
		pString:PTR BYTE,	; point to string
		char:BYTE		; char to remove
Str_lngth PROTO,
		pString:PTR BYTE
.data
string_1 BYTE "Hello##Hello##Hello##", 0
.code
main PROC
	call Clrscr
	INVOKE Str_trimm,ADDR string_1, '#'
	mov edx, OFFSET string_1
	call WriteString
	call Crlf
	exit

main ENDP
Str_trimm PROC USES eax ecx edi,
			pString:PTR BYTE,	
			char:BYTE		

	mov edi, pString
	INVOKE Str_lngth, edi
	cmp eax, 0
	je L3
	mov ecx, eax
	dec eax		; eax에는 문자열에 널값이 포함안된 길이가 들어 있다.
	add edi, eax	; 포인터를 문자 마지막을 가리키게 한다.
L1 :
	mov al, [edi]
	cmp al, char
	je L2
	dec edi
loop L1
	pop edi
	mov BYTE PTR [edi], 0
	ret
L2 :	; '#'아 아니므로 널 바이트를 넣는 곳의 후보가 된다. 그러므로 스택에 push한다.
	push edi	; 현재 edi가 가리키는 곳이 #이다.
	dec edi
	dec ecx
	jmp L1
L3 :
	ret
Str_trimm ENDP

Str_lngth PROC USES edi,
		pString:PTR BYTE

	mov edi, pString
	mov eax, 0
L1 :
	cmp BYTE PTR [edi], 0
	je L2
	inc edi
	inc eax
	jmp L1
	ret
L2 :
	ret
Str_lngth ENDP
END main