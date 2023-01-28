; 206171548, 50%
; 316451012, 50%
.ORIG X3898
;Mul, function version, we're doing haifa convention
;int mul(int a, int b) (return value is in R0)
;we're only doing positive times positive so we're goodddd

;increase stack size by num of registers to backup+lcoal variables
ADD R6,R6 #-3

;backup registers for local use
STR R1,R6,#0
STR R2,R6,#1
STR R7,R6,#2

;load parameters
LDR R1,R6,#4 ;R1=num1
LDR R2,R6,#5 ;R2=num2
AND R0,R0,#0 ;num1 * num2
ADD R1,R1,#0
BRz Fin ;if one of them is zero, res is zero
ADD R2,R2,#0
BRz Fin 
; input is legit so safe to assume num1,num2>0
LOOP:
	ADD R1,R1,#-1
	BRn Fin
	ADD R0,R0,R2
	BR LOOP
FIN:
;restoring backed up registers from stack
LDR R1,R6,#0
LDR R2,R6,#1
LDR R7,R6,#2

;pop current stack frame
ADD R6,R6,#3

RET