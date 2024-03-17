.text
	li	$s1, 3
	li	$s2, 5
	sle 	$t0, $s1, $s2	# $t0 = $s1 <= $s2 ? 1 : 0 
	bnez 	$t0, label
	j	exit
label:
	li	$s3, 10		# neu $s1 <= $s2 thi $s3 = 10
exit: