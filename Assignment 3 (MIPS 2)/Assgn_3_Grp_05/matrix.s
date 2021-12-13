# Assignment number - 3
# Problem number - 3
# Semester - 5 (Aut 2021)
# Group number - 5
# Group Member 1 - Suryam Arnav Kalra (19CS30050)
# Group Member 2 - Kunal Singh (19CS30025)


# This program takes matrix input from user and prints the prints the transpose of the matrix

    .globl  main

    .data

# program output text constants
m_integer:
    .asciiz "Enter the value of m: "
n_integer:
    .asciiz "Enter the value of n: "
a_integer:
    .asciiz "Enter the value of a: "
r_integer:
    .asciiz "Enter the value of r: "
original:
    .asciiz "\n\nThe original matrix is : \n\n"
transpose:
    .asciiz "\n\nThe transposed matrix is : \n\n"
error:
	.asciiz "EXIT! The value of k > n."
newline:
    .asciiz "\n"
comma:
    .asciiz " "

    .text

# main program
#
# program variables
#   m:   $s0
#	n:   $s0 + 4
#   a:   $s0 + 8
#   r:   $s0 + 12
#   A:   $s1
#   B:   $s2
main:
    
init_stack:
    addi    $sp, $sp, -4    # initializing stack pointer and making space for frame pointer
    sw      $fp, 0($sp)     # intializing the frame pointer and storing in stack
    move    $fp, $sp        # moving frame pointer to address where stack pointer is

    addi    $sp, $sp, -16   # making space in stack for four variables m, n, a, r

    li      $v0, 4          # prompt to get integer
    la      $a0, m_integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sw      $v0, 0($sp)     # storing m to the stack where stack pointer is pointing 

    li      $v0, 4          # prompt to get integer
    la      $a0, n_integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sw      $v0, 4($sp)     # storing n to the stack 4 bytes above the stack pointer is pointing 

    li      $v0, 4          # prompt to get integer
    la      $a0, a_integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sw      $v0, 8($sp)     # storing a to the stack 8 bytes above the stack pointer is pointing 

    li      $v0, 4          # prompt to get integer
    la      $a0, r_integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sw      $v0, 12($sp)    # storing r to the stack 12 bytes above the stack pointer is pointing 

    move    $s0, $sp        # storing the address where stack pointer is pointing to register s0 for further referencing

    lw      $t0, 0($s0)     # storing value at s0 i.e m to a temporary resgiter t0
    lw      $t1, 4($s0)     # storing value at 4 bytes above s0 i.e n to a temporary resgiter t1

    mul     $t0, $t1, $t0   # t0 = m*n

    move    $a0, $t0        # a0 = m*n

    jal mallockInStack      # function call to dynamically alloacte 4*m*n space in the stack

    move    $s1, $v0        # storing the address of stack pointer after making 4*m*n space in stack , marking it as the starting address of matrix A

    move    $a0, $t0        # again calling the function to allocate memory for matrix B

    jal mallockInStack 

    move    $s2, $v0        # storing the address of stack pointer after making 4*m*n space in stack , marking it as the starting address of matrix B

    addi    $t2, $zero, 0   #t2 = 0, intializing loop variable for filling values in matrix A

    lw      $t5, 8($s0)     # storing value at 8 bytes above s0 i.e a to a temporary resgiter t5
    lw      $t6, 12($s0)    # storing value at 12 bytes above s0 i.e r to a temporary resgiter t6

fill_while:
    slt     $t3, $t2, $t0   # if t2 < m*n set t3 = 1 ( loop variable is stored in t2 )
    beq     $t3, $zero, exit_fill_while  # if t3 != 1 exit the loop i.e if value at t2 > m*n 
    sll     $t3, $t2, 2     # shift the loop variable by 2 i.e multiply 4 to it
    add     $t3, $t3, $s1   # adding the above generated value to the starting address of matrix A to reach the location of a particular cell in matrix
    move    $a0, $t5        # setting the value to be stored at the current cell we are looking as the parameter for pushtostack function
    jal pushToStack         # the value we passed to this function will be stored in stack
    mul     $t5, $t5, $t6   # multiplying r to the present value of t5 in order to get the next term of the GP series
    addi    $t2, $t2, 1     # add 1 to the loop variable
    j fill_while

exit_fill_while:
    
    li      $v0, 4          # setting value in v0 = 4 for priting string
    la      $a0, original
    syscall

    lw      $a0, 0($s0)     # setting the 1st parameter m for printing
    lw      $a1, 4($s0)     # setting the 2nd parameter n for printing
    move    $a2, $s1        # setting the 3rd parameter the address of the matrix A for printing

    jal printMatrix         # call the function to print the original matrix

    lw      $a0, 0($s0)     # setting the 1st parameter m for transpose function
    lw      $a1, 4($s0)     # setting the 2nd parameter n for transpose function
    move    $a2, $s1        # setting the 3rd parameter the address of the matrix A for transpose function
    move    $a3, $s2        # setting the 4th parameter the address of the matrix B for transpose function

    jal transposeMatrix     # call the function to generate transpose of matrix A and store in matrix B

    li      $v0, 4          # setting value in v0 = 4 for priting string
    la      $a0, transpose
    syscall

    lw      $a0, 4($s0)     # setting the 1st parameter n for printing
    lw      $a1, 0($s0)     # setting the 2nd parameter m for printing
    move    $a2, $s2        # setting the 3rd parameter the address of the matrix B for printing

    jal printMatrix

    li      $v0, 10         # terminate the program
    syscall

transposeMatrix:

    addi    $t0, $zero, 0   # t0 = 0, outer loop variable let us say variable i
outerFor:
    slt     $t1, $t0, $a0   # set t1 = 1, if i < m (number of rows of A)
    beq     $t1, $zero, exitOuterFor  # if t1 == 0 i.e i > m exit the outer for loop 

    addi    $t1, $zero, 0   # t0 = 0, outer loop variable let us say variable j
innerFor:
    slt     $t2, $t1, $a1   # set t2 = 1, if j < n (number of columns of A)
    beq     $t2, $zero, exitInnerFor  # if t2 == 0 i.e j > n exit the inner for loop 

    mul     $t6, $t0, $a1   # t6 = i*n
    add     $t6, $t6, $t1   # t6 = i*n + j
    sll     $t6, $t6, 2     # t6 = 4*(i*n + j)
    add     $t6, $t6, $a2   # adding the value in t6 to the base address of matrix A
    lw      $t5, 0($t6)     # storing the value of A[i*n+j] in t5

    mul     $t6, $t1, $a0   # t6 = j*m
    add     $t6, $t6, $t0   # t6 = j*m + i
    sll     $t6, $t6, 2     # t6 = 4*(j*m + i)
    add     $t6, $t6, $a3   # adding the value in t6 to the base address of matrix B
    sw      $t5, 0($t6)     # storing the value in t5 (A[i*n+j]) at memory address in t6 i.e B[j*m + i] = A[i*n+j]

    addi    $t1, $t1, 1     # adding 1 to the inner loop variable j <-- j + 1
    j innerFor              # jump to label innerfor

exitInnerFor:
    addi    $t0, $t0, 1     # adding 1 to the outer loop variable i <-- i + 1
    j outerFor              # jump to label outerFor

exitOuterFor:               # exit for outer for loop and rerturn from function
    jr $ra


printMatrix:
    move    $t6, $a0        # t6 = first parameter passed to the function, number of rows, say m
    mul     $t0, $a0, $a1   # t0 = m * second parameter passed to the function, number of columns, say n
    addi    $t1, $zero, 0   # t1 = 0, loop variable, say i

print_while:
    slt     $t2, $t1, $t0   # if set t2 = 1 if i < m*n
    beq     $t2, $zero, exit_print_while  # if t2 == 0 i.e i > m*n, exit printwhile loop
    sll     $t2, $t1, 2     # t2 = 4*i, shift loop variable by 2 bits
    add     $t2, $t2, $a2   # add 4*i to the base address value of the matrix passed to the fucntion as third argument, say A
    lw      $t3, 0($t2)     # store the value A[i] in t3

    li      $v0, 1          # set v0 = 1 to print integer
    move    $a0, $t3        # set the integer to print in register a0
    syscall
    li      $v0, 4          # setting value in v0 = 4 for priting string
    la      $a0, comma
    syscall

    addi    $t1, $t1, 1     # adding 1 to the loop variable i <-- i+1
    div     $t1, $a1        # divide i/m
    mfhi    $t7             # store the remainder of the above division in t7 

    bne     $t7, $zero, print_while  # check if the remainder i/m is 0 , if yes then print a new line to print the matrix in row major fashion  

print_new_line:
    li      $v0, 4          # setting value in v0 = 4 for priting string
    la      $a0, newline
    syscall
    j print_while



exit_print_while:           # exit the print while loop
    jr      $ra

pushToStack:
    sw      $a0, 0($t3)     # this will store the only parameter passed to the function in stack, t3 is alrady moved to the position where the argument is to be stored in stack
    jr      $ra

mallockInStack:
    sll     $a0, $a0, 2     # shift the only parameter passed to fucntion by 2 in order to make space for the integers to be stored
    sub     $sp, $sp, $a0   # move the stack pointer by the size calculated above
    move    $v0, $sp        # store the address where the stack pointer is pointing in v0 to return from the fucntion
    jr      $ra
