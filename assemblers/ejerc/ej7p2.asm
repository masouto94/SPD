.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    texto db 255 dup (24h), 0dh, 0ah, 24h
    largo db '000', 0dh, 0ah, 24h

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
        mov ax, 0
    
    proceso:
        cmp texto[bx], 0dh
        je convertir
        cmp texto[bx], 20h
        je verificarSiguiente
        inc bx
        jmp proceso

    verificarSiguiente:
        inc bx
        cmp texto[bx], 20h
        je proceso
    
    incrementar:
        inc ax
        inc bx
        jmp proceso
    
    convertir:
        inc ax                      ; Incremento ax en 1 porque la cantidad de palabras es 1 más que la cantidad de espacios
        mov dl, 100                 ; Proceso para hacer imprimible el número guardado en al
        div dl
        add al, 30h
        mov largo[0], al
        mov al, ah
        mov ah, 0
        mov dl, 10
        div dl
        add al, 30h
        mov largo[1], al
        add ah, 30h
        mov largo[2], ah
    
    imprimir:
        mov ah, 9
        mov dx, offset largo
        int 21h
    
    mov ax, 4c00h
    int 21h
main endp
end

Este programa cuenta las palabras de una cadena contando los espacios, pero verificando que el siguiente carácter sea una letra cuando encuentra un espacio.