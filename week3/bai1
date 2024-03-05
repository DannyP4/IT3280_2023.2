.text
	addi	$s1, $zero, 3 # khai bao i
	addi	$s2, $zero, 5 # khai bao j
	addi	$t1, $zero, 5 # khai bao x
	addi	$t2, $zero, 5 # khai bao y
	addi	$t3, $zero, 5 # khai bao z
start: 
	slt	$t0, $s2, $s1	# j < i
	bne	$t0, $zero, else # means if $t0 = 1 then branch to else
	addi	$t1, $t1, 1	# x=x+1
	addi	$t3, $zero, 1	# z=1 
	j 	endif		# skip “else” part
else:	addi	$t2, $t2, -1	# begin else part: y=y-1 
	add	$t3, $t3, $t3	# z=z*2
endif:
