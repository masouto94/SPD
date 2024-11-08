.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    texto db 255 dup (24h), 0dh, 0ah, 24h

.code

    main proc

        mov ax, @data
        mov ds, ax

        lea bx, cartel
        call impresion

        lea bx, texto
        call carga

        lea bx, texto
        call conversion

        lea bx, texto
        call impresion
        
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
			cmp al, 0dh
			je finCarga
			mov [bx], al
			inc bx
			jmp proceso


		finCarga:
			ret
	carga endp


    conversion proc

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
            ret
    conversion endp

end

Este programa cambia los caracteres en minúscula por caracteres en mayúscula.