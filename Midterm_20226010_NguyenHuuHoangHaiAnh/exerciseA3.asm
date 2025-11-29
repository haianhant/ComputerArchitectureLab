.data
    msg_m:      .asciz "Nhap so M (M>0): "
    msg_n:      .asciz "Nhap so N (N>=M): "
    msg_err:    .asciz "Gia tri khong hop le!\n"
    msg_result: .asciz "Cac so nguyen to la: "
    space:      .asciz " "

.text

main:
# NHẬP M
input_m:
    # In chuỗi "Nhap so M: "
    li a7, 4            # Syscall 4: Print String
    la a0, msg_m
    ecall

    # Đọc số nguyên M
    li a7, 5            # Syscall 5: Read Integer
    ecall
    add s1, a0, zero    # Lưu M vào s1 (biến đếm hiện tại)
    
    # Kiểm tra M > 0
    ble s1, zero error_m
    j input_n

error_m:
    li a7, 4
    la a0, msg_err
    ecall
    j input_m

# NHẬP N
input_n:
    # In chuỗi "Nhap so N: "
    li a7, 4
    la a0, msg_n
    ecall

    # Đọc số nguyên N
    li a7, 5
    ecall
    add s2, a0, zero           # Lưu N vào s2 (giới hạn)
    
    # Kiểm tra N >= M
    blt s2, s1, error_n
    j start_process

error_n:
    li a7, 4
    la a0, msg_err
    ecall
    j input_n
    
start_process:
    # IN THÔNG BÁO KẾT QUẢ 
    li a7, 4
    la a0, msg_result
    ecall

    # VÒNG LẶP TỪ M ĐẾN N 
loop_range:
    bgt s1, s2, end_main    # Nếu s1 (cur) > s2 (N) thì thoát vòng lặp

    # Chuẩn bị tham số gọi hàm
    add a0, s1, zero              # Đưa số cần kiểm tra (s1) vào a0
    jal check_prime               # Gọi hàm check_prime

    # Kiểm tra kết quả trả về trong a0
    beq a0, zero, next_iter # Nếu a0 == 0 (hợp số) thì bỏ qua bước in

    # --- IN SỐ NGUYÊN TỐ ---
    li a7, 1            # Syscall 1: Print Int
    add a0, s1, zero          # Lấy số s1 để in
    ecall

    # In dấu cách
    li a7, 4
    la a0, space
    ecall

next_iter:
    addi s1, s1, 1      # Tăng biến đếm M lên 1
    j loop_range        # Quay lại vòng lặp

end_main:
    # Kết thúc chương trình
    li a7, 10           # Syscall 10: Exit
    ecall

# ---------------------------------------------------
# fct: check_prime
# input pram: a0 (số n)
# output: a0 (1 nếu là số nguyên tố, 0 nếu là hợp số)
# ---------------------------------------------------
check_prime:
    # Kiểm tra điều kiện cơ bản: n < 2
    li t0, 2 # biến chạy từ 2
    blt a0, t0, is_not_prime # Nếu n < 2, Không phải NT


loop_check:
    # Tính i*i (t1 = t0 * t0)
    mul t1, t0, t0
    
    # Nếu i*i > n thì đã kiểm tra xong. Là số NT
    bgt t1, a0, is_prime

    # Kiểm tra n % i == 0 ?
    rem t2, a0, t0      # t2 = n % i
    beq t2, zero, is_not_prime # Nếu chia hết -> Không phải NT

    addi t0, t0, 1      # i++
    j loop_check

is_not_prime:
    li a0, 0            # Return 0
    jr ra               

is_prime:
    li a0, 1            # Return 1
    jr ra                
