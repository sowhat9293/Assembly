INCLUDE Irvine32.inc
BubbleSort PROTO,
		pArray:PTR DWORD,
		Count:DWORD
.data
string_1 BYTE "ABCDEFGH", 0
string_2 BYTE "ABCDEF", 0
.code
main PROC
	
	exit
main ENDP
BubbleSort PROC USES eax ecx esi,
	pArray:PTR DWORD,
	Count:DWORD

	mov ecx, Count	; 카운터를 넣는다
	dec ecx		; 사실상 카운터 - 1번 수행되므로 
L1 :
	push ecx	;ecx값을 스택에 push한다.
	mov esi,pArray	; pArray의 주소값을 esi에 넣는다.
L2 :
	mov eax, [esi]	; esi의 데이터를 eax에 넣는다.
	cmp [esi+4], eax	; esi와 esi+4(다음번 데이터)를 비교한다.
	jge L3			; 데스티네이션이 소스보다 크거나 같으면 L3 점프
	xchg eax,[esi+4]	; 아니면 두개를 바꾼다.
	mov [esi],eax		; 두개를 바꾼다.
L3 :
	add esi,4
	loop L2
	pop ecx
	loop L1
L4 :
	ret
BubbleSort ENDP
END main