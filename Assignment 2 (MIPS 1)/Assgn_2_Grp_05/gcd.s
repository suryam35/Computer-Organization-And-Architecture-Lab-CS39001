# This program computes the gcd of two positive numbers a and b, where a and b are entered by the user

    .globl  main

    .data

# program output text constants
first_integer:
    .asciiz "Enter the first positive integer: "
second_integer:
    .asciiz "Enter the second positive integer: "
result:
    .asciiz "GCD of the two integers is: "
error:
	.asciiz "EXIT! The entered number is not positive."
newline:
    .asciiz "\n"

    .text

# main program
#
# program variables
#   a:   $s0
#	b:   $s1
#	gcd: $s2
#
main:
    li      $v0, 4          # prompt to get first integer
    la      $a0, first_integer
    syscall

    li      $v0, 5          # get a from user
    syscall
    move    $s0, $v0        # $s0 <-- first integer

    # time to do sanity check

    blt $s0, $zero, exit

    li      $v0, 4          # prompt to get second integer
    la      $a0, second_integer
    syscall

    li      $v0, 5          # get b from user
    syscall
    move    $s1, $v0        # $s1 <-- second integer

    # time to do sanity check

    blt $s1, $zero, exit

    move    $a0, $s0        # $a0 <-- first integer
    move 	$a1, $s1        # $a1 <-- second integer

    # call the function gcd(a,b)

    jal gcd

    move    $s2, $v0       # store the gcd value

	li      $v0, 4          # print "GCD of the two integers is: "
    la      $a0, result
    syscall    

    li      $v0, 1          # print gcd
    move    $a0, $s2
    syscall

    li      $v0, 4          # print two newlines
    la      $a0, newline
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall

    li      $v0, 10         # terminate the program
    syscall


gcd:
	beq 	$a0, $zero, L1  # if first integer == 0 then jump to L1 
	beq 	$a1, $zero, L2  # if second integer == 0 then jump to L2
	j while                 # jump to label while

while:
	ble 	$a0, $a1, L3    # branch to label L3 if first integer <= second integer
	sub 	$a0, $a0, $a1   # first integer = first integer - second integer
	bne 	$a1, $zero, while # branch to label while if second integer != 0
	j L2                    # jump to label L2

L3:
	sub 	$a1, $a1, $a0   # second integer = second integer - first integer
	bne 	$a1, $zero, while # branch to label while if second integer != 0
	j L2                    # jump to label L2

L2:
	move 	$v0, $a0        # $v0 <-- first integer  
	jr 		$ra

L1:
	move 	$v0, $a1        # $v0 <-- second integer 
	jr 		$ra

exit:
	li      $v0, 4          # prompt for error
    la      $a0, error
    syscall

    li      $v0, 4          # print two newlines
    la      $a0, newline
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall

    li      $v0, 10         # terminate the program
    syscall

