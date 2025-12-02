`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2025 12:40:30 PM
// Design Name: 
// Module Name: tb_top
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


module tb_top();
    
    logic clk, n_rst; 
    logic i_wen, i_start, output_valid; 
    logic [7:0] i_wdata_1, i_wdata_2, i_wdata_3, output_pixel; 

    top #() DUT (
        .clk(clk), 
        .n_rst(n_rst),
        .i_wen(i_wen), 
        .i_start(i_start), 
        .output_valid(output_valid),
        .i_wdata_1(i_wdata_1),
        .i_wdata_2(i_wdata_2),
        .i_wdata_3(i_wdata_3),
        .output_pixel(output_pixel)
    );

    initial begin
        clk = 1'b0;
        forever begin
            #(5);
            clk = ~clk; 
        end
    end
    
    integer i, expected; 
    integer passed_tests;
    integer total_tests; 
    int a,b,c; 

    function int pix;
        input int pos;
        begin
            pix = (pos > 255) ? (511 - pos) : pos;
        end
    endfunction
    
    initial begin
//        fin = $fopen("C:\\Users\\karan\\Downloads\\lena.bmp", "rb");
//        fout = $fopen("C:\\Users\\karan\\Downloads\\lena_processed.bmp", "wb");

        n_rst = 0; 
        i_wen = 0;
        i_wdata_1 = 0;
        i_wdata_2 = 0;
        i_wdata_3 = 0;
        i_start = 0;
        passed_tests = 0;
        total_tests = 0; 
        
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); 
        
        n_rst = 1;
        @(posedge clk);
        @(posedge clk); 

        for (i = 0; i < 512; i++) begin
            i_wdata_1 = i > 255 ? 511 - i : i;
            i_wdata_2 = i > 255 ? 511 - i : i;
            i_wdata_3 = i > 255 ? 511 - i : i;
            i_wen = 1; 
            @(posedge clk); 
        end
        i_wen = 0; 
        @(posedge clk); 
        @(posedge clk);
        i_start = 1; 
        @(posedge clk);
        i_start = 0; 
        
        for (i = 0; i < 510; i++) begin
            @(posedge output_valid); 
            total_tests++; 
            a = pix(i);
            b = pix(i+1);
            c = pix(i+2);
            expected = (a + b + c) * 3;
            if (expected > 255) expected = 255;
            
            if (output_pixel == expected) begin
                passed_tests++; 
            end
            else begin
                $display("i: %d, expected: %d, actual: %d\n", i, expected, output_pixel); 
            end
        end
        
        $display("%d/%d tests passed\n", passed_tests, total_tests); 
        
        $finish;         
    end

endmodule

