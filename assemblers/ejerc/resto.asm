.8086
.model small
.stack 100h

.data
	output db '000', 0dh, 0ah, 24h
	inputDividendo 	db "Ingrese el dividendo:",0dh,0ah,24h
	inputDivisor	db "Ingrese el divisor:",0dh,0ah,24h
	dividendoAscii db '000',24h 
	divisorAscii db '000',24h
	dividendo db 0 
	divisor db 0
	resultado db 0
	parsers db 100,10,1
.code

main proc
	mov ax, @data
	mov ds, ax
	mov si, 0
	mov bx, 0


	mov ah,9
	mov dx, offset inputDividendo
	int 21h
cargarDividendoAscii:
	mov ah,1
	int 21h
	cmp al, 0dh
	je parsearDividendo
	mov dividendoAscii, al
	inc bx
	jmp cargarDividendoAscii

promptDivisor:
	mov ah,9
	mov dx, offset inputDivisor
	int 21h
	jmp cargarDivisorAscii
cargarDivisorAscii:
	mov ah,1
	int 21h
	cmp al, 0dh	
	je parsearDivisor
	mov divisorAscii, al
	inc bx
	jmp cargarDivisorAscii
	
parsearDividendo:
	cmp si,bx
	je resetCounter
	mov al, dividendoAscii[si]
	sub al, 30h
	mov dl, parsers[si]
	mul dl
	mov dividendo, al
	inc si
	mov ax,0
	jmp parsearDividendo


resetCounter:
	mov si,0
	mov bx,0
	jmp promptDivisor

parsearDivisor:
	cmp si,bx
	je print
	mov al, divisorAscii[si]
	sub al, 30h
	mov dl, parsers[si]
	mul dl
	mov divisor, al
	inc si
	mov ax,0
	jmp print

print:
	mov al, dividendo
	mov dl, divisor
	div dl
	mov resultado,ah
	add resultado, 30h
	mov cl, resultado
	mov output, cl

	mov ah,9
	mov dx, offset output
	int 21h
	mov ax, 4c00h
	int 21h
main endp
end