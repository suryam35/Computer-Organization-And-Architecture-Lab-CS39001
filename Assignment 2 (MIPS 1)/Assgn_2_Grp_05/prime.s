# This program determines whether the entered number by the user is prime or composite

    .globl  main

    .data

# program output text constants
first_integer:
    .asciiz "Enter a positive integer greater than equals to 10: "
prime:
    .asciiz "Entered number is a PRIME number."
composite:
    .asciiz "Entered number is a COMPOSITE number."
error:
    .asciiz "EXIT! The entered number is less than 10."
newline:
    .asciiz "\n"

    .text

# main program
#
# program variables
#   n:   $s0
#   count_of_factors: $s1
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
    slti    $t0, $s0, 10    # if n < 10 then make $t0 = 1
    bne     $t0, $zero, exit # branch to label exit if $t0 != 0 i.e n < 10


    li      $s1, 0          # count_of_factors = 0
    li      $s2, 1          # i = 1
for:
    blt     $s0, $s2, endf  # exit loop if n < i
    div     $s0, $s2        # stores the remainder of n/i in $hi
    mfhi    $t0             # $t0 <-- remainder of n/i
    beq     $t0, $zero, L1  # branch to label L1 if remainder of n/i == 0
    add     $s2, $s2, 1     #     i++
    j       for             # continue loop

L1:
    addi    $s1, $s1, 1     # count_of_factors++
    add     $s2, $s2, 1     #     i++
    j       for             # continue loop

endf:

    slti    $t0, $s1, 3     # set $t0 = 1 if count_of_factors < 3
    bne     $t0, $zero, L2  # branch to label L2 if count_of_factors < 3

    li      $v0, 4          # $v0 <-- 4 for printing
    la      $a0, composite  # pritning that the number is composite
    syscall

    li      $v0, 4          # $v0 <-- 4 for printing
    la      $a0, newline    # printning new line
    syscall
    li      $v0, 4          # $v0 <-- 4 for printing
    la      $a0, newline    # printning new line
    syscall

    li      $v0, 10         # terminate the program
    syscall

L2:
    li      $v0, 4          # $v0 <-- 4 for printing
    la      $a0, prime      # pritning that the number is prime
    syscall

    li      $v0, 4          # $v0 <-- 4 for printing
    la      $a0, newline    # printning new line
    syscall
    li      $v0, 4          # $v0 <-- 4 for printing
    la      $a0, newline    # printning new line
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