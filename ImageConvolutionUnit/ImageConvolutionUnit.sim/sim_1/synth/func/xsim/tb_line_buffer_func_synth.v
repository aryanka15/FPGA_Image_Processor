// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Thu Nov 27 18:28:47 2025
// Host        : AryanHPLaptop running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/karan/Documents/GitHub/ImageProcessor/ImageConvolutionUnit/ImageConvolutionUnit.sim/sim_1/synth/func/xsim/tb_line_buffer_func_synth.v
// Design      : line_buffer
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50ftgb196-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* ADDR_BITS = "9" *) (* SIZE = "512" *) 
(* NotValidForBitStream *)
module line_buffer
   (clk,
    n_rst,
    ren,
    wen,
    wdata,
    wptr,
    empty,
    full,
    rdata);
  input clk;
  input n_rst;
  input ren;
  input wen;
  input [7:0]wdata;
  output [9:0]wptr;
  output empty;
  output full;
  output [7:0]rdata;

  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire empty;
  wire empty_OBUF;
  wire empty_i_1_n_0;
  wire empty_i_3_n_0;
  wire empty_i_4_n_0;
  wire empty_i_5_n_0;
  wire empty_i_6_n_0;
  wire empty_i_9_n_0;
  wire empty_n;
  wire empty_reg_i_2_n_1;
  wire empty_reg_i_2_n_2;
  wire empty_reg_i_2_n_3;
  wire empty_reg_i_7_n_0;
  wire empty_reg_i_7_n_1;
  wire empty_reg_i_7_n_2;
  wire empty_reg_i_7_n_3;
  wire empty_reg_i_7_n_4;
  wire empty_reg_i_7_n_5;
  wire empty_reg_i_7_n_6;
  wire empty_reg_i_7_n_7;
  wire empty_reg_i_8_n_0;
  wire empty_reg_i_8_n_1;
  wire empty_reg_i_8_n_2;
  wire empty_reg_i_8_n_3;
  wire empty_reg_i_8_n_4;
  wire empty_reg_i_8_n_5;
  wire empty_reg_i_8_n_6;
  wire empty_reg_i_8_n_7;
  wire full;
  wire full_OBUF;
  wire full_i_1_n_0;
  wire full_i_2_n_0;
  wire full_i_5_n_0;
  wire full_i_6_n_0;
  wire full_i_7_n_0;
  wire full_reg_i_3_n_3;
  wire full_reg_i_3_n_7;
  wire full_reg_i_4_n_1;
  wire full_reg_i_4_n_2;
  wire full_reg_i_4_n_3;
  wire n_rst;
  wire n_rst_IBUF;
  wire p_0_in;
  wire p_1_in;
  wire [9:0]p_1_in__0;
  wire [7:0]rdata;
  wire [7:0]rdata_OBUF;
  wire ren;
  wire ren_IBUF;
  wire \rptr[0]_i_1_n_0 ;
  wire \rptr[1]_i_1_n_0 ;
  wire \rptr[2]_i_1_n_0 ;
  wire \rptr[3]_i_1_n_0 ;
  wire \rptr[4]_i_1_n_0 ;
  wire \rptr[4]_i_2_n_0 ;
  wire \rptr[5]_i_1_n_0 ;
  wire \rptr[6]_i_1_n_0 ;
  wire \rptr[7]_i_1_n_0 ;
  wire \rptr[8]_i_1_n_0 ;
  wire \rptr[9]_i_2_n_0 ;
  wire [9:0]rptr_reg;
  wire [7:0]wdata;
  wire [7:0]wdata_IBUF;
  wire wen;
  wire wen_IBUF;
  wire [9:0]wptr;
  wire \wptr[8]_i_2_n_0 ;
  wire \wptr[9]_i_2_n_0 ;
  wire [9:0]wptr_OBUF;
  wire [3:0]NLW_empty_reg_i_2_O_UNCONNECTED;
  wire [3:1]NLW_full_reg_i_3_CO_UNCONNECTED;
  wire [3:2]NLW_full_reg_i_3_O_UNCONNECTED;
  wire [3:3]NLW_full_reg_i_4_CO_UNCONNECTED;
  wire [3:0]NLW_full_reg_i_4_O_UNCONNECTED;
  wire [15:0]NLW_mem_reg_DOADO_UNCONNECTED;
  wire [15:8]NLW_mem_reg_DOBDO_UNCONNECTED;
  wire [1:0]NLW_mem_reg_DOPADOP_UNCONNECTED;
  wire [1:0]NLW_mem_reg_DOPBDOP_UNCONNECTED;

  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  OBUF empty_OBUF_inst
       (.I(empty_OBUF),
        .O(empty));
  LUT1 #(
    .INIT(2'h1)) 
    empty_i_1
       (.I0(n_rst_IBUF),
        .O(empty_i_1_n_0));
  LUT4 #(
    .INIT(16'h6A95)) 
    empty_i_3
       (.I0(p_1_in),
        .I1(\rptr[9]_i_2_n_0 ),
        .I2(rptr_reg[8]),
        .I3(rptr_reg[9]),
        .O(empty_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    empty_i_4
       (.I0(empty_reg_i_7_n_5),
        .I1(\rptr[6]_i_1_n_0 ),
        .I2(\rptr[8]_i_1_n_0 ),
        .I3(full_reg_i_3_n_7),
        .I4(\rptr[7]_i_1_n_0 ),
        .I5(empty_reg_i_7_n_4),
        .O(empty_i_4_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    empty_i_5
       (.I0(empty_reg_i_8_n_4),
        .I1(\rptr[3]_i_1_n_0 ),
        .I2(\rptr[5]_i_1_n_0 ),
        .I3(empty_reg_i_7_n_6),
        .I4(\rptr[4]_i_1_n_0 ),
        .I5(empty_reg_i_7_n_7),
        .O(empty_i_5_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    empty_i_6
       (.I0(empty_reg_i_8_n_7),
        .I1(\rptr[0]_i_1_n_0 ),
        .I2(\rptr[2]_i_1_n_0 ),
        .I3(empty_reg_i_8_n_5),
        .I4(\rptr[1]_i_1_n_0 ),
        .I5(empty_reg_i_8_n_6),
        .O(empty_i_6_n_0));
  LUT3 #(
    .INIT(8'h9A)) 
    empty_i_9
       (.I0(wptr_OBUF[0]),
        .I1(full_OBUF),
        .I2(wen_IBUF),
        .O(empty_i_9_n_0));
  FDSE #(
    .INIT(1'b1)) 
    empty_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(empty_n),
        .Q(empty_OBUF),
        .S(empty_i_1_n_0));
  CARRY4 empty_reg_i_2
       (.CI(1'b0),
        .CO({empty_n,empty_reg_i_2_n_1,empty_reg_i_2_n_2,empty_reg_i_2_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_empty_reg_i_2_O_UNCONNECTED[3:0]),
        .S({empty_i_3_n_0,empty_i_4_n_0,empty_i_5_n_0,empty_i_6_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 empty_reg_i_7
       (.CI(empty_reg_i_8_n_0),
        .CO({empty_reg_i_7_n_0,empty_reg_i_7_n_1,empty_reg_i_7_n_2,empty_reg_i_7_n_3}),
        .CYINIT(1'b0),
        .DI(wptr_OBUF[7:4]),
        .O({empty_reg_i_7_n_4,empty_reg_i_7_n_5,empty_reg_i_7_n_6,empty_reg_i_7_n_7}),
        .S(wptr_OBUF[7:4]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 empty_reg_i_8
       (.CI(1'b0),
        .CO({empty_reg_i_8_n_0,empty_reg_i_8_n_1,empty_reg_i_8_n_2,empty_reg_i_8_n_3}),
        .CYINIT(1'b0),
        .DI(wptr_OBUF[3:0]),
        .O({empty_reg_i_8_n_4,empty_reg_i_8_n_5,empty_reg_i_8_n_6,empty_reg_i_8_n_7}),
        .S({wptr_OBUF[3:1],empty_i_9_n_0}));
  OBUF full_OBUF_inst
       (.I(full_OBUF),
        .O(full));
  LUT6 #(
    .INIT(64'h0000000096000000)) 
    full_i_1
       (.I0(rptr_reg[9]),
        .I1(full_i_2_n_0),
        .I2(p_1_in),
        .I3(full_reg_i_4_n_1),
        .I4(n_rst_IBUF),
        .I5(empty_n),
        .O(full_i_1_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    full_i_2
       (.I0(rptr_reg[8]),
        .I1(rptr_reg[6]),
        .I2(rptr_reg[4]),
        .I3(\rptr[4]_i_2_n_0 ),
        .I4(rptr_reg[5]),
        .I5(rptr_reg[7]),
        .O(full_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    full_i_5
       (.I0(empty_reg_i_7_n_5),
        .I1(\rptr[6]_i_1_n_0 ),
        .I2(\rptr[8]_i_1_n_0 ),
        .I3(full_reg_i_3_n_7),
        .I4(\rptr[7]_i_1_n_0 ),
        .I5(empty_reg_i_7_n_4),
        .O(full_i_5_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    full_i_6
       (.I0(empty_reg_i_8_n_4),
        .I1(\rptr[3]_i_1_n_0 ),
        .I2(\rptr[5]_i_1_n_0 ),
        .I3(empty_reg_i_7_n_6),
        .I4(\rptr[4]_i_1_n_0 ),
        .I5(empty_reg_i_7_n_7),
        .O(full_i_6_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    full_i_7
       (.I0(empty_reg_i_8_n_7),
        .I1(\rptr[0]_i_1_n_0 ),
        .I2(\rptr[2]_i_1_n_0 ),
        .I3(empty_reg_i_8_n_5),
        .I4(\rptr[1]_i_1_n_0 ),
        .I5(empty_reg_i_8_n_6),
        .O(full_i_7_n_0));
  FDRE #(
    .INIT(1'b0)) 
    full_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(full_i_1_n_0),
        .Q(full_OBUF),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 full_reg_i_3
       (.CI(empty_reg_i_7_n_0),
        .CO({NLW_full_reg_i_3_CO_UNCONNECTED[3:1],full_reg_i_3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,wptr_OBUF[8]}),
        .O({NLW_full_reg_i_3_O_UNCONNECTED[3:2],p_1_in,full_reg_i_3_n_7}),
        .S({1'b0,1'b0,wptr_OBUF[9:8]}));
  CARRY4 full_reg_i_4
       (.CI(1'b0),
        .CO({NLW_full_reg_i_4_CO_UNCONNECTED[3],full_reg_i_4_n_1,full_reg_i_4_n_2,full_reg_i_4_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_full_reg_i_4_O_UNCONNECTED[3:0]),
        .S({1'b0,full_i_5_n_0,full_i_6_n_0,full_i_7_n_0}));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d8" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d8" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "line_buffer/mem_reg" *) 
  (* RTL_RAM_STYLE = "auto" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "512" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "7" *) 
  RAMB18E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    mem_reg
       (.ADDRARDADDR({1'b1,wptr_OBUF[8:0],1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,rptr_reg[8:0],1'b1,1'b1,1'b1,1'b1}),
        .CLKARDCLK(clk_IBUF_BUFG),
        .CLKBWRCLK(clk_IBUF_BUFG),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,wdata_IBUF}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO(NLW_mem_reg_DOADO_UNCONNECTED[15:0]),
        .DOBDO({NLW_mem_reg_DOBDO_UNCONNECTED[15:8],rdata_OBUF}),
        .DOPADOP(NLW_mem_reg_DOPADOP_UNCONNECTED[1:0]),
        .DOPBDOP(NLW_mem_reg_DOPBDOP_UNCONNECTED[1:0]),
        .ENARDEN(wen_IBUF),
        .ENBWREN(ren_IBUF),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({1'b1,1'b1}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
  IBUF n_rst_IBUF_inst
       (.I(n_rst),
        .O(n_rst_IBUF));
  OBUF \rdata_OBUF[0]_inst 
       (.I(rdata_OBUF[0]),
        .O(rdata[0]));
  OBUF \rdata_OBUF[1]_inst 
       (.I(rdata_OBUF[1]),
        .O(rdata[1]));
  OBUF \rdata_OBUF[2]_inst 
       (.I(rdata_OBUF[2]),
        .O(rdata[2]));
  OBUF \rdata_OBUF[3]_inst 
       (.I(rdata_OBUF[3]),
        .O(rdata[3]));
  OBUF \rdata_OBUF[4]_inst 
       (.I(rdata_OBUF[4]),
        .O(rdata[4]));
  OBUF \rdata_OBUF[5]_inst 
       (.I(rdata_OBUF[5]),
        .O(rdata[5]));
  OBUF \rdata_OBUF[6]_inst 
       (.I(rdata_OBUF[6]),
        .O(rdata[6]));
  OBUF \rdata_OBUF[7]_inst 
       (.I(rdata_OBUF[7]),
        .O(rdata[7]));
  IBUF ren_IBUF_inst
       (.I(ren),
        .O(ren_IBUF));
  LUT3 #(
    .INIT(8'h9A)) 
    \rptr[0]_i_1 
       (.I0(rptr_reg[0]),
        .I1(empty_OBUF),
        .I2(ren_IBUF),
        .O(\rptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hF708)) 
    \rptr[1]_i_1 
       (.I0(rptr_reg[0]),
        .I1(ren_IBUF),
        .I2(empty_OBUF),
        .I3(rptr_reg[1]),
        .O(\rptr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hBFFF4000)) 
    \rptr[2]_i_1 
       (.I0(empty_OBUF),
        .I1(ren_IBUF),
        .I2(rptr_reg[0]),
        .I3(rptr_reg[1]),
        .I4(rptr_reg[2]),
        .O(\rptr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFF7FFFFF00800000)) 
    \rptr[3]_i_1 
       (.I0(rptr_reg[1]),
        .I1(rptr_reg[0]),
        .I2(ren_IBUF),
        .I3(empty_OBUF),
        .I4(rptr_reg[2]),
        .I5(rptr_reg[3]),
        .O(\rptr[3]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \rptr[4]_i_1 
       (.I0(\rptr[4]_i_2_n_0 ),
        .I1(rptr_reg[4]),
        .O(\rptr[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000800000000000)) 
    \rptr[4]_i_2 
       (.I0(rptr_reg[3]),
        .I1(rptr_reg[1]),
        .I2(rptr_reg[0]),
        .I3(ren_IBUF),
        .I4(empty_OBUF),
        .I5(rptr_reg[2]),
        .O(\rptr[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \rptr[5]_i_1 
       (.I0(\rptr[4]_i_2_n_0 ),
        .I1(rptr_reg[4]),
        .I2(rptr_reg[5]),
        .O(\rptr[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \rptr[6]_i_1 
       (.I0(rptr_reg[4]),
        .I1(\rptr[4]_i_2_n_0 ),
        .I2(rptr_reg[5]),
        .I3(rptr_reg[6]),
        .O(\rptr[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \rptr[7]_i_1 
       (.I0(rptr_reg[5]),
        .I1(\rptr[4]_i_2_n_0 ),
        .I2(rptr_reg[4]),
        .I3(rptr_reg[6]),
        .I4(rptr_reg[7]),
        .O(\rptr[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \rptr[8]_i_1 
       (.I0(rptr_reg[6]),
        .I1(rptr_reg[4]),
        .I2(\rptr[4]_i_2_n_0 ),
        .I3(rptr_reg[5]),
        .I4(rptr_reg[7]),
        .I5(rptr_reg[8]),
        .O(\rptr[8]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \rptr[9]_i_1 
       (.I0(\rptr[9]_i_2_n_0 ),
        .I1(rptr_reg[8]),
        .I2(rptr_reg[9]),
        .O(p_0_in));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \rptr[9]_i_2 
       (.I0(rptr_reg[7]),
        .I1(rptr_reg[5]),
        .I2(\rptr[4]_i_2_n_0 ),
        .I3(rptr_reg[4]),
        .I4(rptr_reg[6]),
        .O(\rptr[9]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\rptr[0]_i_1_n_0 ),
        .Q(rptr_reg[0]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\rptr[1]_i_1_n_0 ),
        .Q(rptr_reg[1]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\rptr[2]_i_1_n_0 ),
        .Q(rptr_reg[2]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\rptr[3]_i_1_n_0 ),
        .Q(rptr_reg[3]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\rptr[4]_i_1_n_0 ),
        .Q(rptr_reg[4]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\rptr[5]_i_1_n_0 ),
        .Q(rptr_reg[5]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\rptr[6]_i_1_n_0 ),
        .Q(rptr_reg[6]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\rptr[7]_i_1_n_0 ),
        .Q(rptr_reg[7]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\rptr[8]_i_1_n_0 ),
        .Q(rptr_reg[8]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \rptr_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in),
        .Q(rptr_reg[9]),
        .R(empty_i_1_n_0));
  IBUF \wdata_IBUF[0]_inst 
       (.I(wdata[0]),
        .O(wdata_IBUF[0]));
  IBUF \wdata_IBUF[1]_inst 
       (.I(wdata[1]),
        .O(wdata_IBUF[1]));
  IBUF \wdata_IBUF[2]_inst 
       (.I(wdata[2]),
        .O(wdata_IBUF[2]));
  IBUF \wdata_IBUF[3]_inst 
       (.I(wdata[3]),
        .O(wdata_IBUF[3]));
  IBUF \wdata_IBUF[4]_inst 
       (.I(wdata[4]),
        .O(wdata_IBUF[4]));
  IBUF \wdata_IBUF[5]_inst 
       (.I(wdata[5]),
        .O(wdata_IBUF[5]));
  IBUF \wdata_IBUF[6]_inst 
       (.I(wdata[6]),
        .O(wdata_IBUF[6]));
  IBUF \wdata_IBUF[7]_inst 
       (.I(wdata[7]),
        .O(wdata_IBUF[7]));
  IBUF wen_IBUF_inst
       (.I(wen),
        .O(wen_IBUF));
  LUT3 #(
    .INIT(8'h9A)) 
    \wptr[0]_i_1 
       (.I0(wptr_OBUF[0]),
        .I1(full_OBUF),
        .I2(wen_IBUF),
        .O(p_1_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hF708)) 
    \wptr[1]_i_1 
       (.I0(wptr_OBUF[0]),
        .I1(wen_IBUF),
        .I2(full_OBUF),
        .I3(wptr_OBUF[1]),
        .O(p_1_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hBFFF4000)) 
    \wptr[2]_i_1 
       (.I0(full_OBUF),
        .I1(wen_IBUF),
        .I2(wptr_OBUF[0]),
        .I3(wptr_OBUF[1]),
        .I4(wptr_OBUF[2]),
        .O(p_1_in__0[2]));
  LUT6 #(
    .INIT(64'hFF7FFFFF00800000)) 
    \wptr[3]_i_1 
       (.I0(wptr_OBUF[1]),
        .I1(wptr_OBUF[0]),
        .I2(wen_IBUF),
        .I3(full_OBUF),
        .I4(wptr_OBUF[2]),
        .I5(wptr_OBUF[3]),
        .O(p_1_in__0[3]));
  LUT2 #(
    .INIT(4'h6)) 
    \wptr[4]_i_1 
       (.I0(\wptr[8]_i_2_n_0 ),
        .I1(wptr_OBUF[4]),
        .O(p_1_in__0[4]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \wptr[5]_i_1 
       (.I0(\wptr[8]_i_2_n_0 ),
        .I1(wptr_OBUF[4]),
        .I2(wptr_OBUF[5]),
        .O(p_1_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \wptr[6]_i_1 
       (.I0(wptr_OBUF[4]),
        .I1(\wptr[8]_i_2_n_0 ),
        .I2(wptr_OBUF[5]),
        .I3(wptr_OBUF[6]),
        .O(p_1_in__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \wptr[7]_i_1 
       (.I0(wptr_OBUF[5]),
        .I1(\wptr[8]_i_2_n_0 ),
        .I2(wptr_OBUF[4]),
        .I3(wptr_OBUF[6]),
        .I4(wptr_OBUF[7]),
        .O(p_1_in__0[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \wptr[8]_i_1 
       (.I0(wptr_OBUF[6]),
        .I1(wptr_OBUF[4]),
        .I2(\wptr[8]_i_2_n_0 ),
        .I3(wptr_OBUF[5]),
        .I4(wptr_OBUF[7]),
        .I5(wptr_OBUF[8]),
        .O(p_1_in__0[8]));
  LUT6 #(
    .INIT(64'h0000800000000000)) 
    \wptr[8]_i_2 
       (.I0(wptr_OBUF[3]),
        .I1(wptr_OBUF[1]),
        .I2(wptr_OBUF[0]),
        .I3(wen_IBUF),
        .I4(full_OBUF),
        .I5(wptr_OBUF[2]),
        .O(\wptr[8]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \wptr[9]_i_1 
       (.I0(\wptr[9]_i_2_n_0 ),
        .I1(wptr_OBUF[8]),
        .I2(wptr_OBUF[9]),
        .O(p_1_in__0[9]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \wptr[9]_i_2 
       (.I0(wptr_OBUF[7]),
        .I1(wptr_OBUF[5]),
        .I2(\wptr[8]_i_2_n_0 ),
        .I3(wptr_OBUF[4]),
        .I4(wptr_OBUF[6]),
        .O(\wptr[9]_i_2_n_0 ));
  OBUF \wptr_OBUF[0]_inst 
       (.I(wptr_OBUF[0]),
        .O(wptr[0]));
  OBUF \wptr_OBUF[1]_inst 
       (.I(wptr_OBUF[1]),
        .O(wptr[1]));
  OBUF \wptr_OBUF[2]_inst 
       (.I(wptr_OBUF[2]),
        .O(wptr[2]));
  OBUF \wptr_OBUF[3]_inst 
       (.I(wptr_OBUF[3]),
        .O(wptr[3]));
  OBUF \wptr_OBUF[4]_inst 
       (.I(wptr_OBUF[4]),
        .O(wptr[4]));
  OBUF \wptr_OBUF[5]_inst 
       (.I(wptr_OBUF[5]),
        .O(wptr[5]));
  OBUF \wptr_OBUF[6]_inst 
       (.I(wptr_OBUF[6]),
        .O(wptr[6]));
  OBUF \wptr_OBUF[7]_inst 
       (.I(wptr_OBUF[7]),
        .O(wptr[7]));
  OBUF \wptr_OBUF[8]_inst 
       (.I(wptr_OBUF[8]),
        .O(wptr[8]));
  OBUF \wptr_OBUF[9]_inst 
       (.I(wptr_OBUF[9]),
        .O(wptr[9]));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[0]),
        .Q(wptr_OBUF[0]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[1]),
        .Q(wptr_OBUF[1]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[2]),
        .Q(wptr_OBUF[2]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[3]),
        .Q(wptr_OBUF[3]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[4]),
        .Q(wptr_OBUF[4]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[5]),
        .Q(wptr_OBUF[5]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[6]),
        .Q(wptr_OBUF[6]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[7]),
        .Q(wptr_OBUF[7]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[8]),
        .Q(wptr_OBUF[8]),
        .R(empty_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wptr_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in__0[9]),
        .Q(wptr_OBUF[9]),
        .R(empty_i_1_n_0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
