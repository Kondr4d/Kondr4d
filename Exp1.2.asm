
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
mov bx, 0123h
mov ax, 0456h
add ax, bx
sub ax, bx
push ax
push bx

ret




