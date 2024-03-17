.text
	li 	$s1, 0x4fffffff
	li 	$s2, 0x123 
	li 	$t0, 0
	addu	$s3, $s2, $s1	# $s3 = $s2 + $s1
	xor 	$t1, $s1, $s2	
	# kiem tra xem $s1 va $s2 co cung dau khong, neu co $t1 > 0
	bltz 	$t1, exit 	# $t1 < 0 thi khong tran dau
	xor 	$t2, $s3, $s1	
	# kiem tra xem $s1 va $s3 co cung dau khong, neu trai dau => $t2 < 0 => tran so
	bgtz	$t2, exit	
	# neu $t2 > 0 thi $s3 va $s1 cung dau => khong tran so
	
overflow:
	li 	$t0, 1
exit:
	