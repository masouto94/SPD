.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, '$'
    texto db 50 dup('$'), 0dh, 0ah, '$'

.code

main proc

    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset cartel
    int 21h

    mov cx, 50                     ; Inicializo el contador de loop en 50 porque el máximo son 50 caracteres
    mov bx, 0                      ; Inicializo el contador para recorrer la cadena en 0

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
        cmp texto[bx], '$'      ; Si el carácter es '$', se va a "imprimir" (porque significa que ya terminó la cadena)
        je imprimir
        inc bx
        cmp bx, 50              ; Si bx es 50, salta a "imprimir" (para no poner caracteres de más)
        je imprimir
        jmp proceso
    
    imprimir:
        dec bx                  ; bx tiene almacenada la cantidad de caracteres de la cadena ingresada, por eso lo voy decrementando
        mov dl, texto[bx]       ; Acá estoy recorriendo la cadena de atrás para adelante
        cmp texto[bx], '$'      ; Si el carácter es '$', no se tiene que imprimir (por eso salta a "fin")
        je fin
        mov ah, 2               ; Servicio para imprimir los caracteres de a 1
        int 21h
        loop imprimir           ; Vuelvo a imprimir (el loop se rige por cx)

    fin:
        mov ax, 4c00h
        int 21h

main endp

end

Este programa imprime una cadena ingresada en espejo.