; 206171548, 50%
; 316451012, 50%
.ORIG X38FC
;int getNum(), function version, we're doing haifa convention

; IT IS SAFE TO ASSUME INPUT IS LEGIT AND WONT CAUSE 
;OVERFLOW OR ANY BAD STUFF

;increase stack size by numbers of registers to backup + local variables
ADD R6,R6,#-5

; backup registers for local use
STR R1, R6, #0
STR R2, R6, #1
STR R3, R6, #2
STR R4, R6, #3
STR R7,R6,#4
; There are no parameters to load to function, only to return

; rememebr that the input is either for num of rows/cols(1<x<21) 
; or for matrix values (0,1) so max 2 digits in our number
RESTART:
GETC
OUT
LD R3, NEG_ASCI_OFFEST
ADD R0,R0,R3 ;turn val we got asci->number, if res we got is negative means
;num asci val is not bigger than 48 so it must be either space of newline
;for first input which means user is trying to fk with us
BRn RESTART
ADD R1,R0,#0 ;R1 will hold the number
INPUT_LOOP:
	GETC
	OUT
	ADD R0,R0,R3 ; turn what we got from asci->val
	BRn FIN ;if it is negative, means not a number so must be newline/space=end of input
	JSR MUL_R1_BY_10
	ADD R1,R1,R0 ;R1 is old R0, so we 10*R1+(new)R0 (ex: 8, next input is 1 so 8*10+1=81)
	BR INPUT_LOOP
FIN:
ADD R0,R1,#0 ;R1 holds final val, store it in R0 which is return value

;restore backed up registers from stack
LDR R1, R6, #0
LDR R2, R6, #1
LDR R3, R6, #2
LDR R4, R6, #3
LDR R7, R6, #4 

;pop current stack frame
ADD R6,R6, #5


RET
NEG_ASCI_OFFEST .FILL #-48

MUL_R1_BY_10: ;this lil guy muls R1 by 10, destroys R4,R2 in the process
	ADD R2,R1,#0 ; R2 holds original val
	AND R4,R4,#0
	ADD R4,R4,#9
	LOOP:
		ADD R4,R4,#-1
		BRn finny
		ADD R1,R1,R2
		BR LOOP
	finny:
	RET	
	