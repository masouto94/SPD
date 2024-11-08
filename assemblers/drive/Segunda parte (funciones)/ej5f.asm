.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    lectura db 255 dup (24h), 0dh, 0ah, 24h
    longitud db '000', 0dh, 0ah, 24h
    salidaSi db 'Su texto es palíndromo', 0dh, 0ah, 24h
    salidaNo db 'Su texto no es palíndromo', 0dh, 0ah, 24h

.code

main proc

    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset cartel
    int 21h

    lea bx, lectura
    call carga			; bx queda en el último carácter después de esta función

    call conversion

    lea si, lectura		; si empieza en el offset de "lectura"
    call comparacion
    
    fin:
        mov ax, 4c00h
        int 21h   

main endp


	impresion proc
		push bx

		mov ah, 9
		lea dx, [bx]
		int 21h

		pop bx
		ret
	impresion endp


	carga proc

		proceso:
			mov ah, 1
			int 21h
			cmp al, 20h
			je proceso
			cmp al, 0dh
			je finCarga
			mov [bx], al
			inc bx
			jmp proceso

		finCarga:
			ret
	carga endp


    conversion proc
	push bx

	lea bx, lectura

        proceso1:

            cmp byte ptr [bx], 0dh
            je finConversion

            primeraCondicion:                       ; Etiqueta para evaluar la primera condición (mayor o igual que 'a')
                mov dl, [bx]
                cmp dl, 61h                         ; Comparo el carácter con 'a'
                jae segundaCondicion
                inc bx
                jmp proceso1

            segundaCondicion:                       ; Etiqueta para evaluar la segunda condición (menor o igual que 'z')
                mov dl, [bx]
                cmp dl, 7ah                         ; Comparo el carácter con 'z'
                jbe cambiarLetra
                inc bx
                jmp proceso1

            cambiarLetra:
                sub dl, 20h                         ; Si es letra minúscula, la paso a mayúscula
                mov [bx], dl                        ; Muevo la letra mayúscula a donde apunta BX
                inc bx
                jmp proceso1

        finConversion:
	    pop bx
            ret
    conversion endp



	comparacion proc
		dec bx
		proceso2:
			cmp si, bx
			jae esPalindromo
			mov dl, [si]
			cmp dl, [bx]
			jne noEsPalindromo
			dec bx
			inc si
			jmp proceso2

		esPalindromo:
			lea bx, salidaSi
			call impresion
			jmp finComparacion

		noEsPalindromo:
			lea bx, salidaNo
			call impresion

		finComparacion:
			ret
	comparacion endp


end

