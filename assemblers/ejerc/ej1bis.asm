.8086
.model small
.stack 100h

.data

texto db "Vamos a leer un texto", 0dh, 0ah, '$'
lectura db 255 dup('$')
salto db 0dh, 0ah, '$'

.code

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset texto
    int 21h

    mov bx, 0                ; Inicializa el contador en 0

    ; CAJA DE CARGA
    carga:
        mov ah, 1
        int 21h
        cmp al, '$'              ; Compara el carácter leído con '$' (para ver si terminó de escribirse el texto)
        je fincarga              ; Si es igual, va a "fincarga"
        mov lectura[bx], al      ; Para moverse por "lectura", le ponemos bx (registro que va a memoria)
        inc bx                   ; Incrementa bx de a 1
    jmp carga                ; Salta a la etiqueta "carga" (como si fuera un while)

; FIN CAJA DE CARGA
fincarga:
    mov bx, 0                ; Inicializa de nuevo el contador

proceso:
    cmp lectura[bx], '$'     ; Compara el carácter con '$' como condición de salida
    je finproceso

    cmp lectura[bx], 'a'     ; Compara carácter de "lectura" con la "a" para después cambiarla por la "x"
    je esA
    mov dl, lectura[bx]
    mov ah, 2
    int 21h

    inc bx                    ; Si el carácter no es "a", se incrementa el contador
jmp proceso

esA:
    mov dl, 'x'               ; ACÁ NO SE CAMBIA LA VARIABLE, SIMPLEMENTE SE IMPRIME UNA "x" SI ENCUENTRA UNA "a"
    mov ah, 2
    int 21h
    inc bx
    jmp proceso

finproceso:

    mov ah, 9
    mov dx, offset salto
    int 21h                      ; Se imprime un salto

    mov ah, 9                    ; Se imprime el texto original
    mov dx, offset lectura
    int 21h


    mov ax, 4c00h
    int 21h

main endp

end

En este programa se imprimen los dos textos (el original y el modificado), pero con una sola variable.
Para eso, se usó el servicio 2 (creo), para imprimir carácter por carácter.
Si un carácter es "a", se cambia manualmente por "x", sin modificar la variable.