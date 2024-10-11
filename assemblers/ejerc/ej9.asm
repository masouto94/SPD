.8086
.model small
.stack 100h

.data
    cartel db 'Seleccione la operación: suma (1), resta (2), multiplicación (3), división (4)', 0dh, 0ah, 24h
    mensajeError db 'Opción no válida', 0dh, 0ah, 24h
    mensajeOperando1 db 'Ingrese primer operando', 0dh, 0ah, 24h
    mensajeOperando2 db 'Ingrese segundo operando', 0dh, 0ah, 24h
    opcion db 0
    op1 db 0
    op2 db 0

.code

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset cartel
    int 21h

    cargaOpcion:
        mov ah, 1
        int 21h
        cmp al, 31h
        je suma
    
    printError:
        mov ah, 9
        mov dx, offset mensajeError
        int 21h
        jmp cargaOpcion
    
    suma:
        mov ah, 9
        mov dx, offset mensajeOperando1
        int 21h

        mov ah, 1
        int 21h
        mov op1, al
        
        mov ah, 9
        mov dx, offset mensajeOperando2
        int 21h

        mov ah, 1
        int 21h
        add op1, al
    
    mov ah, 9
    mov dx, offset op1
    int 21h

    mov ax, 4c00h
    int 21h
main endp
end