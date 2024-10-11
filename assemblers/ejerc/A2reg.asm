.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un número (hasta 255)', 0dh, 0ah, 24h
    varASCII db '000', 0dh, 0ah, 24h
    multiplicador db 100, 10, 1
    varReg db 0

.code

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset cartel
    int 21h

    mov bx, 0
    mov cx, 3

    carga:
        mov ah, 1
        int 21h
        cmp al, 0dh
        je finCarga
        mov varASCII[bx], al
        inc bx
        jmp carga
    
    finCarga:
        mov bx, 0
    
    ASCIIaREG:
        mov al, varASCII[bx]
        sub al, 30h
        mov dl, multiplicador[bx]
        mul dl
        add varReg, al
        inc bx
        mov ax, 0
    loop ASCIIaREG

    fin:
        mov ax, 4c00h
        int 21h
main endp
end