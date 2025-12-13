# STUDENT ID: 20226010 => 10. NGUYEN HUU HOANG HAI ANH
.eqv SEVENSEG_LEFT    0xFFFF0011    # Address of the LED on the left 
                                    #     Bit 0 = segment a 
                                    #     Bit 1 = segment b 
                                    #     ...    
                                    #     Bit 7 = dot sign 
.eqv SEVENSEG_RIGHT   0xFFFF0010    # Address of the LED on the right 
 
.text 
main: 
    li      a0,  0x06               # Để hiển thị số 1: Cần bật thanh b và c
    jal     SHOW_7SEG_LEFT          # Show the result 
    li      a0,  0x3F               # Để hiển thị số 0: Cần bật các thanh a, b, c, d, e, f 
    jal     SHOW_7SEG_RIGHT         # Show the result    
exit:      
    li      a7, 10 
    ecall 
end_main: 
 
# --------------------------------------------------------------- 
# Function  SHOW_7SEG_LEFT : Turn on/off the 7seg 
# param[in]  a0   value to shown        
# remark     t0 changed 
# --------------------------------------------------------------- 
SHOW_7SEG_LEFT:   
    li      t0, SEVENSEG_LEFT   # Assign port's address  
    sb      a0, 0(t0)           # Assign new value   
    jr      ra 
                  
# --------------------------------------------------------------- 
# Function  SHOW_7SEG_RIGHT : Turn on/off the 7seg 
# param[in]  a0   value to shown        
# remark     t0 changed 
# --------------------------------------------------------------- 
SHOW_7SEG_RIGHT:  
    li   t0, SEVENSEG_RIGHT     # Assign port's address 
    sb   a0, 0(t0)              # Assign new value  
    jr   ra 
