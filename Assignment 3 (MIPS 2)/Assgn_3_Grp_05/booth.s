# Assignment number - 3
# Problem number - 1
# Semester - 5 (Aut 2021)
# Group number - 5
# Group Member 1 - Suryam Arnav Kalra (19CS30050)
# Group Member 2 - Kunal Singh (19CS30025)


# This program computes product of two 16 bit signed numbers a and b

    .globl  main

    .data

# program output text constants
first_number:
    .asciiz "Enter first number: "
second_number:
    .asciiz "Enter second number: "
result:
    .asciiz "Product of the two numbers is: "
error:
	.asciiz "EXIT! The entered number is not within the range."
newline:
    .asciiz "\n"

    .text

# main program
#
# program variables
#   a:   $s0
#	b:   $s1
#	product: $s2
#
main:
    li      $v0, 4             # set $v0 = 4 to print string
    la      $a0, first_number
    syscall

    li      $v0, 5             # set $v0 = 5 to take integer input
    syscall
    move    $s0, $v0           # set $s0 = integer input (a)

    # time to do sanity check

    slti    $t0, $s0, -32768   # set $t0 = 1 if a < -32768
    bne     $t0, $zero, exit   # if $t0 != 0 exit the program i.e a < -32768

    addi    $t0, $zero, 32767  # set $t0 = 32767
    bgt     $s0, $t0, exit     # if a > 32767 exit the program

    li      $v0, 4             # set $v0 = 4 to print string
    la      $a0, second_number
    syscall

    li      $v0, 5             # set $v0 = 5 to take integer input
    syscall
    move    $s1, $v0


    # time to do sanity check

    slti    $t0, $s1, -32768   # set $t0 = 1 if b < -32768
    bne     $t0, $zero, exit   # if $t0 != 0 exit the program i.e b < -32768

    addi    $t0, $zero, 32767  # set $t0 = 32767
    bgt     $s1, $t0, exit     # if b > 32767 exit the program
    andi    $s1, $s1, 0x0000ffff  # setting upper 16 bits 0

    move    $a0, $s0           # move the value in $s0 to $a0 (1st parameter to the function)
    move 	$a1, $s1           # move the value in $s1 to $a1 (2nd parameter to the function)

    jal multiply_booth         # call the function for booth's multiplication

    move    $s2, $v0           # store the multiplication result in $s2

	li      $v0, 4             # set $v0 = 4 to print string
    la      $a0, result
    syscall    

    li      $v0, 1             # set $v0 = 1 to print the integer
    move    $a0, $s2
    syscall

    li      $v0, 4             # set $v0 = 4 to print string
    la      $a0, newline
    syscall
    li      $v0, 4             # set $v0 = 4 to print string
    la      $a0, newline
    syscall

    li      $v0, 10            # terminate the program
    syscall


# A    = t0
# Q_-1 = t1
# count = t2
# Q_0  = t3
# M    = a0
# Q    = a1

multiply_booth:
    addi    $t0, $zero, 0       # set $t0 = 0 i.e A = 0
    addi    $t1, $zero, 0       # set $t0 = 0 i.e Q_-1 = 0
    addi    $t2, $zero, 16      # set $t0 = 0 i.e count = 16 to multiply 16 bit number

while:
    beq     $t2, $zero, exit_while   # if the count != 0 continue the loop , otherwise exit it
    andi    $t3, $a1, 1         # set $t3 = least significant bit of Q_0
    beq     $t3, $t1, L1        # if lSB of Q_0 and Q_-1 both are equal then branch to label L1
    beq     $t1, $zero, L2      # if LSB of Q_0 and Q_-1 are 10 then branch to label L2
    add     $t0, $t0, $a0       # if the above two are not true then LSB of Q_0 and Q_-1 is 01 hence do $t0 <-- $t0 + $a0 (A = A + M)
    j L1

L2:
    sub     $t0, $t0, $a0       # $t0 <-- $t0 - $a0 (A = A - M)

L1:
    addi    $t2, $t2, -1        # decrement the count by 1 (count <-- count - 1)
    andi    $t1, $a1, 1         # store the LSB of Q in $t1 

    sra     $a1, $a1, 1         # right shift Q by 1 bit and store in $a1 
    andi    $t4, $t0, 1         # store the LSB of A in $t4 
    sll     $t4, $t4, 15        # left shift the LSB of A by 15 bits
    or      $a1, $a1, $t4       # take OR with Q in order to complete the right shift operation on Q

    sra     $t0, $t0, 1         # right shift A by 1 bit in order to complete the right shift operation on A
    j while

exit_while:
    sll     $t0, $t0, 16        # The Answer for the multi is combination of A and Q so shifting A by 16 bits so that Q can accomodate lower 16 bits
    or      $v0, $t0, $a1       # putting Q in the lower 16 bits and setting it to $v0 for return
    jr      $ra


exit:
	li      $v0, 4             # set $v0 = 4 to print string
    la      $a0, error         # prompt for error
    syscall

    li      $v0, 4             # set $v0 = 4 to print string
    la      $a0, newline
    syscall
    li      $v0, 4             # set $v0 = 4 to print string
    la      $a0, newline
    syscall

    li      $v0, 10            # terminate the program
    syscall

