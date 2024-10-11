.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    texto db 255 dup (24h), 0dh, 0ah, 24h
    vocalesASCII db 41h, 45h, 49h, 4Fh, 55h, 61h, 65h, 69h, 6Fh, 75h
    largoPrint db '000', 0dh, 0ah, 24h

.code

main proc

    mov ax, @data
    mov ds, ax

    mov bx, 0                       ; Contador de caracteres
    mov di, 0                       ; Contador de vocales

    mov ah, 9
    mov dx, offset cartel
    int 21h

    carga:
        mov ah, 1
        int 21h
        cmp al, 0dh
        je finCarga
        mov texto[bx], al
        inc bx
    jmp carga

    finCarga:
        mov bx, 0

    recorrerCadena:
        cmp texto[bx], 0dh
        je convertir
        mov si, 0
        compararConVocales:
            cmp si, 10                          ; Si "si" es 10, ya terminó de comparar con todas las vocales
            je siguienteCaracter
            mov al, vocalesASCII[si]
            cmp al, texto[bx]
            je incrementar
            inc si
            jmp compararConVocales
    
    siguienteCaracter:
        inc bx
        jmp recorrerCadena
    
    incrementar:
        inc di
        jmp siguienteCaracter

    convertir:
        mov ax, di                  ; Muevo la cantidad de vocales (di) a ax
        mov dl, 100                 ; El divisor debe ser 100 para que el cociente sea el primer dígito
        div dl                      ; Se divide el largo por 100
        add al, 30h                 ; Hago imprimible el número que me dio el cociente (centenas)
        mov largoPrint[0], al       ; Muevo el cociente al primer dígito de largoPrint
        mov al, ah                  ; El resto se mueve al cociente
        mov ah, 0                   ; Limpio parte alta de ax
        mov dl, 10                  ; Ahora se divide por 10
        div dl
        add al, 30h                 ; Hago imprimible el número que me dio el cociente (decenas)
        mov largoPrint[1], al
        add ah, 30h                 ; Hago imprimible el número que me dio el resto (unidades)
        mov largoPrint[2], ah
    
    imprimir:
        mov ah, 9
        mov dx, offset largoPrint
        int 21h
    
    mov ax, 4c00h
    int 21h

main endp
end

Este programa cuenta e imprime la cantidad de vocales de una cadena.