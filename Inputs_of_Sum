.model small
.stack 100h

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; Display "INPUT VALUES:"
    lea dx, input_msg
    mov ah, 09h
    int 21h

    ; Initialize loop for 5 numbers input
    mov cx, 5                      ; We need to take 5 inputs
    lea si, numbers                ; Point to the array `numbers`

input_loop:
    ; Update the prompt with the current value number
    mov al, [val_num]
    add al, '0'                    ; Convert the value number to ASCII
    mov [prompt+4], al             ; Replace 'x' in 'VAL x: $'

    ; Display the prompt
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Input two-digit number
    ; Read the first digit
    mov ah, 01h                    ; Read one character
    int 21h
    sub al, '0'                    ; Convert ASCII to number
    mov bl, al                     ; Store first digit in BL

    ; Read the second digit
    mov ah, 01h
    int 21h
    sub al, '0'                    ; Convert ASCII to number
    mov bh, al                     ; Store second digit in BH

    ; Combine the two digits into a full number
    mov al, bl                     ; Move first digit into AL
    cbw                            ; Sign-extend AL into AX (16-bit)
    mov dl, 10                     ; Multiplier for tens place
    mul dl                         ; Multiply first digit by 10
    add al, bh                     ; Add the second digit to form the full number

    ; Store the combined number in the array
    mov [si], ax                   ; Store AX into `numbers` array
    add si, 2                      ; Move to the next word in the array

    ; Add the number to the sum
    add [sum], ax                  ; Accumulate into the sum

    ; Print new line after input
    mov ah, 02h
    mov dl, 0Dh                    ; Carriage return
    int 21h
    mov dl, 0Ah                    ; Line feed
    int 21h

    ; Increment the value number
    inc byte ptr [val_num]         ; Increment to the next value number

    ; Loop until all 5 inputs are processed
    loop input_loop

    ; Display "SUM = "
    lea dx, sum_msg
    mov ah, 09h
    int 21h

    ; Display the sum
    mov ax, [sum]
    call print_num                 ; Call print_num to display the sum

    ; Exit the program
    mov ah, 4Ch
    int 21h

main endp

; Procedure to print a multi-digit number in AX
print_num proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 0                      ; Digit counter
    mov bx, 10                     ; Divisor for base 10

    cmp ax, 0
    jne convert_start
    ; If number is zero, print '0'
    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp print_num_end

convert_start:
    convert_loop:
        xor dx, dx                 ; Clear DX before dividing
        div bx                     ; AX = AX / 10, DX = remainder
        add dl, '0'                ; Convert remainder to ASCII
        push dx                    ; Push the ASCII character on the stack
        inc cx                     ; Count the digit
        test ax, ax                ; Check if AX is zero
        jnz convert_loop

    ; Now print the digits from the stack
    print_loop:
        pop dx                     ; Get the digit from the stack
        mov ah, 02h                ; DOS function to print a character
        int 21h
        loop print_loop

print_num_end:
    pop ax
    pop bx
    pop cx
    pop dx
    ret
print_num endp  

.data
    input_msg db 'INPUT VALUES:', 0Dh, 0Ah, '$'
    prompt db 'VAL x: $'           ; 'x' will be replaced with the current number
    sum_msg db 0Dh, 0Ah, 'SUM = $'
    numbers dw 5 dup(0)            ; Array to store 5 input numbers
    sum dw 0                       ; Variable to store the sum of numbers
    val_num db 1                   ; Counter for the current value number (1 to 5)


end main
