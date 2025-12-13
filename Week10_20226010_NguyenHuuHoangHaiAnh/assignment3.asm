.eqv MONITOR_SCREEN 0x10010000  # Start address of the bitmap display 
.eqv RED            0x00FF0000  # Common color values 
.eqv WHITE          0x00FFFFFF 
.eqv BLACK          0x00000000
.text
main:
    li      s0, MONITOR_SCREEN  
    li      s1, 64              # Tổng số 64 ô bàn cờ (8x8)
    li      t0, 0               # Biến đếm i chạy từ 0 đến 63

loop:
    bge     t0, s1, exit        # Nếu i >= 64 thì thoát chương trình

    # Tính hàng, cột
    # Row = i / 8
    srli    t1, t0, 3           # t1 = Row
    # Col = i % 8. (dùng AND với 7)
    andi    t2, t0, 7           # t2 = Col

    # Kiểm tra tính chẵn lẻ của (Row + Col) 
    add     t3, t1, t2          # t3 = Row + Col
    andi    t3, t3, 1           # Lấy bit cuối cùng để kiểm tra chẵn lẻ
    bne     t3, zero, draw_black      # Nếu t3 != 0 (Lẻ) thì vẽ màu đen

draw_white:
    li      t4, WHITE
    j       store_pixel

draw_black:
    li      t4, BLACK

store_pixel:
    sw      t4, 0(s0)           
    addi    s0, s0, 4           
    addi    t0, t0, 1           # Tăng biến đếm i
    j       loop                
exit:
    li      a7, 10              # Exit
    ecall