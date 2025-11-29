# Laboratory Exercise 4, Assignment 4 
.text
    li  s1, 0x7FFFFFFF
    li  s2, 1
    add s3, s1, s2

    xor t1, s1, s3          # t1 = s1 xor s3 xem có khác dấu kết quả không
    xor t2, s1, s2          # t2 = s1 xor s2 xem 2 số hạng cần tính tổng có khác dấu không
    xori t2, t2, 0xffffffff         # cùng dấu thì bit31=1 sau and
    and t1, t1, t2          # cùng dấu và kết quả khác dấu
    srai t0, t1, 31         # t0 = 0xFFFFFFFF hoặc 0x00000000
    andi t0, t0, 1          # t0 = 1 hoặc 0


