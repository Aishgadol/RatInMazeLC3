; 206171548, 50%
; 316451012, 50%
; Convention: Haifa
.ORIG x3000
LD R6, STK_BTM
LEA R3, MATRIX
LD R1, GET_NUM_ADDR
LEA R0, ENTER_NUM
PUTS
JSRR R1 ;getnum, num is stored in R0 and we can assume input is okay (2 to 20)
;time to get the matrix
ADD R2, R0, #0 ;R2 holds Maze N
LD R1 ,GET_MATRIX_ADDR
ADD R6,R6, #-2 ; tutor said we cant use xbfff so we'll store 
;parameters to get matrix in above cells
STR R3 ,R6, #0 ; store paramets for getmatrix 
STR R2 ,R6, #1
JSRR R1 ;get matrix,it is using getnum but it's all good
ADD R6,R6,#2 ;pop frame of parameters
LEA R3, MATRIX
ADD R6,R6, #-2 ; we will push matrix pointer (to 0,0) and row/col size to stack 
;in order to call the solve function
STR R3, R6, #0
STR R2, R6, #1
JSR SOLVE





HALT

MATRIX .blkw #400 #-1
ENTER_NUM .stringz "Please enter a number between 2 to 20: "
STK_BTM .fill xbfff
GET_NUM_ADDR .fill X38FC
GET_MATRIX_ADDR .fill X39C4

;-------------
;shit for the function below:

;-------------------
;void solve(int* matrix, int n)
;-------------
SOLVE:
	
	
	
	
	RET
	
	
;------------
;bool midJourney(int x, int y)
.END