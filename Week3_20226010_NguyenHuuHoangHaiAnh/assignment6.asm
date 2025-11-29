# Assigment 6
.data 
A: .word 0, 1, 2, 5, 10, 7, 8, 9, 6 
.text 
 	la s2, A
 	li s3, 9    # n
	li s1, 1    # i = 1 
	lw s5, 0(s2)    # max = A[0]
loop:	slt   t0, s1, s3  # if i < n, t0 = 1
	beq   t0, zero, endloop # if the condition i<n is wrong then end loop 
   	add t1, s1, s1    # t1 = 2 * s1 
   	add t1, t1, t1    # t1 = 4 * s1 => t1 = 4*i 
   	add t1, t1, s2    # t1 store the address of A[i] 
   	lw    t0, 0(t1)   # load value of A[i] in t0 
  	sgt t2, t0, s5 	  # if A[i] > max t2 = 1
  	beq t2, zero, else
then:	addi s5, t0, 0    # max = A[i]
else: 
   	addi s1, s1, 1    # i = i + 1
   	j  loop           # go to loop 
endloop: 