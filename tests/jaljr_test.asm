.data
M: .word 0

.text 
lui $t0, 0xffff
sw $t0, 0

lbu $t1, 2
add $t0, $t0, $t1

sw $t0, 4
lbu $t2, 0