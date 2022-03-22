.data
M: .word 0

.text 
lui $t0, 4
jal Next

add $t0, $t0, $t0


Next:
	add $t0, $t0, $t0
	add $t0, $t0, $t0
	
	jr $ra
	