.global _start
_start:
	LDR SP, =0x10000
	LDR R0, =LIST
	LDR R2, =N
	MOV R1, R0
	LDR R2, [R2]
	
	CMP R2, #1
	BEQ ENDY
	
PERC:
	ADD R1, R1, #4
	SUB R2, R2, #1
	CMP R2, #1
	BEQ NEXT
	B PERC
	
NEXT: 
	LDR R3, [R0]
	LDR R4, [R1]
	CMP R3, R4
	BNE ENDN
	
	ADD R0, R0, #4
	SUB R1, R1, #4
	CMP R0, R1
	BGE ENDY
	
	B NEXT	
	
ENDY:
	MOV R0, #1
	B ENDY
	
ENDN:
	MOV R0, #0
	B ENDN
	
	
	
LIST:
	.word 1, 1
N:
	.word 2
	
	