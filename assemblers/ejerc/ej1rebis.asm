.8086
.model small
.stack 100h

.data

cartel db 'Ingrese un texto', 0dh, 0ah, '$'     ; Texto que se muestra al inicio
lectura db 255 dup(' '), 0dh, 0ah, '$'          ; Variable llena de espacios, que se modificará con el texto ingresado
separacion db '------------------', 0dh, 0ah, '$'  ; Variable para separar ambos textos en la salida

.code

main proc

    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset cartel
    int 21h

    mov bx, 0                                   ; Se inicializa un contador en 0

carga:
    mov ah, 1
    int 21h
    cmp al, 0dh                                 ; Se compara el carácter con el enter para saber si se terminó de ingresar el texto
    je finCarga                                 ; Se salta a "finCarga" si se terminó de ingresar el texto
    mov lectura[bx], al                         ; Nos movemos por "lectura" con bx (registro que va a memoria)
    inc bx                                      ; Si no es enter, se incrementa el contador
jmp carga

finCarga:
    mov bx, 0                                   ; Una vez ingresado el texto, se reinicia el contador en 0

proceso:
    cmp lectura[bx], 0dh                        ; Se compara el carácter con el enter para saber si se terminó de recorrer "lectura"
    je imprimir                                 ; Si se terminó, se salta a "imprimir"

    cmp lectura[bx], 'a'                        ; Si no se terminó, se compara el carácter con "a"
    je cambiarLetra                             ; Si el carácter es "a", se salta a "cambiarLetra"
    mov dl, lectura[bx]                         ; Si no, se mueve el carácter al registro "dl"
    mov ah, 2                                   ; Servicio para imprimir un carácter
    int 21h

    inc bx                                      ; Si no, se incrementa el contador
jmp proceso                                     ; Se vuelve a iniciar "proceso"

cambiarLetra:
    mov dl, 'x'                                 ; Se imprime una "x" sin modificar la variable "lectura"
    mov ah, 2                                   ; Servicio para imprimir un carácter
    int 21h
    inc bx                                      ; Se incrementa el contador
    jmp proceso                                 ; Se vuelve a "proceso"

imprimir:                                       ; Etiqueta para imprimir texto modificado

    mov ah, 9                                   ; Se imprime la separación
    mov dx, offset separacion
    int 21h

    mov ah, 9
    mov dx, offset lectura
    int 21h

mov ax, 4c00h
int 21h

main endp

end

En este programa se imprimen los dos textos usando una sola variable.
Para eso, se usó el servicio 2 (creo), para imprimir carácter por carácter.
Si un carácter es "a", se cambia manualmente por "x", sin modificar la variable.