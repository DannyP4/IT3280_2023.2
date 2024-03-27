.data
	A:		.word
	Message:	.asciiz	"Nhap so luong phan tu cua mang: "
	Message0: 	.asciiz	"Nhap so: "
	Message1:	.asciiz "Mang sau khi thuc hien selection sort la:"
	Message2:	.asciiz ", "
	Newline:	.asciiz "\n"
	
.text
input_number:
	# Nhap N la so luong phan tu:
	li 	$v0, 4
	la 	$a0, Message
	syscall
	
	li 	$v0, 5
	syscall
	
	move 	$a1, $v0
	sub 	$a1, $a1, 1
	addi 	$s0, $s0, 0
	la 	$a0, A
	addi 	$s0, $a0, 0
	
input_array:
	# Nhap cac gia tri cua mang:
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

main: 	la 	$a0, A		# address of A[0]
	mul  	$s3, $a1, 4	# $s3 = (n - 1) * 4  
	add 	$t6, $a0, $s3	# $t6 = address of  A[0] + (n - 1) * 4 = address of A[n - 1]
	addi	$t6, $t6, 4	# $t6 = address of A[n]
	la 	$a1, 0($t6)	
	sub 	$a1, $a1, 4	# $a1 = address of A[n - 1]
 	j 	max

end_main:
	li 	$v0, 10
	syscall

sort: 	
	bgt 	$a0, $a1, done		# if i = n => done
 	j 	after_sort

after_max: 
	lw 	$t0, 0($a1)		# $t0 = value of adress A[n-1]
 	sw 	$t0, 0($v0)		# value of address ptr = $t0
 	sw 	$v1, 0($a1)		# value of A[n-1] = max
 	addi 	$a1, $a1, -4		# n -= 4
 	j 	sort

done: 	j 	end_main		

max:	
	la 	$a0, A
	addi 	$v0, $a0, 0		# ptr = address of A[0]
	lw 	$v1, 0($v0)		# max = A[0]
	addi 	$t0, $a0, 0		# i = 0

loop:
	beq 	$t0, $a1, ret		# if i = n ret
	addi 	$t0, $t0, 4		# i += 4 
	lw 	$t1, 0($t0)		# temp = A[i]
	slt 	$t2, $t1, $v1 	 	# temp < max 
	bne 	$t2, $zero, loop	# if temp < max loop
	addi 	$v0, $t0, 0		# ptr = address of A[i]
	addi 	$v1, $t1, 0		# max = A[i]
	j 	loop
	
after_sort:
	# Print message1
	li 	$v0, 4
	la 	$a0, Message1
	syscall			
	
	# Print new line
	la 	$a0, Newline
	syscall			
	
	# print number of array
	la 	$s0, A
	la 	$s1, 0($t6)
	lw 	$s2, 0($s0)
	li 	$v0, 1
	la 	$a0, 0($s2)		
	syscall
	
	addi 	$t3, $zero, 0 		# i = 0
	
print_array:
	# Print Message2
	addi 	$t3, $t3, 4		# i += 4 
	add 	$t4, $s0, $t3		# $t1 = address of A[0] + 4*i
	lw 	$t5, 0($t4)		# x = A[i]
	beq  	$t4, $s1, end		# if i > (n-1) end
	li 	$v0, 4
	la 	$a0, Message2
	syscall				
	
	# Print A[i]
	li 	$v0, 1
	la 	$a0, 0($t5)
	syscall				
	j 	print_array
	
end:
	li 	$v0, 4
	la 	$a0, Newline
	syscall
	j max
	
ret:
	j 	after_max
