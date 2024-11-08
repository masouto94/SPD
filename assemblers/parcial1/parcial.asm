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
	inputQuantity	db "Que cantidad desea ingresar?:",0Dh, 0Ah, 24h
	inputCharB		db "Ingrese el caracter 2:",0Dh, 0Ah, 24h

	charAQuantityToREG	db	'000',"$"
	charBQuantityToREG	db	'000',"$"
	
	charAQuantity	db	0
	charBQuantity	db	0
	generatedText	db	100 dup('$'),0Dh,0Ah,24h
	charA			db	"_", 0Dh,0Ah,24h
	charB			db	"_", 0Dh,0Ah,24h

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
	mov al, charAQuantityToREG[0]
	sub al, 30h
	add charAQuantity, al
	mov al, charAQuantityToREG[1]
	sub al, 30h
	add charAQuantity, al
	mov al, charAQuantityToREG[2]
	sub al, 30h
	add charAQuantity, al

promptCharB:
	mov bx,0
	mov ah,9
	mov dx, offset inputCharB
	int 21h

loadCharBQuantity:
	cmp bx,3
	je ASCIIToRegB
	mov ah, 1
	int 21h
	cmp al, 0Dh
	je ASCIIToRegB
	mov charBQuantityToREG[bx], al
	inc bx
	jmp loadCharBQuantity

ASCIIToRegB:
	mov al, charBQuantityToREG[0]
	sub al, 30h
	add charBQuantity, al
	mov al, charBQuantityToREG[1]
	sub al, 30h
	add charBQuantity, al
	mov al, charBQuantityToREG[2]
	sub al, 30h
	add charBQuantity, al

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
	add cx, 1 ;Offset de la siguiente posicion
	mov bx, cx ;arranco a indexar aca
	mov si,bx
	mov ax,0
	mov al, charBQuantity
	add si, ax
	mov al, charB
	
generateCharBText:
	cmp si, bx
	je finish
	mov	generatedText[bx], al
	inc si

finish:
	mov ah,9
	mov dx, offset generatedText
	int 21h
exitProgram:
	mov ax, 4c00h
	int 21h
main endp

end main