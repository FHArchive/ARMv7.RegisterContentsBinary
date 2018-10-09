.global v_bin
@	subroutine will display a 32 bit reg in bin 
@		r0 - number to be displayed in bin 
@		r2 - no. bits to displayed (from lhs - most significant bit )
@		lr - contains return address 
@		all reg. contents preserved

v_bin:	push	{r0-r7}		@ write r0 to r7 to stack 
	@sub	r6,r2,#1	@ r6 = r2 - 1
	@cmp	r6,#31		@ cspr = r6 - 31
	@movhi 	r6,#0		@ if r6 > 31
	mov 	r6,#31		@ output all bin values 
	mov 	r3,r0		@ create copy of input word 
	mov 	r4,#1		@ mov 1 into r4 will be used as mask bit 
	

	@ print pre
	ldr 	r1,=pre		@ ;
	mov	r2,#2		@ num chars to display 
	mov 	r0,#1		@ code for stdout 
	mov	r7,#4		@ linux cmd to write string 
	svc	0		@ run svc command


	ldr 	r5,=dig		@ load location of string into r5
	mov	r2,#1		@ num chars to display 
	mov 	r0,#1		@ code for stdout 
	mov	r7,#4		@ linux cmd to write string 

@ 	loop through leading 0s and do nothing with them 

dscrd:	subs	r6,#1		@ move to the next bit
	@bxlt	lr		@ end the program if no more bits remain (works for bit pattern 0)
	and	r1,r4,r3,lsr r6	@ select the current bit
	cmp	r6,#0		@ which bit am i looking at? if its bit 0 
	beq	nxtbit		@ then goto nextbit
	cmp	r1,#0		@ compare it to 0
	@sub	r6,#1		@ move to the next bit 
	beq	dscrd		@ if the bit was 0 do this again





@	loop through bits in word and output these as a string 

nxtbit:	and	r1,r4,r3,lsr r6	@ r1 = r4 && (lsr(r3, r6)
	add	r1,r5		@ set pointer to "0" or "1"
	svc	0		@ run svc command - print string - prints always 
	subs	r6,#1		@ decrement number of bits to be displayed by 1
	bge	nxtbit		@ branch to nxtbit tag if r6 >= 0 (rhs = 0) 

	pop	{r0-r7}		@ read from memory when finished
	bx	lr		@ return to calling program 

	.data
pre:	.ascii	"0b"
dig:	.ascii	"01"
	.end
