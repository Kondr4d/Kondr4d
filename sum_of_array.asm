; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
MAIN PROC
    MOV AX, 0B800H
    MOV ES, AX                          ; STORE TO DATA SEGMENT
    MOV DI, 0                           
    
    LEA SI, WORD                        ; LOAD WORD DB INTO SI
    MOV CX, 11                          ; LENGHT OF WORD
    
    .DISPLAY_WORD:                      ; DISPLAYS WORD 
        MOV DL, [SI]
        CALL DISPLAY_CHAR
        INC SI
    LOOP .DISPLAY_WORD
    
    LEA SI, NUMS                        ; LOAD WORD DB INTO SI
    MOV CX, 5                           ; LENGHT OF NUM ARRAY
    
    XOR BX, BX
    
    .DISPLAY_DIGIT:                     ; DISPLAYS NUM
        MOV AX, 00H
        MOV AL, [SI]
        ADD SUM, AX                     ; STORE THE SUM INTO SUM VAR
        MOV BL, 10                      ; MOV 10 TO FOR DIVISION
        DIV BL                          ; AX/BL, STORE QUOTIENT TO AL & REMAINDER TO AH
              
        MOV DL, AL                      ; MOVE TENS TO DL
        ADD DL, '0'      
        CALL DISPLAY_CHAR
        
        MOV DL, AH                      ; MOVE ONES TO DL
        ADD DL, '0'      
        CALL DISPLAY_CHAR
        
        DEC CX        
        JZ DISPLAY_EQUAL
        
        MOV DL, ' '
        CALL DISPLAY_CHAR   
        MOV DL, '+'
        CALL DISPLAY_CHAR
        MOV DL, ' '
        CALL DISPLAY_CHAR
        
        INC SI
        JMP .DISPLAY_DIGIT
        
    .READY_SUM:
        MOV AX, SUM                     ; LOAD VALUE OF SUM VAR INTO AX
        MOV CX, 1                       ; LENGTH OF SUM
        XOR BX, BX
        
        .DISPLAY_SUM:                   ; DISPLAYS NUM
            CALL DISPLAY_3DIGIT
            INC SI
        LOOP .DISPLAY_SUM
        
        
    MOV DI, 160    
    LEA SI, WORD2                        ; LOAD WORD DB INTO SI
    MOV CX, 11                          ; LENGHT OF WORD
    
    .DISPLAY_WORD2:                      ; DISPLAYS WORD 
        MOV DL, [SI]
        CALL DISPLAY_CHAR
        INC SI
    LOOP .DISPLAY_WORD2
    
    CALL GET_QUOTIENT
    
    LEA SI, QUOTIENT
    MOV CX, 1
    
    XOR AX, AX
    MOV AL, QUOTIENT
    XOR BX, BX
    
    .DISPLAY_QUOTIENT:
        CALL  DISPLAY_2DIGIT
        INC SI
    LOOP .DISPLAY_QUOTIENT  
    
    MOV DI, 320    
    LEA SI, WORD3                        ; LOAD WORD DB INTO SI
    MOV CX, 12                          ; LENGHT OF WORD
    
    .DISPLAY_WORD3:                      ; DISPLAYS WORD 
        MOV DL, [SI]
        CALL DISPLAY_CHAR
        INC SI
    LOOP .DISPLAY_WORD3
    
    LEA SI, REMAINDER
    MOV AL, REMAINDER
    MOV CX, 1
    
    XOR BX, BX
    
    .DISPLAY_REMAINDER:   
        MOV DL, AL
        ADD DL, '0'
        CALL DISPLAY_CHAR  
        INC SI
    LOOP .DISPLAY_REMAINDER 
          
.END:           
    ret
MAIN ENDP

DISPLAY_CHAR PROC                       ; SUB ROUTINE TO DISPLAY A CHARACTER
    MOV DH, 00001011B
    MOV ES:[DI], DX
    INC DI
    INC DI
    RET  
DISPLAY_CHAR ENDP

DISPLAY_EQUAL PROC                      ; SUB ROUTINE TO DISPLAY EQUAL SIGN 
    MOV DL, ' '
    CALL DISPLAY_CHAR   
    MOV DL, '='
    CALL DISPLAY_CHAR
    MOV DL, ' '
    CALL DISPLAY_CHAR
    JMP .READY_SUM
DISPLAY_EQUAL ENDP

DISPLAY_2DIGIT PROC
    MOV AX, 00H
    MOV AL, [SI]
    MOV BL, 10                      ; MOV 10 TO FOR DIVISION
    DIV BL                          ; AX/BL, STORE QUOTIENT TO AL & REMAINDER TO AH
      
    MOV DL, AL                      ; MOVE TENS TO DL
    ADD DL, '0'      
    CALL DISPLAY_CHAR
    
    MOV DL, AH                      ; MOVE ONES TO DL
    ADD DL, '0'      
    CALL DISPLAY_CHAR           
    RET
DISPLAY_2DIGIT ENDP    

DISPLAY_3DIGIT PROC
    MOV BL, 10                  ; MOV 10 TO FOR DIVISION
    DIV BL                      ; AX/BL, STORE QUOTIENT TO AL & REMAINDER TO AH
    MOV BH, AH
    MOV AH, 0H
    DIV BL 
      
    MOV DL, AL                  ; MOVE HUNDREDS TO DL
    ADD DL, '0'      
    CALL DISPLAY_CHAR
    
    MOV DL, AH                  ; MOVE TENS TO DL
    ADD DL, '0'      
    CALL DISPLAY_CHAR
    
    MOV DL, BH                  ; MOVE ONES TO DL
    ADD DL, '0'      
    CALL DISPLAY_CHAR
    
    MOV DL, ' '
    CALL DISPLAY_CHAR
    RET
DISPLAY_3DIGIT ENDP    

GET_QUOTIENT PROC
    MOV AX, SUM     
    MOV BX, 00H
    MOV BL, DVSR
    DIV BL
    MOV QUOTIENT, AL
    MOV REMAINDER, AH
    RET
GET_QUOTIENT ENDP
  
WORD DB 'THE SUM OF '
WORD2 DB 'QUOTIENT = '
WORD3 DB 'REMAINDER = '
NUMS DB 12, 23, 34, 45, 56
SUM DW ?
QUOTIENT DB ?
REMAINDER DB ?                  
DVSR DB 03
