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

        cmp byte ptr [bx], 'f'
        je esF

        cmp byte ptr [bx], 'g'
        je esG

        cmp byte ptr [bx], 'h'
        je esH

        cmp byte ptr [bx], 'i'
        je esIi

        cmp byte ptr [bx], 'j'
        je esJ

        cmp byte ptr [bx], 'k'
        je esK

        cmp byte ptr [bx], 'l'
        je esL

        cmp byte ptr [bx], 'm'
        je esM

        cmp byte ptr [bx], 'n'
        je esN

        cmp byte ptr [bx], 'o'
        je esO

        cmp byte ptr [bx], 'p'
        je esPe

        cmp byte ptr [bx], 'q'
        je esQ

        cmp byte ptr [bx], 'r'
        je esR

        cmp byte ptr [bx], 's'
        je esS

        cmp byte ptr [bx], 't'
        je esT

        cmp byte ptr [bx], 'u'
        je esU

        cmp byte ptr [bx], 'v'
        je esV

        cmp byte ptr [bx], 'w'
        je esW

        cmp byte ptr [bx], 'x'
        je esX

        cmp byte ptr [bx], 'y'
        je esY

        cmp byte ptr [bx], 'z'
        je esZ

        inc bx
        jmp proceso
    
    esA:
	call cambiaA
        jmp proceso

    esB:
	call cambiaB
        jmp proceso

    esCe:
	call cambiaC
        jmp proceso

    esD:
	call cambiaD
        jmp proceso

    esE:
	call cambiaE
        jmp proceso

    esF:
	call cambiaF
        jmp proceso

    esG:
	call cambiaG
        jmp proceso

    esH:
	call cambiaH
        jmp proceso

    esIi:
	call cambiaI
        jmp proceso

    esJ:
	call cambiaJ
        jmp proceso

    esK:
	call cambiaK
        jmp proceso

    esL:
	call cambiaL
        jmp proceso

    esM:
	call cambiaM
        jmp proceso

    esN:
	call cambiaN
        jmp proceso

    esO:
	call cambiaO
        jmp proceso

    esPe:
	call cambiaP
        jmp proceso

    esQ:
	call cambiaQ
        jmp proceso

    esR:
	call cambiaR
        jmp proceso

    esS:
	call cambiaS
        jmp proceso

    esT:
	call cambiaT
        jmp proceso

    esU:
	call cambiaU
        jmp proceso

    esV:
	call cambiaV
        jmp proceso

    esW:
	call cambiaW
        jmp proceso

    esX:
	call cambiaX
        jmp proceso

    esY:
	call cambiaY
        jmp proceso

    esZ:
	call cambiaZ
        jmp proceso

    imprimir:
        mov ah, 9
        lea dx, codigo
        int 21h

    mov ax, 4c00h
    int 21h
main endp

cambiaA proc
	mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaA endp

cambiaB proc
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
	ret
cambiaB endp

cambiaC proc
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
	ret
cambiaC endp

cambiaD proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaD endp

cambiaE proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaE endp

cambiaF proc
        mov byte ptr [si], '.'
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
	ret
cambiaF endp

cambiaG proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaG endp

cambiaH proc
        mov byte ptr [si], '.'
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
	ret
cambiaH endp

cambiaI proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaI endp

cambiaJ proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaJ endp

cambiaK proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaK endp

cambiaL proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaL endp

cambiaM proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaM endp

cambiaN proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaN endp

cambiaO proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaO endp

cambiaP proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaP endp

cambiaQ proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaQ endp

cambiaR proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaR endp

cambiaS proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaS endp

cambiaT proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaT endp

cambiaU proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaU endp

cambiaV proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaV endp

cambiaW proc
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaW endp

cambiaX proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaX endp

cambiaY proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaY endp

cambiaZ proc
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '-'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], '.'
        inc si
        mov byte ptr [si], ' '
        inc si
        inc bx
	ret
cambiaZ endp

end
