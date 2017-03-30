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
	call Randomize	;	시드 초기화
	mov eax, 100	; 0~99랜덤 난수 생성하기 위한 eax 초기화
	call RandomRange	; 0~99난수 생성
	mov randVal, eax
	mov edx, OFFSET string_1
	Call WriteString
	mov eax, randVal
	Call WriteDec
	Call Crlf
	mov ecx, 100
	mov esi, OFFSET array_1		; esi에 array_1배열 시작주소를 넣는다.
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
		Cnt:DWORD		; 시행한 횟수

	mov Cnt, 0		; 횟수 초기화
	mov first, 0		; first = 0
	mov eax, Count		; last = (count - 1)
	dec eax
	mov last, eax
	mov edi, searchVal	; EDI = searchVal
	mov ebx, pArray		; EBX points to the array (시작점)
L1 :	; while first <= last
	mov eax, first
	cmp eax, last
	jg L5	; exit search	first가 last보다 커지면 그만둔다
	; mid = (last + first) / 2
	mov eax, last
	add eax, first
	shr eax, 1		; shift right 1만큼 가므로 값이 2로 나누어 진다.
	mov mid, eax		; first+last를 2로 나눈값이 mid로 옮겨진다.
	inc Cnt
	;	EDX = values[mid]
	mov esi, mid		
	shl esi, 2		; shift left 2만큼하여 값에 4를 곱하여 준다. 그 이유는 mid나 first, last가 DWORD의 4byte 변수이기 때문이다.
	mov edx, [ebx+esi]	; EDX = values[mid]
	; if ( EDX < searchval(EDI) )	중간값이 찾으려는 값보다 작은 값 일 때
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
	push Cnt	; cnt 값을 스택에 push
	mov eax, -1	; search failed
L9 :
	mov eax, Cnt
	Call WriteDec
	ret
BinarySearch ENDP
END main