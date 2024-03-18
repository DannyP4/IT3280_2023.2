.data
string: .space 21 # the space of string and reverse is 21 because there is a \0 nullterminator in string so we need an extra space"
reverse: .space 21
Input: .asciiz "The initial string is: "
Output: .asciiz "New string after reversion is: "
Error: .asciiz "The initial string is empty, so there is no reverse string for this one"

.text
load_address:
	la $a0, string # load the address of initial string
	la $a1, reverse # load the address of reverse string

initiate:
	add $s0, $zero, $zero # s0 = i = 0
	add $s1, $zero, $zero # s1 = j = 0

check_if_exceed:
	beq $s0, 20, check_string_is_empty # if i = 20, then brench to check whether string is empty ornot, else execute the following commands

character_input: # load the character from user
	li $v0, 12
	syscall
	
check_if_enter:
beq $v0, 10, check_string_is_empty # if the value of $v0 = 10 (When we enter), then check thesecond

load_the_intial_string:
	add $t1, $s0, $a0 # $t1 = $s0 + $a0 = i + x[0]
	# = address of x[i]
	move $t0, $v0 # copy the value of $v0 to $t0
	sb $t0, 0($t1) # x[i] = $t0 = $v0 = character
	nop
	addi $s0, $s0, 1 # $s0 = $s0 + 1 <-> i = i + 1
	j check_if_exceed # next character
	nop 

check_string_is_empty: # check when the string is empty or not
	bgtz $s0, Sub # if i > 0, or string is not empty, go to the next commands, else dothe following
	li $v0, 55 # MessageDialogString
	la $a0, Error # Load the Message
	la $a1, 0 # Load type of the Message, and this situation we use error one (0)
	syscall
	j END # end the program

Sub: # do i = i - 1 to take the index of current character in the string
	sub $s0, $s0, 1

reverse_string:
	sub $t1, $s0, $s1	 # $t1 = i - j
	bltz $t1, print_initial_string # If $t1 < 0, then brench
	add $t2, $t1, $a0	# $t2 = $t1 + $a0 = current i + x[0]
	lb $t3, 0($t2) 		# load the value of $t2 to $t3
	add $t4, $s1, $a1 	# $t4 = $s1 + $a1 = j + y[0]
				# = address of y[j]
	sb $t3, 0($t4) 		# y[j] = $t3 = x[i]
	nop
	addi $s1, $s1, 1 	# increment j
	j reverse_string

print_initial_string: # display initial string
	li $v0, 59
	la $a0, Input
	la $a1, string
	syscall

print_reverse_string:
	li $v0, 59 # display reverse string
 	la $a0, Output
 	la $a1, reverse
 	syscall # Print reverse string
END:
