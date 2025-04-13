.data
msg1: .asciiz "Enter a number: "
msg2: .asciiz "Factorial is: "

.text
main:
	li $v0,4 
	la $a0,msg1
	syscall

	li $v0,5 
	syscall 
	move $t0,$v0 

	add $a0,$0,$t0 
	jal FACT

	add $t1,$0,$v0 

	li $v0,4
	la $a0,msg2
	syscall

	li $v0,1 
	move $a0,$t1
	syscall

	li $v0, 10 
	syscall

.globl FACT
.ent FACT
FACT:
	addi $sp,$sp, -8 
	sw $ra, 4($sp) 
	sw $a0, 0($sp)

	slti $t0, $a0, 1 
	beq $t0, $0, L1 

	li $v0, 1 
	addi $sp, $sp, 8 
	jr $ra

L1:
	addi $a0, $a0, -1 
	jal FACT 

	lw $a0, 0($sp)
	lw $ra, 4($sp) 
	addi $sp, $sp, 8 
	mul $v0, $a0, $v0 
	jr $ra
