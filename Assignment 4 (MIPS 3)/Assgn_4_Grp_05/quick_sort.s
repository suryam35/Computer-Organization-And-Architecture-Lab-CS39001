# Assignment number - 4
# Problem number - 2
# Semester - 5 (Aut 2021)
# Group number - 5
# Group Member 1 - Suryam Arnav Kalra (19CS30050)
# Group Member 2 - Kunal Singh (19CS30025

# This program takes 10 inputs from the user and then prints the sorted array using quick sort
    .globl  main

    .data

# program output text constants
array:
    .space 40
integer:
    .asciiz "Enter the integer: "
result:
    .asciiz "Sorted array : "
newline:
    .asciiz "\n"
comma:
    .asciiz " "

    .text

# main program
#
# program variables
#   array:   $s0
#
main:

init_stack:
    addi    $sp, $sp, -4    # initializing stack pointer and making space for frame pointer
    sw      $fp, 0($sp)     # intializing the frame pointer and storing in stack
    move    $fp, $sp        # moving frame pointer to address where stack pointer is


    addi    $t0, $zero, 0   # store 0 in register t0, the loop variable for input, say i
    la      $s0, array      # make space for 10 elemnts of the array

input_while:
    slti    $t1, $t0, 10    # set $t1 = 1 if i < 10
    beq     $t1, $zero, exit_input_while  # exit the loop if $t1 == 0 i.e i >= 10

    li      $v0, 4          # prompt to get integer
    la      $a0, integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sll     $t1, $t0, 2     # shift the 2 bits of loop variable and store to $t1 i.e $t1 = 4*i
    add     $t1, $t1, $s0   # add 4*i to the base address of the array
    sw      $v0, 0($t1)     # store the value taken as input to the above calculated address
    addi    $t0, $t0, 1     # add 1 to the loop variable
    j input_while

exit_input_while:

    move    $a0, $s0        # store the base address of the array to register $a0 in order to pass is as a parameter to the sort_array function
    li      $a1, 0          # store the start index to pass it as a parameter to the sort function
    li      $a2, 9          # store the end index to pass it as a parameter to the sort function

    jal recursive_sort      # call the recursive sort function

# print array starts
    li      $v0, 4          # print two newlines
    la      $a0, result
    syscall
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

    li      $v0, 10         # terminate the program
    syscall


recursive_sort:
    move    $t0, $ra        # moving the return address of the function call to t0
    sub     $sp, $sp, 4     # decrementing the stack pointer by 4, making space to store value in a register to stack
    sub     $sp, $sp, 4     # decrementing the stack pointer by 4, making space to store value in a register to stack
    move    $a3, $a2        # moving the end index passed to the function , say right to register a3
    jal pushToStack         # calling the function to store right into the stack
    sub     $sp, $sp, 4     # decrementing the stack pointer by 4, making space to store value in a register to stack
    move    $a3, $a1        # moving the end index passed to the function , say right to register a3
    jal pushToStack         # calling the function to store right into the stack
    sub     $sp, $sp, 4     # decrementing the stack pointer by 4, making space to store value in a register to stack
    move    $a3, $t0        # moving the return address passed to the function register a3
    jal pushToStack         # calling the function to store return address into the stack
      

    move    $t0, $a1        # t0 = l = left, since left was passed in register a1 as a parameter to the function
    move    $t1, $a2        # t1 = r = right, since right was passed in register a2 as a parameter to the function
    move    $t2, $a1        # t2 = p = left, store value of left in a register , say p in our program

outer_while:
    bge     $t0, $t1, exit_outer_while  # exit the loop if l >= r, since l is in t0 and r is in t1  
    lw      $a1, 4($sp)     # load from 4 bytes above the stack pointer and store it in register a1, i.e store left in a1
    lw      $a2, 8($sp)     # load from 8 bytes above the stack pointer and store it in register a2, i.e store right in a2

inner_first_while:
    sll     $t3, $t0, 2     # shift l by 2 bits and store it to t3, i.e store 4*l to register t3
    add     $t3, $t3, $a0   # add 4*l to the base address of the array
    lw      $t4, 0($t3)     # t4 = A[l], store the value at base adress + 4*l of the array to register t4
    sll     $t3, $t2, 2     # shift p by 2 bits and store it to t3, i.e store 4*p to register t3
    add     $t3, $t3, $a0   # add 4*p to the base address of the array
    lw      $t5, 0($t3)     # t5 = A[p], store the value at base adress + 4*p of the array to register t4
    bgt     $t4, $t5, second_inner_while # branch to the inner while loop if A[l] > A[p]
    bge     $t0, $a2, second_inner_while # branch to the inner while loop if l > right, since l is stored in t0 and right is stored in a2
    addi    $t0, $t0, 1     # add one to l, l <-- l + 1
    j inner_first_while     # jump to the loop again

second_inner_while:
    sll     $t3, $t1, 2     # shift r by 2 bits and store it to t3, i.e store 4*r to register t3  
    add     $t3, $t3, $a0   # add 4*r to the base address of the array
    lw      $t4, 0($t3)     # t4 = A[r], store the value at base adress + 4*r of the array to register t4
    sll     $t3, $t2, 2     # shift p by 2 bits and store it to t3, i.e store 4*p to register t3
    add     $t3, $t3, $a0   # add 4*p to the base address of the array
    lw      $t5, 0($t3)     # t5 = A[p], store the value at base adress + 4*p of the array to register t4
    blt     $t4, $t5, exit_second_inner_while # branch to the inner while loop if A[r] < A[p]
    ble     $t1, $a1, exit_second_inner_while # branch to the inner while loop if r <= left, since r is stored in t1 and right is stored in a1
    addi    $t1, $t1, -1    # add -1 to r, r <-- r - 1
    j second_inner_while    # jump to the loop again

exit_second_inner_while:
    blt     $t0, $t1, outer_swap # go to label outer swap if l < r, since l is stored in t0 and r is stored in t1
    sll     $t3, $t2, 2     # shift p by 2 bits and store it to t3, i.e store 4*p to register t3
    add     $t3, $t3, $a0   # add 4*p to the base address of the array
    move    $a1, $t3        # a1 = A[p], store the value at base adress + 4*p of the array to register a1
    sll     $t3, $t1, 2     # shift r by 2 bits and store it to t3, i.e store 4*r to register t3  
    add     $t3, $t3, $a0   # add 4*r to the base address of the array
    move    $a2, $t3        # a2 = A[r], store the value at base adress + 4*r of the array to register a2
    jal swap                # jump to the function swap with the two arguments stored in register a1 and a2
    addi    $sp, $sp, 12    # move stack pointer 12 bytes above from where it is right now
    move    $a3, $t1        # move r to register a3, since r is stored in register t1 
    jal pushToStack         # push the value of r to stack
    addi    $sp, $sp, -12   # move stack pointer 12 bytes below from where it is right now
    # sw      $t1, 12($sp)   # r = sp+12
    lw      $a1, 4($sp)     # load the value stored at 4 bytes above the stack pointer to register a1, i.e store left to register a1
    addi    $a2, $t1, -1    # add -1 to r and store in a2, since r is stored in t1
    jal recursive_sort      # call the function recursive sort with arguments in register a0(A), a1(left) and a2(r-1)
    lw      $t1, 12($sp)    # load the value stored at 12 byted above the stack pointer to register t1, i.e store r to register t1
    addi    $a1, $t1, 1     # add 1 to value stored at t1 and store it in a1, i.e store r + 1 to a1
    lw      $a2, 8($sp)     # load the value stored at 8 bytes above the stack pointer to register a2, i.e store right to register a2
    jal recursive_sort      # call the function recursive sort with arguments in register a0(A), a1(r+1) and a2(right)

    lw      $ra, 0($sp)     # load the return address from the stack
    addi    $sp, $sp, 16    # free the space taken in stack
    jr $ra                  # return from the function



outer_swap:
    sll     $t3, $t0, 2     # shift l by 2 bits and store it to t3, i.e store 4*l to register t3
    add     $t3, $t3, $a0   # add 4*l to the base address of the array
    move    $a1, $t3        # a1 = A[l], store the value at base adress + 4*l of the array to register a1
    sll     $t3, $t1, 2     # shift r by 2 bits and store it to t3, i.e store 4*r to register t3
    add     $t3, $t3, $a0   # add 4*r to the base address of the array
    move    $a2, $t3        # a2 = A[r], store the value at base adress + 4*r of the array to register a2
    jal swap                # call the swap function with arguments in register a1 and a2
    j outer_while           # jump to outer while


swap:
    lw      $t6, 0($a1)     # load the value at adress 0 + a1 to register t6
    lw      $t7, 0($a2)     # load the value at adress 0 + a2 to register t7
    sw      $t7, 0($a1)     # stores the value in register t7 to address 0 + a1
    sw      $t6, 0($a2)     # stores the value in register t6 to address 0 + a2
    jr      $ra             # return from the function


exit_outer_while:
    lw      $ra, 0($sp)    # load the return address from the stack
    addi    $sp, $sp, 16   # free the space taken in stack
    jr      $ra            # return from the function


pushToStack:
    sw      $a3, 0($sp)    # takes the argument in register a3 and push it to stack
    jr      $ra            # return from the function