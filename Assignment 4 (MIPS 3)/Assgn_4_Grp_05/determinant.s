# Assignment number - 4
# Problem number - 1
# Semester - 5 (Aut 2021)
# Group number - 5
# Group Member 1 - Suryam Arnav Kalra (19CS30050)
# Group Member 2 - Kunal Singh (19CS30025

# This program takes matrix input from user and finds the determinant of the matrix using recursive function
# to find the determinant we have wrote the algorithm we used in the end of this code as comments

    .globl  main

    .data

# program output text constants
n_integer:
    .asciiz "Enter the value of n: "
a_integer:
    .asciiz "Enter the value of a: "
r_integer:
    .asciiz "Enter the value of r: "
m_integer:
    .asciiz "Enter the value of m: "
original:
    .asciiz "\n\nThe original matrix is : \n\n"
result:
    .asciiz "\n\nThe final determinant of the matrix A is : "
newline:
    .asciiz "\n"
comma:
    .asciiz " "

    .text

# main program
#
# program variables
#	n:   $s0
#   a:   $s0 + 4
#   r:   $s0 + 8
#   m:   $s0 + 12
#   A:   $s1
main:
    
init_stack:
    addi    $sp, $sp, -4    # initializing stack pointer and making space for frame pointer
    sw      $fp, 0($sp)     # intializing the frame pointer and storing in stack
    move    $fp, $sp        # moving frame pointer to address where stack pointer is

    addi    $sp, $sp, -16   # moving stack pointer 16 bytes down to make space for n, a, r, m

    li      $v0, 4          # prompt to get integer
    la      $a0, n_integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sw      $v0, 0($sp)

    li      $v0, 4          # prompt to get integer
    la      $a0, a_integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sw      $v0, 4($sp)

    li      $v0, 4          # prompt to get integer
    la      $a0, r_integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sw      $v0, 8($sp)

    li      $v0, 4          # prompt to get integer
    la      $a0, m_integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sw      $v0, 12($sp)

    move    $s0, $sp        # storing where the stack pointer is located in register s0

    lw      $t0, 0($s0)     # storing value of n in register t0, since n is stored 0 bytes above the stack pointer

    mul     $t0, $t0, $t0   # t0 = n*n, since n is stored in t0

    move    $a0, $t0        # a0 = n*n, since n is stored in t0

    jal mallockInStack      # this function is called with the argument in the register a0, this will allocated a size of n*n to the stack

    move    $s1, $v0        # store the base address returned by the function in the register s1

    addi    $t2, $zero, 0   #t2 = 0

    lw      $t5, 4($s0)     # t5 = a, since a is stored at s0 + 4
    lw      $t6, 8($s0)     # t6 = r, since a is stored at s0 + 8
    lw      $t7, 12($s0)    # t7 = m, since a is stored at s0 + 12

fill_while:                 # this is the loop to fill the matrix
    slt     $t3, $t2, $t0   # if t2 < m*n set t3 = 1 ( loop variable is stored in t2 )
    beq     $t3, $zero, exit_fill_while # if t3 != 1 exit the loop i.e if value at t2 > m*n 
    sll     $t3, $t2, 2     # shift the loop variable by 2 i.e multiply 4 to it
    add     $t3, $t3, $s1   # adding the above generated value to the starting address of matrix A to reach the location of a particular cell in matrix
    div     $t5, $t7        # divide the number by m, taken input from user
    mfhi    $t5             # take the remainder of the division
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
    lw      $a1, 0($s0)     # setting the 2nd parameter n for printing
    move    $a2, $s1        # setting the 3rd parameter the address of the matrix A for printing

    jal printMatrix

    move    $a0, $s1        # setting the first parameter for recursive determinant function, matrix A
    lw      $a1, 0($s0)     # setting the second parameter for recursive determinant function, n (size of the matrix)
    jal recursive_det

    move    $s2, $v0        # store the answer returned from the recursive determinant function

    li      $v0, 4          # setting value in v0 = 4 for priting string
    la      $a0, result
    syscall
    li      $v0, 1          # set 1 to print the integer
    move    $a0, $s2        # set a0 to the final determinant for printing
    syscall

    li      $v0, 10         # terminate the program
    syscall

# a0 = A
# a1 = n

recursive_det:
    sub     $sp, $sp, 24    # making space in stack to store the values that we want to retain after the recursive calls are over
    sw      $ra, 0($sp)     # store the return address at 0 + sp
    sw      $a1, 4($sp)     # store the value of n in register a1, a1 <-- n
    sw      $a0, 8($sp)     # store the base address of the matrix in register a0, a0 <-- A

    slti    $t0, $a1, 2     # if n < 2 , i.e n == 1 then set t0 = 1
    bne     $t0, $zero, exit_recursive_det # if n == 1 then return from the function
    addi    $t0, $zero, 0   # t0 = 0, say result = 0 for our reference
    sw      $t0, 12($sp)    # store the value of result variable 12 bytes above the stack pointer
    addi    $t2, $zero, 0   # t2 = 0, say j = 0, loop variable 
    lw      $t3, 4($sp)     # t3 = n, since n is stored 4 bytes above the stack pointer
    addi    $t4, $zero, 1   # t4 = 1
    sw      $t4, 16($sp)    # store the above setted value in register t4, 16 bytes above the stack pointer
    

determinant_outer_for:
    sw      $t2, 20($sp)    # store the value of j (loop variable) 20 bytes above the stack pointer
    lw      $t3, 4($sp)     # load the value of n from stack to register t3, t3 <-- n
    bge     $t2, $t3, exit_determinant_outer_for # if j > n, exit the loop 
    addi    $t5, $zero, 0   # t5 = 0, say variacble offset = 0 in our program for referencing
    
    addi    $t6, $t3, -1    # t6 = n-1, since n is stored in register t3 
    mul     $t6, $t6, $t6   # compute (n-1) * (n-1) and store it in register t6 
    sll     $t6, $t6, 2     # shift the value stored in register by 2 bit, i.e t6 = 4*value in t6
    sub     $sp, $sp, $t6   # to make the space for the sub matrix of size n-1 * n-1 allocate the space 4*(n-1)^2 in the stack
    move    $a2, $sp        # a2 = address, store the address of the new submatrix in the register a2
    sub     $sp, $sp, 4     # make space in the stack 
    sw      $t6, 0($sp)     # store the value 4*(n-1)^2 in the stack
 
    addi    $t6, $zero, 1   # t6 = 1, say row = 1 in our program for future referencing

determinant_inner_for:
    bge     $t6, $t3, exit_determinant_inner_for # if row >= n, exit the inner for loop
    addi    $t7, $zero, 0   # t7 = 0, say col in our program for future reference 

nested_inner_for:
    bge     $t7, $t3, exit_nested_inner_for # if col >= n, exit the nested for loop
    beq     $t7, $t2, else_block            # if col != j, branch to the else_block
    sll     $t1, $t5, 2     # t1 = offset*4, since offset is stored in register t5
    add     $t1, $t1, $a2   # t1 = offset + minor, since base address of minor is stored in a2
    addi    $t8, $t3, 0     # load the address of n in register t8 since n is in register t3
    mul     $t8, $t8, $t6   # t8 = row*(n-1)
    add     $t8, $t8, $t7   # t8 = row*(n-1) + col
    sll     $t8, $t8, 2     # t8 = 4*(row*(n)+col)
    lw      $s3, 0($sp)     # load the value at 0 bytes below the stack pointer in the register s3
    move    $s2, $sp        # store the address of stack pointer in the register s2
    addi    $s2, $s2, 4     # s2 <-- s2 + 4
    add     $s2, $s2, $s3   # add s2 to the location of stack pointer
    lw      $t9, 8($s2)     # t9 = A, since A is stored at 4 bytes above stack pointer and s2 is pointing at stack pointer only
    add     $t8, $t8, $t9   # t8 = A + t8
    lw      $t9, 0($t8)     # load the value from the matrix, stored at A + t8 
    sw      $t9, 0($t1)     # store that value computed in above step to t1
    addi    $t5, $t5, 1     # increase the offset by 1, since offset is stored in $t5

else_block:
    addi    $t7, $t7, 1     # add 1 to the col, since col is the loop variable for nested_inner_for
    j nested_inner_for      # jump to nested_inner_for

 
exit_nested_inner_for:      
    addi    $t6, $t6, 1     # add 1 to the row, since row is the loop variable for determinant_inner_for
    j determinant_inner_for # jump to determinant_inner_for

exit_determinant_inner_for:
    lw      $t0, 0($sp)     # load the value at 0 bytes above the stack pointer
    add     $sp, $sp, 4     # add 4 to the stack pointer 
    add     $sp, $sp, $t0   # now add the value restored from the stack pointers 2 commands back to the stack pointer

    move    $a0, $a2        # store the value stored in a2 to the register a0
    
    lw      $a1, 4($sp)     # load the value of n from the stack pointer, since n is stored at 4 bytes above the stack pointer
    addi    $a1, $a1, -1    # add -1 to n, n <-- n-1
    sub     $sp, $sp, 4     # subtract 4 from stack pointer
    sub     $sp, $sp, $t0   # subtract back the value added to the stack pointer before call the recursive function again
    jal     recursive_det   # call the recursive determinant function

    # debugging statements

    # move    $a3, $v0
    # li      $v0, 4          # print comma
    # la      $a0, newline
    # syscall
    # li      $v0, 1
    # move    $a0, $a3
    # syscall
    # li      $v0, 4          # print comma
    # la      $a0, newline
    # syscall
    #move    $v0, $a3

    # debugging statements ends

    lw      $t0, 0($sp)     # load the value at 0 bytes above the stack pointer
    add     $sp, $sp, 4     # add 4 to the stack pointer 
    add     $sp, $sp, $t0   # now add the value restored from the stack pointers 2 commands back to the stack pointer
    lw      $t0, 12($sp)    # t0 <-- result, load the value of result from the stack, since result is stored at 12 bytes above the stack
    lw      $t4, 16($sp)    # load the value stored from the  16 bytes above the stack
    lw      $t8, 8($sp)     # load the base address of the matrix from the stack
    lw      $t2, 20($sp)    # store the value of j (loop variable) 20 bytes above the stack pointer
    sll     $t2, $t2, 2     # t2 <-- 4*j
    add     $t2, $t2, $t8   # t2 <-- A + 4*j
    lw      $t2, 0($t2)     # load the value from the above computed address
    mul     $v0, $v0, $t4   # muitliply the value in register t4 to reslut and add it to result
    mul     $v0, $v0, $t2   # multiply the above computed value with j
    add     $t0, $t0, $v0   # add the above computed value to result, result += (-1)^j * value
    sw      $t0, 12($sp)    # store the result back to the stack
    addi    $v1, $zero, -1  # store -1 in register v1
    mul     $t4, $v1, $t4   # multiply -1 to get the power of -1 term everytime
    sw      $t4, 16($sp)    # store this value to get it next time, since we have no power function we keep the old power of -1 in stack and multiple with -1 and use
    lw      $t2, 20($sp)    # load back the value of loop variable j
    addi    $t2, $t2, 1     # add 1 to the loop variable j , j <-- j + 1
    j determinant_outer_for # jump to determinant_outer_for



exit_determinant_outer_for:
    lw      $v0, 12($sp)    # load the result from the stack
    lw      $ra, 0($sp)     # load the return address from the stack
    addi    $sp, $sp, 24    # add back all the space we have allocated in the stack
    jr      $ra             # return from the funtion


exit_recursive_det:
    lw      $v0, 0($a0)     # load the value in a0 to v0
    lw      $ra, 0($sp)     # load the return address from the stack
    move    $t0, $ra        # move the return address in register t0
    move    $t1, $v0        # move the result in register t1
    jal     popFromStack    # pop from stack to free up the space taken
    jal     popFromStack    # pop from stack to free up the space taken
    jal     popFromStack    # pop from stack to free up the space taken
    jal     popFromStack    # pop from stack to free up the space taken
    jal     popFromStack    # pop from stack to free up the space taken
    jal     popFromStack    # pop from stack to free up the space taken
    # addi    $sp, $sp, 24
    move    $ra, $t0        # store back the return address
    move    $v0, $t1        # store back the result to register v0
    jr      $ra             # return from the function



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


popFromStack:
    lw      $v0, 0($sp)     # stores the value at the top of stack
    addi    $sp, $sp, 4     # add 4 to stack pointer to do pop operation
    jr      $ra             # return from function

mallockInStack:
    sll     $a0, $a0, 2     # shift the only parameter passed to fucntion by 2 in order to make space for the integers to be stored
    sub     $sp, $sp, $a0   # move the stack pointer by the size calculated above
    move    $v0, $sp        # store the address where the stack pointer is pointing in v0 to return from the fucntion
    jr      $ra


#determinant(A, n)
#   if n == 1:
#      return A[0]
#   result = 0
#    i = 0 
#    for j -> 0 to n-1:
#       offset = 0
#       for row = 1 to n-1:
#           for col = 0 to n-1:
#               if col != j:
#                    minor + offset = A[row][col]  =  A + 4*(row*(n)+col)
#        form the minor by removing the 0th row and jth column
#        value = determinant(minor, n-1)
#        result += (-1)^j * value
#    return result

