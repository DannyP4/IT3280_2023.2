.data
	A: 		.word
	Message:	.asciiz	"Nhap so luong phan tu N: "
	Message0: 	.asciiz	"Nhap so: "
	Message1:	.asciiz "Mang sau khi thuc hien insertion sort la: "
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
	la	$a0, A			# address of A[0]
	mul	$s3, $a1, 4		# $s3 = (n - 1) * 4
	add	$a1, $s3, $a0		# $a1 = (n - 1) * 4 + A[0] = address of A[n - 1]
	addi	$t6, $a1, 4		# $t6 = address of A[n]
	addi 	$t0, $zero, 0		# $t0 to count the loop
	
insertion_sort:
	la	$a0, A
	addi	$t0, $t0, 4		# i += 4
	add	$v0, $a0, $t0		# $v0 = A[0] + 4*i = A[i]
	bgt	$v0, $a1, print_sort 	# A[i] > A[n - 1] => end
	lw	$s0, 0($v0)		# key = A[i]
	sub	$v1, $v0, 4		# j = i - 4
	
loop:
	blt	$v1, $a0, end_loop	# if j < 0 => end_loop
	lw	$s1, 0($v1)		# $s1 = A[j]
	blt	$s1, $s0, end_loop	# if A[j] < key => end_loop
	addi	$t2, $v1, 4		# $t2 = j + 4
	sw	$s1, 0($t2)		# A[j + 1] = A[j]
	sub	$v1, $v1, 4		# j -= 4
	j	loop
	
end_loop:
	addi	$t2, $v1, 4		# $t2 = j + 4
	sw	$s0, 0($t2)		# A[j + 1] = key
	j 	insertion_sort
	
print_sort:
	# Print message1
	li	$v0, 4
	la	$a0, Message1
	syscall			
	
	# Print new line
	la	$a0, Newline
	syscall			
	
	# Print number of array
	la	$s0, A
	la	$s1, 0($t6)
	lw	$s2, 0($s0)
	li	$v0, 1
	la	$a0, 0($s2)	
	syscall
	
	addi	$t3, $zero, 0 		# i = 0
	
print_array:
	# Print Message2
	addi	$t3, $t3, 4		# i += 4
	add	$t4, $s0, $t3		# $t1 = adrress of A[0] + 4*i = A[i]
	lw	$t5, 0($t4)		# x = A[i]
	beq	$t4, $s1, end_main	# if i > (n - 1) end
	li	$v0, 4
	la	$a0, Message2
	syscall				
	
	# Print A[i]
	li	$v0, 1
	la	$a0, 0($t5)
	syscall				
	
	j	print_array
	
end_main:
	li	$v0, 10
	syscall
	
