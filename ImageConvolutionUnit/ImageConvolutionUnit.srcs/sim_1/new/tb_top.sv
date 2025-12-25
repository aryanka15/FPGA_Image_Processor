`timescale 1ns / 1ps

module tb_top;

    logic clk, n_rst;
    logic i_wen, i_start, output_valid;
    logic [7:0] i_wdata;
    logic [7:0] output_pixel;
    
    int i, j,z, k;
    int count_pixels; 

    // DUT
    top DUT (
        .clk(clk),
        .n_rst(n_rst),
        .i_wen(i_wen),
        .i_start(i_start),
        .i_wdata(i_wdata),
        .output_pixel(output_pixel),
        .output_valid(output_valid)
    );

    // Clock
    initial clk = 0;
    always #2.5 clk = ~clk;

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
        int a,b,c,d,e,f,g,h,jk;
        int expected;
        count_pixels = 0; 
        // Open output file
        outfile = $fopen("C:\\Users\\karan\\Documents\\GitHub\\ImageProcessor\\output\\clown_new.txt","w");
        if (outfile == 0) begin
            $display("ERROR: Cannot open output file");
            $finish;
        end

        // Reset
        n_rst = 0; i_wen = 0; i_start = 0;
        repeat(5) @(posedge clk);
        @(posedge clk); #0.4; 
        n_rst = 1;
        repeat(20) @(posedge clk);  
        @(posedge clk); #0.4;
        
        // Sobel kernel
        kernel = '{
            '{-1,0,1},
            '{-2,0,2},
            '{-1,0,1}
        };

        // Load image
        read_image_file("C:\\Users\\karan\\Documents\\GitHub\\ImageProcessor\\test_scripts\\clown.txt "); // replace with your path
        
        // Load first three lines
        for (k = 0; k < 3; k++) begin
            for (j = 0; j < IMAGE_WIDTH; j++) begin
                i_wdata = image[k][j];
                i_wen = 1;
                @(posedge clk); #0.4;
            end 
            i_wen = 0; 
            @(negedge clk);
            @(posedge clk);
            @(posedge clk);
            @(posedge clk);
            @(posedge clk);
        end 
    
        // Stream image pixels
        for (i = 0; i < IMAGE_HEIGHT-2; i++) begin
            // Write logic
            fork 
                begin
                    @(posedge clk); #0.4; 
                    if (i < IMAGE_HEIGHT-3) begin
                        for (j = 0; j < IMAGE_WIDTH; j++) begin
                            i_wdata = image[i+3][j];
                            i_wen = 1;
                            @(posedge clk); #0.4;
                        end 
                        i_wen = 0; 
                        @(negedge clk);
                        @(posedge clk);
                        @(posedge clk);
                        @(posedge clk); #0.4;
                    end 
                end   
                // Start convolution
                begin
                    @(posedge clk); #0.4; 
                    i_start = 1;
                    @(posedge clk);
                    @(posedge clk); #0.4; 
                    i_start = 0;
                    @(posedge output_valid);
                    $fwrite(outfile,"%0d\n",output_pixel);
                    // Capture output pixels
                    count_pixels++; 
                    for (z = 1; z < IMAGE_WIDTH-2; z++) begin
                        if (output_valid)
                            $fwrite(outfile,"%0d\n",output_pixel);
                        else
                            z--;
                        @(posedge clk); #0.4;
                    end
                end
            join
        end

        $fclose(outfile);
        $display("Finished writing %0d output pixels to conv_output.txt", count_pixels);
        $finish;
    end

endmodule
