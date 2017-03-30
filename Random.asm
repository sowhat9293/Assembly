INCLUDE Irvine32.inc

BinarySearch PROTO,
		pArray:PTR DWORD,	; pointer to array
		Count:DWORD,		; array size
		searchVal:DWORD		; serach value
.data
randVal DWORD ?
array_1 DWORD 100 DUP(0)
string_1 BYTE "Random Number : ", 0
string_2 BYTE "Circit Count : ", 0
.code
main PROC
	call Randomize	;	�õ� �ʱ�ȭ
	mov eax, 100	; 0~99���� ���� �����ϱ� ���� eax �ʱ�ȭ
	call RandomRange	; 0~99���� ����
	mov randVal, eax
	mov edx, OFFSET string_1
	Call WriteString
	mov eax, randVal
	Call WriteDec
	Call Crlf
	mov ecx, 100
	mov esi, OFFSET array_1		; esi�� array_1�迭 �����ּҸ� �ִ´�.
	mov eax, 0
L1 :
	mov [esi], eax
	add esi, 4
	inc eax
loop L1
	mov edx, OFFSET string_2
	Call WriteString
	INVOKE BinarySearch,ADDR array_1, 100, randVal
	Call Crlf
	exit

main ENDP
BinarySearch PROC USES ebx edx esi edi,
		pArray:PTR DWORD,	; pointer to array
		Count:DWORD,		; array size
		searchVal:DWORD		; serach value

Local		first:DWORD,		; first position
		last:DWORD,		; last position
		mid:DWORD,		; midpoint	
		Cnt:DWORD		; ������ Ƚ��

	mov Cnt, 0		; Ƚ�� �ʱ�ȭ
	mov first, 0		; first = 0
	mov eax, Count		; last = (count - 1)
	dec eax
	mov last, eax
	mov edi, searchVal	; EDI = searchVal
	mov ebx, pArray		; EBX points to the array (������)
L1 :	; while first <= last
	mov eax, first
	cmp eax, last
	jg L5	; exit search	first�� last���� Ŀ���� �׸��д�
	; mid = (last + first) / 2
	mov eax, last
	add eax, first
	shr eax, 1		; shift right 1��ŭ ���Ƿ� ���� 2�� ������ ����.
	mov mid, eax		; first+last�� 2�� �������� mid�� �Ű�����.
	inc Cnt
	;	EDX = values[mid]
	mov esi, mid		
	shl esi, 2		; shift left 2��ŭ�Ͽ� ���� 4�� ���Ͽ� �ش�. �� ������ mid�� first, last�� DWORD�� 4byte �����̱� �����̴�.
	mov edx, [ebx+esi]	; EDX = values[mid]
	; if ( EDX < searchval(EDI) )	�߰����� ã������ ������ ���� �� �� ��
	cmp edx, edi
	jge L2
	; first = mid + 1
	mov eax, mid
	inc eax
	mov first, eax
	jmp L4
	; else if ( EDX > searchVal(EDI) )
L2 :
	cmp edx, edi
	jle L3
	; last = mid - 1
	mov eax, mid
	dec eax
	mov last, eax
	jmp L4
	; else return mid
L3 :
	mov eax, mid
	jmp L9
L4 :
	jmp L1		; continue the loop
L5 :
	push Cnt	; cnt ���� ���ÿ� push
	mov eax, -1	; search failed
L9 :
	mov eax, Cnt
	Call WriteDec
	ret
BinarySearch ENDP
END main