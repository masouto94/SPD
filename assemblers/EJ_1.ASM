.8086
.model small
.stack 100h

.data
	init db "Ingrese un texto",0dh,0ah,24h
	linebreak db 0dh,0ah,'$'
	textSegment db 255 dup ('$')
	output db 255 dup ('$')

.code

main proc

mov ax, @data
mov ds, ax

mov ah, 9
mov dx, offset init
int 21h

mov bx,0

loadInstruct:
	mov ah,1
	int 21h

	cmp al, 0dh
	je stopLoad
	mov textSegment[bx], al
	mov output[bx], al
	inc bx
jmp loadInstruct

stopLoad:
	;reset accumulato
	mov bx,0
	jmp process

process:
	cmp output[bx], '$'
	je prompt
	cmp output[bx],'a'
	je swapChar
	inc bx
	jmp process

swapChar:
	mov output[bx],'x'
	inc bx
	jmp process

prompt:
	mov ah, 9
	mov dx, offset linebreak
	int 21h
	int 21h
	mov dx, offset textSegment
	int 21h

	mov dx, offset linebreak
	int 21h

	mov dx, offset output
	int 21h

	mov ax, 4c00h
	int 21h


main endp

end main