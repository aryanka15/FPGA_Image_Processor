`timescale 1ns / 1ps

module tb_top;

    logic clk, n_rst;
    logic i_wen, i_start, output_valid;
    logic [7:0] i_wdata_1, i_wdata_2, i_wdata_3;
    logic [7:0] output_pixel;

    // DUT
    top DUT (
        .clk(clk),
        .n_rst(n_rst),
        .i_wen(i_wen),
        .i_start(i_start),
        .i_wdata_1(i_wdata_1),
        .i_wdata_2(i_wdata_2),
        .i_wdata_3(i_wdata_3),
        .output_pixel(output_pixel),
        .output_valid(output_valid)
    );

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Parameters
    localparam int LINE_LENGTH = 512;

    // Input image and kernel
    logic [7:0] line0[0:LINE_LENGTH-1];
    logic [7:0] line1[0:LINE_LENGTH-1];
    logic [7:0] line2[0:LINE_LENGTH-1];
    int kernel[0:2][0:2];

    initial begin
        int i;
        int expected, a,b,c,d,e,f,g,h,j;
        int passed = 0, total = 0;

        // Reset
        n_rst = 0;
        i_wen = 0;
        i_start = 0;
        repeat(5) @(posedge clk);
        n_rst = 1;
        @(posedge clk);

        kernel = '{
            '{-1, 0,  1},
            '{-2, 0,  2},
            '{-1, 0,  1}
        };

        for (i=0; i<LINE_LENGTH; i++) begin
            line0[i] = $urandom_range(0,255);
            line1[i] = $urandom_range(0,255);
            line2[i] = $urandom_range(0,255);
        end

        // Stream 3 lines into line buffers in parallel
        for (i=0; i<LINE_LENGTH; i++) begin
            i_wdata_1 = line0[i];
            i_wdata_2 = line1[i];
            i_wdata_3 = line2[i];
            i_wen = 1;
            @(posedge clk);
        end
        i_wen = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); 
        // Start convolution
        i_start = 1;
        @(posedge clk);
        i_start = 0;

        // Wait for output and check results
        for (i=0; i<LINE_LENGTH-2; i++) begin
            @(posedge output_valid);

            // Compute expected output
            a = line0[i];   b = line0[i+1];   c = line0[i+2];
            d = line1[i];   e = line1[i+1];   f = line1[i+2];
            g = line2[i];   h = line2[i+1];   j = line2[i+2];

            expected = a*kernel[0][0] + b*kernel[0][1] + c*kernel[0][2]
                     + d*kernel[1][0] + e*kernel[1][1] + f*kernel[1][2]
                     + g*kernel[2][0] + h*kernel[2][1] + j*kernel[2][2];
            if (expected > 255) expected = 255;
            if (expected < 0) expected = 0;

            total++;
            if (output_pixel == expected)
                passed++;
            else
                $display("Mismatch at pixel %0d: expected %0d, got %0d", i, expected, output_pixel);
        end

        $display("Passed %0d/%0d tests", passed, total);
        $finish;
    end

endmodule
