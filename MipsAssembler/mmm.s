# MIPS program to find min, max, sum, and average of 2, 1, 3
# Results:
#   $s0 = min
#   $s1 = max
#   $s2 = sum
#   $v0 = average

.text
main:
    li $t0, 2       # num1
    li $t1, 1       # num2
    li $t2, 3       # num3

    # Min
    move $s0, $t0       
    slt  $t3, $t1, $s0 
    beq  $t3, $zero, check_t2_min
    move $s0, $t1     

check_t2_min:
    slt  $t3, $t2, $s0  
    beq  $t3, $zero, done_min
    move $s0, $t2      

done_min:

    # Max
    move $s1, $t0       
    slt  $t3, $s1, $t1  
    beq  $t3, $zero, check_t2_max
    move $s1, $t1      

check_t2_max:
    li $t0, 2       # num1
    li $t1, 1       # num2
    li $t2, 3       # num3
    slt  $t3, $s1, $t2  
    beq  $t3, $zero, done_max
    move $s1, $t2      

done_max:
    li $t0, 2       # num1
    li $t1, 1       # num2
    li $t2, 3       # num3
    # Sum
    add	 $s2, $t0, $t1
    add	 $s2, $s2, $t2

    move $a0, $s2  
    li $a1, 3 
    jal divide       

    li $v0, 10
    syscall

divide:
    move $v1, $a0    
    li   $v0, 0      

div_loop:
    sub $v1, $v1, $a1      
    slt $a2, $v1, $zero    
    bne $a2, $zero, end_div 
    addi $v0, $v0, 1       
    j div_loop

end_div:
    jr $ra
