# Lab 06, assignment 4, insertion sort - Hai Anh 20226010
.data
A:    .word  7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
Aend: .word

.text
.globl main
main:
    la    a0, A		# a0 = &A[0]
    la    a1, Aend
    addi  a1, a1, -4    # a1 = &A[n-1]
    j     sort

after_sort:
    li    a7, 10
    ecall
end_main:

sort:	addi  s0, a0, 4           
sort_loop:	blt   a1, s0, done        
    		j     insert              # chèn A[i] (ở s0) vào đoạn đã sắp 
after_insert:	addi  s0, s0, 4           # i++
    		j     sort_loop
done:		j     after_sort

insert:		lw    s1, 0(s0)           # s1 = A[i]
    		addi  t0, s0, -4          

shift_loop:	blt   t0, a0, place_key   # đặt key tại &A[0]
    		lw    t1, 0(t0)           # t1 = A[j]
    		bge   s1, t1, place_key   # ừng dồn, đặt key tại j+1
    		sw    t1, 4(t0)           # dồn A[j] sang phải A[j+1] = A[j]
    		addi  t0, t0, -4          # j--
    		j     shift_loop

place_key:	sw    s1, 4(t0)           # đặt key vào vị trí j+1
    		j     after_insert
