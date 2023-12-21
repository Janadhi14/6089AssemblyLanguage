

screen EQU $0400

START:
 ldy #screen ; loading screen address into y regester
 ldd #$0000 ;loading 0 into the D register (for fib sequence initilization)
 ldx #$0001 ; loading x with 1 for fib sequence initilization
 jsr MAIN ; call the main 
 rts

MAIN:
 pshu d ;push d onto the stack
 pshu a ;push a onto the stack
 jsr CONVERSION ; justm to the converison  to convert eth high byte of D to ASCII
 tfr b,a ;Transfer B (which was modified in CONVERT) to A
 pshu b ;push b onto the stack 
 jsr CONVERSION ;jump to the conversion
 pulu a
 bra FIBONACCI

FIBONACCI:
 pshu d ;push onto stack
 pshu x
 addd ,U ;Adding the top two numbers on the stack, which will compute the next Fibonacci number
 pulu x ;Pull back the original value of X from the stack 
 pulu x ; pull the next fibonacci number form the stack into X 
 cmpd #$2511 ; so we compare cause 2511(asici) termination point so we comare and keep oging until this is achieved 
 beq DONE ;branches to done if D is equal to 2511(which is the )
 pshu a ; push A onto the stack 
 lda #$2C ;load A with the comma 
 sta ,y+ ; Store the comma at the address currently that Y is ponitng to 
pulu a ; pull the value stored in A(,) 
 bra MAIN , then branch back to main for the next number in teh sequence 

CONVERSION: ;using a similar function to as before to convert one byte (2 hex digits) in A to ASCII representation
 lsra 
 lsra
 lsra
 lsra
 jsr CHECK  ;checking function
 pulu a ; pulling nack the otigional value A from the stack
 anda #$f ;Mask A with 0xF  (second hex digit)
 jsr CHECK 
 rts

CHECK: 
 cmpa #$0A  
 bge LETTER
 ble NUMBER

LETTER:
 suba #$09 ;substracting 9 so we are getting the correct A to F values 
 sta ,y+
 rts

NUMBER:
 adda #$30 ; adding 30 to get the correct ascii representation 
 sta ,y+ ;store at the current screen y value and then increment y 
 rts
 
DONE:
 rts
