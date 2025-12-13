.data
    msg_input:  .asciz "Nhap 1 ky tu: "
    msg_res:    .asciz "\n2 chu so cuoi cua ASCII la: "

.text
main:
    li a7, 4            
    la a0, msg_input
    ecall

    li a7, 12           #read char
    ecall
    
    add t0, a0, zero           

    # Tính phần dư khi chia 100 để lấy 2 chữ số cuối
    li t1, 100          
    rem a0, t0, t1      

    # vì a0 sắp bị dùng in chuỗi nên lưu vào t2
    add t2, a0, zero         

    li a7, 4
    la a0, msg_res
    ecall

    # Nếu phần dư < 10, in thêm số 0 đằng trước, ví dụ 5 thì in 05 cho đủ 2 số như yêu cầu đề
    li t3, 10
    bge t2, t3, print_num   # Nếu >= 10 thì in bình thường
    
    # Nếu < 10, in số 0 trước
    li a7, 1
    li a0, 0
    ecall

print_num:
    li a7, 1            
    add a0, t2, zero           
    ecall

    li a7, 10           # Exit
    ecall