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
    input logic signed [71:0] kernel, 
    input logic start_conv, 
    output logic [7:0] output_pixel,
    output logic data_ready
    );
        
    logic signed [15:0] mul_data [2:0][2:0]; 
    logic signed [15:0] sum_rows [2:0];
    logic signed [15:0] sum_rows_reg [2:0];
    logic signed [15:0] sum_reg; 
    logic [7:0] sum_output;  
    
    
    logic signed [7:0] kernel_array [0:2][0:2];
    assign kernel_array[0][0] = kernel[71:64];
    assign kernel_array[0][1] = kernel[63:56];
    assign kernel_array[0][2] = kernel[55:48];
    assign kernel_array[1][0] = kernel[47:40];
    assign kernel_array[1][1] = kernel[39:32];
    assign kernel_array[1][2] = kernel[31:24];
    assign kernel_array[2][0] = kernel[23:16];
    assign kernel_array[2][1] = kernel[15:8];
    assign kernel_array[2][2] = kernel[7:0];

    // --- Unpack conv_data into 2D array of pixels ---
    logic [7:0] pixel_array [0:2][0:2];
    assign pixel_array[0][0] = conv_data[71:64];
    assign pixel_array[0][1] = conv_data[63:56];
    assign pixel_array[0][2] = conv_data[55:48];
    assign pixel_array[1][0] = conv_data[47:40];
    assign pixel_array[1][1] = conv_data[39:32];
    assign pixel_array[1][2] = conv_data[31:24];
    assign pixel_array[2][0] = conv_data[23:16];
    assign pixel_array[2][1] = conv_data[15:8];
    assign pixel_array[2][2] = conv_data[7:0];
    
    logic mul_valid, sum_valid, sum_valid1; 
        
    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            mul_valid <= '0;
            sum_valid <= '0;
            sum_valid1 <= '0; 
            data_ready <= '0;
        end
        else begin
            mul_valid <= start_conv; 
            sum_valid1 <= mul_valid; 
            sum_valid <= sum_valid1; 
            data_ready <= sum_valid; 
        end
    end
    
     
    genvar i, j; 
    generate
        for (i = 0; i < 3; i++) begin: gen_row
            for (j = 0; j < 3; j++) begin: gen_col
                localparam index = 72 - 8*(3*i + j + 1); 
                always_ff @(posedge clk, negedge n_rst) begin: ff_mul
                    if (~n_rst) begin
                        mul_data[i][j] <= '0; 
                    end
                    else if (start_conv) begin
                        mul_data[i][j] <= $signed({1'b0,pixel_array[i][j]}) * kernel_array[i][j];
                    end
                end
            end
        end
    endgenerate
    
    genvar k;
    generate
        for (k = 0; k < 3; k++) begin
            always_comb begin: sum_logic
                sum_rows[k] = 16'd0;
                if (mul_valid) begin
                    for (int z = 0; z < 3; z++) begin
                        sum_rows[k] = sum_rows[k] + mul_data[k][z];
                    end
                end
            end
            
            always_ff @(posedge clk, negedge n_rst) begin: sum_rows_reg_logic 
                if (~n_rst) begin
                    sum_rows_reg[k] <= 16'd0; 
                end
                else begin
                    if (mul_valid) begin
                        sum_rows_reg[k] <= sum_rows[k];
                    end
                end
            end
        end
    endgenerate
    
    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            sum_reg <= 16'd0; 
            output_pixel <= 8'd0; 
        end
        else begin
            sum_reg <= sum_rows_reg[0] + sum_rows_reg[1] + sum_rows_reg[2];
            if (sum_valid) 
                output_pixel <= sum_output; 
        end
    end
    
    always_comb begin: output_pixel_logic
        if (sum_reg < 0) begin
            sum_output = ~sum_reg + 1'b1; 
        end
        else if (sum_reg > 255) begin
            sum_output = 8'd255; 
        end
        else begin
            sum_output = sum_reg[7:0]; 
        end
    end
        
    
endmodule
