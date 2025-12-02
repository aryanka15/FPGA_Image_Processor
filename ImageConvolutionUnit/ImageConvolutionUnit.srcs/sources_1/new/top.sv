`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2025 08:35:44 PM
// Design Name: 
// Module Name: top
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


module top (
    // Essential Control Ports (Map these to FPGA pins)
    input logic clk, 
    input logic n_rst,
    input logic i_wen, i_start,
    input logic [7:0] i_wdata_1, i_wdata_2, i_wdata_3,
    // Output Port (Map this to FPGA pin/LEDs)
    output logic [7:0] output_pixel,
    output logic output_valid
);

    // First signal ff
    logic [7:0] wdata_1_1, wdata_2_1, wdata_3_1;
    logic wen_1, start_1; 

    // Synced Signals
    logic [7:0] wdata_1, wdata_2, wdata_3;
    logic wen, start; 

    // Line Buffer Signals
    logic ren;
    logic full_1, empty_1;
    logic full_2, empty_2; 
    logic full_3, empty_3; 
    logic [7:0] rdata_1, rdata_2, rdata_3; 
    
    // Shift Register Signals
    logic shift_en; 
    logic [71:0] conv_data;   
    
    // MAC Signals    
//    localparam [71:0] kernel = {
//        8'hFE,  // K[0,0] = -2 (MSB)
//        8'hFF,  // K[0,1] = -1
//        8'h00,  // K[0,2] = 0
//        8'hFF,  // K[1,0] = -1
//        8'h01,  // K[1,1] = +1
//        8'h01,  // K[1,2] = +1
//        8'h00,  // K[2,0] = 0
//        8'h01,  // K[2,1] = +1
//        8'h02   // K[2,2] = +2 (LSB)
//    };

        localparam [71:0] kernel = {
        8'h01,  // K[0,0] = -2 (MSB)
        8'h01,  // K[0,1] = -1
        8'h01,  // K[0,2] = 0
        8'h01,  // K[1,0] = -1
        8'h01,  // K[1,1] = +1
        8'h01,  // K[1,2] = +1
        8'h01,  // K[2,0] = 0
        8'h01,  // K[2,1] = +1
        8'h01   // K[2,2] = +2 (LSB)
    };
    
    // Controller Signals
    logic start_conv;
    
    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            wdata_1 <= '0; 
            wdata_2 <= '0; 
            wdata_3 <= '0;
            wdata_1_1 <= '0; 
            wdata_2_1 <= '0; 
            wdata_3_1 <= '0; 
            wen <= '0;
            start <= '0;
            wen_1 <= '0;
            start_1 <= '0;
        end
        else begin
            wdata_1_1 <= i_wdata_1; 
            wdata_2_1 <= i_wdata_2; 
            wdata_3_1 <= i_wdata_3; 
            wen_1 <= i_wen; 
            start_1 <= i_start; 
            
            wdata_1 <= wdata_1_1;
            wdata_2 <= wdata_2_1;
            wdata_3 <= wdata_3_1;
            wen <= wen_1; 
            start <= start_1; 
        end
    end
    
    controller control (
        .clk(clk),
        .n_rst(n_rst),
        .full_1(full_1),
        .full_2(full_2),
        .full_3(full_3),
        .empty_1(empty_1),
        .empty_2(empty_2),
        .empty_3(empty_3),
        .start(start),
        .data_valid(output_valid),
        .start_conv(start_conv),
        .shift_en(shift_en),
        .ren(ren)
     );
    
    line_buffer buffer1 (
        .clk(clk), 
        .n_rst(n_rst), 
        .ren(ren), 
        .wen(wen), 
        .wdata(wdata_1), 
        .empty(empty_1), 
        .full(full_1), 
        .rdata(rdata_1)
     );
     
     line_buffer buffer2 (
        .clk(clk), 
        .n_rst(n_rst), 
        .ren(ren), 
        .wen(wen), 
        .wdata(wdata_2), 
        .empty(empty_2), 
        .full(full_2), 
        .rdata(rdata_2)
     );
     
     line_buffer buffer3 (
        .clk(clk), 
        .n_rst(n_rst), 
        .ren(ren), 
        .wen(wen), 
        .wdata(wdata_3), 
        .empty(empty_3), 
        .full(full_3), 
        .rdata(rdata_3)
     );
     
     shift_reg reg1 (
        .clk(clk), .n_rst(n_rst),
        .shift_en(shift_en),
        .serial_in(rdata_1),
        .o_data(conv_data[71:48])
     );
     
     shift_reg reg2 (
        .clk(clk), .n_rst(n_rst),
        .shift_en(shift_en),
        .serial_in(rdata_2),
        .o_data(conv_data[47:24])
     );
     
     shift_reg reg3 (
        .clk(clk), .n_rst(n_rst),
        .shift_en(shift_en),
        .serial_in(rdata_3),
        .o_data(conv_data[23:0])
     );
    
     mac conv_block (
        .clk(clk),
        .n_rst(n_rst),
        .conv_data(conv_data),
        .kernel(kernel),
        .start_conv(start_conv),
        .output_pixel(output_pixel),
        .data_ready(output_valid)
     );

endmodule
