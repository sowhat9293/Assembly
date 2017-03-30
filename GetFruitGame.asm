INCLUDE Irvine32.inc
Dec_Fruit PROTO
CheckEndGame PROTO
PrintFruit PROTO
.data
num_apple DWORD 5	; 사과 5
num_orange DWORD 7	; 오렌지 7
num_banana DWORD 9	; 바나나 9
num_cmp DWORD 2		; 기준으로 되는 num
num_end DWORD 0	; 게임 끝
string_1 BYTE "APPLE(1)-----ORANGE(2)-----BANANA(3)", 0
string_null BYTE "               ", 0
string_input1 BYTE "Select Fruit Number : ", 0
string_input2 BYTE "How many do you want to get ? ", 0
string_end BYTE "Game Over!", 0
string_notend BYTE "Play Again!", 0
string_error BYTE "You can't get more bigger than Fruit!!", 0
.code
main PROC
	mov ecx, 3
L1 :
	mov eax, 0		; 초기화
	INVOKE PrintFruit	; 과일 갯수 출력

	mov edx, OFFSET string_input1
	Call WriteString
	Call ReadInt
	INVOKE Dec_Fruit
	INVOKE CheckEndGame
	cmp num_end, 99
	je L2
	inc ecx	; 무한루프
Loop L1
L2 :
	INVOKE PrintFruit
	mov edx, OFFSET string_end
	Call WriteString
	exit
main ENDP
Dec_Fruit PROC USES eax ecx edi
	
	cmp eax, num_cmp
	jl R1
	je R2
	jg R3
R1 :	; Apple을 선택한 경우
	mov edx, OFFSET string_input2
	Call WriteString
	Call ReadInt
	cmp num_apple, eax
	jl R10
	sub num_apple, eax
	cmp num_apple, 0
	Call Crlf
	jmp R9
R2 :	;Orange를 선택한 경우
	mov edx, OFFSET string_input2
	Call WriteString
	Call ReadInt
	cmp num_orange, eax
	jl R10
	sub num_orange, eax
	Call Crlf
	jmp R9
R3 :	;Banana를 선택한 경우
	mov edx, OFFSET string_input2
	Call WriteString
	Call ReadInt
	cmp num_banana, eax
	jl R10
	sub num_banana, eax
	Call Crlf
	jmp R9
R9 :
	ret
R10 :
	mov edx, OFFSET string_error
	Call WriteString
	Call Crlf
	ret
Dec_Fruit ENDP

CheckEndGame PROC USES eax ecx edi
	mov eax, num_apple
	add eax, num_orange
	add eax, num_banana
	cmp eax, 0
	je K1
	mov edx, OFFSET string_notend
	Call WriteString
	Call Crlf
	ret
K1	:
	mov num_end, 99
	mov edx, OFFSET string_end
	ret
CheckEndGame ENDP

PrintFruit PROC USES eax ecx edi
	mov edx, OFFSET string_1
	Call WriteString
	Call Crlf
	mov eax, num_apple
	Call WriteDec
	mov edx, OFFSET string_null
	Call WriteString
	mov eax, num_orange
	Call WriteDec
	mov edx, OFFSET string_null
	Call WriteString
	mov eax, num_banana
	Call WriteDec
	Call Crlf
	; 여기까지가 입력 전 출력 소스
	ret
PrintFruit ENDP
END main