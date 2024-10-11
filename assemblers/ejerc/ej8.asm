.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    texto db 255 dup(24h), 0dh, 0ah, 24h

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
        cmp texto[bx], 24h          ; Comparo con '$' en vez del enter porque, si no, se le suman 5 a todos los '$' de la variable original
        je imprimir
        mov al, texto[bx]
        add al, 5
        mov texto[bx], al
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

Este programa encripta un texto sumándole 5 a cada letra. No tiene verificación (o sea, también le suma 5 a cualquier otro carácter).