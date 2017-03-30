INCLUDE Irvine32.inc

Str_cpy PROTO,
		source:PTR BYTE,	; source string	
		target:PTR BYTE		; target string
Str_lngth PROTO,
		pString:PTR BYTE
.data
string_1 BYTE "ABCDEFGABCDEFGABCDEFGABCDEFG", 0
string_2 BYTE 20 DUP(?), 0
.code
main PROC
	call Clrscr
	
	INVOKE Str_cpy,	ADDR string_1, ADDR string_2

	mov edx, OFFSET string_2
	call WriteString
	call Crlf
	exit

main ENDP
Str_cpy PROC USES eax ecx esi edi,
			source:PTR BYTE,	; source string
			target:PTR BYTE		; target string

	invoke Str_lngth, source
	mov ecx, eax
	inc ecx	; add 1 for null byte
	mov esi, source
	mov edi, target
	cld
	rep movsb
	ret
Str_cpy ENDP

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