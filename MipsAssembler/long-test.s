addi $s0,$0,10
addi $s1,$0,20
addi $s2,$0,30
addi $s3,$0,40
addi $s4,$0,50
addi $s5,$0,100
addi $t0,$0,0
addi $s6,$0,5
L1:
sll $t1, $t0, 2
add $t1, $s5, $t1
sw $s0,0($t1)
addi $t0,$t0,1
bne $t0,$s5,L1
addi $s7,$0,20
move $a0,$s7
jal sum
add $s8,$v0,$zero
addi $t0,$0,0
L2:
sll $t1, $t0, 2
add $t1, $s5, $t1
lw $s0,0($t1)
add $s8,$s8,$s0
addi $t0,$t0,1
bne $t0,$s5,L1
j Exit
sum:
add $v0, $a0, $a0
jr $ra
Exit:
addi $0,$0,0
