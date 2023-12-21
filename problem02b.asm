
;//problem 2b


screen EQU $0400 ; start of the screen 

lda #$30 ;Load o into 
ldx #$31
ldy #screen
bra print

fibonacci:     ;fibonacci label 
tfr a, b       ;transfering contents of register A into register B 
abx            ;Adding the B register to X so now X holds the sum of the previous two Fibonacci numbers
tfr x, a       ;transfering X contents to A register 
suba #$30      ;substracting the memory from the accumulator 
cmpa #$38      ;check if we are at the end of the sequence by comparing memory from accumulator with memory address 38
beq done       ; we are going to jump to done if we reach the 8th number on the fib list if the value stored at A is equal to 8.
tfr b, x       ; now we transfer b content to x 
bra print      ;now we branch to the print statement and print out the value stored in register A 

print:
sta ,y+  ;This time we are incrementing the y register so we are printing at every consecutive place on the screen

bra fibonacci. ; branching back to the fibonacci label 

done:
sta ,y+ ; Store the final value in A at the memory address pointed to by Y, then increment Y (essentially printing the last Fibonacci value)
rts  ;return from subroutine