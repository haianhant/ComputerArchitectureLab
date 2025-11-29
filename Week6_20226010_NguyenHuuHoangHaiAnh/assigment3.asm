# Lab 06, assignment 3, bubble sort - Hai Anh 20226010
.data
A:    .word  7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
Aend: .word              

.text
.globl main
main:
    la    a0, A            # a0 = &A[0]
    la    a1, Aend
    addi  a1, a1, -4       # a1 = &A[n-1]
    j     sort

after_sort:
    li    a7, 10
    ecall
end_main:

sort:	beq   a0, a1, done     
    	j     pass             
after_pass:	addi  a1, a1, -4       
    		j     sort
done:		j     after_sort

pass:	addi  t0, a0, 0        

loop:	beq   t0, a1, ret      # nếu i == a1 không còn cặp để so sánh
    	lw    t2, 0(t0)        # t2 = A[i]
    	lw    t3, 4(t0)        # t3 = A[i+1]
    	bge   t3, t2, no_swap  # nếu A[i+1] >= A[i] 
    	# swap A[i] và A[i+1]
    	sw    t3, 0(t0)
    	sw    t2, 4(t0)
no_swap:	addi  t0, t0, 4        # i++
    		j     loop
ret:	j     after_pass