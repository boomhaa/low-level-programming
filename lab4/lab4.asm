; вариант 3
assume CS:code,DS:data 

data segment
    
    arr db 8 dup (?)   
    absRes db ?        
    sumRes dw ?        
    maxRes db ?         
    msg1 db "res for absol: $"
    msg2 db "res for sum: $"
    msg3 db "res for max: $"
    dummy db 0Dh, 0Ah, '$'
    msg4 db '$'

data ends
code segment

absol macro r, x
    local negative, done
    push ax          
    
    mov al, x     
    test al, al      
    jns done         
    neg al       
done:
    mov r, al         
    pop ax          
endm

sum macro x
    local sumLoop
    push cx            
    push si
    
    xor ax, ax       
    mov cx, length x
    lea si, x        
sumLoop:
    mov bl, [si]     
    cbw               
    add ax, bx      
    inc si           
    loop sumLoop
    
    pop si           
    pop cx
endm

max macro x
    local maxLoop, next
    push cx          
    push si
    
    mov si, offset x
    mov al, [si]     
    mov cx, length x
    dec cx          
    inc si           
maxLoop:
    cmp [si], al    
    jle next       
    mov al, [si]     
next:
    inc si          
    loop maxLoop
    
    pop si          
    pop cx
endm


print proc
    push ax
    push bx
    push cx
    push dx
    
    test al, al       
    jns positive
    push ax
    mov dl, '-'       
    mov ah, 02h
    int 21h
    pop ax
    neg al            
    positive:
        mov bl, 10
        xor ah, ah
        div bl            
        push ax            
        cmp al, 0          
        jne recursive      
        pop ax             
        mov dl, ah         
        add dl, '0'
        mov ah, 02h
        int 21h
        jmp print_done
    recursive:
        call print     
        pop ax             
        mov dl, ah        
        add dl, '0'
        mov ah, 02h
        int 21h
    print_done:
        pop dx
        pop cx
        pop bx
        pop ax
        ret
print endp

start:
   
    mov ax, data
    mov ds, ax
    
    mov si, offset arr
    mov byte ptr [si], 10
    mov byte ptr [si+1], -5
    mov byte ptr [si+2], 15
    mov byte ptr [si+3], -20
    mov byte ptr [si+4], 7
    mov byte ptr [si+5], -3
    mov byte ptr [si+6], 30
    mov byte ptr [si+7], -2

    mov al, -10
    absol absRes, al

    sum arr
    mov sumRes, ax

    max arr
    mov maxRes, al

    mov dx, offset msg1
    mov ah, 09h
    int 21h
    mov al, absRes
    call print

    mov dx, offset dummy
    mov ah, 09h
    int 21h

    mov dx, offset msg2
    mov ah, 09h
    int 21h

    mov ax, sumRes
    call print

    mov dx, offset dummy
    mov ah, 09h
    int 21h

    mov dx, offset msg3
    mov ah, 09h
    int 21h
    mov al, maxRes
    call print

    mov dx, offset msg4
    mov ah, 09h
    int 21h

    mov ax, 4C00h
    int 21h


code ends
end start
