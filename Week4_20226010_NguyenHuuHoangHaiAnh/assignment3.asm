# Laboratory Exercise 4, Assignment 3 
.text 
	li	s1, -7
	# Question a: s0 = abs(s1)
	srai t0, s1, 31          
	xor  s0, s1, t0          
	sub  s0, s0, t0 
	# Question b: s0 = s1
	slli s0, s1, 0
	# Question c: s0 = bit invert (s0)
	xori s0, s0, 0xffffffff
	#Question d
	bge  s2, s1, label
	label:
	
	
	