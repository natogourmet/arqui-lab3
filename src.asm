.data

Vector:	.word	-99, 0, -60, 45, -70, -28, -64, 46, -10, -9, -14, 45, -52, -24, -13, 2, 2, -63, 69, 32, 72, 34, 75, -26, 66, -35, 65, 77, 59, 18, 90, -66, -11, 4, -66, 80, 59, -59, -73, -41, 10, -27, 88, -74, -91, -13, 24, 69, 10, 89, 65, 17, -20, -14, 22, 70, -33, 92, 37, 92, 55, 28, -81, 22, 2, -21, 8, -15, -7, 7, 84, 62, -55, -87, 81, -76, 56, 67, -85, -90, -82, 83, -90, -2, 21, -31, 52, -54, -81, 2, 14, -31, 85, -21, 98, 98, 65, 3, -95, -4

.text

lui 	$t0, 1
lui 	$t1, 2
slt 	$s7, $t0, $t1	# Getting a 1
add 	$t1, $s7, $s7	# t1 is 2
add 	$s6, $t1, $t1	# Getting a 4

add 	$s5, $s6, $s6	#8
add 	$s5, $s5, $s5	#16
add 	$t1, $s5, $s5	#32
add 	$s5, $t1, $t1	#64
add 	$s5, $s5, $t1	#64+32 = 96
add	$s5, $s5, $s6	#96+4 = 100

add	$s4, $s7, $zero 	#s4 will be a counter = 1

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
	beq	$s4, $s5, End_Loop	# If counter == 100 break
	lw 	$s1, 0($s0)		#Loads current number
	beq	$s2, $zero, IsEven 	# (Toggle == 0)
	
		slt	$t0, $t8, $s1		# If (greatest < current)
		beq	$t0, $zero, NotGreaterOdd
			add	$t8, $s1, $zero
			#add	$t4, $zero, $zero
		NotGreaterOdd:
		
		
		slt	$t0, $s1, $t6		# If (current < smallest)
		beq	$t0, $zero, NotSmallerOdd
			add	$t6, $s1, $zero
			#add	$t2, $zero, $zero
		NotSmallerOdd:
		
		beq	$zero, $zero, NotSmallerEven
	
	
	IsEven:
		slt	$t0, $t9, $s1		# If (greatest < current)
		beq	$t0, $zero, NotGreaterEven
			add	$t9, $s1, $zero
			#add	$t5, $zero, $zero
		NotGreaterEven:
		
		
		slt	$t0, $s1, $t7		# If (current < smallest)
		beq	$t0, $zero, NotSmallerEven
			add	$t7, $s1, $zero
			#add	$t3, $zero, $zero
		NotSmallerEven:
	
	nor	$s2, $s2, $zero		# Toggle = !Toggle because next is Odd Index
	add	$s0, $s0, $s6		# Next Pos
	add	$s4, $s4, $s7		# Counter += 1
	beq 	$zero, $zero, Loop
	
End_Loop:


Count_Loop:
	#This loop will traverse Vector backwards so we don't have to set again the counter and the vector pointer
	beq	$s4, $s7, End_Count_Loop	# If counter == 1 break
	lw 	$s1, 0($s0)
	
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
	
	
	sub	$s0, $s0, $s6		# Prev Pos
	sub	$s4, $s4, $s7		#counter -= 1
	beq 	$zero, $zero, Count_Loop
	

End_Count_Loop: