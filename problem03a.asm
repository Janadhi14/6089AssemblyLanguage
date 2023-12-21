
screen EQU $0400

START:
 ldy #screen ; loading the screen address into the Y register 
 jsr MAIN ;we are jumping to the main subroutine 
 rts ; return from subroutine when we finish



MAIN: 
 ldd #$FDCB ;loading the letters FDCB into the D register (A and B combined)
 pshu d, a ;pushing the D and A registers onto the hardwarestack  (temporarily storing the value(origional value))
 jsr CONVERSION ;jumping to main subroutine conversion which will convert 
 tfr b,a    ;transfer b into a so we are getting the next letters 
 jsr CONVERSION ;jump to conversion adn do the same for the next 2 letters    
 lda #$20  ;loading the space character into register A.
 sta ,y+   ; for printing out the space between the numbers once we print out the letters  
; for printing out the letters 
 ldd #$1234    ;loading up register with numbers 1234           
 pshu d, a     ; pushing the d register and a register to the stack 
 jsr CONVERSION   ; jump to the conversion subroutine again for teh numbers 
 tfr b,a     ;transfer the value in b to A 
 jsr CONVERSION   ; jump to the conversion subroutine again 
 rts     ; return from subroutine when we finish 

; a subroutine to convert a single 8-bit value, representing two 4-bit hexadecimal digits, and convert both of these hexidecimal representaitons of the digits into their ASCII representations.

CONVERSION: 
 lsra
 lsra
 lsra
 lsra           ;right shifting 4 times so we can shift the binary value right so that we can get the isolate only the letter or number that we want. in the A register 
 jsr CHECK  ; jumping to the subroutine checking to see if it is a letter or number 
 pulu a   ; pulling the value A from the stack 
 anda #$f  ;Mask A with `0xF` to get the second hex digit
 jsr CHECK ; now we are going to jump to the check subroutine
 rts ; return to subroutine   

; checking subroutine to check if the value is the hexvalues 
CHECK: 
cmpa #$0A ; comparing the value in the A register with the value 10(#$0A)
bge LETTERS ; branching to print letters if greater than the comparison value in A 
ble NUMBERS ;branching to numbers if the vale A is less than or equal to 9 

; Letters subroutine for printing letters 
LETTERS:
 suba #$09    ;Subtract 9 to align with ASCII values.
 sta ,y+      ;going to the next position 
 rts      ; returning to subroutine
; Numbers subroutine 
NUMBERS:
 adda #$30
 sta ,y+
 rts

