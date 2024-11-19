assume CS:code,DS:data 

data segment
array dw 1,2,5,4,6,7,4,5,9
arr_size equ ($-array)/2
count dw 0
output db "    "

data ends

code segment
start:
mov AX, data
mov DS, AX ; заносим в сегментный регистр адрес сегмента
xor si, si
mov si, offset array
mov cx, arr_size
mov bx, 0
point1:
    inc bx
    cmp bx, cx
    jge point3
    mov ax, [si]
    inc si
    inc si
    mov dx, [si]
    cmp ax, dx
    jb point2
    jmp point1

point2:
    inc count
    jmp point1


point3:


mov ax, count
mov si, offset output + 4
mov bx, "$"
mov [si], bx
mov cx, 10

point4:
    dec si
    xor dx, dx
    div cx
    add dl, 30h
    mov [si], dl
    cmp ax, 0
    jne point4
    
mov dx, offset output
mov ah, 09h
int 21h

mov ah, 4Ch
int 21h
code ends
end start
