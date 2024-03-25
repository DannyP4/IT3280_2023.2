.data
	A: 		.word
	Message1:	.asciiz	"Nhap so luong phan tu: "
	Message2: 	.asciiz	"Nhap so: "
	Message3:	.asciiz	"Do dai cua mang co tong lon nhat la: "
	Message4:	.asciiz	"Tong lon nhat la: "
	Newline:	.asciiz	"\n"

.text
input_number:
	# Nhap so luong phan tu:
	li 	$v0, 4
	la 	$a0, Message1
	syscall
	
	li 	$v0, 5
	syscall
	
	move 	$a1, $v0	# Gan N vao $a1
	
	sub 	$a1, $a1, 1	# Tru $a1 di 1
	
	la 	$a0, A
	addi 	$s0, $a0, 0	# Gan dia chi mang A vao $s0

input_array:
	# Nhap cac phan tu cua mang:
	bgt 	$t0, $a1, main 	
	# Neu $t0 > $a1 thi ket thuc nhap phan tu
	li 	$v0, 4
	la 	$a0, Message2
	syscall
	
	li 	$v0, 5
	syscall
	
	move 	$t1, $v0
	sw 	$t1, 0($s0) 	# Gan cac gia tri vua nhap vao mang A
	addi 	$s0, $s0, 4	
	# Tro den dia chi cua phan tiep theo trong mang
	addi 	$t0, $t0, 1
	j 	input_array

main: 	la 	$a0, A
 	j 	mspfx
 	nop

continue:
	# In ra output
	addi 	$s0, $v0, 0
	addi 	$s1, $v1, 0
	li 	$v0, 4
	la 	$a0, Message3
	syscall
	
	li 	$v0, 1
	la 	$a0, 0($s0)
	syscall
	
	li 	$v0, 4
	la	$a0, Newline
	syscall
	
	li 	$v0, 4
	la 	$a0, Message4
	syscall
	
	li 	$v0, 1
	la 	$a0, 0($s1)
	syscall

lock: 	li 	$v0, 10
	syscall

mspfx: 	addi 	$v0, $zero, 0		# max_length = 0
 	addi 	$v1, $zero, 0		# max_sum = 0
 	addi 	$t0, $zero, 0		# i = 0
 	addi 	$t1, $zero, 0		# sum = 0

loop: 	add 	$t2, $t0, $t0		# 2*i
 	add 	$t2, $t2, $t2		# 4*i
	add 	$t3, $t2, $a0		# $t3 = (address of A) + 4*i
	lw 	$t4, 0($t3)		# $t4 = A[i]
	add 	$t1, $t1, $t4		# sum += A[i]
	slt 	$t5, $v1, $t1		# if max_sum < sum 
	bne 	$t5, $zero, mdfy	# j mdfy
	j 	test

mdfy: 	addi 	$v0, $t0, 1		# max_length = i + 1
	addi 	$v1, $t1, 0		# max_sum = sum

test: 	addi 	$t0, $t0, 1		# i++
	sle 	$t5, $t0, $a1		# if i <= n thi loop
	bne  	$t5, $zero, loop

done: 	
	j 	continue
	
