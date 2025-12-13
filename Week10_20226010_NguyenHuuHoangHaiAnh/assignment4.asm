.eqv KEY_CODE       0xFFFF0004  # ASCII code from keyboard, 1 byte
.eqv KEY_READY      0xFFFF0000  # =1 if has a new keycode ?
                                # Auto clear after lw
.eqv DISPLAY_CODE   0xFFFF000C  # ASCII code to show, 1 byte 
.eqv DISPLAY_READY  0xFFFF0008  # =1 if the display has already to do
				# Auto clear after sw

.text
main:
    li      s1, 0               # s1: Biến trạng thái để theo dõi chuỗi "exit"

loop:
WaitForKey:
    li      t0, KEY_READY
    lw      t1, 0(t0)           # Đọc bit Ready
    beq     t1, zero, WaitForKey      # Nếu bằng 0 thì đợi tiếp

    li      t0, KEY_CODE
    lw      a0, 0(t0)           # a0 chứa ký tự vừa nhập 

    # KIỂM TRA CHUỖI "exit" 
    # Kiểm tra ký tự nhập vào (a0) để cập nhật trạng thái s1
check_exit:
    # Case 'e'
    li      t2, 'e'
    beq     a0, t2, set_state_1
    
    # Case 'x'
    li      t2, 'x'
    beq     a0, t2, check_state_x
    
    # Case 'i'
    li      t2, 'i'
    beq     a0, t2, check_state_i
    
    # Case 't'
    li      t2, 't'
    beq     a0, t2, check_state_t
    
    # Nếu không phải e, x, i, t theo đúng thứ tự, Reset trạng thái về 0
    li      s1, 0
    j       process_char

set_state_1:
    li      s1, 1
    j       process_char

check_state_x:
    li      t3, 1
    beq     s1, t3, set_state_2
    li      s1, 0               # Reset nếu không đúng thứ tự
    j       process_char
set_state_2:
    li      s1, 2
    j       process_char

check_state_i:
    li      t3, 2
    beq     s1, t3, set_state_3
    li      s1, 0
    j       process_char
set_state_3:
    li      s1, 3
    j       process_char

check_state_t:
    li      t3, 3
    beq     s1, t3, exit_program # Bắt được "exit" 
    li      s1, 0
    j       process_char

    # XỬ LÝ KÝ TỰ ĐỂ HIỂN THỊ 
process_char:
    # Kiểm tra Số
    li      t2, '0'
    blt     a0, t2, check_others # Nhỏ hơn '0' khác
    li      t2, '9'
    bgt     a0, t2, check_upper  # Lớn hơn '9', Kiểm tra chữ Hoa
    # Nếu là số, Giữ nguyên, nhảy đến In
    j       show_display

    # Kiểm tra Chữ Hoa 
check_upper:
    li      t2, 'A'
    blt     a0, t2, check_others
    li      t2, 'Z'
    bgt     a0, t2, check_lower
    # Nếu là chữ Hoa, Cộng 32 để thành chữ thường
    addi    a0, a0, 32
    j       show_display

    # Kiểm tra Chữ Thường 
check_lower:
    li      t2, 'a'
    blt     a0, t2, check_others
    li      t2, 'z'
    bgt     a0, t2, check_others
    # Nếu là chữ Thường, Trừ 32 để thành chữ hoa
    addi    a0, a0, -32
    j       show_display

    # d. Các ký tự khác
check_others:
    li      a0, '*'             # Đổi thành dấu sao

    # HIỂN THỊ RA MÀN HÌNH
show_display:
WaitForDisplay:
    li      t0, DISPLAY_READY
    lw      t1, 0(t0)           # Đọc bit Ready của màn hình
    beqz    t1, WaitForDisplay  # Nếu bằng 0 (bận) thì đợi

    li      t0, DISPLAY_CODE
    sw      a0, 0(t0)           # Gửi ký tự đã xử lý ra màn hình
    
    j       loop                # Quay lại chờ phím tiếp theo

exit_program:
    li      a7, 10		# Exit
    ecall