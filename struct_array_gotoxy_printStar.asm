INCLUDE Irvine32.inc
COORD STRUCT
	X WORD ?
	Y WORD ?
COORD ENDS
.data
NumPoints = 3
AllPoints COORD NumPoints DUP(<0,0>)

.code
main PROC
	mov edi, 0	; array index
	mov ecx, NumPoints	; loop counter 
	mov ax, 1	; x,y�� �� ��
L1 :
	mov (COORD PTR AllPoints[edi]).X, ax
	mov (COORD PTR AllPoints[edi]).Y, ax
	add edi, TYPE COORD
	add ax, 10
Loop L1
	
	mov edi, 0
	mov ecx, NumPoints
	call Clrscr
L2 :	; gotoxy�� �������� ����
	mov ax, (COORD PTR AllPoints[edi]).X
	mov dh, al
	mov ax, (COORD PTR AllPoints[edi]).Y
	mov dl, al
	call Gotoxy
	mov al, '*'
	call WriteChar
	add edi, TYPE COORD
Loop L2
	exit
main ENDP
END main

// ����ü�� gotoxy�� �̿��Ͽ� *�� ����ϴ� ���α׷�