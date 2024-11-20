
.8086
.model small
.stack 100h
.data
bufferLen			equ 1
arch1		db 'file.txt',0	;un archivo, debe estar en la misma carpeta del ejecutable
buffer		db 1 dup(?)		;buffer de lectura del archivo 1
cola		db '$'
collector	db 255 dup("$"),24h
errmsg		db 10,13,'error apertura archivo file.txt!',10,13,'$'
fileHandler		dw ?			; file fileHandlerr del archivo abierto
salto 		db 	0dh,0ah,24h
;Esto es lo que se pushea desde el programa
;readStart	dw 0
linesRead	dw 0
linesToRead	dw 1

.code
public SelectWord
; main proc
; 	mov ax,@data
; 	mov ds,ax    ; lo de siempre
; 	push readStart
; 	;push linesToRead
; 	call SelectWord
; 	mov ah,9
; 	int 21h
; 	mov ah,4ch
;     int 21h  
; main endp


SelectWord proc
	;Recibe por stack la linea que debe leer
	;devuelve por dx la palabra
	;ss:[bp+4] => Linea a leer (empieza en 0)
	;dx => Palabra leida
	push bp
	mov bp, sp
	push ax
	push cx
	push si

	mov si,0
	
	mov linesRead, 0
	mov ax, ss:[bp+4]
	add ax, linesToRead
	mov linesToRead, ax

	;Abre el archivo
	mov ah,3dh
	lea dx,arch1
	mov al,0
	int 21h
	mov fileHandler,ax 


readLoop_SelectWord:	
	;Empieza a leer los caracteres y los guarda en buffer
	mov ah,3fh
	mov bx,fileHandler
	lea dx, buffer
	mov cx,bufferLen
	int 21h
    cmp ax,0  
	je return_SelectWord

	;Si no llegue a la linea que debo leer, salteo
	push bx
	mov bx, ss:[bp+4]
	cmp bx,linesRead
	pop bx
	ja skipLine_SelectWord

readLine_SelectWord:	
	;Si debo leer esta linea, empiezo a guardarla en el collector
	lea bx, collector
	mov al, buffer
	cmp al, 0Dh
	je hasReadLine_SelectWord
	cmp buffer,0Ah
	je hasReadLine_SelectWord
	mov [bx][si], al
	inc si
	jmp readLoop_SelectWord

skipLine_SelectWord:	
	;Si no debo leer esta linea, solo la recorro
	lea dx, buffer
	cmp buffer,0Ah
	je hasReadLine_SelectWord
	jmp readLoop_SelectWord

hasReadLine_SelectWord:	
	inc linesRead
	jmp checkpage_SelectWord
checkpage_SelectWord:	
	;Verifico silas lineas leidas coinciden con las que tengo que leer
	;Para este caso linesToRead es siempre 1
	push bx
	mov bx, linesRead
	cmp bx,linesToRead
	pop bx

	jne readNextLine_SelectWord
	je return_SelectWord
	call clearscreen

readNextLine_SelectWord:
	jmp readLoop_SelectWord
return_SelectWord:	
	;Si llegué al final del archivo, lo cierro
	mov ah,3eh
	mov dx,fileHandler                                     ;close
	int 21h 
	lea dx, collector
	
	pop si
	pop cx
	pop ax
	pop bp
	ret 2
SelectWord endp


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

proc GetFileLength
	ret 
GetFileLength endp

end
