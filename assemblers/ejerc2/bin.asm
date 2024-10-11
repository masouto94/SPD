
.8086
.model small
.stack 100h
.data
	varBinariaAscii db "00000000",0dh,0ah,24h
.code
	main proc
	mov ax, @data
	mov ds, ax
	mov cx, 8

	mov bl, 00110101b
	lea si, varBinariaAscii
	movimiento:
		shl bl,1
		jc esUno
		inc si
	sigue:
	loop movimiento
	jmp fin
	esUno:
		add byte ptr [si], 1
		inc si
	jmp sigue
	fin:
	mov ah,9
	lea dx, varBinariaAscii
	int 21h
	mov ax, 4c00h
	int 21h

	main endp
end
