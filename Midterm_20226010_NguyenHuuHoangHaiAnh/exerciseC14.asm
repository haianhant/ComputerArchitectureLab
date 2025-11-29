.data
    # Bộ nhớ cho 2 chuỗi nhập vào (tối đa 100 ký tự)
    strA:       .space 100
    strB:       .space 100
    
    # Mảng đánh dấu (Map) cho bảng mã ASCII (128 ký tự)
    # map[65] là 'A', map[66] là 'B',...
    ascii_map:  .space 128  

    # Các chuỗi thông báo
    msg_a:      .asciz "Nhap chuoi A: "
    msg_b:      .asciz "Nhap chuoi B: "
    msg_res:    .asciz "Ky tu in hoa chung: "
    newline:    .asciz "\n"

.text

main:
    # NHẬP CHUỖI A 
    li a7, 4
    la a0, msg_a
    ecall

    li a7, 8            # Syscall 8: Read String
    la a0, strA         # Địa chỉ bộ đệm
    li a1, 100          # Độ dài tối đa
    ecall

    # NHẬP CHUỖI B 
    li a7, 4
    la a0, msg_b
    ecall

    li a7, 8
    la a0, strB
    li a1, 100
    ecall

    # XỬ LÝ CHUỖI A (ĐÁNH DẤU) 
    la s1, strA         # s1 trỏ tới đầu chuỗi A
    la s2, ascii_map    # s2 trỏ tới mảng đánh dấu

process_A_loop:
    lb t1, 0(s1)        # Lấy ký tự hiện tại từ strA
    
    # Kiểm tra kết thúc chuỗi (gặp null 0 hoặc xuống dòng 10)
    beq t1, zero, start_process_B
    li t2, 10           # Ký tự '\n'
    beq t1, t2, start_process_B

    # Kiểm tra có phải IN HOA không? ('A' <= char <= 'Z')
    li t2, 65           # 'A'
    blt t1, t2, next_char_A     # Nhỏ hơn 'A' Bỏ qua
    li t2, 90           # 'Z'
    bgt t1, t2, next_char_A     # Lớn hơn 'Z' thì Bỏ qua

    # Đánh dấu vào mảng map
    # Địa chỉ ô nhớ = Base_Map + ASCII_Code
    add t3, s2, t1      # t3 = Địa chỉ map[char]
    li t4, 1
    sb t4, 0(t3)        # Gán map[char] = 1

next_char_A:
    addi s1, s1, 1      # Tăng con trỏ chuỗi A
    j process_A_loop

    # XỬ LÝ CHUỖI B (KIỂM TRA VÀ IN) 
start_process_B:
    # In thông báo kết quả trước
    li a7, 4
    la a0, msg_res
    ecall

    la s1, strB         # s1 trỏ tới đầu chuỗi B (tái sử dụng thanh ghi)
    # s2 vẫn đang trỏ tới ascii_map

process_B_loop:
    lb t1, 0(s1)        # Lấy ký tự hiện tại từ strB
    
    # Kiểm tra kết thúc chuỗi
    beq t1, zero exit_program
    li t2, 10
    beq t1, t2, exit_program

    # Kiểm tra có phải IN HOA không?
    li t2, 65
    blt t1, t2, next_char_B
    li t2, 90
    bgt t1, t2, next_char_B

    # Kiểm tra trong mảng đánh dấu xem A có ký tự này không
    add t3, s2, t1      # t3 = Địa chỉ map[char]
    lb t4, 0(t3)        # Lấy giá trị trạng thái (0 hoặc 1)

    # Nếu t4 == 1 (Nghĩa là có trong A), thì in ra
    li t5, 1
    bne t4, t5, next_char_B

    # In ký tự ra màn hình
    li a7, 11           # Syscall 11: Print Char
    mv a0, t1           # Ký tự cần in
    ecall
    
    # QUAN TRỌNG: Đánh dấu lại là 0 để KHÔNG in lặp lại
    # Ví dụ: A="HELLO", B="BELL". 'L' xuất hiện 2 lần trong B, chỉ in 1 lần.
    sb zero, 0(t3)      

next_char_B:
    addi s1, s1, 1      # Tăng con trỏ chuỗi B
    j process_B_loop

exit_program:
    # In xuống dòng cho đẹp
    li a7, 4
    la a0, newline
    ecall

    li a7, 10           # Exit
    ecall
