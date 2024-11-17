
.8086
.model small
.stack 100h
.data
len			equ 1
bofile		db '--- inicio ---',10,13,'$'
arch1		db 'uno.txt',0	;un archivo, debe estar en la misma carpeta del ejecutable
buf1		db 1 dup(?)		;buffer de lectura del archivo 1
cola		db '$'
errmsg		db 10,13,'error apertura archivo uno.txt!',10,13,'$'
finmsg		db 10,13,'-- fin ---',10,13,'$'
fiha1		dw ?			; file fiha1r del archivo abierto
cantreng	db 39

.code

main proc
	mov ax,@data
	mov ds,ax    ; lo de siempre
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
	;mov dx, ax
	lea dx, buf1 ;aca seria donde guardariamos en otra variable lo que se leyo
	mov ah,9

	int 21h

	cmp buf1,0Ah
	je checkpage

	jmp readLoop

checkpage:
	push bx
	push di
	mov bl, cantreng
	inc bl
	cmp bl,39
	jne sigo123
	call clearscreen

sigo123:
	cmp bl,39
	mov bl,0
	inc bl
	lea di,cantreng
	mov byte ptr[di],bl
	pop di
	pop bx
	jmp readLoop
endoffile:
	mov ah,3eh
	mov dx,fiha1                                     ;close
	int 21h 
fin:
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
