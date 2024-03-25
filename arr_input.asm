.data
	arr: 	.word 100
	Msg1: 	.asciiz "Nhap n phan tu cua mang: "
	Msg2: 	.asciiz "Mang phai co it nhat 2 phan tu, vui long nhap lai n: "
	Msg3: 	.asciiz "\nNhap cac phan tu cua mang: \n"
	Msg4: 	.asciiz "Nhap so: "
.text
	la	$a1, arr	# Gan dia chi arr vao $a1

	# Message 1:
	li	$v0, 4
	la	$a0, Msg1
	syscall
	j	n_input

Message2:
	# Message 2:
	li	$v0, 4
	la	$a0, Msg2
	syscall

n_input:	
	# Nhap so phan tu cua mang:
	li	$v0, 5
	syscall
	move	$s0, $v0	# Gan n vao thanh $s0
	move	$s1, $v0	# Gan n vao thanh $s1
	
Check_n:
	slti	$t9, $v0, 2	# $t9 = $v0 < 2 ? 1 : 0
	bne 	$t9, $zero, Message2	
	
	# Message 3: 
	li	$v0, 4
	la	$a0, Msg3
	syscall
	
	li	$t1, 0		# i = 0
CheckLength:		
	beq	$t1, $s1, Sum	# Neu i = n thi xuong nhan Sum
	
	# Message 4: 
	li	$v0, 4
	la	$a0, Msg4
	syscall
	
	# Nhap cac phan tu cua mang:
	li	$v0, 5
	syscall
	
	sll	$t2, $t1, 2	# $t2 = 4 * i
	add	$a1, $a1, $t2	# $a1 = 4 * i + arr[0]
	sw	$v0, 0($a1) 	# arr[i] = $v0 = so vua nhap
	addi	$t1, $t1, 1	# i += 1	
	j	CheckLength	

Sum:		
	la	$a1, arr	# Lay lai dia chi $a1
	li	$t0, 0	 	# sum = 0	
	li	$t1, 0		# i = 0
	
Loop_sum:	
	sll	$t2, $t1, 2	# $t2 = i * 4
	add	$a1, $a1, $t2	# $a1 = 4 * i + arr[0]
	lw	$t3, 0($a1)	# t3 = arr[i]
	add	$t0, $t0, $t3	# sum = sum + t3 = sum + arr[i]
	addi	$t1, $t1, 1	# i += 1
	beq	$t1, $s0, End	
	j 	Loop_sum

End:	
	
	# Ket thuc
	li 	$v0, 10
	syscall
