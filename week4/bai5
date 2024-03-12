.text
	li 	$s0, 3		# dat so can nhan la x = 3
	li 	$t1, 1		# buoc nhay la 1
	li 	$t2, 5		
	# se co 4 vong lap tu 1 den 4, tuong ung voi viec ta
	# se nhan x voi 2, 4, 8, 16.
	
loop:	
	sllv 	$s0, $s0, $t1	
	# phep lui $t1 bit, dong nghia voi phep nhan voi luy thua cua 2
	addi	$t1, $t1, 1 	# $t1 = $t1 + 1
	sub 	$s1, $t1, $t2	# $s1 = $t1 - $t1
	beqz 	$s1, endloop	# neu $s1 = 0 thi dung vong lap
	j	loop
endloop: