.data
	m1: 	.asciiz "First num: "
	m2:	.asciiz "Second num: "
	m3:	.asciiz "The sum of "
	m4:	.asciiz " and "
	m5:	.asciiz " is "
.text
	# Nhap so dau tien:
	li	$v0, 4
 	la	$a0, m1
 	syscall
 	
	li 	$v0, 5
 	syscall 
 	move	$a1, $v0 	# Cho so dau tien vao thanh ghi $a1
 	
 	# Nhap so thu hai:
 	li 	$v0, 4
 	la 	$a0, m2
 	syscall
 	
 	li 	$v0, 5
 	syscall 
 	move	$a2, $v0	# Cho so thu hai vao thanh ghi $a1
 	
 	# Tinh tong hai so vua nhap:
 	add 	$a3, $a1, $a2	# Cho tong hai so vao thanh ghi $a3
 	
 	# In ra:
 	# In "The sum of ":
 	li	$v0, 4
 	la	$a0, m3
 	syscall
 	
 	li	$v0, 1
 	addi	$a0, $a1, 0
 	syscall 
 	
 	# In " and "
 	li	$v0, 4
 	la	$a0, m4
 	syscall
 	
 	li	$v0, 1
 	addi	$a0, $a2, 0
 	syscall 
 	
 	# In " is: "
 	li	$v0, 4
 	la	$a0, m5
 	syscall
 	
 	li	$v0, 1
 	addi	$a0, $a3, 0
 	syscall 
 	
 	# Ket thuc chuong trinh:
 	li	$v0, 10
 	syscall
