.ORIG X39C4
;void getMatrix(MatrixPtr p, int size)
; we assume R6+0 is the pointer to the matrix (address of cell 0,0)
; we assume R6+1 is the size of matrix

;increase stack size by number of registers to backup
ADD R6,R6,#-5

;backup registers for local use
STR R1, R6, #0 ; flag for illegal input
STR R2, R6, #1 ;getnum address / something else
STR R3, R6, #2	;matrix size
STR R4, R6, #3 ; matrix address
STR R7, R6, #4

;load parameters
LDR R4, R6, #5 ; R4=Matrix Address
LDR R3, R6, #6 ; R3=Matrix size
AND R1,R1,#0 ; this is flag for illegal input
LEA R0, PLZ_ENTER
PUTS
AND R0,R0,#0
RESTART_MATRIX_INPUT:
;illegal situations: maze cell val !=0,1  // (0,0)!=1 // (n-1,n-1)!=1
;first we check (0,0)
ADD R3,R3,#-2 ; skip first cell so reduce R3 which is matrix
; size aka loop counter, also skip last cell which we need 
;to check if is 1

LD R2, GETNUM_ADDR ; getnum stores the input in R0
JSRR R2
ADD R0,R0,#-1; check if R0=1
BRz GoodInput1
ADD R1,R1,#1 ;raise flag
GoodInput1:
ADD R0,R0,#1 ;restore R0
STR R0,R4,#0
ADD R4,R4,#1 ;forward matrix pointer
InputLOOPY:
	ADD R3,R3,#-1 ; using R3 as loop counter
	BRn NOW_TAKE_FINAL_ELEMENT
	JSRR R2 ;getnum into R2, can be only 0 or 1
	ADD R0,R0,#0 ; check if 0
	BRz GoodInputInLOOP
	ADD R0,R0,#-1 ;check if 1
	BRz GoodInputInLoopButGotOneNeedToFixR0
	;we got here so no bueno amigo
	ADD R1,R1,#1 ;raise de flag
	GoodInputInLoopButGotOneNeedToFixR0:
	ADD R0,R0,#1 ; fixing R0
	GoodInputInLOOP:
	;we're here so need to store and forward pointer
	STR R0,R4,#0
	ADD R4,R4,#1 ;forward matrix pointer`
	BR InputLOOPY
NOW_TAKE_FINAL_ELEMENT:
;we got here so we're finished taking 1+(n^2)-2 inputs, to complete to 
;n^2 we need 1 more which is (n-1,n-1) elemnt
;Size=-1 (in R3) and R4 points to final cell 
JSRR R2 
ADD R0,R0,#-1; check if R0=1
BRz GoodInput2
ADD R1,R1,#1 ;raise flag
GoodInput2:
ADD R0,R0,#1 ;restore R0
STR R0,R4,#0

;we're done filling the matrix, time to check if it is legal
;remember R1 is our flag which could've been raised millions of times,
;if it aint 0, input is not good somehwere we dont rly care
ADD R1,R1,#0
BRz PrintAndFin
;we're here so flag isnt 0 so we need to restart input matrix
LEA R0,BAD_INPUT
PUTS
BR RESTART_MATRIX_INPUT

PrintAndFin:
LEA R0, HOPEFUL_MOUSE
PUTS

;restore backed up registers from stack
STR R1, R6, #0 
STR R2, R6, #1 
STR R3, R6, #2	
STR R4, R6, #3 
STR R7, R6, #4

;pop current staack framE
ADD R6,R6,#5

RET
GETNUM_ADDR .fill x38FC
BAD_INPUT .stringz "Illegal maze! Please try again:\n"
PLZ_ENTER .stringz "Please Enter the maze matrix:\n"
HOPEFUL_MOUSE .stringz "The mouse is hopeful he will find his cheese\n"
.END