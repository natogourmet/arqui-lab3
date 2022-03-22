.data
M: .word 0

.text
lui $t0, 3
lui $t1, 0

sw $t0, 8($t1)

add $t0, $t0, $t0

lw $t1, 8($t1)
