.data
string: 	.space 21 	# Toi da 21 ky tu vi phai tinh them ca ki tu cuoi '\0'
reverse: 	.space 21	
Mssg: 		.asciiz "Nhap chuoi: "
Input: 		.asciiz "\nChuoi ban vua nhap la: "
Output: 	.asciiz "\nChuoi dao nguoc la: "
Error: 	.asciiz "Chuoi khong co phan tu nao!"

.text
	# Message:
	li	$v0, 4
	la	$a0, Mssg
	syscall
	
	# Lay dia chi cua x[0] va y[0]:
	la	$a0, string
	la	$a1, reverse
	
	# Khoi tao cac gia tri:
	li	$s0, 0		# i = 0
	li	$s1, 0		# j = 0
	
	# Nhap chuoi:
CheckLength:		
	# Neu do dai chuoi i = 20 thi dung vong lap va in ket qua
	beq	$s0, 20, Sub
In:
	# Nhap ki tu:
	li $v0, 12
	syscall
	
CheckEnter:
	# Neu user nhap enter thi dung vong lap
	beq	$v0, 10, CheckEmpty

load:
	add	$t1, $s0, $a0	# $t1 = i + x[0]
	move	$t0, $v0	# $t0 = $v0
	sb	$t0, 0($t1)	# x[i] = $t0 = ki tu vua nhap	
	nop
	addi	$s0, $s0, 1	# i += 1
	j	CheckLength
	nop

CheckEmpty:
	# Kiem tra neu chuoi la trong (empty)
	bgtz $s0, Sub		# Neu i > 0 thi chuoi khong trong
	li $v0, 55 		# Hien dialog thong bao chuoi trong
	la $a0, Error 
	la $a1, 0 
	syscall	
	j	out
	
Sub:
	sub	$s0, $s0, 1	# i -= 1 de lay gia tri chu cai hien tai,
				# tuc la chu cai o cuoi string.
makeReverse:
	sub 	$s2, $s0, $s1	# Dat $s2 = t = i - j
	bltz 	$s2, out	# Neu $s2 = t < 0 thi out
	add	$t1, $s2, $a0	# $t1 = t + x[0]
	lb 	$t2, 0($t1)	# $t2 = x[t], t hien tai dang co gia tri string.size() - 1
	add 	$t3, $s1, $a1 	# $t3 = j + y[0]	
	sb	$t2, 0($t3)	# y[j] = $t2 = x[t]
	nop
	addi 	$s1, $s1, 1 	# j += 1
	j 	makeReverse
	
out:	# In ra output:
	# Chuoi vua nhap:
	li	$v0, 4
	la	$a0, Input
	syscall
	
	li	$v0, 4
	la	$a0, string
	syscall
	
	# Chuoi dao nguoc
	li	$v0, 4
	la	$a0, Output
	syscall
	
	li	$v0, 4
	la	$a0, reverse
	syscall 
 	
 	# Ket thuc
	li	$v0, 10
	syscall
