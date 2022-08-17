.globl write_matrix

.text

write_matrix:

	    addi sp sp -36
	    sw ra 0(sp)
	    sw s0 4(sp)
	    sw s1 8(sp)
	    sw s2 12(sp)
	    sw s3 16(sp)
	    sw s4 20(sp)
	    sw s5 32(sp) 


    addi s0 a0 0	# s0 = filename
    addi s1 a1 0	# s1 = address of matrix in memory	
    addi s2 a2 0 	# s2 = num of rows
    sw 	 s2 24(sp)	# storing num of rows in memory at location 24(sp)
    addi s3 a3 0	# s3 = num of cols
    sw   s3 28(sp)	# storing num of cols in memory at location 28(sp)
    mul  s4 s2 s3 	# s4 has rows*cols 

    addi a1 a0 0 	# a1 = filename for fopen
    addi a2 x0 1	# a2 = 1 for w  for fopen

    jal fopen

    addi a1 a0 0    # a1 now has file descriptor


    addi s5 a1 0    # s5 = file descriptor 
    #jal print_int

    addi a2 sp 24	# loading the address of num of rows to a2
    addi a3 x0 2	# reading 2 items from memory
	addi a4 x0 4    # each item is 4 bytes
	jal fwrite    	# write the dimension of the matrix


	addi a1 s5 0    # reset a1 

    addi a2 s1 0    # a2 has the address of the matrix				
    addi a3 s4 0 	# a3 has rows*cols
    addi a4 x0 4    # each item is 4 bytes
    jal fwrite		# write the matrix

    addi a1 s5 0
    #jal print_int
    jal fclose
    


    bne a0 x0 eof_or_error             #bug suspected here
    


    # Epilogue
	    lw ra 0(sp)
	    lw s0 4(sp)
	    lw s1 8(sp)
	    lw s2 12(sp)
	    lw s3 16(sp)
	    lw s4 20(sp)
	    lw s5 32(sp)

	    addi sp sp 36 

	    jr ra

    #ret

eof_or_error:
    li a1 1
    jal exit2
    
