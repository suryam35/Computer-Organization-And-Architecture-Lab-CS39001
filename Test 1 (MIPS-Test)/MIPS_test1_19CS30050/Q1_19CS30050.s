# Question : 2
# Semester : 5
# Roll No.: 19CS30050
# Name: Suryam Arnav Kalra

# Question 1 of the test

    .globl  main

    .data

# program output text constants
input_string:
    .space 200
shift:
    .asciiz "Enter the value of shift: "
text:
    .asciiz "Enter the string: "
second_text:
    .asciiz "Enter E (for encryption) and D (for decryption): "
output_text:
    .asciiz "Text: "
cipher_text:
    .asciiz "Converted Text: "
newline:
    .asciiz "\n"

    .text

# main program
#
# program variables
#   shift_value : $s0
#
main:
    li      $v0, 4
    la      $a0, text   # prompt to get the input string
    syscall

    li      $v0, 8
    la      $a0, input_string  # get the input string from the user
    li      $a1, 50
    syscall

    addi    $t0, $zero, 0   # set i = 0

ToUpper:
    
    lbu     $t1, input_string($t0)   # load the byte present at input_string[t0]
    beq     $t1, $zero, exitToUpper   # if it is the null character then exit this function
    ble     $t1, 'Z', case   # if it is already in uppercase skip this character

    addi    $t1, $t1, -32  # convert to lowercase
    sb      $t1, input_string($t0)  # store it back in the input string

case:
    addi    $t0, $t0, 1   # increment i to i + 1
    j ToUpper

exitToUpper:

    li      $v0, 4
    la      $a0, output_text   # print prompt to print the output
    syscall

    li      $v0, 4
    la      $a0, input_string   # print the input string which is converted to uppercase
    syscall

    li      $v0, 4
    la      $a0, shift   # get the shift value
    syscall

    li      $v0, 5          # get number from user
    syscall
    move    $s0, $v0

    li      $t5, 26   # store the shift value mod 26
    div     $s0, $t5
    mfhi    $s0

    li      $v0, 4
    la      $a0, second_text  # get the character for encryption or decryption
    syscall

    li      $v0, 12          # get character from user
    syscall
    move    $s1, $v0

    li      $v0, 4
    la      $a0, newline
    syscall

    addi    $t0, $zero, 0   # set i = 0
    beq     $s1, 'E', encrypt   # go to encrypt if character was 'E'


decrypt:
    lbu     $t1, input_string($t0)
    beq     $t1, 10, exit   # if it is a new line character then exit this function

    addi    $t1, $t1, -65   # add -65 to get the values from 0 to 25
    sub     $t1, $t1, $s0   # do x = x - n
    li      $t3, 26  
    addi    $t1, $t1, 26   # do x = x + 26 = x - n + 26
    div     $t1, $t3   # do x = x % 26
    mfhi    $t1
    addi    $t1, $t1, 65   # do x = x + 65
    sb      $t1, input_string($t0)  # store the character back

    addi    $t0, $t0, 1  # increment i to i + 1
    j decrypt  

encrypt:

    lbu     $t1, input_string($t0)
    beq     $t1, 10, exit # if it is a new line character then exit this function

    addi    $t1, $t1, -65  # add -65 to get the values from 0 to 25
    add     $t1, $t1, $s0  # do x = x + n
    li      $t3, 26
    div     $t1, $t3
    mfhi    $t1            # do x = x % 26
    addi    $t1, $t1, 65   # do x = x + 65
    sb      $t1, input_string($t0)   # store the character back

    addi    $t0, $t0, 1  # increment i to i + 1
    j encrypt


exit:

    li      $v0, 4
    la      $a0, cipher_text   # print prompt for the output text
    syscall

    li      $v0, 4
    la      $a0, input_string   # print the input string in the cipher form
    syscall

    li      $v0, 4
    la      $a0, newline
    syscall

    li      $v0, 10         # terminate the program
    syscall

