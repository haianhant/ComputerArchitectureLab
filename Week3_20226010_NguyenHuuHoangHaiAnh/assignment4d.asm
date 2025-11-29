# Assignment 4d the condition is i + j > m + n
.text 
start: 	li s1, 7   	# i
	li s2, 8    	# j
	li s3, 4	# m
	li s4, 5	# n
        add s5, s1, s2 	# s5 = i + j
        add s6, s3, s4  # s6 = m + n
        
	sgt   t0, s5, s6     # set t0 = 1 if i + j > m + n else clear t0 = 0 
	beq   t0, zero, else # t0 = 0 means the condition is wrong, jump else    
then:   addi  t1, t1, 1         # then part: x=x+1 
	addi  t3, zero, 1       # z=1 
	j     endif             # skip “else” part 
else:   addi  t2, t2, -1        # begin else part: y=y-1 
	add   t3, t3, t3        # z=2*z 
endif:  nop
