.data
Vector:	.word	-100, -59, 31, 57, -85, 79, -41, 82, -89, 53, -68, 8, 1, 12, -1, -83, 68, 73, -30, -46, 54, -31, -22, -73, -43, -53, -73, 20, -6, -17, 3, 20, -6, -51, 23, -20, -89, 94, 52, 4, -56, 90, 64, -64, -45, -2, -59, -53, 46, -48, 34, -62, -56, -35, -86, 21, -65, 56, 40, 66, -46, -37, 57, 12, 76, 3, 10, 35, -19, -95, 20, -84, 81, -52, 85, -57, 19, 78, 18, 98, -9, 51, -92, -39, -3, -73, 52, -2, -18, -48, 42, -67, 57, 49, 10, -76, 25, -1, -49, 33

.text


#$t1 notEven
#$t2 num

#$s4 = bigEvenCount
#$s5 = smallEvenCount
#$s5 = bigOddCount
#$s5 = smallOddCount

la	$t2, Vector			#num=vector[0]

Loop:
	beq	$t1, $zero, Even		#is idx even?	
	#else (idx is odd)
		slt $t3, $s2, $t2		#Is bigOdd < num
		beq $t3, 1, SetBigOdd		# then
		continue1:
		slt $t3, $t2, $s3		#Is num < smallOdd
		beq $t3, 1, SetSmallEven	# then
		j endIf					
												
	Even:
	#if idx is even then
		slt $t3, $s0, $t2		#Is bigEven < num ?
		beq $t3, 1, SetBigEven		# then
		continue2:
		slt $t3, $t2, $s1		#Is num < smallEven ?
		beq $t3, 1, SetSmallEven	# then
		j endIf
		   
		 ####################################Esto se puede convertir a funcion setNum()  
		SetBigOdd:
			add $s2, $t2, $zero			#bigOdd = num
			j continue1
			
		SetSmallOdd:
			add $s3, $t2, $zero			#smallEven = num
			j endIf
			   
		SetBigEven:
			add $s0, $t2, $zero			#bigEven = num
			j continue2
	
		SetSmallEven:
			add $s1, $t2, $zero			#smallEven = num
			j endIf
		#####################################fin funcion	

	endIf:
	
