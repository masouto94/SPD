.8086
.model small
.stack 100h

.data
	cartel db 'Ingrese un texto (hasta 50 caracteres)', 0dh, 0ah, 24h
	texto db 255 dup(24h), 0dh, 0ah, 24h

.code

	main proc
		mov ax, @data
		mov ds, ax

		mov cx, 50							; Para que los loops no se hagan más de 50 veces

		lea bx, cartel
		call impresion

		lea bx, texto						; No hago push-pop con BX para tenerlo "sucio" (con la dirección del último carácter de "texto")
		call carga

		call imprimirAlReves				; Esta función imprime los caracteres de "texto" uno por uno, de atrás para adelante

		mov ax, 4c00h
		int 21h
	main endp


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


	impresion proc
		push bx

		mov ah, 9
		lea dx, [bx]
		int 21h

		pop bx
		ret
	impresion endp

	imprimirAlReves proc
		proceso2:
			dec bx								; Se decrementa BX en uno porque el último carácter es '$'
			mov dl, [bx]
			cmp bx, offset texto				; Si BX tiene la dirección del primer carácter, salta a imprimir el último
			je finImprimirAlReves
			mov ah, 2
			int 21h
			loop proceso2

		finImprimirAlReves:						; Esta etiqueta es para imprimir el último carácter (en vez de loopear, termina)
			mov ah, 2
			int 21h
			ret
	imprimirAlReves endp

end