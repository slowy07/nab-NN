#define c_print_int 1
#define c_print_str 4
#define c_atoi 5
#define c_sbrk 9
#define c_exit 10
#define c_print_char 11
#define c_openFile 13
#define c_readFile 14
#define c_writeFile 15
#define c_closeFile 16
#define c_exit2 17
#define c_fflush 18
#define c_feof 19
#define c_ferror 20
#define c_printHex 34


.globl print_int, print_str, atoi, sbrk, exit, print_char, fopen, fread, fwrite, fclose, exit2, fflush, ferror, print_hex


.globl file_error, print_int_array, malloc

.data
error_string: .string "This library file should not be directly called!"

.text

main:
    la a1 error_string
    jal print_str
    li a1 1
    jal exit2

print_int:
    li a0 c_print_int
    ecall
    jr ra

print_str:
    li a0 c_print_str
    ecall
    jr ra
atoi:
    li a0 c_atoi
    ecall
    jr ra

sbrk:
    li a0 c_sbrk
    ecall
    jr ra


exit:
    li a0 c_exit
    ecall


print_char:
    li a0 c_print_char
    ecall
    jr ra

fopen:
    li a0 c_openFile
    ecall
    jr ra

fread:
    li a0 c_readFile
    ecall
    jr ra

fwrite:
    li a0 c_writeFile
    ecall
    jr ra

fclose:
    li a0 c_closeFile
    ecall
    jr ra



exit2:
    li a0 c_exit2
    ecall
    jr ra

fflush:
    li a0 c_fflush
    ecall
    jr ra


ferror:
    li a0 c_ferror
    ecall
    jr ra

print_hex:
    li a0 c_printHex
    ecall
    jr ra

malloc:
    # Call to sbrk
    mv a1 a0
    addi a0 x0 9
    ecall
    jr ra
    
print_int_array:
    # Prologue
    addi sp sp -24
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw ra 20(sp)

    # Save arguments
    mv s0 a0
    mv s1 a1
    mv s2 a2

    # Set outer loop index
    li s3 0

outer_loop_start:
    # Check outer loop condition
    beq s3 s1 outer_loop_end

    # Set inner loop index
    li s4 0

inner_loop_start:
    # Check inner loop condition
    beq s4 s2 inner_loop_end

    # t0 = row index * len(row) + column index
    mul t0 s2 s3 
    add t0 t0 s4 
    slli t0 t0 2

    # Load matrix element
    add t0 t0 s0
    lw t1 0(t0)

    # Print matrix element
    mv a1 t1
    jal print_int

    # Print whitespace
    li a1 ' '
    jal print_char
    

    addi s4 s4 1
    j inner_loop_start

inner_loop_end:
    # Print newline
    li a1 '\n'
    jal print_char

    addi s3 s3 1
    j outer_loop_start

outer_loop_end:
    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw ra 20(sp)
    addi sp sp 24

    jr ra
