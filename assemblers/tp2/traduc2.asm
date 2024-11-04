.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto alfanumérico', 0dh, 0ah, 24h
    palabra db 255 dup(24h), 0dh, 0ah, 24h; palabra cargada desde el archivo
    codigo db 255 dup(24h), 0dh, 0ah, 24h; palabra en morse codificada por la función que traduce
    palabraUsuario db 255 dup(24h), 0dh, 0ah, 24h; la del usuario
    alfabeto db 'abcdefghijklmnopqrstuvwxyz', 0dh, 0ah, 24h
    tablaMorse db '.- ', '-... ', '-.-. ', '-.. ', '. ', '..-. ', '--. ', '.... ', '.. ', '.--- ', '-.- ', '.-.. ', '-- ', '-. ', '--- ', '.--. ', '--.- ', '.-. ', '... ', '- ', '..- ', '...- ', '.-- ', '-..- ', '-.-- ', '--.. ', 0dh, 0ah, 24h

.code

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    lea dx, cartel
    int 21h

    carga:
        mov ah, 1
        int 21h
        cmp al, 0dh
        je finCarga
        mov [bx], al
        inc bx
        jmp carga

    finCarga:
        lea bx, palabra							; bx: índice para recorrer "palabra"
	lea di, codigo							; di: índice para recorrer "codigo" (palabra codificada)

    comparacion:

	recorrerPalabra:
		mov dl, [bx]						; Muevo a dl el carácter al que apunta bx
		cmp dl, 0dh
		je imprimir
		mov si, 0						; si: índice para recorrer alfabeto

		recorrerAlfabeto:
			cmp si, 26
			je siguienteCaracter
			cmp dl, alfabeto[si]
			je codificar
			inc si
			jmp recorrerAlfabeto

		codificar:						; El registro si tiene guardado el índice del alfabeto (ej.: 'a' = 0, 'z' = 25)
			mov bp, 0					; bp: índice interno de cada símbolo morse
			escribirSimbolo:
				mov dh, tablaMorse[si+bp]		; Muevo a dh un carácter de un símbolo morse
				cmp dh, ' '
				je siguienteCaracter
				mov [di], dh				; Guardo el código morse correspondiente a ese índice en la variable "codigo"
				inc bp
				jmp escribirSimbolo

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
