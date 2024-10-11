.8086
.model small
.stack 100h

.data
	message		db "Ingrese un texto:",0dh,0ah,24h
	textInput	db 255 dup ("$")
	container	db '000',24h
	palabras	db 0

.code
main proc
	mov ax, @data
	mov ds, ax
	
	mov bx,0
	mov si,0
	mov ah, 9
	mov dx, offset message
	int 21h

carga:
	mov ah, 1
	int 21h
	cmp al, 0dh
	je contarPalabras
	mov textInput[bx], al
	inc bx
	jmp carga

contarPalabras:
	cmp si, bx
	je regToASCII
	cmp textInput[si], 20h
	je verificarEspacio
	inc si
	jmp contarPalabras

verificarEspacio:
	inc si
	cmp textInput[si], 20h
	jne sumarPalabra
	jmp contarPalabras

sumarPalabra:
	add palabras, 1
	jmp contarPalabras
regToASCII:
	mov ax,0
	add palabras,1
	mov al, palabras
	mov dl, 100
	div dl
	add al, 30h
	mov container[0], al
	mov al, ah
	mov ah,0
	mov dl, 10
	div dl
	add al, 30h
	mov container[1], al
	mov al, ah
	mov ah,0
	add al, 30h
	mov container[2], al
	jmp prompt 

prompt:
	mov ah,9
	mov dx, offset container
	int 21h


finish:
	mov ax, 4c00h
	int 21h	
main endp

end main