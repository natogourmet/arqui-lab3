.data
M: .word 0

.text
lui $t0, 3
lui $t1, 4

beq $t0, $t1, Fin

lui $t2, 3

beq $t0, $t2, Fin

add $t0, $t0, $t1
add $t0, $t0, $t1
add $t0, $t0, $t1

Fin:

