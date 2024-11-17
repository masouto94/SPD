.8086
.model small
.stack 100h

.data
	tabla db 'A .-    B -...   C -.-.   D -..    E .     F ..-.', 0dh, 0ah, \
			 'G --.   H ....   I ..     J .---   K -.-   L .-..', 0dh, 0ah, \
			 'M --    N -.     O ---    P .--.   Q --.-  R .-.', 0dh, 0ah, \
			 'S ...   T -      U ..-    V ...-   W .--   X -..-', 0dh, 0ah, \
			 'Y -.--  Z --..', 0dh, 0ah, 24h
	cartelJugador db 'Ingrese el código morse correspondiente de la palabra '
	palabra db 'computadora', 0dh, 0ah, 24h
	cartelModalidad db 	'Seleccione modalidad:', 0dh, 0ah, \
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
	cartelError db 'Intente de nuevo', 0dh, 0ah, 24h
	cartelExito db 'Felicitaciones', 0dh, 0ah, 24h
	codigo db 255 dup(24h), 0dh, 0ah, 24h; palabra en morse codificada por la función que traduce
	palabraUsuario db 255 dup(24h), 0dh, 0ah, 24h; la entrada del usuario
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
		call imprimirSalto

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
			call cargaUsuario
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


cargaUsuario proc

    lea bx, cartelJugador
    call impresion

    call traduccion

    call imprimirSalto

    lea bx, codigo
    push bx
    call contarCaracteresSt		    		; Se cuentan los caracteres de "codigo" para después hacer la comparación
    mov ah, 0
    mov longitud, al

    lea bx, longitudAscii					; Esto es para ver si se están contando bien los caracteres
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
            je meterPunto

        analizarRaya:
            cmp al, '-'
            je meterRaya

		jmp cargaMorse

        meterPunto:
            mov palabraUsuario[si], al
			call punto
            inc si
            jmp cargaMorse

		meterRaya:
            mov palabraUsuario[si], al
			call raya
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
        lea bx, cartelExito
        call impresion
        jmp finCargaUsuario

    salidaNo:
        lea bx, cartelError
        call impresion

    finCargaUsuario:
		lea bx, palabraUsuario
		call impresion
	ret

cargaUsuario endp


traduccion proc
    lea bx, palabra								; bx: índice para recorrer "palabra"
    lea di, codigo								; di: índice para recorrer "codigo" (palabra codificada)    


	recorrerPalabra:
		mov dl, [bx]							; Muevo a dl el carácter al que apunta bx
		cmp dl, 0dh
		je imprimir
		mov si, 0								; si: índice para recorrer alfabeto
		mov ax, 0

		recorrerAlfabeto:
			cmp si, 26
			je siguienteCaracter
			cmp dl, alfabeto[si]
			je codificar
			inc si
			jmp recorrerAlfabeto

		codificar:								; El registro si tiene guardado el índice del alfabeto (ej.: 'a' = 0, 'z' = 25)
			escribirSimbolo:
				mov caracter, dl				; Movemos a "caracter" lo que está en dl (el carácter a codificar)
				mov dl, 4 						; Movemos 4 a dl para multiplicar el índice de si
				mov ax, si  					; Movemos a ax el índice de si (porque dl multiplica por ax)
				mul dl							; Multiplicamos si por 4
				mov si, ax						; Muevo a si lo que está en ax (el índice multiplicado por 4)
				add al, 4   					; Sumo 4 al índice para ponerlo como condición de salida

				bucleMorse:
					cmp si, ax					; Si si = ax, significa que se terminó de codificar la letra
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
		inc ax
		inc bx
		jmp procesoContar

	finProcesoContar:
		pop bx
		pop bp
		ret 2
contarCaracteresSt endp


punto proc

	; Configurar el PIT para tono
	mov al, 00110100b  ; 34h - select channel 2, binary mode
	out 43h, al        ; Enviar el comando al PIT

	; Establecer la frecuencia (ejemplo: 440 Hz)
	mov ax, 6000      ; Calcular el valor (1193180 / frecuencia)
	out 42h, al        ; Enviar parte baja
	mov al, ah         ; Enviar parte alta
	out 42h, al

	; Habilitar el altavoz
	mov al, 03h        ; Activar el altavoz
	out 61h, al

	; Esperar un segundo (puedes ajustar el tiempo) = 0FFFh
	mov cx, 0333h
delay:
	mov dx, 0333h
delay_loop:
	nop
	dec dx
	jnz delay_loop
	dec cx
	jnz delay

	; Apagar el altavoz
	mov al, 00h        ; Desactivar el altavoz
	out 61h, al

	ret
punto endp


raya proc

	; Configurar el PIT para tono
	mov al, 00110100b  ; 34h - select channel 2, binary mode
	out 43h, al        ; Enviar el comando al PIT

	; Establecer la frecuencia (ejemplo: 440 Hz)
	mov ax, 6000      ; Calcular el valor (1193180 / frecuencia)
	out 42h, al        ; Enviar parte baja
	mov al, ah         ; Enviar parte alta
	out 42h, al

	; Habilitar el altavoz
	mov al, 03h        ; Activar el altavoz
	out 61h, al

	; Esperar un segundo (puedes ajustar el tiempo) = 0FFFh
	mov cx, 0999h
delay2:
	mov dx, 0999h
delay_loop2:
	nop
	dec dx
	jnz delay_loop2
	dec cx
	jnz delay2

	; Apagar el altavoz
	mov al, 00h        ; Desactivar el altavoz
	out 61h, al

	ret
raya endp


delay_corto proc
	; Un delay corto entre punto y raya
	mov cx, 0333h      ; Puedes ajustar este valor para un delay adecuado
delay_corto_loop:
	mov dx, 0FFFh
delay_corto_inner:
	nop
	dec dx
	jnz delay_corto_inner
	dec cx
	jnz delay_corto_loop

	ret
delay_corto endp


delay_largo proc
	; Un delay largo entre letras
	mov cx, 0999h      ; Puedes ajustar este valor para un delay adecuado
delay_largo_loop:
	mov dx, 0FFFh
delay_largo_inner:
	nop
	dec dx
	jnz delay_largo_inner
	dec cx
	jnz delay_largo_loop

	ret
delay_largo endp



end