.data
	A: 		.word 
	Message:	.asciiz	"Nhap so luong phan tu N: "
	Message0: 	.asciiz	"Nhap so: "
	Message1:	.asciiz "Mang sau khi thuc hien bubble sort la: "
	Message2:	.asciiz ", "
	Newline:	.asciiz "\n"
	
.text
input_number:
	# Nhap so luong phan tu N:
	li 	$v0, 4
	la 	$a0, Message
	syscall
	
	li 	$v0, 5
	syscall
	
	move 	$a1, $v0
	sub 	$a1, $a1, 1	# n -= 1
	addi 	$s0, $s0, 0
	la 	$a0, A
	addi 	$s0, $a0, 0
	
input_array:
	# Nhap cac phan tu cua A:
	bgt 	$t0, $a1, end_input
	li 	$v0, 4
	la 	$a0, Message0
	syscall
	
	li 	$v0, 5
	syscall
	
	move 	$t1, $v0
	sw 	$t1, 0($s0)
	addi 	$s0, $s0, 4
	addi 	$t0, $t0, 1
	j 	input_array
	
end_input:

main:
	# Khoi tao cac gia tri
	la	$a0, A		# address of A[0]
	addi 	$a2, $a0, 4	# address of A[1]	
	mul	$s3, $a1, 4	# $s3 = (n - 1) * 4
	add	$a1, $s3, $a0	# $a1 = (n - 1) * 4 + A[0] = address of A[n - 1]
	addi	$t6, $a1, 4	# $t6 = address of A[n]
	addi 	$t0, $zero, 0	# $t0 to count the loop
	j 	bubble_sort
	
swap:
 	lw 	$t2, 0($a2)	# $t2 = A[i]
 	sw 	$t2, 0($t1)	# A[j] = $t2 = A[i]
 	sw	$v0, 0($a2)	# A[i] = *($v0) = A[j]
 	j 	continue
 	
reset:
	la	$a0, A
	addi	$t0, $zero, 0	# j = 0
	addi	$a2, $a2, 4	# i += 1
	j 	bubble_sort
	
bubble_sort:
	bgt  	$a2, $a1, print_sort	# if i > (n-1) end
	add 	$t1, $a0, $t0		# $t1 = address of A[0] + 4*j = A[j]
	beq	$t1, $a2, reset		# if j = i print
	lw	$v0, 0($t1)		# $v0 = A[j]
	lw	$v1, 0($a2)		# $v1 = A[i]
	blt	$v1, $v0, swap		# if A[i] > A[j] swap

continue:
	addi	$t0, $t0, 4		# j++
	j 	bubble_sort
	
print_sort:
	li	$v0, 4
	la	$a0, Message1
	syscall			# Print message1
	
	la	$a0, Newline
	syscall			# Print newLine
	
	la	$s0, A
	la	$s1, 0($t6)
	lw	$s2, 0($s0)
	li	$v0, 1
	la	$a0, 0($s2)	# Print number1 of array
	syscall
	
	addi	$t3, $zero, 0 	# i = 0
	
print_array:
	addi	$t3, $t3, 4		# i++
	add	$t4, $s0, $t3		# $t1 = adrress of A[0] + 4*i = A[i]
	lw	$t5, 0($t4)		# x = A[i]
	beq	$t4, $s1, end		# if i > (n-1) end
	li	$v0, 4
	la	$a0, Message2
	syscall				# Print Message2
	
	li	$v0, 1
	la	$a0, 0($t5)
	syscall				# Print A[i]
	
	j	print_array
	
end:
	li	$v0, 4
	la	$a0, Newline
	syscall
	
end_main:
	# Exit
	li	$v0, 10
	syscall				
