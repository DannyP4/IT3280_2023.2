.data 
	array: .word -4, 1, -2, 14, 16, -11	# khoi tao mang va cac phan tu
.text
	addi	$s1, $zero, 0	# khoi tao i
	addi	$s2, $zero, 6	# khoi tao n
	addi	$s3, $zero, 1	# khoi tao step
	la	$s4, array	# khoi tao array 
	addi 	$s5, $zero, 0	# khoi tao max 

loop: 
	slt 	$t2, $s1, $s2 
	beq 	$t2, $zero, endloop
	add	$t1, $s1, $s1
	add	$t1, $t1, $t1	# t1 = 4 * i
	add 	$t1, $t1, $s4	
	lw 	$t0, 0($t1)	# gia tri cua A[i] luu vao $t0
	addi 	$t5, $t0, 0	# luu gia tri A[i] vao $t5
	 
if:	
	slti	$t3, $t0, 0	# A[i] < 0 ? 1 : 0
	beq 	$t3, $zero, else 	# A[i} >= 0 thi else
	sub	$t0, $zero, $t0		# A[i] = 0 - A[i}
	j	endif
else:	addi 	$t0, $t0, 0
endif:

if1:
	#sge	$t4, $t0, $s5	# A[i] >= max ? 1 : 0
	slt 	$t4, $t0, $s5	# A[i] < max ? 1 : 0
	bne 	$t4, $zero, endif1 	# neu A[i] < max thi ket thuc if1
	#beq 	$t4, $zero, endif1 	# neu A[i] < max thi ket thuc if1
	add 	$s5, $zero, $t0		# gan max = A[i]
	addi 	$s6, $t5, 0		# %s6 la gia tri nguyen ban cua A[i]
endif1:	

	add 	$s1, $s1, $s3	# i += 1
	
	j	loop
endloop:
	
