
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
MOV AX, 0202h
MOV BX, 0B0Bh
SUB BX, AX

ret