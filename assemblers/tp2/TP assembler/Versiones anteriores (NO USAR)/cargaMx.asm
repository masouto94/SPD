.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese el código', 0dh, 0ah, 24h
    cartelError db 'Intente de nuevo', 0dh, 0ah, 24h
    cartelExito db 'Felicitaciones', 0dh, 0ah, 24h
    codigo db 255 dup(24h), 0dh, 0ah, 24h; palabra en morse codificada por la función que traduce
    ;elCodigo db '... --- ... ', 0dh, 0ah, 24h
    palabra db 'perro', 0dh, 0ah, 24h; palabra cargada desde el archivo (AHORA HARDCODEADA)
    palabraUsuario db 255 dup(24h), 0dh, 0ah, 24h; la del usuario
    alfabeto db 'abcdefghijklmnopqrstuvwxyz', 0dh, 0ah, 24h
    morse db '.-**', '-...', '-.-.', '-..*', '.***', '..-.', '--.*', '....', '..**', '.---', '-.-*', '.-..', '--**', '-.**', '---*', '.--.', '--.-', '.-.*', '...*', '-***', '..-*', '...-', '.--*', '-..-', '-.--', '--..', 0dh, 0ah, 24h
    caracter db ' ', 0dh, 0ah, 24h
    longitud db 0
    longitudUsuario db 0
    longitudAscii db '000', 0dh, 0ah, 24h

.code

extrn imprimirSalto:proc
extrn impresion:proc
extrn carga:proc
extrn mayusculizador:proc
;extrn contarCaracteresSt:proc
extrn regToAscii:proc

main proc
    mov ax, @data
    mov ds, ax

    lea bx, cartel
    call impresion

    call traduccion

    call imprimirSalto

    lea bx, codigo
    push bx
    call contarCaracteresSt		    ; Se cuentan los caracteres de "codigo" para después hacer la comparación
    mov ah, 0
    mov longitud, al

    lea bx, longitudAscii                  ; Esto es para ver si se están contando bien los caracteres
    call regToAscii
    lea bx, longitudAscii
    call impresion

    mov ax, 0
    mov si, 0

    cargaMorse:
        mov ah, 1
        int 21h
        cmp al, 0dh
        je preComparacion
        cmp al, 20h
        je tokenizarMorse

        analizarPunto:
            cmp al, '.'
            je meter

        analizarRaya:
            cmp al, '-'
            je meter

	jmp cargaMorse

        meter:
            mov palabraUsuario[si], al
            inc si
            jmp cargaMorse

        tokenizarMorse:
            mov dl, 4                       ; Muevo 4 a dl
            mov ax, si                      ; Muevo si a ax
            div dl                          ; Divido si por 4 para quedarme con el resto (resto = cantidad de rayas y puntos del símbolo morse)
            cmp ah, 0
            je cargaMorse
            sub dl, ah                      ; Eso se lo resto a 4 para tener la cantidad de espacios (queda guardada en dl)
            mov ch, 0
            mov cl, dl                      ; Guardo en cx la cantidad de espacios
            completarAsteriscos:
                mov palabraUsuario[si], '*'
                inc si
                loop completarAsteriscos
            jmp cargaMorse

    preComparacion:
        mov ax, si
        mov ah, 0
        mov longitudUsuario, al              ; Almacenamos cantidad de caracteres de lo que ingresó el usuario

        mov si, 0
        mov ch, 0
        mov cl, longitud                     ; Almacenamos la cantidad de caracteres de "codigo" en CX para hacer el loop
            
    comparacion:
        mov dl, palabraUsuario[si]
        cmp dl, codigo[si]
        jne salidaNo
        inc si
        loop comparacion

    mov ah, 0                               ; Esto se hace para ver si el usuario se pasó de caracteres
    mov al, longitudUsuario                 ; Si la longitud es distinta al contador SI, es porque metió caracteres de más
    cmp si, ax
    jne salidaNo

    salidaSi:
        mov ah, 9
        lea dx, cartelExito
        int 21h
        jmp fin

    salidaNo:
        mov ah, 9
        lea dx, cartelError
        int 21h

    fin:
	lea bx, palabraUsuario
	call impresion
        mov ax, 4c00h
        int 21h
main endp


traduccion proc

    lea bx, palabra								; bx: índice para recorrer "palabra"
    lea di, codigo								; di: índice para recorrer "codigo" (palabra codificada)


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
			jmp recorrerPalabra


    imprimir:
	mov ah, 9
	lea dx, codigo
	int 21h

    ret
traduccion endp



    contarCaracteresSt proc
		push bp
		mov bp, sp
		push bx

        mov bx, [ss:bp+4]
        mov ax, 0

        procesoContar:
            cmp byte ptr [bx], 24h
            je finProcesoContar
	    ;cmp byte ptr [bx], '*'
	    ;je ignorar
            inc ax
            inc bx
            jmp procesoContar

	;ignorar:
	    ;inc bx
	    ;jmp procesoContar

        finProcesoContar:
            pop bx
            pop bp
            ret 2
    contarCaracteresSt endp





end