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

	mov ecx, Count	; ī���͸� �ִ´�
	dec ecx		; ��ǻ� ī���� - 1�� ����ǹǷ� 
L1 :
	push ecx	;ecx���� ���ÿ� push�Ѵ�.
	mov esi,pArray	; pArray�� �ּҰ��� esi�� �ִ´�.
L2 :
	mov eax, [esi]	; esi�� �����͸� eax�� �ִ´�.
	cmp [esi+4], eax	; esi�� esi+4(������ ������)�� ���Ѵ�.
	jge L3			; ����Ƽ���̼��� �ҽ����� ũ�ų� ������ L3 ����
	xchg eax,[esi+4]	; �ƴϸ� �ΰ��� �ٲ۴�.
	mov [esi],eax		; �ΰ��� �ٲ۴�.
L3 :
	add esi,4
	loop L2
	pop ecx
	loop L1
L4 :
	ret
BubbleSort ENDP
END main