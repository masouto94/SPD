.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    texto db 255 dup (24h), 0dh, 0ah, 24h
    largo db '0', 0dh, 0ah, 24h

.code

main proc

    mov ax, @data
    mov ds, ax

    mov bx, 0

    mov ah, 9
    mov dx, offset cartel
    int 21h

    carga:
        mov ah, 1
        int 21h
        cmp al, 0dh
        je finCarga
        inc bx
    jmp carga

    finCarga:
        mov ax, bx                  ; Se mueve bx a ax
        add ax, '0'                 ; Se convierte el valor numérico en ax en su ASCII correspondiente (se le suma 48d)
        mov largo, al               ; Se almacena ese valor en "largo"
    
    imprimir:
        mov ah, 9
        mov dx, offset largo
        int 21h
    
    mov ax, 4c00h
    int 21h

main endp
end

Este programa lee un texto de hasta 9 caracteres e imprime su largo.