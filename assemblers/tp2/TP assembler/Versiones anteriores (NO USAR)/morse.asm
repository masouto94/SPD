.8086
.model small
.stack 100h

.data
	tabla db 'A .-    B -...   C -.-.   D -..    E .     F ..-.', 0dh, 0ah, \
			 'G --.   H ....   I ..     J .---   K -.-   L .-..', 0dh, 0ah, \
			 'M --    N -.     O ---    P .--.   Q --.-  R .-.', 0dh, 0ah, \
			 'S ...   T -      U ..-    V ...-   W .--   X -..-', 0dh, 0ah, \
			 'Y -.--  Z --..', 0dh, 0ah, 24h
	;jugador db '', 0dh, 0ah, 24h
	cartelJugador db 'Ingrese el código morse correspondiente de la palabra '
	palabra db 'SOS', 0dh, 0ah, 24h
	cartelModalidad db 			'Seleccione modalidad:', 0dh, 0ah, \
				   	    	'1. Codificar palabra (con tabla de referencia)', 0dh, 0ah, \
				            	'2. Codificar palabra (sin tabla de referencia)', 0dh, 0ah, \
				   		'3. Decodificar código morse escrito (con tabla de referencia)', 0dh, 0ah, \
				   		'4. Decodificar código morse escrito (sin tabla de referencia)', 0dh, 0ah, \
				   		'5. Escribir código morse a partir de sonidos', 0dh, 0ah, \
				   		'6. Decodificar código morse en sonido (con tabla de referencia)', 0dh, 0ah, \
				   		'7. Decodificar código morse en sonido (sin tabla de referencia)', 0dh, 0ah, \
						'0. Salir', 0dh, 0ah, 24h
	cartel1 db 'SE MUESTRA LA TABLA Y SE PIDE CODIFICAR PALABRA X', 0dh, 0ah, 24h
	cartel2 db 'SE PIDE CODIFICAR PALABRA X SIN MOSTRAR TABLA', 0dh, 0ah, 24h
	cartel3 db 'SE MUESTRA CÓDIGO MORSE Y SE PIDE ESCRIBIRLO EN ALFABETO (MOSTRANDO TABLA)', 0dh, 0ah, 24h
	cartel4 db 'SE MUESTRA CÓDIGO MORSE Y SE PIDE ESCRIBIRLO EN ALFABETO (SIN TABLA)', 0dh, 0ah, 24h
	cartel5 db 'SE REPRODUCE SONIDO Y EL USUARIO DEBE COPIARLO', 0dh, 0ah, 24h
	cartel6 db 'SE REPRODUCE SONIDO Y EL USUARIO DEBE ESCRIBIR LA PALABRA (MOSTRANDO TABLA)', 0dh, 0ah, 24h
	cartel7 db 'SE REPRODUCE SONIDO Y EL USUARIO DEBE ESCRIBIR LA PALABRA (SIN TABLA)', 0dh, 0ah, 24h
	cartelNoValido db 'Opción no válida', 0dh, 0ah, 24h


.code

extrn imprimirSalto:proc
extrn impresion:proc
extrn carga:proc
extrn mayusculizador:proc
extrn contarCaracteresSt:proc
extrn regToAscii:proc
extrn mostrarTabla:proc


main proc
	mov ax, @data
	mov ds, ax

	call menu	
		
	fin:
		mov ax, 4c00h
		int 21h
main endp


menu proc
	elegirModalidad:

		lea bx, cartelModalidad
		call impresion

		mov ah, 1
		int 21h

		cmp al, '1'
		je modalidad1
		cmp al, '2'
		je modalidad2
		cmp al, '3'
		je modalidad3
		cmp al, '4'
		je modalidad4
		cmp al, '5'
		je modalidad5
		cmp al, '6'
		je modalidad6
		cmp al, '7'
		je modalidad7
		cmp al, '0'
		je fin

		lea bx, cartelNoValido
		call impresion
		jmp elegirModalidad

		modalidad1:
			lea bx, cartel1
			call impresion
			call mostrarTabla
			jmp elegirModalidad
		
		modalidad2:
			lea bx, cartel2
			call impresion
			jmp elegirModalidad

		modalidad3:
			lea bx, cartel3
			call impresion
			call mostrarTabla
			jmp elegirModalidad

		modalidad4:
			lea bx, cartel4
			call impresion
			jmp elegirModalidad

		modalidad5:
			lea bx, cartel5
			call impresion
			jmp elegirModalidad

		modalidad6:
			lea bx, cartel6
			call impresion
			call mostrarTabla
			jmp elegirModalidad

		modalidad7:
			lea bx, cartel7
			call impresion
			jmp elegirModalidad

	ret
menu endp


end