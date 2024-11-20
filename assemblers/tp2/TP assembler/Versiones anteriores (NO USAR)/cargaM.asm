.8086
.model small
.stack 100h

.data
    cartel db 'Ingrese el código', 0dh, 0ah, 24h
    cartelError db 'Intente de nuevo', 0dh, 0ah, 24h
    cartelExito db 'Felicitaciones', 0dh, 0ah, 24h
    elCodigo db '... --- ... ', 0dh, 0ah, 24h
    palabraUsuario db 255 dup(24h), 0dh, 0ah, 24h; la del usuario
    longitud db 0
    longitudUsuario db 0
    longitudAscii db '000', 0dh, 0ah, 24h

.code

extrn imprimirSalto:proc
extrn impresion:proc
extrn mayusculizador:proc
extrn contarCaracteresSt:proc
extrn regToAscii:proc

main proc
    mov ax, @data
    mov ds, ax

    lea bx, cartel
    call impresion

    lea bx, elCodigo
    push bx
    call contarCaracteresSt
    mov ah, 0
    mov longitud, al

    ;lea bx, longitudAscii                  ; Esto es para ver si se están contando bien los caracteres
    ;call regToAscii
    ;lea bx, longitudAscii
    ;call impresion

    mov ax, 0

    cargaMorse:
        mov ah, 1
        int 21h
        cmp al, 0dh
        je preComparacion
        cmp al, 20h
        je tokenizarMorse
        analizarPunto:
            cmp al, '.'
            jne analizarRaya
            je meter

        analizarRaya:
            cmp al, '-'
            jne cargaMorse
            je meter

        meter:
            mov palabraUsuario[si], al
            inc si
            jmp cargaMorse

        tokenizarMorse:
            mov dl, 4                       ; Muevo 4 a dl
            mov ax, si                      ; Muevo si a ax
            div dl                          ; Divido si por 4 para quedarme con el resto (resto = cantidad de rayas y puntos del símbolo morse)
            cmp ah, 0
            je cargaMorse
            sub dl, ah                      ; Eso se lo resto a 4 para tener la cantidad de espacios (queda guardada en dl)
            mov ch, 0
            mov cl, dl                      ; Guardo en cx la cantidad de espacios
            completarEspacios:
                mov palabraUsuario[si], 20h
                inc si
                loop completarEspacios
            jmp cargaMorse

    preComparacion:
        mov ax, si
        mov ah, 0
        mov longitudUsuario, al              ; Almacenamos cantidad de caracteres de lo que ingresó el usuario

        mov si, 0
        mov ch, 0
        mov cl, longitud                     ; Almacenamos la cantidad de caracteres de elCodigo en CX para hacer el loop
            
    comparacion:
        mov dl, palabraUsuario[si]
        cmp dl, elCodigo[si]
        jne salidaNo
        inc si
        loop comparacion

    mov ah, 0                               ; Esto se hace para ver si el usuario se pasó de caracteres
    mov al, longitudUsuario                 ; Si la longitud es distinta al contador SI, es porque metió caracteres de más
    cmp si, ax
    jne salidaNo

    salidaSi:
        mov ah, 9
        lea dx, cartelExito
        int 21h
        jmp fin

    salidaNo:
        mov ah, 9
        lea dx, cartelError
        int 21h

    fin:
	lea bx, palabraUsuario
	call impresion
        mov ax, 4c00h
        int 21h
main endp
end