.8086
.model small
.stack 100h

.data
	cartel db 'Ingrese un número binario de 8 dígitos:', 0dh, 0ah, 24h
	cartel2 db 'Usted ingresó el número '
	binario_en_ascii2 db '00000000', 0dh, 0ah, 24h
	binario_en_ascii db '00000000', 0dh, 0ah, 24h
	binario_en_reg db 0b


.code

main proc
	
	mov ax, @data
	mov ds, ax

	mov cx, 8

	lea bx, cartel
	call impresion

	lea bx, binario_en_ascii
	call carga

	lea bx, binario_en_ascii
	call asciiToBin

	mov cx, 8
	lea bx, binario_en_ascii2
	call binToAscii

	lea bx, cartel2
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
		push bx
		push cx

		proceso:
			mov ah, 1
			int 21h
			cmp al, 0dh
			je finCarga
			mov [bx], al
			inc bx
			jmp proceso

		finCarga:
			pop cx
			pop bx
			ret
	carga endp


	asciiToBin proc
		mov si, 0
		mov cx, 8

		proceso0:
			shl si, 1
			cmp byte ptr [bx], '1'
			jne siguiente0
			inc si

		siguiente0:
			inc bx
			loop proceso0

		mov ax, si
		mov ah, 0
		mov binario_en_reg, al

		ret
	asciiToBin endp


	binToAscii proc

		mov al, binario_en_reg

		proceso1:
			shl al, 1		; Desplazo un bit a la izquierda
			jc esUno		; Si hay carry, el bit era 1 (si no, era 0)
			mov byte ptr [bx], '0'
			inc bx
			jmp siguiente

		esUno:
			mov byte ptr [bx], '1'
			inc bx

		siguiente:
			loop proceso1

		ret
	binToAscii endp


end