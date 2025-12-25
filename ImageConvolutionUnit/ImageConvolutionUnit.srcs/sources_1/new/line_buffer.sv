`timescale 1ns / 1ps

module line_buffer #(parameter SIZE=512) (
    input  logic        clk,
    input  logic        n_rst,
    input  logic        rptr_rst,
    input  logic        ren,
    input  logic        wen,
    input  logic [7:0]  wdata,
    output logic empty,
    output logic full,
    output logic [7:0] rdata
);


    localparam ADDR_BITS = $clog2(SIZE);

    logic [7:0] mem [SIZE-1:0];

    logic [ADDR_BITS:0] rptr, wptr; 
    logic [ADDR_BITS:0] nxt_wptr, nxt_rptr;

    logic [ADDR_BITS-1:0] waddr, raddr;
    logic [ADDR_BITS:0] rptr_inverted; 

    logic full_n, empty_n;  

    assign waddr = wptr[ADDR_BITS-1:0];
    assign raddr = rptr[ADDR_BITS-1:0];

    assign nxt_wptr = wptr + (wen & ~full); 
    assign nxt_rptr = rptr + (ren & ~empty); 
    

    always_ff @(posedge clk) begin
        if (wen & ~full)
            mem[waddr] <= wdata;
    end

    always_ff @(posedge clk) begin
        rdata <= '0; 
        if (ren & ~empty)
            rdata <= mem[raddr];
    end

    always_comb begin
        empty_n = empty; 
        full_n = full;
        
        if (rptr_rst) begin
            empty_n = 1'b0;
            full_n = 1'b1; 
        end
        
        else if (wen & ~full) begin
            empty_n = 1'b0;
            rptr_inverted = {~rptr[ADDR_BITS], rptr[ADDR_BITS-1:0]};
            if ((wptr + 1'b1) == rptr_inverted)
                full_n = 1'b1;
            else
                full_n = 1'b0; 
        end
        else if (ren & ~empty) begin
            full_n = 1'b0; 
            if ((rptr + 1'b1) == wptr) begin
                empty_n = 1'b1;
            end
            else begin
                empty_n = 1'b0; 
            end
        end
    end

    always_ff @(posedge clk) begin
        if (~n_rst) begin
            wptr <= '0;
            rptr <= '0;
            empty <= 1;
            full <= 0;
        end else begin
            wptr <= nxt_wptr;
            rptr <= rptr_rst ? {~nxt_wptr[ADDR_BITS], nxt_wptr[ADDR_BITS-1:0]} : nxt_rptr;
            empty <= empty_n;
            full <= full_n;
        end
    end

endmodule
