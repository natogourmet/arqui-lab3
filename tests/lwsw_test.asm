.data
M: .word 0

.text
Previous:
lui $t0, 4
add $t0, $t0, $t0

j Next
add $t0, $t0, $t0
add $t0, $t0, $t0
add $t0, $t0, $t0
add $t0, $t0, $t0

Next:
add $t0, $t0, $t0

j Previous