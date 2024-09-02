.8086
.model small

.stack 100h
.data 
texto db "hola viejo",0dh,0ah,24h

.code

	main proc
	mov ax, @data
	mov ds,ax

	mov ah, 9
	mov dx, offset texto
	int 21h
	mov ax, 4C00h
	int 21h
	main endp
end main
