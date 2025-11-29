# Assignment 4a the condition is i < j
.text 
start: 	li s1, 2
	li s2, 3

	slt   t0, s1, s2     # set t0 = 1 if i < j else clear t0 = 0 
	beq   t0, zero, else # t0 = 0 means i >= j, jump else    
then:   addi  t1, t1, 1         # then part: x=x+1 
	addi  t3, zero, 1       # z=1 
	j     endif             # skip “else” part 
else:   addi  t2, t2, -1        # begin else part: y=y-1 
	add   t3, t3, t3        # z=2*z 
endif:  nop