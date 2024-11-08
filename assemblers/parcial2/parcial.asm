.8086
.model small
.stack 100h
.386
.data
    prompt  db  "Ingrese el texto",0dh,0ah,24h
    texto   db  255 dup("$"), 0dh, 0ah, 24h
    finPrograma db  "Fin del programa",0dh,0ah,24h
    help    db "1 para contar espacios",0dh,0ah,"2 para contar parrafos",0dh,0ah,"3 para contar caracteres",0dh,0ah,"4 para contar numeros",0dh,0ah,"5 para contar todo",0dh,0ah,"0 para finalizar",0dh,0ah,24h
    opcion  db  0
    opcionInvalida  db "La opcion no es valida. Ingrese un valor de los siguientes:",0dh,0ah,24h
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
    lea dx, salto
    int 21h
   
    mov ah,1 
    int 21h
    mov ah,0
    mov [separador], ax
    xor ax,ax

cargarTexto:
    mov ah,9
    lea dx, salto
    int 21h
    lea dx, prompt
    int 21h
    
    lea bx, texto
    push separador
    call cajaCarga

inicio:
    xor dx,dx
    lea bx, texto
    call mostrarMenu
    mov [opcion], dl
    cmp opcion,0

    je finish
    
    cmp opcion,1
    je contarEspacios
    
    cmp opcion,2
    je contarParrafo

    cmp opcion,3
    je contarCaracteres

    cmp opcion,4
    je contarNumeros

    
contarEspacios:
    call contadorEspacios
    mov cantEspacioReg,al
    lea bx, cantEspacio
    call regToAscii
    mov ah, 9
    mov dx, offset salto
    int 21h
    mov dx, offset cantEspacio
    int 21h
    cmp opcion,5
    jne inicio

lea bx, texto
contarParrafo:
    call contadorParrafo
    mov cantParrafoReg,al
    lea bx, cantParrafo
    call regToAscii
    mov ah, 9
    mov dx, offset salto
    int 21h
    mov dx, offset cantParrafo
    int 21h
    cmp opcion,5
    jne inicio

lea bx, texto
contarCaracteres:
    call contadorCaracteres
    mov cantCaracteresReg,al
    lea bx, cantCaracteres
    call regToAscii
    mov ah, 9
    mov dx, offset salto
    int 21h
    mov dx, offset cantCaracteres
    int 21h
    cmp opcion,5
    jne inicio

lea bx, texto
contarNumeros:
    call contadorNumeros
    mov cantNumerosReg,al
    lea bx, cantNumeros
    call regToAscii
    mov ah, 9
    mov dx, offset salto
    int 21h
    mov dx, offset cantNumeros
    int 21h
    cmp opcion,5
    jne inicio


jmp inicio
finish:
    mov ah,9
    lea dx, finPrograma
    int 21h
    mov ax,4c00h
    int 21h

main endp

mostrarMenu proc
    push ax
    ;dx == Se guarda el valor de la opcion    

    mostrarOpciones_mostrarMenu:
        mov ah, 9
        lea dx, help
        int 21h
        mov ah,1
        int 21h
        mov ah,0
        cmp al, 30h         ;0 ascii
        jb opcionInvalida_mostrarMenu
        cmp al, 35h         ;4 ascii
        ja opcionInvalida_mostrarMenu
        sub al, 30h
        jmp return_mostrarMenu
    
    opcionInvalida_mostrarMenu:
        mov ah, 9
        lea dx, opcionInvalida
        int 21h
        jmp mostrarOpciones_mostrarMenu

    return_mostrarMenu:
        mov ah, 9
        lea dx, salto
        int 21h
        mov dx, ax
        pop ax
        ret
mostrarMenu endp
end