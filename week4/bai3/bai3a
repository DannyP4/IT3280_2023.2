.text
	li	$s1, -10 
	
	slt	$t0, $s1, $zero		# $t0 = $s1 < 0 ? 1 : 0
	beqz 	$t0, ABS		# $t0 = 0 => ABS
	sub	$s0, $zero, $s1		# else $s1 = 0 - $s1
	j 	END
ABS:
	add	$s0, $s1, $zero		# $s0 = | $s1 |
END: