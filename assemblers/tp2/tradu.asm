.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto alfanumérico', 0dh, 0ah, 24h
    palabra db 255 dup(24h), 0dh, 0ah, 24h
    codigo db 255 dup(24h), 0dh, 0ah, 24h

.code

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    lea dx, cartel
    int 21h

    lea bx, palabra

    carga:
        mov ah, 1
        int 21h
        cmp al, 0dh
        je finCarga
        mov [bx], al
        inc bx
        jmp carga

    finCarga:
        lea bx, palabra
        lea si, codigo
        ;mov bx, 0
        ;mov si, 0

    proceso:
        cmp byte ptr [bx], 0dh
        je imprimir

        cmp byte ptr [bx], 'a'
        je esA

        cmp byte ptr [bx], 'b'
        je esB

        cmp byte ptr [bx], 'c'
        je esCe

        cmp byte ptr [bx], 'd'
        je esD

        cmp byte ptr [bx], 'e'
        je esE

	inc bx
	jmp proceso

    esA:
	mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
        jmp proceso

    esB:
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
        jmp proceso

    esCe:
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
        jmp proceso

    esD:
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
        jmp proceso

    esE:
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
        jmp proceso


    imprimir:
        mov ah, 9
        lea dx, codigo
        int 21h

    mov ax, 4c00h
    int 21h
main endp

end