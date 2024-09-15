org 100h

    LEA DX, MSG_PROMPT
    MOV AH, 9
    INT 21H
    
    CALL NEW_LINE
    
    GET_INPUT:
        CMP NUM, 6
        JE DISPLAY_SUM
        CALL DISPLAY_PROMPT
        
        MOV AH, 1
        INT 21H
        SUB AL, '0'
        MOV BH, AL
        INT 21H
        SUB AL, '0'
        MOV BL, AL
        
        MOV AL, BH
        MOV CL, 10
        MUL CL
        ADD AL, BL
        MOV AH, 0
        ADD SUM, AX
        
        CALL NEW_LINE
        
        MOV CX, SUM
    LOOP GET_INPUT    

ret

DISPLAY_SUM:
    LEA DX, SUM_PROMPT
    MOV AH, 9
    INT 21H

    MOV AX, SUM 
    MOV CX, 1
    XOR BX, BX
    CALL DISPLAY_DIGIT
    JMP EXIT

DISPLAY_DIGIT:                  ; DISPLAYS NUM
    MOV BL, 10                  ; MOV 10 TO FOR DIVISION
    DIV BL                      ; AX/BL, STORE QUOTIENT TO AL & REMAINDER TO AH
    MOV REMAINDER, AH
    MOV AH, 0H
    DIV BL
    MOV BH, AH 
          
    MOV DL, AL                  ; MOVE HUNDREDS TO DL
    ADD DL, '0'      
    CALL DISPLAY_CHAR
    
    MOV DL, BH                  ; MOVE TENS TO DL
    ADD DL, '0'      
    CALL DISPLAY_CHAR
    
    MOV DL, REMAINDER           ; MOVE ONES TO DL
    ADD DL, '0'      
    CALL DISPLAY_CHAR
    
    MOV DL, ' '
    CALL DISPLAY_CHAR
    INC SI
    LOOP DISPLAY_DIGIT
    
    RET

DISPLAY_CHAR:
    MOV AH, 2
    INT 21H
    RET

DISPLAY_PROMPT:
    MOV AL, NUM
    ADD AL, '0'
    MOV [INPUT_PROMPT+4], AL
    INC NUM
    
    LEA DX, INPUT_PROMPT
    MOV AH, 9
    INT 21H
    RET

NEW_LINE:
    MOV DX, 13
    MOV AH, 2
    INT 21H
    MOV DX, 10
    MOV AH, 2
    INT 21H
    RET 
    
EXIT:
    RET    

MSG_PROMPT DB 'INPUT VALUES:$'
INPUT_PROMPT DB 'VAL ?: $'
SUM_PROMPT DB 'SUM = $'
NUM DB 1
REMAINDER DB ?
SUM DW ?
