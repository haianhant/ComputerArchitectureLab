.data
    array:      .space 400          # Dành 400 bytes cho tối đa 100 phần tử
    msg_n:      .asciz "Nhap so luong phan tu N (0 < N <= 100): "
    msg_err:    .asciz "N khong hop le! Nhap lai.\n"
    msg_elem:   .asciz "Nhap phan tu: "
    msg_neg:    .asciz "Tong cac so am: "
    msg_pos:    .asciz "\nTong cac so duong: "

.text

main:
    # NHẬP N VÀ KIỂM TRA 
input_n_loop:
    li a7, 4
    la a0, msg_n
    ecall

    li a7, 5
    ecall
    add s1, a0, zero  # Lưu N vào s1

    # Kiểm tra N <= 0
    ble s1, zero, invalid_n
    # Kiểm tra N > 100
    li t0, 100
    bgt s1, t0, invalid_n
    
    j input_array_prep      # N hợp lệ, sang bước nhập mảng

invalid_n:
    li a7, 4
    la a0, msg_err
    ecall
    j input_n_loop          # Quay lại nhập N

    # NHẬP MẢNG
input_array_prep:
    la s2, array            # s2 = Base Address
    li t0, 0                # i = 0

input_loop:
    bge t0, s1, calc_prep   # Nếu i >= N thì chuyển sang bước tính toán

    # In nhắc nhập
    li a7, 4
    la a0, msg_elem
    ecall

    # Nhập số nguyên
    li a7, 5
    ecall

    # Lưu vào mảng
    slli t1, t0, 2          # Offset = i * 4
    add t1, s2, t1          # Address = Base + Offset
    sw a0, 0(t1)            # Store vào bộ nhớ

    addi t0, t0, 1          # i++
    j input_loop

    # TÍNH TỔNG ÂM VÀ DƯƠNG 
calc_prep:
    li t0, 0                # Reset i = 0
    li s3, 0                # s3 = Tổng Âm (sum_neg)
    li s4, 0                # s4 = Tổng Dương (sum_pos)

calc_loop:
    bge t0, s1, print_res   # Nếu i >= N thì in kết quả

    # Lấy A[i] từ bộ nhớ
    slli t1, t0, 2	    # Offset = i * 4
    add t1, s2, t1	    # Address = Base + Offset
    lw t2, 0(t1)            # t2 = A[i]

    # Phân loại số
    blt t2, zero, add_neg        # Nếu t2 < 0 Nhảy đến cộng âm
    bgt t2, zero, add_pos        # Nếu t2 > 0 Nhảy đến cộng dương
    j next_iter             # Nếu t2 == 0 Bỏ qua

add_neg:
    add s3, s3, t2          # sum_neg += A[i]
    j next_iter

add_pos:
    add s4, s4, t2          # sum_pos += A[i]
    j next_iter

next_iter:
    addi t0, t0, 1          # i++
    j calc_loop

    # IN KẾT QUẢ 
print_res:
    # In tổng âm
    li a7, 4
    la a0, msg_neg
    ecall

    li a7, 1
    add a0, s3, zero               # In giá trị s3
    ecall

    # In tổng dương
    li a7, 4
    la a0, msg_pos
    ecall

    li a7, 1
    add a0, s4, zero              # In giá trị s4
    ecall

    # Kết thúc
    li a7, 10
    ecall
