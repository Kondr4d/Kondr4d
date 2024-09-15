org 100h

MAIN PROC
    MOV DX, OFFSET STR1
    MOV AH, 9
    INT 21H
    
    MOV DX, OFFSET BUFFER
    MOV AH, 0AH
    INT 21H

    MOV DX, 13
    MOV AH, 2
    INT 21H
    MOV DX, 10
    MOV AH, 2
    INT 21H 
    
    XOR CX, CX
    MOV COUNT, CL
    MOV SI, OFFSET BUFFER+2
    MOV CL, [SI-1]
    
    .COUNTING:
        CMP [SI], 'A'
        JE .COUNT1
        CMP [SI], 'E'
        JE .COUNT1
        CMP [SI], 'I'
        JE .COUNT1
        CMP [SI], 'O'
        JE .COUNT1
        CMP [SI], 'U'
        JE .COUNT1
        CMP [SI], 'a'
        JE .COUNT1
        CMP [SI], 'e'
        JE .COUNT1
        CMP [SI], 'i'
        JE .COUNT1
        CMP [SI], 'o'
        JE .COUNT1
        CMP [SI], 'u'
        JE .COUNT1
        INC SI
    LOOP .COUNTING
    
    CMP CL, 0
    JE .DISPLAY  
                        
    .COUNT1:
        INC COUNT
        INC SI
    LOOP .COUNTING        
    
    
    .DISPLAY:
        MOV DX, OFFSET STR2
        MOV AH, 9
        INT 21H
        
        MOV AH, 2
        MOV DL, COUNT
        ADD DL, '0'
        INT 21H
        
        MOV DX, OFFSET STR3
        MOV AH, 9
        INT 21H
        
    
    .END:
        ret
MAIN ENDP

STR1 DB 'Input a string: $'
STR2 DB 'The string contains $'
STR3 DB ' vowels!$'
BUFFER DB 15,?,15 DUP('')
COUNT DB ?
