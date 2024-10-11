.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, '$'
    texto db 5 dup(' '), 0dh, 0ah, '$'

.code

main proc

    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset cartel
    int 21h

    mov cx, 5
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
        cmp texto[bx], 0dh
        je imprimir
        inc bx
        jmp proceso
    
    imprimir:
        dec bx
        mov dl, texto[bx]
        mov ah, 2
        int 21h
        loop imprimir
    
    mov ax, 4c00h
    int 21h

main endp

end