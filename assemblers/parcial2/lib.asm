.8086
.model small
.stack 100h

.data
    numeroReg db 0
    multiplicador db 100, 10, 1
    divisor db 100, 10, 1

.code

public asciiToReg
public regToAscii
public impresion
public cajaCarga
public contadorEspacios
public contadorNumeros
public contadorCaracteres
public contadorParrafo

    impresion proc
        push bx

        mov ah, 9
        lea dx, [bx]
        int 21h

        pop bx
        ret
    impresion endp


cajaCarga proc
    ;bp+4 => Variable con el separador pasada como primer valor del stack
    ;bx => Debe tener la cadena a la cual cargarle los valores. Lo procesa como puntero
    push bp
    mov bp, sp
    push ax
    push bx

    cargar_cajaCarga:
        mov ah,1
        int 21h
        mov ah,0
        cmp ax, ss:[bp+4]
        je return_cajaCarga
        mov [bx], al
        inc bx
    jmp cargar_cajaCarga

    return_cajaCarga:
    pop bx
    pop ax
    pop bp
    ret 4
cajaCarga endp


asciiToReg proc                 ; La función recibe en bx el offset de numeroAscii para devolverlo como registro
    push ax
    push si
    push cx
    push bx

    mov ax, 0
    mov si, 0
    mov cx, 3

    proceso0:
        mov al, [bx]
        sub al, 30h
        mov dl, multiplicador[si]
        mul dl
        add numeroReg, al
        inc bx
        inc si
        mov ax, 0
        loop proceso0

    pop bx
    pop cx
    pop si
    pop ax      
    ret
asciiToReg endp


regToAscii proc                 ; La función recibe en bx el offset de numeroReg para devolverlo como ASCII
    push ax
    push si
    push cx
    push bx

        ;mov ah, 0              ; Estas dos instrucciones las uso
        ;mov al, numeroReg          ; solamente si no tengo el número en ax
    mov si, 0
    mov cx, 3

    proceso2:
        mov dl, divisor[si]
        div dl
        add al, 30h
        mov [bx], al
        mov al, ah
        mov ah, 0
        inc bx
        inc si
        loop proceso2

    pop bx
    pop cx
    pop si
    pop ax      
    ret
regToAscii endp


contadorEspacios proc
    ;ax == Valor corriente de cantidad de espacios. El registro se modifica directamente
    ;bx => Referencia de la cadena a contar
    push bx
    mov ax,0

    looper_contadorEspacios:
        cmp byte ptr [bx], "$"
        je return_contadorEspacios
        cmp byte ptr [bx], 20h
        je incremento_contadorEspacios
        inc bx
        jmp looper_contadorEspacios
    
    incremento_contadorEspacios:
        inc ax
        inc bx
        jmp looper_contadorEspacios
    
    return_contadorEspacios:
        pop bx
        ret
contadorEspacios endp

contadorNumeros proc
    ;ax == Valor corriente de cantidad de numeros. El registro se modifica directamente
    ;bx => Referencia de la cadena a contar
    push bx
    mov ax,0

    looper_contadorNumeros:
        cmp byte ptr [bx], "$"
        je return_contadorNumeros
        cmp byte ptr [bx], "0"
        jb nan_contadorNumeros
        cmp byte ptr [bx], "9"
        ja nan_contadorNumeros
        inc bx
        inc ax
        jmp looper_contadorNumeros
    
    nan_contadorNumeros:
        inc bx
        jmp looper_contadorNumeros
    
    return_contadorNumeros:
        pop bx
        ret
contadorNumeros endp

contadorCaracteres proc
    ;ax == Valor corriente de cantidad de caracteres. El registro se modifica directamente
    ;bx => Referencia de la cadena a contar
    push bx
    mov ax,0

    looper_contadorCaracteres:
        cmp byte ptr [bx], "$"
        je return_contadorCaracteres
        inc ax
        inc bx
        jmp looper_contadorCaracteres
    return_contadorCaracteres:
        pop bx
        ret
contadorCaracteres endp

contadorParrafo proc
    ;ax == Valor corriente de cantidad de parrafos. El registro se modifica directamente
    ;bx => Referencia de la cadena a contar
    push bx
    mov ax,1    ;inicializa el contador de párrafos en 1 porque el párrafo 0 es el primero

    looper_contadorParrafo:
        cmp byte ptr [bx], "$"
        je return_contadorParrafo
        cmp byte ptr [bx], 0dh
        je incremento_contadorParrafo
        inc bx
        jmp looper_contadorParrafo
    
    incremento_contadorParrafo:
        inc ax
        inc bx
        jmp looper_contadorParrafo
    
    return_contadorParrafo:
        pop bx
        ret
contadorParrafo endp
end