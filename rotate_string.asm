; rotate in place string character from left to right

org 100h

    MOV DX, OFFSET STR1             ; Display 'Input a string:'
    MOV AH, 9
    INT 21H    
    
    MOV DX, OFFSET BUFFER           ; Read string user input
    MOV AH, 0AH
    INT 21H
    
    XOR BX, BX
    MOV BL, BUFFER[1]               ; Get length of the string
    MOV BUFFER[BX+2], '$'
    MOV BH, BUFFER[1]

    CALL NEW_LINE
    
    MOV DX, OFFSET STR2             ; Display 'Output:'
    MOV AH, 9
    INT 21H
    
    CALL NEW_LINE
    
    MOV DX, OFFSET BUFFER[2]        ; Skip first 2 bytes and display the string
    MOV AH, 9
    INT 21H
    
    JMP SET_COUNTER
        
RET

SET_COUNTER:                        ; Set counter for rotation
    MOV BL, 8
    JMP START_LOOP
    
    
START_LOOP:                         ; Rotation process
    MOV CH, 0
    MOV CL, BUFFER[1]               ; Load the length of the string
    MOV SI, CX
    MOV CH, BUFFER[SI+1]            ; Load the last character of the string
    MOV SI, 0
    CLC
    AND CH, 1                       ; Check if the last character is odd or even
    JZ ROTATE                       ; If even, jump to ROTATE
    STC                             ; If odd, set the CF

ROTATE:
    RCR BUFFER[SI+2], 1             ; Rotate the string by 1 bit to the right
    INC SI
    DEC CL
    JNZ ROTATE
    
    DEC BL
    JNZ START_LOOP
    JMP DISPLAY
    
DISPLAY:
    CALL NEW_LINE
    MOV DX, OFFSET BUFFER
    ADD DX, 2                       ; Skip the first 2 control bytes
    MOV AH, 9
    INT 21H
    
    DEC BH
    JNZ SET_COUNTER
    JMP EXIT             

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

STR1 DB 'Input a string: $'
STR2 DB 'Output:$'
BUFFER DB 15,?,15 DUP('')
