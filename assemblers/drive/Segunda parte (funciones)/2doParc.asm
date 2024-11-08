.8086
.model small
.stack 100h

.data
	cartel db 'Ingrese un texto (finalice con el signo pesos)', 0dh, 0ah, 24h
	cartelMenu db 0dh, 'Seleccione una opción:'
	opcion1 db '1. Contar y mostrar cantidad de espacios', 0dh, 0ah
	opcion2 db '2. Contar y mostrar cantidad de párrafos', 0dh, 0ah
	opcion3 db '3. Contar y mostrar cantidad de caracteres', 0dh, 0ah
	opcion4 db '4. Contar y mostrar cantidad de números', 0dh, 0ah
	opcion5 db '5. Salir del programa', 0dh, 0ah, 24h
	cartelError db 'Opción no válida', 0dh, 0ah, 24h
	salto db 0dh, 0ah, 24h
	cartelEspacios db 'Cantidad de espacios: '
	cantEspacios db '000', 0dh, 0ah, 24h
	cartelParrafos db 'Cantidad de párrafos: '
	cantParrafos db '000', 0dh, 0ah, 24h
	cartelCaracteres db 'Cantidad de caracteres: '
	cantCaracteres db '000', 0dh, 0ah, 24h
	cartelNumeros db 'Cantidad de números: '
	cantNumeros db '000', 0dh, 0ah, 24h
	longitud db 0
	texto db 255 dup(24h), 0dh, 0ah, 24h
	opcion db 0

.code

;extrn carga:proc
extrn impresion:proc
extrn asciiToReg:proc
extrn regToAscii:proc
extrn contarEspacios:proc


	main proc
		mov ax, @data
		mov ds, ax

		lea bx, cartel
		call impresion

		lea bx, texto
		call carga

		lea bx, salto
		call impresion
		lea bx, salto
		call impresion

		mostrarMenu:
			lea bx, cartelMenu
			call impresion

			; Comparaciones
			mov ah, 1
			int 21h
			cmp al, '1'
			je esOpcion1
			cmp al, '2'
			je esOpcion2
			cmp al, '3'
			je esOpcion3
			cmp al, '4'
			je esOpcion4
			cmp al, '5'
			je fin

			lea bx, cartelError
			call impresion
			jmp mostrarMenu

		; Contar espacios e imprimir la cantidad
		esOpcion1:
			lea bx, texto
			call contarEspacios
			lea bx, cantEspacios
			call regToAscii
			lea bx, salto
			call impresion
			lea bx, salto
			call impresion
			lea bx, cartelEspacios
			call impresion
			jmp mostrarMenu

		; Contar párrafos e imprimir la cantidad
		esOpcion2:
			lea bx, texto
			call contarParrafos
			lea bx, cantParrafos
			call regToAscii
			lea bx, salto
			call impresion
			lea bx, cartelParrafos
			call impresion
			jmp mostrarMenu

		; Imprimir cantidad de caracteres (se contaron en la caja de carga)
		esOpcion3:
			lea bx, cantCaracteres
			mov ah, 0
			mov al, longitud
			call regToAscii
			lea bx, salto
			call impresion
			lea bx, cartelCaracteres
			call impresion
			jmp mostrarMenu

		; Contar números e imprimir la cantidad
		esOpcion4:
			lea bx, texto
			call contarNumeros
			lea bx, cantNumeros
			call regToAscii
			lea bx, salto
			call impresion
			lea bx, cartelNumeros
			call impresion
			jmp mostrarMenu
		
		fin:
			mov ax, 4c00h
			int 21h
	main endp


	carga proc
		push bx
		mov cx, 0

		proceso:
			mov ah, 1
			int 21h
			cmp al, 24h
			je finCarga
			mov [bx], al
			inc cx				; Registro para contar caracteres
			inc bx
			jmp proceso


		finCarga:
			mov ch, 0
			mov longitud, cl
			pop bx
			ret
	carga endp


	contarParrafos proc
		mov ax, 0

		proceso4:
			cmp byte ptr [bx], 24h
			je finContarParrafos
			cmp byte ptr [bx], 0dh
			je contarEnter
			inc bx
			jmp proceso4

		contarEnter:
			inc bx				; Esto lo hago para ver si el siguiente carácter es enter
			cmp byte ptr [bx], 0dh		; De ser así, vuelve a proceso4 porque no quiero contar párrafos de más
			je proceso4
			inc ax
			inc bx
			jmp proceso4

		finContarParrafos:
			inc ax				; La cantidad de párrafos es uno más que la cantidad de enter
			ret
	contarParrafos endp


	contarNumeros proc
		mov ax, 0

			primeraCondicion:
				cmp byte ptr [bx], 24h
				je finContarNumero
				cmp byte ptr [bx], '0'
				jae segundaCondicion
				inc bx
				jmp primeraCondicion

			segundaCondicion:
				cmp byte ptr [bx], '9'
				jbe contarNumero
				inc bx
				jmp primeraCondicion

			contarNumero:
				inc ax
				inc bx
				jmp primeraCondicion

			finContarNumero:
				ret
	contarNumeros endp



end