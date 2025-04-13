.data
prompt1: .asciiz "Enter your roll number: "
prompt2: .asciiz "Enter your friend's roll number: "
msg1:    .asciiz "Rounded Average is: "

.text
.globl main

main:
    # Prompt for your roll number
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0       # Store your roll number in $t0

    # Prompt for friend's roll number
    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0       # Store friend's roll number in $t1

    # Set up arguments for AVERAGE
    move $a0, $t0       # Your roll number
    move $a1, $t1       # Friend's roll number
    li   $a2, 3         # Constant 3

    jal AVERAGE
    move $t2, $v0       # Save result

    # Print result message
    li $v0, 4
    la $a0, msg1
    syscall

    # Print the result
    li $v0, 1
    move $a0, $t2
    syscall

    # Exit
    li $v0, 10
    syscall

# ======== AVERAGE FUNCTION ==========
.globl AVERAGE
AVERAGE:
    # Prologue: save return address
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    # Compute (a + b + c + 1) / 3
    add $t0, $a0, $a1
    add $t0, $t0, $a2
    addi $t0, $t0, 1

    li $t1, 3
    div $t0, $t1
    mflo $v0

    # Epilogue: restore return address
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
