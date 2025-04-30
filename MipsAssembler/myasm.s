.text
main:
    	li $a0, 5
	li $a1, 7
	jal add_number
        nop
	j exit
add_number:
	add $v0, $a0, $a1
	jr $ra
exit:
    j exit

