.global _start
.global SWAP
_start:
LDR SP, = 0x3FFFFFC
LDR R0, =LIST 
LDR R2, [R0]
SUB R2, R2, #1 //index of list
ADD R0, R0, #4 //address of item in first list
MOV R1, R0

OUT:

PUSH {R0}
CMP R2, #0
BEQ END

MOV R3, R2

IN:
PUSH {R0}
CMP R3, #0
BEQ BET
BL SWAP
SUB R3, R3, #1
POP {R0}
ADD R0, R0, #4

B IN

BET:
SUB R2, R2, #1
MOV R3, R2
POP {R0}
MOV R0, R1
B OUT

END:
B END


SWAP:
    PUSH {LR}
    PUSH {R5} //random one
    PUSH {R1} //another random one
    
    // R0 has #1 address
    PUSH {R0}
    LDR R1, [R0, #4]
    LDR R0, [R0]
    CMP R0, R1
    BGE YES
    POP {R0}
    MOV R0, #0
    B ENDSUB
YES:
    // EOR R1, R0, R1
    // EOR R0, R1, R0
    // EOR R1, R1, R0
    POP {R5} // address R0 => R5
    STR R1, [R5]
    ADD R5, R5, #4
    STR R0, [R5]
    MOV R0, #1
    B ENDSUB
ENDSUB:
    POP {R1}
    POP {R5}
    POP {PC}