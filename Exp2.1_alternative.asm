
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
    MOV AX, 0B800H
    MOV ES, AX                          ; STORE TO DATA SEGMENT
    MOV DI, 0
    MOV CX, 76                          ; LENGHT OF THE SCREEN    
    
    .NAME:
        MOV ES: [DI-2], 00000000B       ; CLEAR PREVIOUS CHARACTER
        MOV DL, 'S'
        MOV DH, 00001011B               ; FOREGROUND - BLUE, BACKGROUND - BLACK    
        MOV ES: [DI], DX    
        MOV DL, 'K'    
        MOV ES: [DI+2], DX              ; INCREMENT BY 2, SINCE THE FIRST CHAR TAKES 2 BYTES     
        MOV DL, 'T'
        MOV ES: [DI+4], DX    
        MOV DL, 'G'
        MOV ES: [DI+6], DX
        MOV DL, 'A'
        MOV ES: [DI+8], DX
        ADD DI, 2                       ; MOVE BY 2 BYTES 
    LOOP .NAME
ret



