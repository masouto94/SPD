.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese una palabra', 0dh, 0ah, 24h
    palabra db 255 dup(24h), 0dh, 0ah, 24h; palabra cargada desde el archivo
    codigo db 255 dup(24h), 0dh, 0ah, 24h; palabra en morse codificada por la función que traduce
    palabraUsuario db 255 dup(24h), 0dh, 0ah, 24h; la del usuario
    ;posiciones db 0, 3, 7, 
    alfabeto db 'abcdefghijklmnopqrstuvwxyz', 0dh, 0ah, 24h
    morse db '.-  ', '-...', '-.-.', '-.. ', '.   ', '..-.', '--. ', '....', '..  ', '.---', '-.- ', '.-..', '--  ', '-.  ', '--- ', '.--.', '--.-', '.-. ', '... ', '-   ', '..- ', '...-', '.-- ', '-..-', '-.--', '--..', 0dh, 0ah, 24h
    caracter db ' ', 0dh, 0ah, 24h

.code

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    lea dx, cartel
    int 21h

    lea bx, palabra

    carga:
        mov ah, 1
        int 21h
        cmp al, 0dh
        je finCarga
        mov [bx], al
        inc bx
        jmp carga

    finCarga:
        lea bx, palabra								; bx: índice para recorrer "palabra"
	lea di, codigo								; di: índice para recorrer "codigo" (palabra codificada)

    comparacion:

	recorrerPalabra:
		mov dl, [bx]							; Muevo a dl el carácter al que apunta bx
		cmp dl, 0dh
		je imprimir
		mov si, 0							; si: índice para recorrer alfabeto
		mov ax, 0

		recorrerAlfabeto:
			cmp si, 26
			je siguienteCaracter
			cmp dl, alfabeto[si]
			je codificar
			inc si
			jmp recorrerAlfabeto

		codificar:							; El registro si tiene guardado el índice del alfabeto (ej.: 'a' = 0, 'z' = 25)
			escribirSimbolo:
				mov caracter, dl				; Movemos a "caracter" lo que está en dl (el carácter a codificar)
				mov dl, 4 					; Movemos 4 a dl para multiplicar el índice de si
				mov ax, si  					; Movemos a ax el índice de si (porque dl multiplica por ax)
				mul dl						; Multiplicamos si por 4
				mov si, ax					; Muevo a si lo que está en ax (el índice multiplicado por 4)
				add al, 4   					; Sumo 4 al índice para ponerlo como condición de salida

				bucleMorse:
					cmp si, ax				; Si si = ax, significa que se terminó de codificar la letra
					je siguienteCaracter
					mov dh, morse[si]			; Muevo a dh un carácter de un símbolo morse
					mov [di], dh				; Guardo el código morse correspondiente a ese índice en la variable "codigo"
					inc di
					inc si
					jmp bucleMorse

		siguienteCaracter:
			inc bx
			jmp comparacion


    imprimir:
	mov ah, 9
	lea dx, codigo
	int 21h

    mov ax, 4c00h
    int 21h
main endp
end
