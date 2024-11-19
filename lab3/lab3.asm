; вариант 6
assume CS:code,DS:data 

data segment
    str1 db 100, 99 dup ('$')
    str2 db 100, 99 dup ('$')
    dummy db 0Dh, 0Ah, '$'
    result db "   "         
data ends
code segment

strcspn proc
    push bp
    mov bp, sp
    mov si, [bp+6]
   

    add si, 2
    

    xor cx, cx

    while_str1:
        mov al, [si]
        cmp al, '$'
        jz return
        mov di, [bp+4]
        add di, 2
        while_str2:
            mov bl, [di]
            cmp bl, '$'
            je add1

            cmp al, bl
            je return

            inc di
            jmp while_str2

    add1:
        inc cx
        inc si
        jmp while_str1

    return:
        pop bp
        mov ax, cx
        ret
strcspn endp

start:
    mov ax, data
    mov ds, ax

    mov dx, offset str1
    mov ah, 0Ah
    int 21h
    push dx

    mov dx, offset dummy
    mov ah, 09h
    int 21h
    
    mov dx, offset str2
    mov ah, 0Ah
    int 21h
    push dx

    call strcspn
    pop dx
    push ax

    pop ax
    mov cx, 10
    xor si, si
    mov si, offset result + 3
    mov bx, '$'
    mov [si], bx
   
    print:
        dec si
        xor dx, dx
        div cx
        add dl, 30h
        mov [si], dl
        cmp ax, 0
        jne print

    mov dx, offset dummy
    mov ah, 09h
    int 21h

    mov dx, offset result
    mov ah, 09h
    int 21h

    mov ah,4Ch
    int 21h 

code ends
end start
