.8086
.model small
.stack 100h

.data
	numeroReg db 0
	multiplicador db 100, 10, 1
	divisor db 100, 10, 1

.code

public asciiToReg
public regToAscii
public impresion
public carga
public contarEspacios


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


	asciiToReg proc					; La función recibe en bx el offset de numeroAscii para devolverlo como registro
		push ax
		push si
		push cx
		push bx

		mov ax, 0
		mov si, 0
		mov cx, 3

		proceso0:
			mov al, [bx]
			sub al, 30h
			mov dl, multiplicador[si]
			mul dl
			add numeroReg, al
			inc bx
			inc si
			mov ax, 0
			loop proceso0

		pop bx
		pop cx
		pop si
		pop ax		
		ret
	asciiToReg endp


	regToAscii proc					; La función recibe en bx el offset de numeroReg para devolverlo como ASCII
		push ax
		push si
		push cx
		push bx

        	;mov ah, 0				; Estas dos instrucciones las uso
        	;mov al, numeroReg			; solamente si no tengo el número en ax
		mov si, 0
		mov cx, 3

		proceso2:
			mov dl, divisor[si]
			div dl
			add al, 30h
			mov [bx], al
			mov al, ah
			mov ah, 0
			inc bx
			inc si
			loop proceso2

		pop bx
		pop cx
		pop si
		pop ax		
		ret
	regToAscii endp


	contarEspacios proc
		push bx
		mov ax, 0
		proceso3:
			cmp byte ptr [bx], 24h
			je finContarEspacios
			cmp byte ptr [bx], 20h
			je contarEspacio
			inc bx
			jmp proceso3

		contarEspacio:
			inc ax
			inc bx
			jmp proceso3

		finContarEspacios:
			pop bx
			ret
	contarEspacios endp

end