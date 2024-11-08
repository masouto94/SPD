.8086
.model small
.stack 100h

.data
    cartelMenu db 'Seleccione una opción', 0dh, 0ah, \
                  '1. Sumar dos números', 0dh, 0ah, \
                  '2. Convertir un número hexadecimal a binario', 0dh, 0ah, \
                  '3. Buscar un carácter en una cadena y contarlo', 0dh, 0ah, \
                  '4. Pasar una cadena a mayúscula', 0dh, 0ah, \
                  '0. Salir', 0dh, 0ah, 24h
    cartelHexa db 'Ingrese un númerohexadecimal', 0dh, 0ah, 24h
    cartelError db 'Opción no válida', 0dh, 0ah, 24h
    cartelOperando db 'Ingrese operando', 0dh, 0ah, 24h
    cartelMayus db 'Ingrese un texto', 0dh, 0ah, 24h
    cartelCaracter db 'Ingrese un carácter a buscar', 0dh, 0ah, 24h
    num1 db '000', 0dh, 0ah, 24h
    num2 db '000', 0dh, 0ah, 24h
    resultadoReg db 0
    resultadoAscii db '000', 0dh, 0ah, 24h
    texto db 255 dup(24h), 0dh, 0ah, 24h
    hexaAscii db '00', 0dh, 0ah, 24h
    binarioAscii db '00000000', 0dh, 0ah, 24h
    caracter db ' ', 0dh, 0ah, 24h


.code

extrn impresion:proc
extrn carga:proc
extrn regToAscii:proc
extrn asciiToReg:proc
extrn mayusculizador:proc
extrn asciiToHexa:proc
extrn binToAscii:proc

    main proc
        mov ax, @data
        mov ds, ax

        mostrarMenu:

            lea bx, cartelMenu
            call impresion

            ; Comparaciones
            mov ah, 1
            int 21h
            cmp al, '1'
            je sumarDosNumeros
            cmp al, '2'
            je convertirHexaABinario
            cmp al, '3'
            je preBuscarCaracter
            cmp al, '4'
            je preMayusculizar
            cmp al, '0'
            je preFin
            lea dx, cartelError
            call impresion
            jmp mostrarMenu

        preMayusculizar:
            jmp mayusculizar

        preFin:
            jmp fin

        preBuscarCaracter:
            jmp buscarCaracter

        sumarDosNumeros:
            lea bx, cartelOperando
            call impresion

            lea bx, num1
            call carga

            lea bx, num1
            call asciiToReg

            add resultadoReg, al

            lea bx, cartelOperando
            call impresion

            lea bx, num2
            call carga

            lea bx, num2
            call asciiToReg

            add resultadoReg, al

            mov al, resultadoReg

            lea bx, resultadoAscii
            call regToAscii

            lea bx, resultadoAscii
            call impresion

            jmp mostrarMenu

        convertirHexaABinario:
            lea bx, cartelHexa
            call impresion

            lea bx, hexaAscii
            call carga

            lea bx, hexaAscii
            call asciiToHexa

            lea bx, binarioAscii
            call binToAscii

            lea bx, binarioAscii
            call impresion

            jmp mostrarMenu

        buscarCaracter:
            lea bx, cartelMayus
            call impresion

            lea bx, texto
            call carga

            lea bx, cartelCaracter
            call impresion

            lea bx, caracter
            call carga

            lea bx, texto
            call contarCaracter

            mov al, resultadoReg

            lea bx, resultadoAscii
            call regToAscii

            lea bx, resultadoAscii
            call impresion

            jmp mostrarMenu

        mayusculizar:
            lea bx, cartelMayus
            call impresion

            lea bx, texto
            call carga

            lea bx, texto
            call mayusculizador

            lea bx, texto
            call impresion

            jmp mostrarMenu

    
        fin:
            mov ax, 4c00h
            int 21h
    main endp


    contarCaracter proc

        mov ax, 0

        mov dl, caracter

        proceso6:
            cmp byte ptr [bx], 0dh
            je finContarCaracter
            cmp byte ptr [bx], dl
            je incrementar
            inc bx
            jmp proceso6

        incrementar:
            inc ax
            inc bx
            jmp proceso6

        finContarCaracter:
            mov ah, 0
            mov resultadoReg, al
            ret
    contarCaracter endp


end