.text
.globl sum_array
sum_array:
    addi sp, sp, -16    
    sd ra, 8(sp)        
    li t0, 0              
    li t1, 0          
.L_sum_loop:
    bge t0, a0, .L_sum_end 
    slli t2, t0, 2         
    add t3, a1, t2        
    lw t4, 0(t3)          
    andi t5, t4, 1        
    bne t5, zero, .L_sum_odd
    add t1, t1, t4         
    j .L_sum_next
.L_sum_odd:
    sub t1, t1, t4         
.L_sum_next:
    addi t0, t0, 1
    j .L_sum_loop
.L_sum_end:
    mv a0, t1             
    ld ra, 8(sp)
    addi sp, sp, 16
    jr ra

.text
.globl main
main:
    addi sp, sp, -48      
    sd ra, 40(sp)         
    li t0, 5
    sw t0, 0(sp)           
    li t1, 0
    sw t1, 4(sp)           
    addi t2, sp, 8       
.L_main_loop:
    lw t1, 4(sp)           
    lw t0, 0(sp)           
    bge t1, t0, .L_main_end
    mul t3, t1, t1        
    slli t4, t1, 2
    add t5, t2, t4
    sw t3, 0(t5)          
    addi t1, t1, 1
    sw t1, 4(sp)
    j .L_main_loop
.L_main_end:
    lw a0, 0(sp)       
    addi a1, sp, 8    
    call sum_array    
    call putint            
    li a0, 0 
    ld ra, 40(sp)
    addi sp, sp, 48
    jr ra
