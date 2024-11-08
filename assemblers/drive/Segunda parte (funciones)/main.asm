.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese un texto', 0dh, 0ah, 24h
    texto db 255 dup(24h), 0dh, 0ah, 24h
    cantCaracteresAscii db '000', 0dh, 0ah, 24h

.code

extrn cargaSt:proc
extrn contarCaracteresSt:proc
;extrn regToAscii:proc
extrn impresion:proc
extrn regToAsciiSt:proc
;extrn numeroReg:byte

    main proc
        mov ax, @data
        mov ds, ax

        lea dx, cartel
        call impresion

        lea bx, texto
        push bx
        call cargaSt

        lea bx, texto
        push bx
        call contarCaracteresSt

        ;mov numeroReg, al

        lea bx, cantCaracteresAscii
        call regToAsciiSt

        lea bx, cantCaracteresAscii
        call impresion

        mov ax, 4c00h
        int 21h
    main endp

end