assume CS:code,DS:data ; привязка сегментных регистров к сегментам

data segment ; сегмент данных, описывает все используемые в программе переменные
a db 1
b db 4
c db 3
d db 2
e db ?,'$'
data ends ; конец сегмента

code segment ; сегмент кода, содержит непосредственно код программы
start: ; метка, с которой начинается исполнение программы
mov AX, data
mov DS, AX ; заносим в сегментный регистр адрес сегмента
mov al, a
mov ah, b
shl al, 1
mov cl, 2
shr ah, cl
sub al, ah
mov ah, c
mul ah
mov ah, d
sub al, ah
mov e, al
mov AH,4Ch
int 21h ; идентификатор функции 4Сh - завершение программы
code ends
end start ; конец программы, здесь же указывается метка, с которой начинается исполнение программы