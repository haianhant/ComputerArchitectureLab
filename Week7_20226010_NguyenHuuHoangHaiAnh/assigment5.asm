# Laboratory Exercise 7, Assignment 5
.text
main:
    li a0,  7
    li a1, -2
    li a2,  5
    li a3,  9
    li a4,  5
    li a5,  6
    li a6, -3
    li a7,  3

    addi sp, sp, -32
    sw a0,  0(sp)
    sw a1,  4(sp)
    sw a2,  8(sp)
    sw a3, 12(sp)
    sw a4, 16(sp)
    sw a5, 20(sp)
    sw a6, 24(sp)
    sw a7, 28(sp)

    add  a0, sp, x0      # a0 = &array[0] in stack
    li   a1, 8           # a1 = number of elements
    jal  minmax8

after_minmax8:

    addi sp, sp, 32      # pop the temporary 8-word array

    li a7, 10
    ecall
minmax8:
    addi sp, sp, -20
    sw   ra, 16(sp)
    sw   s0, 12(sp)
    sw   s1,  8(sp)
    sw   s2,  4(sp)
    sw   s3,  0(sp)

    add  s0, a0, x0      # s0 = base pointer
    add  s2, a1, x0      # s2 = length N
    lw   s1, 0(s0)       # s1 = arr[0]

    add  a0, s1, x0      # a0 = max value
    add  a2, s1, x0      # a2 = min value
    li   a1, 0           # a1 = index of max
    li   a3, 0           # a3 = index of min

    li   s3, 1           # s3 = i = 1 (start from second element)

mm_loop:
    bge  s3, s2, mm_done
    slli t1, s3, 2       # t1 = i * 4
    add  t1, s0, t1      # t1 = &arr[i]
    lw   t2, 0(t1)       # t2 = arr[i]

    sub  t3, t2, a0      # t3 = arr[i] - max
    ble  t3, x0, check_min
    add  a0, t2, x0      # new max
    add  a1, s3, x0      # new idx_max = i

check_min:
    sub  t3, t2, a2      # t3 = arr[i] - min
    bge  t3, x0, mm_next
    add  a2, t2, x0      # new min
    add  a3, s3, x0      # new idx_min = i

mm_next:
    addi s3, s3, 1       # i++
    j    mm_loop

mm_done:
    lw   s3,  0(sp)
    lw   s2,  4(sp)
    lw   s1,  8(sp)
    lw   s0, 12(sp)
    lw   ra, 16(sp)
    addi sp, sp, 20
    jr   ra
