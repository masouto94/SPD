
.8086
.model small
.stack 100h
.data
len			equ 1
bofile		db '--- inicio ---',10,13,'$'
arch1		db 'file.txt',0	;un archivo, debe estar en la misma carpeta del ejecutable
buf1		db 1 dup(?)		;buffer de lectura del archivo 1
cola		db '$'
collector	db 255 dup("$"),24h
errmsg		db 10,13,'error apertura archivo file.txt!',10,13,'$'
finmsg		db 10,13,'-- fin ---',10,13,'$'
fiha1		dw ?			; file fiha1r del archivo abierto
salto 		db 	0dh,0ah,24h
readStart	db 0
linesRead	db 0
linesToRead	db 1

.code

main proc
	mov ax,@data
	mov ds,ax    ; lo de siempre

	mov al, readStart
	add al, linesToRead
	mov linesToRead,al

	mov ah,3dh
	lea dx,arch1
	mov al,0  ; 0 mean for reading purpose             ;open
	int 21h
	mov fiha1,ax 


readLoop:
	mov ah,3fh
	mov bx,fiha1
	lea dx, buf1                            ;read
	mov cx,len
	int 21h
    cmp ax,0   ; ahi en al hay algo....
	je endoffile

	push bx
	mov bl, readStart
	cmp bl,linesRead
	pop bx
	ja skipLine ; ver por que la condicion no funciona con el primero

readLine:
	lea bx, collector
	mov al, buf1
	cmp al, 0Dh
	je readLoop
	cmp buf1,0Ah
	je hasReadLine
	mov [bx][si], al
	inc si
	jmp readLoop

skipLine:
	lea dx, buf1 ;aca seria donde guardariamos en otra variable lo que se leyo
	cmp buf1,0Ah
	je hasReadLine
	jmp readLoop

hasReadLine:
	inc linesRead
	jmp checkpage
checkpage:
	push bx
	mov bl, linesRead
	cmp bl,linesToRead
	pop bx

	jne readNextLine
	je endoffile
	call clearscreen

readNextLine:
	jmp readLoop
endoffile:
	mov ah,3eh
	mov dx,fiha1                                     ;close
	int 21h 
fin:
	mov ah,9
	lea dx, salto
	int 21h
	lea dx, collector
	int 21h
	mov ah,4ch
    int 21h  
main endp


proc Clearscreen
	push ax
	push es
	push cx
	push di
	mov ax,3
	int 10h
	mov ax,0b800h
	mov es,ax
	mov cx,1000
	mov ax,7
	mov di,ax
	cld
	rep stosw
	pop di
	pop cx
	pop es
	pop ax
	ret 
Clearscreen endp

end
