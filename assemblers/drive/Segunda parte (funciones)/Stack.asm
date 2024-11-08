.8086
.model small
.stack 100h

.data
	numeroReg db 0
	binario_en_reg db 0b
	multiplicador db 100, 10, 1
	divisor db 100, 10, 1
	salto db 0dh, 0ah, 24h

.code

public cargaSt
public contarCaracteresSt
public regToAsciiSt


    cargaSt proc
		push bp
		mov bp, sp
		push bx
		push ax

        mov bx, ss:[bp+4]

        procesoCarga:
            mov ah, 1
            int 21h
            cmp al, 0dh
            je finCargaSt
            mov [bx], al
            inc bx
            jmp procesoCarga

        finCargaSt:
            pop bx
            pop ax
            pop bp
            ret 4
    cargaSt endp


    contarCaracteresSt proc
		push bp
		mov bp, sp
		push bx

        mov bx, ss:[bp+4]
        mov ax, 0

        procesoContar:
            cmp byte ptr [bx], 0dh
            je finProcesoContar
            inc ax
            inc bx
            jmp procesoContar

        finProcesoContar:
            pop bx
            pop bp
            ret 2
    contarCaracteresSt endp


    regToAsciiSt proc
		push bp
		mov bp, sp
        push ax
		push cx
		push si
        push dx
		push bx

        mov bx, ss:[bp+4]
        mov ax, ss:[bp+6]

		mov si, 0
		mov cx, 3
        mov dx, 0
		
		procesoR2A:
			mov dl, divisor[si]
			div dl
			add al, 30h
			mov byte ptr [bx], al
			mov al, ah
			mov ah, 0
			inc bx
			inc si
		    loop procesoR2A

		pop bx
        pop dx
		pop si
		pop cx
        pop ax
		pop bp
        ret 4
    regToAsciiSt endp

end