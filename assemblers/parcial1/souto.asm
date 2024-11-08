.8086
.model small
.stack 100h

; El puntaje de este ejercicio contará como 6 puntos 

; Consigna:
; Realizar un programa en assembler que genere un texto de hasta 100 caracteres, usando 2 caracteres a elección, el sistema debe preguntar cuantos caracteres se desean generar, y luego pedir de a uno los 2 caracteres sobre los que se generará el texto. EL SISTEMA DEBE COMPROBAR QUE LA CANTIDAD DE CARACTERES GENERADA NO SUPERE LOS 100

; Luego de generado el texto debe mostrarlo en pantalla. 
; Ej:
; INGRESE CANTIDAD DEL CARACTER 1: 5
; QUE CARACTER DESEA INGRESAR:  T

; INGRESE CANTIDAD DEL CARACTER 2: 5
; QUE CARACTER DESEA INGRESAR:  5

; SU TEXTO TIENE 10 CARACTERES, NO SOBREPASA EL MAXIMO

; SU TEXTO ES:
; TTTTT55555
.data
	inputCharA		db "Ingrese el caracter 1:",0Dh, 0Ah, 24h
	inputQuantity	db 0Dh, 0Ah,"Que cantidad desea ingresar?:",0Dh, 0Ah, 24h
	inputCharB		db 0Dh, 0Ah,"Ingrese el caracter 2:",0Dh, 0Ah, 24h

	charAQuantityToREG	db	'000',"$"
	charBQuantityToREG	db	'000',"$"
	
	charAQuantity	db	0
	charBQuantity	db	0
	generatedText	db	100 dup('$'),0Dh,0Ah,24h
	charA			db	"_", 0Dh,0Ah,24h
	charB			db	"_", 0Dh,0Ah,24h
	sizes			db 	1,10,100
	errorMessage	db 	0Dh,0Ah,"El valor de los chars ingresados es mayor a 100", 24h

.code

main proc
	mov ax, @data
	mov ds, ax
	mov bx,0
	mov si,0

promptCharA:
	mov ah,9
	mov dx, offset inputCharA
	int 21h

loadCharA:
	mov ah, 1
	int 21h
	cmp al, 0Dh
	je promptCharAQuantity
	mov charA, al
	jmp loadCharA

promptCharAQuantity:
	mov ah,9
	mov dx, offset inputQuantity
	int 21h

loadCharAQuantity:
	cmp bx,3
	je ASCIIToRegA
	mov ah, 1
	int 21h
	cmp al, 0Dh
	je ASCIIToRegA
	mov charAQuantityToREG[bx], al
	inc bx
	jmp loadCharAQuantity

ASCIIToRegA:

	dec bx
	mov al, charAQuantityToREG[bx]
	sub al, 30h
	mov dl, sizes[bx]
	mul dl

	add charAQuantity, al
	cmp dl, 1
	je promptCharB
	jmp ASCIIToRegA

promptCharB:
	mov bx,0
	mov ah,9
	mov dx, offset inputCharB
	int 21h

loadCharB:
	mov ah, 1
	int 21h
	cmp al, 0Dh
	je promptCharBQuantity
	mov charB, al
	jmp loadCharB

promptCharBQuantity:
	mov ah,9
	mov dx, offset inputQuantity
	int 21h

loadCharBQuantity:
	mov ah, 1
	int 21h
	cmp al, 0Dh
	je ASCIIToRegB
	mov charBQuantityToREG[bx], al
	inc bx
	jmp loadCharBQuantity

ASCIIToRegB:
	dec bx
	mov al, charBQuantityToREG[bx]
	sub al, 30h
	mov dl, sizes[bx]
	mul dl

	add charBQuantity, al
	cmp dl, 1
	je checkLength
	jmp ASCIIToRegB

checkLength:
	mov ax,0
	add al, charAQuantity
	add al, charBQuantity
	cmp al, 100
	ja	error

setCharALoop:
	mov cl, charAQuantity
	mov bx,0
	mov al, charA

generateCharAText:
	cmp cx,bx
	je setCharBLoop
	mov	generatedText[bx], al
	inc bx
	jmp generateCharAText

setCharBLoop:
	xor cx, cx
	add cl, charBQuantity
	mov ax,0
	mov al, charB
	
generateCharBText:
	cmp si, cx
	je finish
	mov	generatedText[bx], al
	inc si
	inc bx
	jmp generateCharBText

finish:
	mov ah,9
	mov dx, offset generatedText
	int 21h
	jmp exitProgram
error:
	mov ah,9
	mov dx, offset errorMessage
	int 21h

exitProgram:
	mov ax, 4c00h
	int 21h
main endp

end main