.8086
.model small
.stack 100h

.data
    prompt  db  "Ingrese el texto",0dh,0ah,24h
    texto   db  255 dup("$"), 0dh, 0ah, 24h
    help    db "1 para contar espacios",0dh,0ah,"2 para contar parrafos",0dh,0ah,"3 para contar caracteres",0dh,0ah,"4 para contar numeros",0dh,0ah,"0 para finalizar",0dh,0ah,24h
    promptSeparador db "Ingrese el separador",0dh,0ah,24h
    separador   dw "-"
    
    cantEspacioReg db 0
    cantParrafoReg db 0
    cantCaracteresReg db 0
    cantNumerosReg db 0
    
    salto   db 0dh, 0ah,24h
    
    cantEspacio db '000 Espacios',0dh, 0ah, 24h
    cantParrafo db '000 Parrafos',0dh, 0ah, 24h
    cantCaracteres db '000 Caracteres',0dh, 0ah, 24h
    cantNumeros db '000 Numeros',0dh, 0ah, 24h
.code

extrn regToASCII:proc
extrn asciiToReg:proc
extrn cajaCarga:proc
extrn contadorEspacios:proc
extrn contadorNumeros:proc
extrn contadorCaracteres:proc
extrn contadorParrafo:proc
main proc
    mov ax, @data
    mov ds,ax
    mov ah, 9
    lea dx, promptSeparador
    int 21h
   
    mov ah,1 
    int 21h
    mov ah,0
    mov [separador], ax
    xor ax,ax
inicio:
    call mostrarMenu
    lea bx, texto
    push separador
    call cajaCarga
    cmp dl,0
    je finish
    cmp dl,1
    je contarEspacios
    
    jmp inicio
    mov ah,9
    lea dx, prompt
    lea bx, texto
    int 21h
    
contarEspacios:
    call contadorEspacios
    mov cantEspacioReg,al
    mov ah,0
    xor bx,bx
    lea bx, cantEspacio
    call regToAscii
    mov ah, 9
    mov dx, offset salto
    int 21h
    mov dx, offset cantEspacio
    int 21h
    jmp inicio
lea bx, texto
contarParrafo:
    xor ax, ax
    call contadorParrafo
    mov cantParrafoReg,al
    lea bx, cantParrafo
    call regToAscii

lea bx, texto
contarCaracteres:
    xor ax, ax
    call contadorCaracteres
    mov cantCaracteresReg,al
    lea bx, cantCaracteres
    call regToAscii

lea bx, texto
contarNumeros:
    xor ax, ax
    call contadorNumeros
    mov cantNumerosReg,al
    lea bx, cantNumeros
    call regToAscii

finish:
    mov ah, 9
    mov dx, offset salto
    int 21h
    mov dx, offset cantEspacio
    int 21h
    mov dx, offset cantParrafo
    int 21h
    mov dx, offset cantCaracteres
    int 21h
    mov dx, offset cantNumeros
    int 21h
    mov ax,4c00h
    int 21h
main endp






mostrarMenu proc
    push ax
    ;esperamos de dx un valor		
		mov ah, 9
        lea dx, help
 		int 21h
        mov ah,1
        int 21h
        mov ah,0
        sub al, 30h
 		mov dx, ax
 		pop ax
    ret
mostrarMenu endp
end