# This program determines whether the number entered by the user is a perfect number or not

    .globl  main

    .data

# program output text constants
first_integer:
    .asciiz "Enter a positive integer: "
is_perfect_number:
    .asciiz "Entered number is a perfect number."
is_not_perfect_number:
    .asciiz "Entered number is not a perfect number."
newline:
    .asciiz "\n"

    .text

# main program
#
# program variables
#   n:   $s0
#   sum_of_factors: $s1
#   i:   $s2
#
main:
    li      $v0, 4          # issue prompt
    la      $a0, first_integer
    syscall

    li      $v0, 5          # get n from user
    syscall
    move    $s0, $v0        # $s0 <-- n

    # do sanity check
    slti    $t0, $s0, 1     # set $t0 = 1 if n < 1
    bne     $t0, $zero, exit # exit the program if n < 1


    li      $s1, 0          # sum_of_factors = 0
    li      $s2, 1          # i = 1
for:
    ble     $s0, $s2, endf  # exit loop if n <= i
    div     $s0, $s2        # stores the remainder of n/i in $hi
    mfhi    $t0             # $t0 <-- remainder of n/i
    beq     $t0, $zero, L1  # branch to label L1 if remainder of n/i == 0
    add     $s2, $s2, 1     #     i++
    j       for             # continue loop

L1:
    add     $s1, $s1, $s2   # sum_of_factors += i
    add     $s2, $s2, 1     #     i++
    j       for             # continue loop

endf:

    bne     $s1, $s2, L2    # branch to label L2 if sum_of_factors != n

    li      $v0, 4          # print two newlines
    la      $a0, is_perfect_number
    syscall

    li      $v0, 4          # print two newlines
    la      $a0, newline
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall

    li      $v0, 10         # terminate the program
    syscall

L2:
    li      $v0, 4          # $v0 <-- 4 for printing
    la      $a0, is_not_perfect_number
    syscall

    li      $v0, 4          # $v0 <-- 4 for printing
    la      $a0, newline    # printing new line
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall

    li      $v0, 10         # terminate the program
    syscall

exit:
    li      $v0, 4          # print error message
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