.8086
.model small
.stack 100h

.data
    mensajeOperando1 db 'Ingrese primer operando (000-255)', 0dh, 0ah, 24h
    mensajeOperando2 db 'Ingrese segundo operando (000-255)', 0dh, 0ah, 24h
    cartelMenu db 'Suma (+) | Resta (-) | Producto (*) | Cociente (/)', 0dh, 0ah, 24h
    cartelError db 'Opción no válida', 0dh, 0ah, 24h
    opcion db ''
    op1 db '000', 0dh, 0ah, 24h
    op2 db '000', 0dh, 0ah, 24h
    carteResultado db 'El resultado es '
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

        ; Ingresar primer operando

        lea bx, mensajeOperando1
        call impresion

        lea bx, op1
        call carga

        lea bx, op1
        call asciiToReg
        mov varReg1, al

		call imprimirSalto

        ; Ingresar operación

        lea bx, cartelMenu
        call impresion
        lea bx, opcion
        call carga

        ; Ingresar segundo operando

        lea bx, mensajeOperando2
        call impresion

        lea bx, op2
        call carga

        lea bx, op2
        call asciiToReg
        mov varReg2, al

        ; Comparar para operar

        lea bx, opcion
        cmp byte ptr [bx], '+'
        je sumar
        cmp byte ptr [bx], '-'
        je restar
        cmp byte ptr [bx], '*'
        je multiplicar
        cmp byte ptr [bx], '/'
        je dividir
        lea bx, cartelError
        call impresion

        ; Operar e imprimir

        sumar:
            mov al, varReg1
            add al, varReg2
            mov numeroReg, al
            jmp imprimir


        restar:
            mov al, varReg1
            sub al, varReg2
            mov numeroReg, al
            jmp imprimir

        multiplicar:
            mov al, varReg1
            mov dl, varReg2
            mul dl
            mov numeroReg, al
            jmp imprimir

        dividir:
            mov al, varReg1
            mov dl, varReg2
            div dl
            mov numeroReg, al
            jmp imprimir

        imprimir:

            lea bx, resultadoImp
            call regToAscii

            call imprimirSalto

            lea bx, carteResultado
            call impresion

            
            mov ax, 4c00h
            int 21h
    main endp

end
