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

    localparam int IMAGE_WIDTH  = 512;
    localparam int IMAGE_HEIGHT = 512;

    logic [7:0] image[0:IMAGE_HEIGHT-1][0:IMAGE_WIDTH-1];
    int kernel[0:2][0:2];

    // Output file handle
    integer outfile;

    // Read image from text file
    task automatic read_image_file(input string filename);
        int i, j, c;
        int file;
        file = $fopen(filename, "r");
        if (file == 0) begin
            $display("ERROR: Cannot open file %s", filename);
            $finish;
        end
        for (i = 0; i < IMAGE_HEIGHT; i++) begin
            for (j = 0; j < IMAGE_WIDTH; j++) begin
                if ($fscanf(file, "%d", c) != 1) begin
                    $display("ERROR: Not enough pixels in %s. i: %d, j: %d\n", filename, i, j);
                    $finish;
                end
                image[i][j] = c;
            end
        end
        $fclose(file);
    endtask

    initial begin
        int i, j;
        int a,b,c,d,e,f,g,h,jk;
        int expected;

        // Open output file
        outfile = $fopen("C:\\Users\\karan\\Documents\\GitHub\\ImageProcessor\\lena_new.txt","w");
        if (outfile == 0) begin
            $display("ERROR: Cannot open output file");
            $finish;
        end

        // Reset
        n_rst = 0; i_wen = 0; i_start = 0;
        repeat(5) @(posedge clk);
        n_rst = 1;
        @(posedge clk);

        // Sobel kernel
        kernel = '{
            '{-1,0,1},
            '{-2,0,2},
            '{-1,0,1}
        };

        // Load image
        read_image_file("C:\\Users\\karan\\Documents\\GitHub\\ImageProcessor\\image.txt "); // replace with your path

        // Stream image pixels
        for (i = 0; i < IMAGE_HEIGHT-2; i++) begin
            for (j = 0; j < IMAGE_WIDTH; j++) begin
                i_wdata_1 = image[i  ][j];
                i_wdata_2 = image[i+1][j];
                i_wdata_3 = image[i+2][j];
                i_wen = 1;
                @(posedge clk);
            end
            i_wen = 0;
            @(posedge clk);
            @(posedge clk);

            // Start convolution
            i_start = 1;
            @(posedge clk);
            i_start = 0;

            // Capture output pixels
            for (j = 0; j < IMAGE_WIDTH-2; j++) begin
                @(posedge output_valid);
                $fwrite(outfile,"%0d\n",output_pixel);
            end
            @(posedge clk);
        end

        $fclose(outfile);
        $display("Finished writing output pixels to conv_output.txt");
        $finish;
    end

endmodule
