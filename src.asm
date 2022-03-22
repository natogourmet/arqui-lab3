.data

Vector:	.word	-100, -59, 31, 57, -85, 79, -41, 82, -89, 53, -68, 8, 1, 12, -1, -83, 68, 73, -30, -46, 54, -31, -22, -73, -43, -53, -73, 20, -6, -17, 3, 20, -6, -51, 23, -20, -89, 94, 52, 4, -56, 90, 64, -64, -45, -2, -59, -53, 46, -48, 34, -62, -56, -35, -86, 21, -65, 56, 40, 66, -46, -37, 57, 12, 76, 3, 10, 35, -19, -95, 20, -84, 81, -52, 85, -57, 19, 78, 18, 98, -9, 51, -92, -39, -3, -73, 52, -2, -18, -48, 42, -67, 57, 49, 10, -76, 25, -1, -49, 33

.text

lui 	$t0, 1
lui 	$t1, 2
slt 	$s7, $t0, $t1	# Getting a 1
add 	$t1, $s7, $s7
add 	$s6, $t1, $t1	# Getting a 4

lui	$t9, 0xffff	# Greatest Even
lui	$t8, 0xffff	# Greatest Odd
lui	$t7, 0x1	# Smallest Even
lui	$t6, 0x1	# Smallest Odd
lui	$t5, 0		# Greatest Even Counter
lui	$t4, 0		# Greatest Odd Counter
lui	$t3, 0		# Smallest Even Counter
lui	$t2, 0		# Smallest Odd Counter

la 	$s0, Vector		# First vector loaded somehow, only god knows how
lui	$s2, 0			# Toggle to check if even


Loop:
	lw 	$s1, 0($s0)
	beq	$s1, $zero, End_Loop
	beq	$s2, $zero, IsEven 	# (Toggle == 0)
	
		slt	$t0, $t8, $s1		# If (greatest < current)
		beq	$t0, $zero, NotGreaterOdd
			add	$t8, $s1, $zero
			add	$t4, $zero, $zero
		NotGreaterOdd:
		
		
		slt	$t0, $s1, $t6		# If (current < smallest)
		beq	$t0, $zero, NotSmallerOdd
			add	$t6, $s1, $zero
			add	$t2, $zero, $zero
		NotSmallerOdd:
		
		beq	$zero, $zero, NotSmallerEven
	
	
	IsEven:
		slt	$t0, $t9, $s1		# If (greatest < current)
		beq	$t0, $zero, NotGreaterEven
			add	$t9, $s1, $zero
			add	$t5, $zero, $zero
		NotGreaterEven:
		
		
		slt	$t0, $s1, $t7		# If (current < smallest)
		beq	$t0, $zero, NotSmallerEven
			add	$t7, $s1, $zero
			add	$t3, $zero, $zero
		NotSmallerEven:
		
	# Counters checker
		
	CheckGreatestEven:	beq $s1, $t9, SameGreatestEven		# if (current == GreatestEven)
		beq $zero, $zero, CheckGreatestOdd
		SameGreatestEven: 	add	$t5, $t5, $s7		# GreatestEvenCounter + 1
		
	CheckGreatestOdd:	beq 	$s1, $t8, SameGreatestOdd	# if (current == GreatestOdd)
		beq $zero, $zero, CheckSmallestEven
		SameGreatestOdd: 	add	$t4, $t4, $s7		# GreatestOddCounter + 1
		
	CheckSmallestEven:	beq 	$s1, $t7, SameSmallestEven	# if (current == SmallestEven)
		beq $zero, $zero, CheckSmallestOdd
		SameSmallestEven: 	add	$t3, $t3, $s7		# SmallestEven + 1
	
	CheckSmallestOdd:	beq 	$s1, $t6, SameSmallestOdd	# if (current == SmallestOdd)
		beq $zero, $zero, EndEquals
		SameSmallestOdd: 	add	$t2, $t2, $s7		# SmallestOdd + 1
		
	EndEquals:
	
	nor	$s2, $s2, $zero		# Toggle = !Toggle because next is Odd Index
	add	$s0, $s0, $s6		# Next Pos
	beq 	$zero, $zero, Loop
	
End_Loop: