`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2025 12:13:37 AM
// Design Name: 
// Module Name: controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module controller(
    input logic clk, n_rst, all_full, all_empty, start, data_valid,
    output logic start_conv, shift_en, ren, buffer_shift
    );
        
    typedef enum logic [2:0] {IDLE, READ_INIT, SHIFT_INIT, START_CONV, WAIT_DATA, LAST_DATA} state_t;
    
    state_t state, next_state; 
    
    logic all_full, all_empty;
    logic [2:0] cnt_3, nxt_cnt; 
    logic cnt_en;
    
    logic [8:0] buffer_shift_counter;  
    
    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            state <= IDLE;
            cnt_3 <= '0;  
        end
        else begin
            state <= next_state;
            cnt_3 <= nxt_cnt; 
        end  
    end
    
    always_comb begin: count_logic 
        nxt_cnt = cnt_3; 
        if (cnt_en) begin
            nxt_cnt = cnt_3 == 3'd3 ? 3'd1 : cnt_3 + 1; 
        end
    end
    
    always_comb begin: output_logic 
        start_conv = 0; 
        shift_en = 0;
        ren = 0; 
        cnt_en = 0; 
        case (state)
            READ_INIT: begin
                ren = 1; 
                cnt_en = 1; 
            end
            SHIFT_INIT: begin
                shift_en = 1;
                ren = 1;
                cnt_en = 1;  
            end
            START_CONV: begin
                start_conv = 1;
                shift_en = 1;
                ren = 1; 
            end
            WAIT_DATA: begin
                start_conv = 0;
                shift_en = 0;
                ren = 0; 
            end
            LAST_DATA: begin
                start_conv = 1;
                shift_en = 0;
                ren = 0; 
            end
            default: begin
                start_conv = 0; 
                shift_en = 0;
                ren = 0; 
                cnt_en = 0;
            end
        endcase
    end
    
    always_comb begin: next_state_logic
        next_state = state; 
        case (state) 
            IDLE: begin
                if (start & all_full) begin
                    next_state = READ_INIT; 
                end
            end
            READ_INIT: begin
                next_state = SHIFT_INIT; 
            end
            SHIFT_INIT: begin
                if (cnt_3 == 3'd3) begin
                    next_state = START_CONV; 
                end
            end
            START_CONV: begin
                if (all_empty) begin
                    next_state = LAST_DATA; 
                end 
            end
            LAST_DATA: begin
                next_state = WAIT_DATA; 
            end
            WAIT_DATA: begin
                next_state = data_valid ? WAIT_DATA : IDLE; 
            end
            default: begin
                next_state = state;  
            end
        endcase
    end
    
    always_ff @(posedge clk, negedge n_rst) begin: buffer_counter
        if (~n_rst) begin
            buffer_shift_counter <= '0; 
        end
        else begin
            if (data_valid) begin
                buffer_shift_counter <= buffer_shift_counter == 9'd510 ? '0 : buffer_shift_counter + 1; 
            end
            else buffer_shift_counter <= '0;
        end
    end
    
    always_comb begin: shift_logic
        buffer_shift = 0; 
        if (buffer_shift_counter == 9'd510) begin
            buffer_shift = 1; 
        end
    end
    
endmodule
