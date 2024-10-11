.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    texto db 255 dup (24h), 0dh, 0ah, 24h

.code

main proc

    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset cartel
    int 21h

    mov bx, 0

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
    
    proceso:

        cmp texto[bx], 0dh          	        ; Comparo el carácter con enter
        je imprimir
    
        primeraCondicion:                       ; Etiqueta para evaluar la primera condición (mayor o igual que 'a')
            mov dl, texto[bx]
            cmp dl, 61h                         ; Comparo el carácter con 'a'
            jae segundaCondicion
            inc bx
            jmp proceso
        
        segundaCondicion:                       ; Etiqueta para evaluar la segunda condición (menor o igual que 'z')
            mov dl, texto[bx]
            cmp dl, 7ah                         ; Comparo el carácter con 'z'
            jbe cambiarLetra
            inc bx
            jmp proceso
        
        cambiarLetra:
            sub dl, 20h
            mov texto[bx], dl
            inc bx
            jmp proceso
    
    imprimir:
        mov ah, 9
        mov dx, offset texto
        int 21h
    
    mov ax, 4c00h
    int 21h

main endp
end

Este programa cambia los caracteres en minúscula por caracteres en mayúscula.