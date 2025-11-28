`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2025 11:35:15 PM
// Design Name: 
// Module Name: shift_reg
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


module shift_reg #(parameter WIDTH=24) (
    input logic clk, n_rst, 
    input logic shift_en, 
    input logic [7:0] serial_in,
    output logic [WIDTH-1:0] o_data
    );
    
    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            o_data <= '0; 
        end
        else begin
            if (shift_en) begin
                o_data <= {o_data[WIDTH-9:0], serial_in};
            end
        end
    end
    
endmodule
