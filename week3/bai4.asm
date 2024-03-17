.data
	m: .word 4
	n: .word 6
.text
	addi	$s1, $zero, 3 	# khai bao i
	addi	$s2, $zero, 5 	# khai bao j
	addi	$t1, $zero, 5 	# khai bao x
	addi	$t2, $zero, 5	# khai bao y
	addi	$t3, $zero, 5 	# khai bao z
	la	$t4, m
	lw	$s4, 0($t4)	# khai bao m
	la	$t5, n
	lw	$s5, 0($t5) 	# khai bao n
start:
	#slt	$t0, $s1, $s2	# i<j	a)
	#sge  	$t0, $s1, $s2	# i>=j	b)
	add	$s3, $s1, $s2 	# khai bao i+j	c+d)
	#sle	$t0, $s3, $zero	# i+j<=0	c)
	add	$s6, $s4, $s5	# khai bao m+n	d)
	sgt	$t0, $s3, $s6	# i+j>m+n	d)
	 
	#slt	$t0, $s2, $s1	# j<i
	beq	$t0, $zero, else
	addi	$t1, $t1, 1	# x=x+1
	addi	$t3, $zero, 1	# z=1
	j 	endif
else:	addi	$t2, $t2, -1	# y=y-1
	add	$t3, $t3, $t3	# z=z*2
endif:
