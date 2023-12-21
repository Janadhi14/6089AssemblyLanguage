

screen EQU $0400   ;start of screen

lda #$30       ;load accumulator from memory with 0
ldx #$31       ;load accumulator from memory with 1
bra print      ;now print straight away the first 2 fib numbers 

FIBONACCI:     ;fibonacci label 
tfr a, b       ;transfering contents of register A into register B 
abx            ;Adding the B register to X so now X holds the sum of the previous two Fibonacci numbers
tfr x, a       ;transfering X contents to A register 
suba #$30      ;substracting the memory from the accumulator 
cmpa #$38      ;check if we are at the end of the sequence by comparing memory from accumulator with memory address 38
beq done       ; we are going to jump to done if we reach the 8th number on the fib list if the value stored at A is equal to 8.
tfr b, x       ; we transfer b content to x 
bra print      ;now we branch to the print statement and print out the value stored in register A 

print:         ; label for print routine
ldy #screen    ; load the value for the screen into the Y register 
sta ,y         ; Store the value in the A register at the memory address pointed to by the Y register (essentially printing)

bra fibonacci. ; branching back to the fibonacci label 

done:          ; done condition label  
sta ,y         ; Store the value in the A register at the memory address pointed to by the Y register (essentially printing) for the last fib value 
rts            ; return from subroutine 