assume CS:code,DS:data ; привязка сегментных регистров к сегментам

data segment ; сегмент данных, описывает все используемые в программе переменные
a dw 2000
b dw 200
c dw 3
d dw 2
e db "          " 
output db "hex dec", 0Dh, 0Ah, "$"
data ends ; конец сегмента

code segment ; сегмент кода, содержит непосредственно код программы
start: ; метка, с которой начинается исполнение программы
mov AX, data
mov DS, AX ; заносим в сегментный регистр адрес сегмента
mov dx, offset output
mov ah, 09h
int 21h
mov si,offset e + 10
mov bx, '$'
mov [si], bx
mov ax, a
mov dx, b
shl ax, 1
mov cl, 2
shr dx, cl
sub ax, dx
mul c
mov dx, d
sub ax, dx
mov cx, 10
mov bx, ax

point1:
    dec si
    xor dx, dx
    div cx
    add dl, 30h
    mov [si], dl
    cmp ax, 0
    jne point1

dec si


point2:
    dec si
    mov ax, bx
    and ax, 0Fh
    add al, 30h
    cmp al, 39h
    jbe point3
    add al, 7

point3:
    mov [si], al
    mov cl, 4
    shr bx, cl
    cmp bx, 0
    jne point2



mov dx, offset e
mov ah, 09h
int 21h

mov AH,4Ch
int 21h ; идентификатор функции 4Сh - завершение программы
code ends
end start ; конец программы, здесь же указывается метка, с которой начинается исполнение программы