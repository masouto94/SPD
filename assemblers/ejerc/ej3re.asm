.8086
.model small
.stack 100h

.data

cartel db 'Ingrese un texto en minúscula', 0dh, 0ah, '$'
lectura db 255 dup('$')

.code

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset cartel
    int 21h

    mov bx, 0

carga:
    mov ah, 1
    int 21h
    cmp al, 0dh
    je finCarga
    mov lectura[bx], al
    inc bx
jmp carga

finCarga:
    mov bx, 0

proceso:
    cmp lectura[bx], 0dh
    je imprimir

    cmp bx, 0
    je cambiarPrimeraLetra

    cmp lectura[bx], ' '
    je cambiarLetra

    inc bx
jmp proceso

cambiarPrimeraLetra:
    mov al, lectura[bx]
    sub al, 32
    mov lectura[bx], al
    inc bx
jmp proceso

cambiarLetra:
    inc bx
    mov al, lectura[bx]
    sub al, 32
    mov lectura[bx], al
    inc bx
jmp proceso


imprimir:
    mov ah, 9
    mov dx, offset lectura
    int 21h

mov ax, 4c00h
int 21h

main endp
end