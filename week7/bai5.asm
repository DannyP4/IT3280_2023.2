.data
	a: 		.word 0
	A: 		.space 32
	Message: 	.asciiz "Nhap so $s"
	MessageNum: 	.asciiz ": "
	Message1: 	.asciiz "Gia tri lon nhat la: "
	Message2: 	.asciiz " o thanh ghi $s"
	Message3: 	.asciiz "Gia tri nho nhat la: "
	Newline: 	.asciiz "\n"
	
.text
start:
	la 	$a0, A		# $a0 = address of A[0]
	addi 	$t0, $a0, 0	# $50 = $a0
	
input:
	beq 	$t1, 8, end_input 	# if i = 8 end_input
	
	li 	$v0, 4
	la 	$a0, Message
	syscall
	
	li	$v0, 1
	move	$a0, $t1
	syscall
	
	li 	$v0, 4
	la 	$a0, MessageNum
	syscall
	
	li 	$v0, 5
	syscall			# input number
	
	move 	$t2, $v0
	sw 	$t2, 0($t0)    	# $t0 = A[i]
	addi 	$t0, $t0, 4  	# address of A[i]
	addi 	$t1, $t1, 1  	# i++
	j 	input
	
end_input:
	la 	$t0, A
	addi 	$a0, $zero, 0 
	addi 	$t1, $zero, 0
	addi 	$t2, $zero, 0 	# reset register
load_value:
	lw 	$s0, 0($t0)	# load $s0
	lw 	$s1, 4($t0)	# load $s1
	lw 	$s2, 8($t0)	# load $s2
	lw 	$s3, 12($t0) 	# load $s3
	lw 	$s4, 16($t0) 	# load $s4
	lw 	$s5, 20($t0) 	# load $s5
	lw 	$s6, 24($t0) 	# load $s6
	lw 	$s7, 28($t0) 	# load $s7
	
main: 	jal 	WARP

print: 	
	add 	$a1, $v0, $zero 
	li 	$v0, 4
	la 	$a0, Message1
	syscall	
	
	li 	$v0, 1
	addi 	$a0, $a1, 0
	syscall
	
	li 	$v0, 4
	la 	$a0, Message2
	syscall		
	
	li 	$v0, 1
	addi 	$a0, $t2, 0
	syscall		# print lagerst
	
	li 	$v0, 4
	la 	$a0, Newline
	syscall
	
	la 	$a0, Message3
	syscall
	
	li 	$v0, 1
	addi 	$a0, $v1, 0
	syscall
	
	li 	$v0, 4
	la 	$a0, Message2
	syscall		# print smallest
	
	li 	$v0, 1
	addi 	$a0, $t3, 0
	syscall
	
quit: 	
	li $v0, 10  	# terminate
	syscall
	
endmain:

WARP: 	
	la 	$t0, a		# address of A[-1]
	addi 	$a0, $a0, -1 	# j = -1
	sw 	$fp, -4($sp)	# save frame pointer
	addi 	$fp, $sp, 0 	# new frame pointer to top
	addi 	$sp, $sp, -8 	# next stack
	sw 	$ra, 0($sp)	# save return adress
	jal stack
	
	nop
	lw 	$ra, 0($sp)	# restore address from stack
	addi 	$sp, $fp, 0 	# return stack pointer
	lw 	$fp, -4($sp) 	# return frame pointer
	jr 	$ra

wrap_end:

stack:	sw 	$fp,-4($sp)	# save frame pointer
	addi 	$fp,$sp,0 	# new frame pointer to top
	addi 	$sp,$sp,-16 	# create space for $ra, $a0, $A[i]( value of register s(j)
	sw 	$ra,8($sp)  	# save return address
	sw 	$a0,4($sp)  	# save number of register save value
	lw 	$t1,0($t0)  	# $t1 = A[i] = value of s(j)
	sw 	$t1,0($sp)  	# save s(j)
	bne 	$a0,7,recursive 	#if j = 7 recursive
	nop
	lw 	$v0, 0($sp)	# save max value
	lw 	$v1, 0($sp) 	# save min value
	lw 	$t2, 4($sp) 	# save number of register save max value
	lw 	$t3, 4($sp) 	# save number of register save min value
	j 	min_max
	nop
	
recursive:
	addi 	$a0, $a0, 1 	# j++
	addi 	$t0, $t0, 4 	# address of A[j]
	jal 	stack
	nop
	j 	find_max
	nop
	
min_max:
	lw 	$ra, 8($sp) 	# save return address
	lw 	$t1, 0($sp) 	# save temp value
	lw 	$t4, 4($sp) 	# save temp number of register
	addi 	$sp, $fp, 0 	# restore stack pointer
	lw 	$fp, -4($sp) 	# restore frame pointer
	jr 	$ra 
	
find_max:
	bgt 	$t1, $v0, max 	# if temp_value > max
	j 	find_min
	
max:
	addi 	$v0, $t1, 0 	# max = temp_value
	addi 	$t2, $t4, 0 	# number of register = temp number of register
	nop
	
find_min:
	blt 	$t1, $v1, min 	# if temp_vale < min
	j 	min_max
min:
	addi 	$v1, $t1, 0 	# min = temp value
	addi 	$t3, $t4, 0 	# number of register = temp number of register
	j 	min_max
	nop
	
