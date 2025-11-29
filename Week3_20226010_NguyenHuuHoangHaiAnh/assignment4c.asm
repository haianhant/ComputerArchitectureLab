# Assignment 4c the condition is i + j <= 0
.text 
start: 	li s1, -2
	li s2, 2
        add s3, s1, s2		# s3 = i + j
	sgt   t0, s3, zero     # set t0 = 1 if i + j > 0 else clear t0 = 0 
	bne   t0, zero, else # t0 != 0 means t0 = 1, jump else    
then:   addi  t1, t1, 1         # then part: x=x+1 
	addi  t3, zero, 1       # z=1 
	j     endif             # skip “else” part 
else:   addi  t2, t2, -1        # begin else part: y=y-1 
	add   t3, t3, t3        # z=2*z 
endif:  nop