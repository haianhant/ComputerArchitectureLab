# HƯỚNG DẪN SỬ DỤNG BÀI CỦA HẢI ANH 20226010
# ĐỂ RA HÌNH CHỮ NHẬT ĐÚNG
# Cấu hình trên bitmap
# Unit Width in Pixels: 8
# Unit Height in Pixels: 8
# Display Width in Pixels: 256
# Display Height in Pixels: 256
# Base address 0x10010000 (static data)

.eqv MONITOR_SCREEN 0x10010000  # Start address of the bitmap display 
.eqv RED            0x00FF0000  # Mã màu Đỏ
.eqv GREEN          0x0000FF00  # Mã màu Xanh lá
.eqv WIDTH          32          # WIDTH: 256 / 8 = 32 ô ngang

.data
    msg_x1: .asciz "Nhap x1: "
    msg_y1: .asciz "Nhap y1: "
    msg_x2: .asciz "Nhap x2: "
    msg_y2: .asciz "Nhap y2: "
    msg_err: .asciz "Error: x1 phai khac x2 va y1 phai khac y2! Vui long nhap lai.\n"

.text
main:
input_loop:
    # NHẬP TỌA ĐỘ
    # x1
    li a7, 4
    la a0, msg_x1
    ecall
    li a7, 5
    ecall
    add s1, a0, zero          # s1 = x1

    # Nhập y1
    li a7, 4
    la a0, msg_y1
    ecall
    li a7, 5
    ecall
    add s2, a0, zero          # s2 = y1

    # x2
    li a7, 4
    la a0, msg_x2
    ecall
    li a7, 5
    ecall
    add s3, a0, zero           # s3 = x2

    # y2
    li a7, 4
    la a0, msg_y2
    ecall
    li a7, 5
    ecall
    add s4, a0, zero           # s4 = y2

    # KIỂM TRA HỢP LỆ 
    beq s1, s3, input_error
    beq s2, s4, input_error
    
    # Kiểm tra tràn màn hình (x, y phải < 32)
    li t0, 32
    bge s1, t0, input_error
    bge s3, t0, input_error
    bge s2, t0, input_error
    bge s4, t0, input_error

    j find_min_max

input_error:
    li a7, 4
    la a0, msg_err
    ecall
    j input_loop

    # TÌM, Xác định 4 góc
find_min_max:
    # Xử lý X
    blt s1, s3, set_x_normal
    add s5, s3, zero           # min_x
    add s6, s1, zero          # max_x
    j check_y
set_x_normal:
    add s5, s1, zero
    add s6, s3, zero

check_y:
    # Xử lý Y
    blt s2, s4, set_y_normal
    add s7, s4, zero          # min_y
    add s8, s2, zero           # max_y
    j start_draw
set_y_normal:
    add s7, s2, zero
    add s8, s4, zero

    # VẼ HÌNH 
start_draw:
    add t0, s7, zero           # t0 = y (chạy từ min_y den max_y)

loop_y:
    bgt t0, s8, exit    # Nếu y > max_y thì dừng

    add t1, s5, zero           # t1 = x (chạy từ min_x toi max_x)

loop_x:
    bgt t1, s6, next_line # Nếu x > max_x thì xuống dòng

    # TÍNH ĐỊA CHỈ MEMORY
    # Address = Base + (y * WIDTH + x) * 4
    # WIDTH ở đây là 32
    li t2, WIDTH        # t2 = 32
    mul t3, t0, t2      # t3 = y * 32
    add t3, t3, t1      # t3 = y * 32 + x
    slli t3, t3, 2      # t3 = Index * 4 
    
    li t4, MONITOR_SCREEN
    add t4, t4, t3      # t4 = Địa chỉ tuyệt đối

    # XÁC ĐỊNH MÀU 
    # Viền khi: x == min_x HOẶC x == max_x HOẶC y == min_y HOẶC y == max_y
    beq t1, s5, draw_border
    beq t1, s6, draw_border
    beq t0, s7, draw_border
    beq t0, s8, draw_border

    # Nếu không phải viền, Nền (Xanh)
    li t5, GREEN
    j store_pixel

draw_border:
    li t5, RED          # Viền (Đỏ)

store_pixel:
    sw t5, 0(t4)        # Ghi màu vào RAM

    addi t1, t1, 1      # x++
    j loop_x

next_line:
    addi t0, t0, 1      # y++
    j loop_y

exit:
    li a7, 10
    ecall
