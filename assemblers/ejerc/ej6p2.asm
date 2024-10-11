.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    texto db 255 dup (24h), 0dh, 0ah, 24h
    largo db 0
    largoPrint db '000', 0dh, 0ah, 24h

.code

main proc

    mov ax, @data
    mov ds, ax

    mov bx, 0                       ; Contador para contar caracteres
    ;mov cx, 3                       ; Contador para el loop "convertir"

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
        mov largo, bl               ; Muevo la cantidad de caracteres a la variable "largo" (lo cambio por bl para que coincida el tamaño del registro con el de la variable)
        mov ax, bx

    convertir:
        mov ax, 0                   ; Limpio el registro ax
        mov al, largo               ; El dividendo es lo que está almacenado en "largo"
        mov dl, 100                 ; El divisor debe ser 100 para que el cociente sea el primer dígito
        div dl                      ; Se divide el largo por 100
        ;add al, 30h                 ; Convierto el cociente a ASCII para hacerlo imprimible
        add largoPrint[0], al       ; Muevo el cociente al primer dígito de largoPrint
        mov al, ah
        mov ah, 0
        mov dl, 10
        div dl
        ;add al, 30h
        add largoPrint[1], al
        add largoPrint[0], ah

        ; AHORA HAY QUE HACER ESO DE LA DIVISIÓN POR 10 PARA SACAR CADA DÍGITO

        ;mov ax, bx                  ; Se mueve bx a ax
        ;add ax, '0'                 ; Se convierte el valor numérico en ax en su ASCII correspondiente (se le suma 48d)
        ;mov largo, al               ; Se almacena ese valor en "largo"
    
    imprimir:
        mov ah, 9
        mov dx, offset largoPrint
        int 21h
    
    mov ax, 4c00h
    int 21h

main endp
end