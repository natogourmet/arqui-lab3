.data

Vector:	.word	-99, 0, -60, 45, -70, -28, -64, 46, -10, -9, -14, 45, -52, -24, -13, 2, 2, -63, 69, 32, 72, 34, 75, -26, 66, -35, 65, 77, 59, 18, 90, -66, -11, 4, -66, 80, 59, -59, -73, -41, 10, -27, 88, -74, -91, -13, 24, 69, 10, 89, 65, 17, -20, -14, 22, 70, -33, 92, 37, 92, 55, 28, -81, 22, 2, -21, 8, -15, -7, 7, 84, 62, -55, -87, 81, -76, 56, 67, -85, -90, -82, 83, -90, -2, 21, -31, 52, -54, -81, 2, 14, -31, 85, -21, 98, 98, 65, 3, -95, -4

.text

# lui	$sp, 0x1		# TODO: Uncomment
la	$s0, Vector		# TODO: Change to 0




#	Calling The Get One and Four Procedure
jal	GetOneAndFour
add	$s1, $v0, $0		# Saving number one
add	$s2, $v1, $0		# Saving number four




#	Calling The Get Hundred Procedure
jal	GetHundred
add	$s3, $v0, $0		# Saving number one hundred




#	Calling The Count Get Maxs Mins Procedure
jal	GetMaxsMins
# DISCLAIMER:
# This proccess could've been done with less instructions but it's like this just for the sake 
# of showing the whole stacking flow
add	$s5, $v0, $0		# Gets v0	// Gets Smallest Even
add	$s4, $v1, $0		# Gets v1	// Gets Smallest Odd

lw	$v0, 0($sp)		# Pops v0
lw	$v1, 4($sp)		# Pops v1
add	$sp, $sp, $s2		# Stack Pile + 4
add	$sp, $sp, $s2		# Stack Pile + 4

add	$s7, $v0, $0		# Gets v0(sp)	// Gets Greatest Even
add	$s6, $v1, $0		# Gets v1(sp)	// Gets Greatest Odd




#	Calling The Count Max Mins Procedure
add	$a0, $s7, $0
add	$a1, $s6, $0
add	$a2, $s5, $0
add	$a3, $s4, $0
jal	CountMaxMins
# DISCLAIMER:
# This proccess could've been done with less instructions but it's like this just for the sake 
# of showing the whole stacking flow
add	$s1, $v0, $0		# Gets v0	// Gets Smallest Even
add	$s0, $v1, $0		# Gets v1	// Gets Smallest Odd

lw	$v0, 0($sp)		# Pops v0
lw	$v1, 4($sp)		# Pops v1
add	$sp, $sp, $s2		# Stack Pile + 4
add	$sp, $sp, $s2		# Stack Pile + 4

add	$s3, $v0, $0		# Gets v0(sp)	// Gets Greatest Even
add	$s2, $v1, $0		# Gets v1(sp)	// Gets Greatest Odd


j Finish_Program


####################################################################################################
# PROCEDURE: Get One and Four
# Creates the numbers one and four
# params:
# return:
#	- v0: Number one
#	- v1: Number four
GetOneAndFour:
	lui 	$t0, 1
	lui 	$t1, 2
	slt 	$t0, $t0, $t1	# Getting a 1
	add 	$t1, $t0, $t0	# t1 is 2
	add 	$t1, $t1, $t1	# Getting a 4
	
	add	$v0, $t0, $0
	add	$v1, $t1, $0
	jr	$ra

####################################################################################################
# PROCEDURE: Get Hundred
# Creates the numbers one hundred
# params:
# return:
#	- v0: Number One Hundred
GetHundred:
	add 	$t0, $s2, $s2	#8
	add 	$t0, $t0, $t0	#16
	add 	$t1, $t0, $t0	#32
	add 	$t0, $t1, $t1	#64
	add 	$t0, $t0, $t1	#64+32 = 96
	add	$t0, $t0, $s2	#96+4 = 100
	
	add	$v0, $t0, $0
	jr	$ra
	

####################################################################################################
# PROCEDURE: GetMaxsMins
# Looks for the Max and Min numbers of both even and odd index slots in the Vector
# params:
# return:
#	- v0(sp): Greatest Even
#	- v1(sp): Greatest Odd
#	- v0: Smallest Even
#	- v1: Smallest Even
GetMaxsMins:

lui	$t9, 0xffff	# Greatest Even
lui	$t8, 0xffff	# Greatest Odd
lui	$t7, 0x1	# Smallest Even
lui	$t6, 0x1	# Smallest Odd

add	$t4, $0, $0 		# s4 will be a counter = 0
add 	$t3, $s0, $0		# Loads Vector first pos
lui	$t2, 0			# Toggle to check if even



Loop:
	beq	$t4, $s3, End_Loop	# If counter == 100 break
	lw 	$t1, 0($t3)		#Loads current number
	beq	$t2, $zero, IsEven 	# (Toggle == 0)
	
		slt	$t0, $t8, $t1		# If (greatest < current)
		beq	$t0, $zero, NotGreaterOdd
			add	$t8, $t1, $zero
			#add	$t4, $zero, $zero
		NotGreaterOdd:
		
		
		slt	$t0, $t1, $t6		# If (current < smallest)
		beq	$t0, $zero, NotSmallerOdd
			add	$t6, $t1, $zero
			#add	$t2, $zero, $zero
		NotSmallerOdd:
		
		j NotSmallerEven
	
	
	IsEven:
		slt	$t0, $t9, $t1		# If (greatest < current)
		beq	$t0, $zero, NotGreaterEven
			add	$t9, $t1, $zero
			#add	$t5, $zero, $zero
		NotGreaterEven:
		
		
		slt	$t0, $t1, $t7		# If (current < smallest)
		beq	$t0, $zero, NotSmallerEven
			add	$t7, $t1, $zero
			#add	$t3, $zero, $zero
		NotSmallerEven:
	
	nor	$t2, $t2, $zero		# Toggle = !Toggle because next is Odd Index
	add	$t3, $t3, $s2		# Next Pos
	add	$t4, $t4, $s1		# Counter += 1
	j Loop
	
End_Loop:


# DISCLAIMER:
# This proccess could've been done with less instructions but it's like this just for the sake 
# of showing the whole stacking flow
add	$v0, $t9, $0
add	$v1, $t8, $0

sub	$sp, $sp, $s2		# Stack Pile -4
sub	$sp, $sp, $s2		# Stack Pile -4
sw	$v0, 0($sp)		# Stacks v0
sw	$v1, 4($sp)		# Stacks v1

add	$v0, $t7, $0		# Carry new v0
add	$v1, $t6, $0		# Carry new v1

jr	$ra


####################################################################################################
# PROCEDURE: Count Max Mins
# Counts the amount of times each value is present in the Vector
# params:
#	- a0: Value 1
#	- a1: Value 2
#	- a2: Value 3
#	- a3: Value 4
# return:
#	- v0(sp): Value 1 Counter
#	- v1(sp): Value 2 Counter
#	- v0: Value 3 Counter
#	- v1: Value 4 Counter
CountMaxMins:
add	$t0, $s0, $0	# Vector pos 0
add	$t2, $0, $0	# Counter = 0

lui	$t9, 0		# Greatest Even Counter
lui	$t8, 0		# Greatest Odd Counter
lui	$t7, 0		# Smallest Even Counter
lui	$t6, 0		# Smallest Odd Counter
Count_Loop:
	#This loop will traverse Vector backwards so we don't have to set again the counter and the vector pointer
	beq	$t2, $s3, End_Count_Loop	# If counter == 100 break
	lw 	$t1, 0($t0)
	
	# Counters checker
		
	CheckGreatestEven:	beq 	$t1, $a0, SameGreatestEven		# if (current == GreatestEven)
		j CheckGreatestOdd
		SameGreatestEven: 	add	$t9, $t9, $s1		# GreatestEvenCounter + 1
		
	CheckGreatestOdd:	beq 	$t1, $a1, SameGreatestOdd	# if (current == GreatestOdd)
		j CheckSmallestEven
		SameGreatestOdd: 	add	$t8, $t8, $s1		# GreatestOddCounter + 1
		
	CheckSmallestEven:	beq 	$t1, $a2, SameSmallestEven	# if (current == SmallestEven)
		j CheckSmallestOdd
		SameSmallestEven: 	add	$t7, $t7, $s1		# SmallestEven + 1
	
	CheckSmallestOdd:	beq 	$t1, $a3, SameSmallestOdd	# if (current == SmallestOdd)
		j EndEquals
		SameSmallestOdd: 	add	$t6, $t6, $s1		# SmallestOdd + 1
		
	EndEquals:
	
	
	add	$t0, $t0, $s2		# Next Pos
	add	$t2, $t2, $s1		# Counter += 1
	beq 	$zero, $zero, Count_Loop
	

End_Count_Loop:

# DISCLAIMER:
# This proccess could've been done with less instructions but it's like this just for the sake 
# of showing the whole stacking flow
add	$v0, $t9, $0
add	$v1, $t8, $0

sub	$sp, $sp, $s2		# Stack Pile -4
sub	$sp, $sp, $s2		# Stack Pile -4
sw	$v0, 0($sp)		# Stacks v0
sw	$v1, 4($sp)		# Stacks v1

add	$v0, $t7, $0		# Carry new v0
add	$v1, $t6, $0		# Carry new v1

jr	$ra


########################################################################################################################################################################################################
########################################################################################################################################################################################################
########################################################################################################################################################################################################
########################################################################################################################################################################################################
Finish_Program: