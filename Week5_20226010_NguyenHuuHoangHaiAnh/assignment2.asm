# Laboratory Exercise 5, Assignment 2
.data
str1: .asciz "The sum of "
str2: .asciz " and "
str3: .asciz " is "

.text
    li s0, 5
    li s1, 10
    # In phần chuỗi đầu tiên
    li a7, 4           
    la a0, str1        
    ecall
    # In giá trị của s0
    li a7, 1           
    add a0, s0, zero          
    ecall
    # In phần chuỗi thứ hai
    li a7, 4
    la a0, str2
    ecall
    # In giá trị của s1
    li a7, 1
    add a0, s1, zero          
    ecall
    # In phần chuỗi thứ ba
    li a7, 4
    la a0, str3
    ecall
    # Tính và in kết quả
    add t0, s0, s1
    li a7, 1
    add a0, t0, zero          
    ecall
    # Kết thúc chương trình
    li a7, 10          # exit
    ecall