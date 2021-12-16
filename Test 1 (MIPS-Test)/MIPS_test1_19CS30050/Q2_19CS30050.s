# Question : 1
# Semester : 5
# Roll No.: 19CS30050
# Name: Suryam Arnav Kalra

# This program takes 10 inputs from the user and forms the max heap

    .globl  main

    .data

# program output text constants
array:
    .space 40
integer:
    .asciiz "Enter the integer: "
input_array:
    .asciiz "Input array: "
output_array:
    .asciiz "Output max heap: "
newline:
    .asciiz "\n"
comma:
    .asciiz ", "

    .text

# main program
#
# program variables
#   array:   $s0
#
main:
    addi    $t0, $zero, 0
    la      $s0, array

input_while:
    slti    $t1, $t0, 10   # if $t0 < 10 then set $t1 = 1
    beq     $t1, $zero, exit_input_while   # if $t1 == 0 then exit 

    li      $v0, 4          # prompt to get integer
    la      $a0, integer
    syscall

    li      $v0, 5          # get number from user
    syscall
    sll     $t1, $t0, 2
    add     $t1, $t1, $s0
    sw      $v0, 0($t1)   # store the input integer into the array
    addi    $t0, $t0, 1
    j input_while

exit_input_while:

    li      $v0, 4          # print prompt of input array
    la      $a0, input_array
    syscall

    addi    $t0, $zero, 0  # t0 = i = 0
print_while:
    slti    $t1, $t0, 10   # if $t0 < 10 then set $t1 to 1
    beq     $t1, $zero, exit_print_while   # if $t1 == 0 then exit loop of printing
    sll     $t1, $t0, 2
    add     $t1, $t1, $s0
    lw      $t2, 0($t1)   # get the integer stored at A[i]

    li      $v0, 1    # make a system call to print the stored integer
    move    $a0, $t2 
    syscall
    li      $v0, 4          # print comma
    la      $a0, comma
    syscall
    
    addi    $t0, $t0, 1
    j print_while

exit_print_while: 
    li      $v0, 4          # print newlines
    la      $a0, newline
    syscall

    move    $a0, $s0
    li      $a1, 10   # n = 10

    li      $t0, 4   # t0 = start_index = (n/2) - 1 = (10/2) - 1 = 4

heapify_for:
    blt     $t0, $zero, exit_heapify_for   # if i <= 0 then exit heapify

    move    $a0, $s0   # set the parameters to call the heapify function
    move    $a2, $t0

    jal heapify    # jump and link to the heapify function
 
    addi    $t0, $t0, -1   # do i = i-1
    j heapify_for   # jump back to the heapify loop

heapify:    # this is a recursive function
    addi    $sp, $sp, -12   # make room on stack pointer
    sw      $ra, 0($sp)   # store the return address
    move    $t1, $a2   # t1 = largest = i

    sll     $t3, $t1, 1
    addi    $t3, $t3, 1   # t3 = 2*i + 1 = l

    addi    $t4, $t3, 1   # t4 = 2*i + 2 = r

    bge     $t3, $a1, second_if   # if l >= n then branch to next if

    sll     $t5, $t3, 2
    add     $t5, $t5, $a0
    lw      $t6, 0($t5)   # t6 = A[l]

    sll     $t5, $t1, 2
    add     $t5, $t5, $a0
    lw      $t7, 0($t5)   # t7 = A[largest]

    ble     $t6, $t7, second_if   # if A[l] <= A[largest] then branch to next if

    move    $t1, $t3   # set largest = l


second_if:
    bge     $t4, $a1, third_if   # if r >= n then branch to next if

    sll     $t5, $t4, 2
    add     $t5, $t5, $a0
    lw      $t6, 0($t5)   # t6 = A[r]

    sll     $t5, $t1, 2
    add     $t5, $t5, $a0
    lw      $t7, 0($t5)   # t7 = A[largest]

    ble     $t6, $t7, third_if   # if A[r] <= A[largest] then branch to next if

    move    $t1, $t4    # set largest = r

third_if:
    beq     $t1, $a2, outside_third_if   # if largest == i then exit heapify


    # the below code swaps A[i] and A[largest]
    sll     $t5, $a2, 2
    add     $t5, $t5, $a0
    lw      $t6, 0($t5)   # t6 = A[i]

    sll     $t5, $t1, 2
    add     $t5, $t5, $a0
    lw      $t7, 0($t5)   # t7 = A[largest]

    sll     $t5, $t1, 2
    add     $t5, $t5, $a0
    sw      $t6, 0($t5)

    sll     $t5, $a2, 2
    add     $t5, $t5, $a0
    sw      $t7, 0($t5)

    move    $a2, $t1    # set the value of i to largest 

    jal heapify    # and again call the heapify function

outside_third_if:
    lw      $ra, 0($sp)   # get back the return address
    addi    $sp, $sp, 12  # pop from stack
    jr      $ra   # jump to the specified position


exit_heapify_for:

    li      $v0, 4          # print prompt for output array
    la      $a0, output_array
    syscall

    addi    $t0, $zero, 0  # t0 = i = 0
print_while_second:
    slti    $t1, $t0, 10   # if i < 10 then set t1 = 1
    beq     $t1, $zero, exit_print_while_second  # if t1 == 0 then exit this print loop
    sll     $t1, $t0, 2
    add     $t1, $t1, $s0
    lw      $t2, 0($t1)   # get the value of A[i]

    li      $v0, 1
    move    $a0, $t2    # print the value of A[i]
    syscall
    li      $v0, 4          # print comma
    la      $a0, comma
    syscall
    
    addi    $t0, $t0, 1
    j print_while_second

exit_print_while_second: 
    li      $v0, 4          # print newlines
    la      $a0, newline
    syscall

    li      $v0, 10         # terminate the program
    syscall