.8086
.model small
.stack 100h

.data
	cartel db 'Ingrese un texto', 0dh, 0ah, 24h
	texto db 255 dup(24h), 0dh, 0ah, 24h
	textoModificado db 255 dup(24h), 0dh, 0ah, 24h
	salto db 0dh, 0ah, 24h

.code

	main proc
		mov ax, @data
		mov ds, ax

		lea bx, cartel
		call impresion

		lea bx, texto
		call carga

		lea bx, texto
		lea si, textoModificado
		call cambiarLetra

		lea bx, textoModificado
		call impresion

		mov ax, 4c00h
		int 21h
	main endp


	carga proc
		push bx

		proceso:
			mov ah, 1
			int 21h
			cmp al, 0dh
			je finCarga
			mov [bx], al
			inc bx
			jmp proceso


		finCarga:
			pop bx
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


	cambiarLetra proc
		push bx

		comparar:
			cmp byte ptr [bx], 0dh
			je finCambiarLetra
			cmp byte ptr [bx], 'a'
			je cambio
			mov al, [bx]
			mov [si], al
			inc bx
			inc si
			jmp comparar

		cambio:
			mov byte ptr [si], 'x'
			inc bx
			inc si
			jmp comparar

		finCambiarLetra:
			pop bx
			ret
	cambiarLetra endp

end