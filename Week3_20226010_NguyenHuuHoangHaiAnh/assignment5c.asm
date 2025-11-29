# Assigment 5c the condition tested at the end of the loop is A[i]!=0 
.data 
A: .word 0, 0, 0, 5, 4, 7, 8, 9, 6 
.text 
 	la s2, A
 	li s3, 4    # n
 	li s4, 1    # step
	li s1, 0    # i = 0 
	li s5, 0    # sum = 0 
loop:	bne   t0, zero, endloop # if A[i]!=0 then end loop 
   	add t1, s1, s1    # t1 = 2 * s1 
   	add t1, t1, t1    # t1 = 4 * s1 => t1 = 4*i 
   	add t1, t1, s2    # t1 store the address of A[i] 
   	lw    t0, 0(t1)   # load value of A[i] in t0 
  	add s5, s5, t0    # sum = sum + A[i] 
   	add s1, s1, s4    # i = i + step 
   	j  loop           # go to loop 
endloop: 
