; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here

MAIN PROC
    MOV AX, 0B800H
    MOV ES, AX                      ; STORE TO DATA SEGMENT
    MOV DI, 0
    
    LEA SI, NUM                     ; LOAD WORD DB INTO SI
    MOV CX, 1                       ; LENGHT OF NUM ARRAY
    
    XOR BX, BX
    
    .DISPLAY_DIGIT:                 ; DISPLAYS NUM
        MOV AX, 00H 
        MOV AL, [SI]
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
        INC SI
    LOOP .DISPLAY_DIGIT
ret
MAIN ENDP

DISPLAY_CHAR PROC
    MOV DH, 00001011B
    MOV ES:[DI], DX
    INC DI
    INC DI
    RET  
DISPLAY_CHAR ENDP    

NUM DB 123
