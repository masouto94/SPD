.8086
.model small
.stack 100h

.data
	pista db 'A .-    B -...   C -.-.   D -..    E .     F ..-.', 0dh, 0ah, \
			 'G --.   H ....   I ..     J .---   K -.-   L .-..', 0dh, 0ah, \
			 'M --    N -.     O ---    P .--.   Q --.-  R .-.', 0dh, 0ah, \
			 'S ...   T -      U ..-    V ...-   W .--   X -..-', 0dh, 0ah, \
			 'Y -.--  Z --..', 0dh, 0ah, 24h
	jugador db '', 0dh, 0ah, 24h
	salto db 0dh, 0ah, 24h
	cartelJugador db 'Ingrese el código morse correspondiente de la palabra '
	palabra db 30 dup(24h), 0dh, 0ah, 24h
	cartelPregunta db '¿Desea imprimir la tabla de referencias? S/N', 0dh, 0ah, 24h
	cartelError db 'Error en el último símbolo ingresado', 0dh, 0ah, 24h
	cartelExito db '¡Felicitaciones! Codificación correcta', 0dh, 0ah, 24h

.code

main proc
	mov ax, @data
	mov ds, ax

	mov ah, 9
	lea dx, cartelPregunta
	int 21h

	mov ah, 1
	int 21h

	cmp al, 'S'
	je mostrarPista
	cmp al, 's'
	je mostrarPista

	mostrarPalabra:
		mov ah, 9
		lea dx, cartelJugador
		int 21h
		jmp fin

	mostrarPista:
		mov ah, 9
		lea dx, salto
		int 21h

		mov ah, 9
		lea dx, pista
		int 21h
		jmp mostrarPalabra	
		
	fin:
		mov ax, 4c00h
		int 21h
main endp
end