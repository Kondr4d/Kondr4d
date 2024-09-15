org 100h

MAIN PROC
    MOV DX, OFFSET STR
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
        
    
    MOV BL, 2
    DIV BL
    
    CMP AH, 0

    MOV DX, 13
    MOV AH, 2
    INT 21H
    MOV DX, 10
    MOV AH, 2
    INT 21H    
    
    JE .ISEVEN        
    
    .ISODD:
        MOV DX, OFFSET ODD_STR
        MOV AH, 9
        INT 21H
        JMP .END

    .ISEVEN:
        MOV DX, OFFSET EVEN_STR
        MOV AH, 9
        INT 21H
        JMP .END
    
    
    .END:
        ret
MAIN ENDP

STR DB 'Input a value: $'
EVEN_STR DB 'The value is an even number!$'
ODD_STR DB 'The value is an odd numbers!$'
