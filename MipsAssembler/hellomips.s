.data
message: .asciiz "Hello, MIPS!"

    .text
main:
    li $v0, 4
    la $a0, message
    syscall

    jal function

    li $v0, 4
    la $a0, message
    syscall

    li $v0, 10
    syscall

function:
    li $v0, 4
    la $a0, message
    syscall

    jr $ra