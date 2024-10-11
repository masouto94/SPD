.8086
.model small
.stack 100h

.data

cartel db 'Ingrese un texto', 0dh, 0ah, '$'     ; Texto que se muestra al inicio
lectura db 255 dup(' '), 0dh, 0ah, '$'          ; Variable llena de espacios, que se modificará con el texto ingresado

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
    je cambiarLetra                             ; Si el carácter es una vocal en minúscula, se salta a "cambiarLetra"
    cmp lectura[bx], 'e'
    je cambiarLetra
    cmp lectura[bx], 'i'
    je cambiarLetra
    cmp lectura[bx], 'o'
    je cambiarLetra
    cmp lectura[bx], 'u'
    je cambiarLetra
    inc bx                                      ; Si no, se incrementa el contador
jmp proceso                                     ; Se vuelve a iniciar "proceso"

cambiarLetra:
    mov al, lectura[bx]                         ; Se mueve al registro "al" el carácter que es vocal minúscula
    sub al, 32                                  ; Se le resta 32 para cambiar a mayúscula
    mov lectura[bx], al                         ; Se pone la vocal mayúscula en el lugar donde antes estaba la minúscula

    inc bx                                      ; Se incrementa el contador
    jmp proceso                                 ; Se vuelve a "proceso"

imprimir:                                       ; Etiqueta para imprimir texto modificado
    mov ah, 9
    mov dx, offset lectura
    int 21h

mov ax, 4c00h
int 21h

main endp

end

En este programa se usa una sola variable (lectura) que se modifica. Solo se imprime la variable modificada.