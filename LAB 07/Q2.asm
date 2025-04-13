.data
prompt1: .asciiz "Enter the base number (sum of roll number digits): "
prompt2: .asciiz "Enter the exponent (0–9): "
resultMsg: .asciiz "Result is: "

.text
.globl main

main:
    # Prompt and read base number
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0   # store base (num) in $t0

    # Prompt and read exponent
    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0   # store exponent (pow) in $t1

    # Set up arguments for POWER
    move $a0, $t0   # num -> $a0
    move $a1, $t1   # pow -> $a1

    jal POWER       # call POWER(num, pow)
    move $t2, $v0   # get result in $t2

    # Print result message
    li $v0, 4
    la $a0, resultMsg
    syscall

    # Print the result
    li $v0, 1
    move $a0, $t2
    syscall

    # Exit
    li $v0, 10
    syscall


# ===========================
# FUNCTION: POWER(num, pow)
# INPUT: $a0 = num (base)
#        $a1 = pow (exponent)
# OUTPUT: $v0 = num^pow
# ===========================

.globl POWER
POWER:
    # Prologue
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $s0, 0($sp)

    li $s0, 1          # result = 1
    move $t0, $a1      # t0 = exponent (counter)

    beqz $t0, power_done   # if exponent is 0, skip loop

power_loop:
    mul $s0, $s0, $a0       # result *= base
    addi $t0, $t0, -1       # exponent--
    bgtz $t0, power_loop

power_done:
    move $v0, $s0           # return result in $v0

    # Epilogue
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
