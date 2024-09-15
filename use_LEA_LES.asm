
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
    MOV AX, 0B800H
    MOV ES, AX                   ; STORE TO DATA SEGMENT
    MOV DI, 0
    MOV CX, 76                   ; LENGHT OF THE SCREEN 
    
    LEA SI, INIT
    MOV CX, 5
     
   .DISPLAY:
        MOV DL, [SI]
        MOV DH, 00001011B   
        MOV ES:[DI], DX
        INC SI
        INC DI
        INC DI
    LOOP .DISPLAY

ret
  
INIT DB 'S', 'K', 'T', 'G', 'A'
NGAN DB 3 DUP('S')