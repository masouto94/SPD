.8086
.model small
.stack 100h

.data
	cartel db 'Conversión de ASCII a binario:', 0dh, 0ah, 24h
	binario_en_ascii db '10101111', 0dh, 0ah, 24h
	binario_reg db 0


.code

main proc
	
	mov ax, @data
	mov ds, ax

	mov si, offset binario_en_ascii
	mov cx, 8
	mov bx, 0

	mov ah, 9
	mov dx, offset cartel
	int 21h

	proceso:
		shl bx, 1         	; Desplazo BX a la izquierda para dejar espacio para el siguiente bit
		cmp [si], '1'		; Comparo el bit en cuestión con '1'
		jne siguiente		; Si no es igual, sigo con el siguiente
		inc bx			; Si es igual a '1', se incrementa bx en 1 (en el bit que está recorriendo si)

	siguiente:
		inc si
		loop proceso

	mov ax, 4c00h
	int 21h

main endp
end