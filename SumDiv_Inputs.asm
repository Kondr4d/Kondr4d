.model small
.stack 100h


.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax 
    
    lea dx, input_msg
    mov ah, 09h
    int 21h

    ; Initialize sum to 0
    mov cx, 5                      ; Loop counter for 5 numbers
    lea si, numbers                ; Point to numbers array

input_loop:
    ; Update prompt with current value number
    mov al, [val_num]
    add al, '0'                    ; Convert to ASCII
    mov [prompt+4], al             ; Replace 'x' in 'Val x: $' with current number

    ; Print prompt
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Read first digit
    mov ah, 01h                    ; Read a single character
    int 21h
    sub al, '0'                    ; Convert ASCII to digit
    mov bl, al                     ; Store first digit in BL

    ; Read second digit
    mov ah, 01h                    ; Read another character
    int 21h
    sub al, '0'                    ; Convert ASCII to digit
    mov bh, al                     ; Store second digit in BH

    ; Combine the two digits to form the number
    mov al, bl                     ; Move first digit into AL (8-bit)
    cbw                            ; Sign-extend AL into AX (16-bit)
    mov dl, 10                     ; Multiplier for tens place
    mul dl                         ; Multiply first digit by 10
    add al, bh                     ; Add the second digit to get the full number

    ; Store the number in the numbers array
    mov [si], ax                   ; Store AX (the combined number) in memory
    add si, 2                      ; Move to next word in array

    ; Add the number to sum
    add [sum], ax                  ; Accumulate into sum 

    ; Print new line
    mov ah, 02h
    mov dl, 0Dh                    ; Carriage return
    int 21h
    mov dl, 0Ah                    ; Line feed   
    int 21h      

    ; Increment val_num
    inc byte ptr [val_num]         ; Increment to the next value number

    ; Decrement loop counter and repeat
    loop input_loop 
                         
    
    ; Display "Sum = " message
    lea dx, sum_msg
    mov ah, 09h
    int 21h
    
    ; Display the sum
    mov ax, [sum]
    call print_num                 ; Print the sum value
    
    ; Print new line
    mov ah, 02h
    mov dl, 0Dh                    ; Carriage return
    int 21h
    mov dl, 0Ah                    ; Line feed   
    int 21h       

    ; Get the divisor from user input
    lea dx, divisor_prompt  
    mov ah, 09h
    int 21h     

    ; Read first digit for divisor
    mov ah, 01h                    ; Read a single character
    int 21h
    sub al, '0'                    ; Convert ASCII to digit
    mov bl, al                     ; Store first digit in BL

    ; Read second digit for divisor
    mov ah, 01h                    ; Read another character
    int 21h
    sub al, '0'                    ; Convert ASCII to digit
    mov bh, al                     ; Store second digit in BH

    ; Combine the two digits to form the divisor
    mov al, bl                     ; Move first digit into AL (8-bit)
    cbw                            ; Sign-extend AL into AX (16-bit)
    mov dl, 10                     ; Multiplier for tens place
    mul dl                         ; Multiply first digit by 10
    add al, bh                     ; Add the second digit to get the full divisor

    ; Store the divisor in memory   
    mov [divisor], ax  

    ; Print new line
    mov ah, 02h
    mov dl, 0Dh                    ; Carriage return
    int 21h
    mov dl, 0Ah                    ; Line feed   
    int 21h      

    ; Divide sum by divisor
    mov ax, [sum]                  ; Load the sum into AX
    xor dx, dx                     ; Clear DX (for the division)
    div word ptr [divisor]         ; Divide by the divisor

    ; Store quotient and remainder
    mov [quotient], ax             ; Store quotient
    mov [remainder], dx            ; Store remainder                       

    ; Display quotient
    lea dx, quotient_msg
    mov ah, 09h
    int 21h
    mov ax, [quotient]
    call print_num                 ; Print the quotient

    ; Display remainder
    lea dx, remainder_msg
    mov ah, 09h
    int 21h
    mov ax, [remainder]
    call print_num                 ; Print the remainder

    ; Exit program
    mov ah, 4Ch
    int 21h

main endp

print_num proc
    ; Convert number in AX to string and print
    push ax
    push bx
    push cx
    push dx

    mov cx, 0
    mov bx, 10                      ; Divisor for base 10

    cmp ax, 0
    jne convert_start
    ; If number is zero, print '0'
    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp print_num_end

convert_start:
    convert_loop:
        xor dx, dx                  ; Clear DX before dividing
        div bx                      ; AX = AX / 10, DX = remainder
        add dl, '0'                 ; Convert remainder to ASCII
        push dx                     ; Push the ASCII character on the stack
        inc cx                      ; Count the digit
        test ax, ax                 ; Check if AX is zero
        jnz convert_loop

    print_loop:
        pop dx
        mov ah, 02h                 ; Function to print character
        int 21h
        loop print_loop

print_num_end:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_num endp    


.data     
    input_msg db 'INPUT VALUES:', 0Dh, 0Ah, '$'
    prompt db 'VAL x: $'           ; 'x' will be replaced with the current number
    divisor_prompt db 0Dh, 0Ah, 'Enter a divisor: $'
    sum_msg db 0Dh, 0Ah, 'SUM = $'
    quotient_msg db 0Dh, 0Ah, 'THE QUO = $'
    remainder_msg db 0Dh, 0Ah, 'THE REM = $'
    divisor dw ?                   ; Divisor will be set by user input
    numbers dw 5 dup(0)
    sum dw 0
    quotient dw 0
    remainder dw 0
    val_num db 1                   ; Variable to keep track of current value number

end main
   
   
