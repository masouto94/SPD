.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    lectura db 255 dup (24h), 0dh, 0ah, 24h
    salidaSi db 'Su texto es palíndromo', 0dh, 0ah, 24h
    salidaNo db 'Su texto no es palíndromo', 0dh, 0ah, 24h

.code

main proc

    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset cartel
    int 21h

    mov bx, 0                   ; Inicializo contadores en 0
    mov si, 0

    carga:
        mov ah, 1
        int 21h
        cmp al, 20h             ; Si el carácter ingresado es espacio, vuelve a "carga" porque no queremos considerar los espacios
        je carga
        cmp al, 0dh             ; Si el carácter ingresado es enter, salta a finCarga
        je finCarga
        mov lectura[bx], al
        inc bx                  ; Al final de la carga, bx va a tener el largo de la cadena ingresada
        jmp carga
    
    finCarga:
        mov cx, bx
        dec bx                  ; Le resto 1 a bx para que coincida con el índice del último carácter
        jmp mayus

    mayus:
    
        primeraCondicion:                       ; Etiqueta para evaluar la primera condición (mayor o igual que 'a')
            mov dl, lectura[si]
            cmp dl, 61h                         ; Comparo el carácter con 'a'
            jae segundaCondicion
            inc si
            jmp mayus
        
        segundaCondicion:                       ; Etiqueta para evaluar la segunda condición (menor o igual que 'z')
            cmp dl, 7ah                         ; Comparo el carácter con 'z'
            jbe cambiarLetra
            inc si
            jmp mayus
        
        cambiarLetra:
            sub dl, 20h
            mov lectura[si], dl
            inc si
    loop mayus
    mov si, 0
    jmp proceso

    proceso:
        cmp si, bx              ; Si si > bx, significa que ya comparó todos los caracteres en espejo y es palíndromo
        ja esPal
        mov dl, lectura[si]     ; Muevo lectura[si] a dl para poder compararlo con lectura[bx]
        cmp dl, lectura[bx]
        jne noPal               ; Si no es igual, no es palíndromo
        dec bx                  ; Decremento bx e incremento si
        inc si
        jmp proceso

    esPal:
        mov ah, 9
        mov dx,0
        mov dx, offset salidaSi
        int 21h
        jmp fin                 ; Salta a "fin" para que no imprima "salidaNo"

    noPal:
        mov ah, 9
        mov dx, offset salidaNo       
        int 21h
    
    fin:
        mov ax, 4c00h
        int 21h   

main endp
end

Este programa verifica si una cadena es un palíndromo, considerando que los espacios no cuentan para la verificación.
Falta resolver el problema de las mayúsculas.