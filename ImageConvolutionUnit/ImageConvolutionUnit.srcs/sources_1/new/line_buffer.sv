`timescale 1ns / 1ps

module line_buffer #(parameter SIZE=512) (
    input  logic        clk,
    input  logic        n_rst,
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
    
    logic full_n, empty_n;  

    assign waddr = wptr[ADDR_BITS-1:0];
    assign raddr = rptr[ADDR_BITS-1:0];

    assign nxt_wptr = wptr + (wen & ~full); 
    assign nxt_rptr = rptr + (ren & ~empty); 
    

    always_ff @(posedge clk) begin
        if (wen)
            mem[waddr] <= wdata;
    end

    always_ff @(posedge clk) begin
        if (ren)
            rdata <= mem[raddr];
    end

    always_comb begin
        full_n = 1'b0;
        empty_n = 1'b0; 
        if (nxt_wptr == nxt_rptr)
            empty_n = 1;
        else if ((nxt_wptr[ADDR_BITS-1:0] == nxt_rptr[ADDR_BITS-1:0]) && (nxt_wptr[ADDR_BITS] != nxt_rptr[ADDR_BITS]))
            full_n = 1;
    end

    always_ff @(posedge clk) begin
        if (!n_rst) begin
            wptr <= '0;
            rptr <= '0;
            empty <= 1;
            full <= 0;
        end else begin
            wptr <= nxt_wptr;
            rptr <= nxt_rptr;
            empty <= empty_n;
            full <= full_n;
        end
    end

endmodule
