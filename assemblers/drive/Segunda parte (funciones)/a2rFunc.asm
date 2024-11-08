.8086
.model small
.stack 100h

.data
	cartel db 'Ingrese un número de tres dígitos (000-255)', 0dh, 0ah, 24h
	cartel2 db 'Ud. ingresó el número:', 0dh, 0ah, 24h
	numeroAscii db '000', 0dh, 0ah, 24h
	numeroReg db 0
	numeroAscii2 db '000', 0dh, 0ah, 24h
	multiplicador db 100, 10, 1
	divisor db 100, 10, 1

.code

	main proc
		mov ax, @data
		mov ds, ax

		lea bx, numeroAscii
		mov cx, 3

		mov ah, 9
		mov dx, offset cartel
		int 21h

		carga:
			mov ah, 1
			int 21h
			mov [bx], al
			inc bx
			loop carga

		lea bx, numeroAscii			; Vuelvo a poner el offset de numeroAscii en bx
		lea si, numeroReg			; Pongo en si la variable a llenar
		call asciiToReg				; Llamo a la función para pasar de ASCII a registro

		mov ax, 0				; Limpio registro ax
		mov al, numeroReg			; Muevo a al el número guardado en el registro
		lea bx, numeroAscii2			; Pongo en bx el offset de numeroAscii2 (la segunda variable a imprimir)
		call regToAscii				; Llamo a la función para pasar de registro a ASCII

		mov ah, 9
		mov dx, offset cartel2
		int 21h

		mov ah, 9
		mov dx, offset numeroAscii2
		int 21h

		mov ax, 4c00h
		int 21h
	main endp


	asciiToReg proc					; La función recibe en bx el offset de numeroAscii para devolverlo como registro
		push ax
		push si
		push cx
		push bx

		mov ax, 0
		mov si, 0
		mov cx, 3

		proceso:
			mov al, [bx]
			sub al, 30h
			mov dl, multiplicador[si]
			mul dl
			add numeroReg, al
			inc bx
			inc si
			mov ax, 0
			loop proceso

		pop bx
		pop cx
		pop si
		pop ax		
		ret
	asciiToReg endp


	regToAscii proc					; La función recibe en bx el offset de numeroReg para devolverlo como ASCII
		push ax
		push si
		push cx
		push bx

		mov si, 0
		mov cx, 3

		proceso2:
			mov dl, divisor[si]
			div dl
			add al, 30h
			mov [bx], al
			mov al, ah
			mov ah, 0
			inc bx
			inc si
			loop proceso2

		pop bx
		pop cx
		pop si
		pop ax		
		ret
	regToAscii endp

end