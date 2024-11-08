.8086
.model small
.stack 100h

.data
    cartelMenu db '1. Pasar de binario a decimal / 2. Pasar de decimal a binario / 3. Pasar de hexadecimal a binario / 0. Salir del programa', 0dh, 0ah, 24h
    cartelError db 'Opción no válida', 0dh, 0ah, 24h
    opcion db '', 0dh, 0ah, 24h
    cartelBinADec db 'Ingrese un número binario entre 0 y 11111111', 0dh, 0ah, 24h
    cartelDecABin db 'Ingrese un número decimal entre 0 y 255', 0dh, 0ah, 24h
    cartelHexaABin db 'Ingrese un número hexadecimal entre 0 y FF', 0dh, 0ah, 24h
    binarioReg db 0b
    decimalReg db 0
    cartelSalida1 db 'El número binario ingresado corresponde al decimal '
    decimalAscii db '000', 0dh, 0ah, 24h
    cartelSalida2 db 'El número decimal ingresado corresponde al binario '
    binarioAscii db '00000000', 0dh, 0ah, 24h
    cartelSalida3 db 'El número hexadecimal ingresado corresponde al binario '
    binarioAscii2 db '00000000', 0dh, 0ah, 24h
    hexaAscii db '00', 0dh, 0ah, 24h
    testing db '', 0dh, 0ah, 24h


.code

extrn imprimirSalto:proc
extrn asciiToReg:proc
extrn regToAscii:proc
extrn binToAscii:proc
extrn asciiToBin:proc
extrn asciiToHexa:proc
extrn carga:proc
extrn impresion:proc

    main proc
        mov ax, @data
        mov ds, ax

        mostrarMenu:
            call imprimirSalto
            ; Muestra menú
            lea bx, cartelMenu
            call impresion
            ; Recibe elección del usuario
            lea bx, opcion
            call carga
            ; Hace las comparaciones
            cmp byte ptr [bx], '0'
            je fin
            cmp byte ptr [bx], '1'
            je binarioADecimal
            cmp byte ptr [bx], '2'
            je decimalABinario
            cmp byte ptr [bx], '3'
            je hexaABinario
            lea bx, cartelError
            call impresion
            jmp mostrarMenu
        
        binarioADecimal:
            lea bx, cartelBinADec
            call impresion
            ; El usuario carga el número binario
            lea bx, binarioAscii
            call carga
            ; Se pasa a registro
            call asciiToBin
            ; Se pasa a decimal ASCII y se imprime
            lea bx, decimalAscii
            call regToAscii
            call imprimirSalto
            lea bx, cartelSalida1
            call impresion
            jmp mostrarMenu
        
        decimalABinario:
            lea bx, cartelDecABin
            call impresion
            ; El usuario carga el número decimal
            lea bx, decimalAscii
            call carga
            ; Se pasa a registro
            call asciiToReg
            ; Se pasa a binario ASCII y se imprime
            lea bx, binarioAscii
            call binToAscii
            call imprimirSalto
            lea bx, cartelSalida2
            call impresion
            jmp mostrarMenu

        hexaABinario:
            lea bx, cartelHexaABin
            call impresion
            ; El usuario carga el número hexadecimal
            lea bx, hexaAscii
            call carga
            ; Se pasa a registro
            call asciiToHexa

            ;mov testing, al
            ;lea bx, testing
            ;call impresion

            ; Se pasa a binario ASCII y se imprime
            lea bx, binarioAscii2
            call binToAscii
            call imprimirSalto
            lea bx, cartelSalida3
            call impresion
            jmp mostrarMenu

        fin:
            mov ax, 4c00h
            int 21h
    main endp

end