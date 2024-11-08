.8086
.model small
.stack 100h

.data
    mensajeOperando1 db 'Ingrese primer operando (000-255)', 0dh, 0ah, 24h
    mensajeOperando2 db 'Ingrese segundo operando (000-255)', 0dh, 0ah, 24h
    op1 db '000', 0dh, 0ah, 24h
    op2 db '000', 0dh, 0ah, 24h
    resultadoImp db '000', 0dh, 0ah, 24h
    numeroReg db 0
    salto db 0dh, 0ah, 24h
    varReg1 db 0
    varReg2 db 0
    multiplicador db 100, 10, 1
    divisor db 100, 10, 1

.code

extrn impresion:proc
extrn imprimirSalto:proc
extrn carga:proc
extrn asciiToReg:proc
extrn regToAscii:proc

    main proc
        mov ax, @data
        mov ds, ax

        mov bx, 0
        mov cx, 3
		mov ax, 0

        lea bx, mensajeOperando1
        call impresion

        lea bx, op1
        call carga

        lea bx, op1
        call asciiToReg
        mov varReg1, al

		call imprimirSalto

        lea bx, mensajeOperando2
        call impresion

        lea bx, op2
        call carga

        lea bx, op2
        call asciiToReg
        mov varReg2, al

        operacion:
            mov al, varReg1
            add al, varReg2
            mov numeroReg, al

        lea bx, resultadoImp
        call regToAscii

		call imprimirSalto

        lea bx, op1
        call impresion

		call imprimirSalto

        lea bx, op2
        call impresion

		call imprimirSalto

        lea bx, resultadoImp
        call impresion
        
        mov ax, 4c00h
        int 21h
    main endp


end