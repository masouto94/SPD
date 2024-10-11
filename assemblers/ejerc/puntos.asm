.8086
.model small
.stack 100h

.data
   cadena db 255 dup (24h)
   texto2 db 0dh, 0ah,'La cantidad de puntos fueron:',24h
   puntos db 0

.code

main proc 
	mov ax, @data
	mov ds, ax

reinicio:
	xor bx, bx
	mov puntos, 0

carga:
	cmp bx, 255
	je inicializar
	mov ah,1
	int 21h
	mov cadena[bx], al
	cmp cadena[bx], 0dh
	je inicializar
	cmp cadena[bx], '/'
	je reinicio
	inc bx
	jmp carga

inicializar:
	xor bx, bx
	jmp proceso

punto:
        
	mov cadena[bx], ';'
	add puntos, 1
	inc bx
	jmp proceso


proceso:
	cmp cadena[bx], 0dh
	je finproce
	cmp cadena[bx], '.'
	je punto
	inc bx
	jmp proceso
finproce:

	mov ah, 9
	mov dx, offset cadena
	int 21h

	mov ah, 9
	mov dx, offset texto2
	int 21h

   mov al, puntos         
   add al, '0'                

	mov dl, al                 
	mov ah, 2                  
	int 21h
	mov ax, 4c00h
	int 21h

main endp
end main