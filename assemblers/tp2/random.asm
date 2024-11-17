
.8086
.model small
.stack 100h
.data
    seed dw 0
    promptSeed  db "Ingrese la semilla",0dh,0ah,24h
    salto db 0dh,0ah,24h
    regres db 0
    res db "000",24h
    divisor db 100, 10, 1

.code
main proc
	mov ax,@data
	mov ds,ax
    mov ah,9
    lea dx, promptSeed
    int 21h
    lea dx, salto
    int 21h
    mov ah,1
    int 21h
    
    mov seed, ax
    mov si,1
    mov di,1
    
    cmp al,'z'
    je fin
    mov cx,6
    semillero: 
        int 81h
        add di, ax
        add si, di
        loop semillero


fin:
    mov regres,ah
    lea bx, res
    mov si,0
    call regToAscii
    mov ah,9
    lea dx, salto
    int 21h
    
    lea dx, res
    int 21h
	mov ax,4C00h
    int 21h  
main endp

	regToAscii proc					; La función recibe en bx el offset de numeroReg para devolverlo como ASCII
		push ax
		push si
		push cx
		push bx

        mov ah, 0					; Estas dos instrucciones las uso
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
end

