.globl relu
.data
.text

relu:
    lw t2 0(a0)     	#t2 = array[i]
    blt t2 x0 zeroIsMax #if a2 == 0
    addi a0 a0 4 	    #i++
    addi a1 a1 -1 		#k--
    beq a1 x0 exitout   #if k == 0 (i.e. end of array)
    j relu

zeroIsMax: 
	sw x0 0(a0) 		#a[i] = 0
	addi a0 a0 4 		#i++
	addi a1 a1 -1 		#k--
	beq a1 x0 exitout
    j relu 				#loop back

exitout:
	jr ra

