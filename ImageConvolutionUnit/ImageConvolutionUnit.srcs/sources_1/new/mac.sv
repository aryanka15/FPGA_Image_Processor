`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2025 06:59:29 PM
// Design Name: 
// Module Name: mac
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


module mac(
    input logic clk, n_rst,
    input logic [71:0] conv_data,
    input logic [71:0] kernel, 
    input logic start_conv, 
    output logic [7:0] output_pixel,
    output logic data_ready
    );
        
    logic [11:0] mul_data [2:0][2:0]; 
    logic [14:0] sum, sum_reg;
    logic [7:0] sum_output;  
    
    logic mul_valid, sum_valid; 
        
    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            mul_valid <= '0;
            sum_valid <= '0;
            data_ready <= '0;
        end
        else begin
            mul_valid <= start_conv; 
            sum_valid <= mul_valid; 
            data_ready <= sum_valid; 
        end
    end
    
    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            sum_reg <= '0; 
            output_pixel <= '0; 
        end
        else begin
            sum_reg <= sum; 
            output_pixel <= sum_output; 
        end
    end
    
    genvar i, j; 
    generate
        for (i = 0; i < 3; i++) begin
            for (j = 0; j < 3; j++) begin
                localparam index = 8*(3*i + j); 
                always_ff @(posedge clk, negedge n_rst) begin
                    if (~n_rst) begin
                        mul_data[i][j] = '0; 
                    end
                    else begin
                        mul_data[i][j] <= conv_data[(index + 7):index] * kernel[(index + 7):index]; 
                    end
                end
            end
        end
    endgenerate
    
    always_comb begin: sum_logic
        sum = 15'd0; 
        for (int k = 0; k < 3; k++) begin
            for (int z = 0; z < 3; z++) begin
                sum = sum + mul_data[k][z]; 
            end
        end
    end  
    
    always_comb begin: output_pixel_logic
        sum_output = sum_reg > 15'd255 ? 8'd255 : sum_reg[7:0]; 
    end
        
    
endmodule
