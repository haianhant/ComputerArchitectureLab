.data
string:   .space 21
reverse:  .space 21
message1: .asciz "Enter a string (<= 20 characters): "
message2: .asciz "Reverse string: "

.text
get_string:
    li a7, 54           
    la a0, message1
    la a1, string
    li a2, 21           
    ecall

get_length:
    la a0, string      
    li t0, 0            # t0 = length = 0
check_char:
    add t1, a0, t0      # t1 = địa chỉ của string[length]
    lb t2, 0(t1)        # t2 = ký tự string[length]
    beq t2, zero, reverse_string # Nếu là null, kết thúc đếm và bắt đầu đảo ngược
    addi t0, t0, 1      # length++
    j check_char

reverse_string:
    # t0 chứa độ dài chuỗi L
    la s0, string       # s0 = con trỏ đến chuỗi gốc
    la s1, reverse      # s1 = con trỏ đến chuỗi ngược
    li t1, 0            # t1 = i = 0 (chỉ số cho chuỗi gốc)
    addi t2, t0, -1     # t2 = j = L-1 (chỉ số cho chuỗi ngược)

reverse_loop:
    # Đọc ký tự từ string[i]
    add t3, s0, t1      # t3 = địa chỉ string[i]
    lb t4, 0(t3)        # t4 = giá trị string[i]

    # Ghi ký tự vào reverse[j]
    add t5, s1, t2      # t5 = địa chỉ reverse[j]
    sb t4, 0(t5)        # reverse[j] = string[i]

    # Cập nhật chỉ số
    addi t1, t1, 1      # i++
    addi t2, t2, -1     # j--
    
    # Kiểm tra điều kiện dừng (khi i >= L)
    blt t1, t0, reverse_loop # Nếu i < L thì lặp lại

    # Thêm ký tự null vào cuối chuỗi reverse
    add t3, s1, t0      # t3 = địa chỉ reverse[L]
    sb zero, 0(t3)      # Ghi null vào cuối chuỗi

print_reverse:
    # Sử dụng ecall 59 để hiển thị chuỗi trong dialog
    li a7, 59           
    la a0, message2     # Chuỗi thông báo
    la a1, reverse      # Địa chỉ chuỗi ngược
    ecall

exit_program:
    li a7, 10           # ecall 10: exit
    ecall