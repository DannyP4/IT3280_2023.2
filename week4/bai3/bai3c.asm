.text
	li	$s1, 8
	addi 	$s0, $s1, 1		# $s0 = $s1 + 1
	sub	$s0, $zero, $s0		# $s0 = 0 - $s0
	# not $s0, $s1