
;//Question 1:
lda #$30    ; Load the value 0 (we are saying 30 becase hexidecimal) into the A register 

LOOP:       ; loop label
sta $0400   ; Store the current value of the A register to memory location 0x0400
inca      ; we want to increment the value in the A register by 1
cmpa #$39   ; Compare the value in the A register to the immediate value 0x39 which is 9 
ble LOOP    ;If the value in the A is less than or equal to 9, branch back to the otp of teh loop
rts         ; Return from subroutine