.8086
.model small
.stack 100h

.data
	cartel db 'Ingrese un número de tres dígitos (000-255)', 0dh, 0ah, 24h
	cartel2 db 'Ud. ingresó el número:', 0dh, 0ah, 24h
	numeroAscii db '000', 0dh, 0ah, 24h
	numeroReg db 0
	numeroAscii2 db '000', 0dh, 0ah, 24h

.code

extrn asciiToReg:proc
extrn regToAscii:proc
extrn impresion:proc
extrn carga:proc

main proc

		mov ax, @data
		mov ds, ax

		lea bx, numeroAscii
		mov cx, 3

		lea bx, cartel
		call impresion

		lea bx, numeroAscii
		call carga

		lea bx, numeroAscii			; Vuelvo a poner el offset de numeroAscii en bx
		lea si, numeroReg			; Pongo en si la variable a llenar
		call asciiToReg				; Llamo a la función para pasar de ASCII a registro

		lea bx, numeroAscii2			; Pongo en bx el offset de numeroAscii2 (la segunda variable a imprimir)
		call regToAscii				; Llamo a la función para pasar de registro a ASCII

		lea bx, cartel2
		call impresion

		lea bx, numeroAscii2
		call impresion

		mov ax, 4c00h
		int 21h

main endp
end main