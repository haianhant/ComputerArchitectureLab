# Laboratory Exercise 4, Assignment 2 
.text 
	li	s0, 0x12345678 # Test value 
	# Extract MSB of s0 to t0
	srli  	t0, s0, 24   
	# clear LSB of s0 to s1
	li   	t1, 0xFFFFFF00
	and  	s1, s0, t1 
	# set LSB (bits 7 to 0 are set to 1)
	ori  	s2, s0, 0xFF
	# clear s0
	and 	s0, s0, zero
	
