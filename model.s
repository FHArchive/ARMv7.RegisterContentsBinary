	.global	_start		@ start
_start:	mov	r0,#0b0

@ looks like the length of the word needs passing in as the program prints 0

	



	bl	v_bin		@ go to subroutine 
	mov	r0,#0		@ terminate
	mov	r7,#1
	svc	0

