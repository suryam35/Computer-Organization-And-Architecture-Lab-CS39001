# Assignment number - 3
# Problem number - 2
# Semester - 5 (Aut 2021)
# Group number - 5
# Group Member 1 - Suryam Arnav Kalra (19CS30050)
# Group Member 2 - Kunal Singh (19CS30025)


# This program takes 10 inputs from the user and then prints the Kth largest number among them

    .globl  main

    .data

# program output text constants
array:
    .space 40
integer1:
    .asciiz "Enter the "
integer2:
    .asciiz " integer: "
second_integer:
    .asciiz "\nEnter the value of k: "
result1:
    .asciiz "\nThe "
result2:
    .asciiz " largest value is: "
error:
	.asciiz "\nEXIT! The value of k > n."
sorted_array:
    .asciiz "\nThe sorted array is: "
st:
    .asciiz "st"
nd:
    .asciiz "nd"
th:
    .asciiz "th"
rd:
    .asciiz "rd"

newline:
    .asciiz "\n"
comma:
    .asciiz " "

    .text

# main program
#
# program variables
#   array:   $s0
#	k:   $s1
#
main:
    addi    $t0, $zero, 0   # store 0 in register t0, the loop variable for input, say i
    la      $s0, array      # make space for 10 elemnts of the array

input_while:
    slti    $t1, $t0, 10    # set $t1 = 1 if i < 10
    beq     $t1, $zero, exit_input_while   # exit the loop if $t1 == 0 i.e i >= 10

    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, integer1
    syscall

    move    $a0, $t0        # set $a0 as an 1st argument to the function print_number

    jal     print_number    # function will take the integer input and prints 1st, 2nd, 3rd, 4th.. accordingly

    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, integer2
    syscall

    li      $v0, 5          # set $v0 = 5 to take integer input
    syscall
    sll     $t1, $t0, 2     # shift the 2 bits of loop variable and store to $t1 i.e $t1 = 4*i
    add     $t1, $t1, $s0   # add 4*i to the base address of the array
    sw      $v0, 0($t1)     # store the value taken as input to the above calculated address
    addi    $t0, $t0, 1     # add 1 to the loop variable
    j input_while

exit_input_while:

    move    $a0, $s0        # store the base address of the array to register $a0 in order to pass is as a parameter to the sort_array function

    jal sort_array          # call sort_array function

    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, sorted_array
    syscall

# print array starts

    addi    $t0, $zero, 0   # t0 = 0 , loop variable , say i
print_while:
    slti    $t1, $t0, 10    # set $t1 = 1 if i < 10
    beq     $t1, $zero, exit_print_while  # exit the loop if $t1 == 0 i.e i >= 10
    sll     $t1, $t0, 2     # shift the 2 bits of loop variable and store to $t1 i.e $t1 = 4*i
    add     $t1, $t1, $s0   # add 4*i to the base address of the array
    lw      $t2, 0($t1)     # store the value at the above calculated location to $t2

    li      $v0, 1          # set $v0 = 1 to print the integer
    move    $a0, $t2        # move the content of $t2 to $a0 in order to print it
    syscall
    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, comma
    syscall
    
    addi    $t0, $t0, 1     # add 1 to the loop variabe i.e i <-- i + 1
    j print_while

exit_print_while: 
    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, newline
    syscall
# print array ends

    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, second_integer
    syscall

    li      $v0, 5          # set $v0 = 5 to take the integer input
    syscall
    move    $s1, $v0        # set $s1 = $v0 , store k to $s1

find_k_largest:
    
    slti    $t0, $s1, 11    # set $t1 = 1 if k < 11
    beq     $t0, $zero, exit  # exit the program if $t1 == 0 i.e k > 10

    addi    $t1, $zero, 10  # set $t1 = 10
    sub     $t1, $t1, $s1   # $t1 = $t1 - k , to get the value to be printed from first of the array
    sll     $t1, $t1, 2     # shift 2 bits of the position found in above step 
    add     $t1, $t1, $s0   # add the calculated value got in the above step to the base address of the array
    lw      $t2, 0($t1)     # store the value to be printed in $t2


    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, result1   
    syscall

    move    $a0, $s1        # set the input (k) in register $a0 for printing

    addi    $a0, $a0, -1    # subtract 1 from it and store it to $a0 in order to pass it as a argument to the print_number function

    jal     print_number    # call print_number 

    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, result2
    syscall

    li      $v0, 1          # set $v0 = 1 to print the integer
    move    $a0, $t2        # set $a0 = value of the kth largest number in the array
    syscall

    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, newline
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall

    li      $v0, 10         # terminate the program
    syscall



sort_array:
    addi    $t0, $zero, 10    # set $t0 = 10, say n
    addi    $t1, $zero, 1     # set $t1 = 1 , loop varible, say j
for:
    bge     $t1, $t0, exit_for  # if i > n exit the loop
    sll     $t2, $t1, 2       # shift the loop variable by 2 in order to get the value 4*j
    add     $t2, $t2, $a0     # add the above calculated value to the base address of the array (a)
    lw      $t3, 0($t2)       # store a[j] in t3 register
    addi    $t4, $t1, -1      # set $t4 = j-1 , i.e inner loop variable, say i = j-1

inner_while:
    blt     $t4, $zero, exit_inner_while  # if i < 0 exit inner while loop
    sll     $t2, $t4, 2       # shift the loop variable by 2 in order to get the value 4*i
    add     $t2, $t2, $a0     # add the above calculated value to the base address of the array (a)
    lw      $t5, 0($t2)       # store a[i] in t5 register
    ble     $t5, $t3, exit_inner_while  # if a[i] < a[j] exit inner while loop
    sw      $t5, 4($t2)       # set a[i] = a[i+1]
    addi    $t4, $t4, -1      # decrease the inner loop variable i <-- i-1
    j inner_while

exit_inner_while:
    addi    $t4, $t4, 1       # add 1 to the inner loop variable , i <-- i + 1
    sll     $t4, $t4, 2       # shift the loop variable by 2 in order to get the value 4*i
    add     $t4, $t4, $a0     # add the above calculated value to the base address of the array (a)
    sw      $t3, 0($t4)       # store a[j] = a[i+1]
    addi    $t1, $t1, 1       # add 1 to the outer loop variable, j <-- j + 1
    j for

exit_for:
    jr $ra

exit:
	li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, error      # prompt for error
    syscall

    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, newline
    syscall
    li      $v0, 4          # set $v0 = 4 to print string
    la      $a0, newline
    syscall

    li      $v0, 10         # terminate the program
    syscall

# the code below is used to print given number with proper suffix such as 1st, 2nd, 3rd, 4th..

print_number:
    beq     $a0, $zero, print_st   # if the provided number is 0 (1 in 1 based indexing) the branch for print st in suffix
    addi    $t7, $zero, 0
    slti    $t7, $a0, 2
    bne     $t7, $zero, print_nd   # if the provided number is 1 (2 in 1 based indexing) the branch for print st in suffix
    addi    $t7, $zero, 0
    slti    $t7, $a0, 3
    bne     $t7, $zero, print_rd   # if the provided number is 2 (3 in 1 based indexing) the branch for print st in suffix
    li      $v0, 1
    addi    $a0, $a0, 1            # else if nothing above is true then the number must be 4 onwards so add th in the suffix
    syscall
    li      $v0, 4
    la      $a0, th
    syscall
    jr $ra

# program to print the digit followed by "rd" as the suffix 

print_rd:
    li      $v0, 1
    addi    $a0, $a0, 1
    syscall
    li      $v0, 4
    la      $a0, rd
    syscall
    jr $ra

# program to print the digit followed by "nd" as the suffix 

print_nd:
    li      $v0, 1
    addi    $a0, $a0, 1
    syscall
    li      $v0, 4
    la      $a0, nd
    syscall
    jr $ra

# program to print the digit followed by "st" as the suffix 

print_st:
    li      $v0, 1
    addi    $a0, $a0, 1
    syscall
    li      $v0, 4
    la      $a0, st
    syscall
    jr $ra

