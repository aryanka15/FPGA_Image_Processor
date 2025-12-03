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
    input logic clk, n_rst, full_1, empty_1, full_2, empty_2, full_3, empty_3, start, data_valid,
    output logic start_conv, shift_en, ren
    );
        
    typedef enum logic [2:0] {IDLE, READ_INIT, SHIFT_INIT, START_CONV, WAIT_CONV, READ_DATA, SHIFT_DATA} state_t;
    
    state_t state, next_state; 
    
    logic all_full, all_empty;
    logic [2:0] cnt_3, nxt_cnt; 
    logic cnt_en;
    
    assign all_full = full_1 & full_2 & full_3; 
    assign all_empty = empty_1 & empty_2 & empty_3; 
    
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
            end
            START_CONV: begin
                start_conv = 1; 
            end
            READ_DATA: begin
                ren = 1; 
            end
            SHIFT_DATA: begin
                shift_en = 1; 
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
                else begin
                    next_state = READ_INIT; 
                end
            end
            START_CONV: begin
                next_state = WAIT_CONV; 
            end
            WAIT_CONV: begin
                if (data_valid & ~all_empty) begin
                    next_state = READ_DATA; 
                end
                else if (data_valid & all_empty) begin
                    next_state = IDLE; 
                end
            end
            READ_DATA: begin
                next_state = SHIFT_DATA; 
            end
            SHIFT_DATA: begin
                next_state = START_CONV; 
            end
            default: begin
                next_state = state;  
            end
        endcase
    end
    
endmodule
