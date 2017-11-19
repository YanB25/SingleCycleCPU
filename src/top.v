`include "head.v"
`timescale 1ns / 1ps
module CPU (
    input clk,
    input nRST,
    input key_in,
    input [1:0]dispSel,
    output [3:0] pos_ctrl,
    output [7:0] num_ctrl
    
    );
    wire RST;
    wire press_clk;
    assign RST = ~nRST;
    wire [3:0] pos_ctrl;
    wire [7:0] num_ctrl;
    wire [31:0] pc;
    wire [31:0] newpc;
    wire [15:0] immd16;
    wire [25:0] immd26;
    wire [1:0]PCSel;
    PC pcinstance(
        .clk(press_clk),
        .RST(RST),
        .newpc(newpc),
        .pc(pc)
    );

    PCHelper pchelper(
        .pc(pc),
        .immd16(immd16),
        .immd26(immd26),
        .sel(PCSel),
        .newpc(newpc)
    );
    wire [31:0]ins;
    wire romnrd = 0;
    ROM rom(
        .nrd(romnrd),
        .addr(pc),
        .dataOut(ins)
    );

    wire [5:0] op;
    wire [5:0] func;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] sftamt;
    Decoder decoder(
        .ins(ins),
        .op(op),
        .func(func),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .immd16(immd16),
        .immd26(immd26),
        .sftamt(sftamt)
    );

    wire ZERO;
    wire SIGN;
    wire ALUScrA;
    wire ALUScrB;
    wire DB;
    wire RegWr;
    wire nRD;
    wire nWR;
    wire RegDst;
    wire ExtSel;
    wire [2:0]ALUop;
    CU cu(
        .Op(op),
        .Func(func),
        .ZERO(ZERO),
        .SIGN(SIGN),
        .ALUScrA(ALUScrA),
        .ALUScrB(ALUScrB),
        .DB(DB),
        .RegWr(RegWr),
        .nRD(nRD),
        .nWR(nWR),
        .RegDst(RegDst),
        .ExtSel(ExtSel),
        .PCSel(PCSel),
        .ALUop(ALUop)
    );

    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [4:0] WriteReg;
    assign WriteReg = RegDst == `FromRt ? rt : rd;
    wire [31:0] RegWriteData;
    wire [31:0] ALUResult;
    wire [31:0] RAMOut;
    assign RegWriteData = DB == `FromALU ? ALUResult : RAMOut;
    RegFile regfile(
        .CLK(press_clk),
        .RST(RST),
        .RegWre(RegWr),
        .ReadReg1(rs),
        .ReadReg2(rt),
        .WriteReg(WriteReg),
        .WriteData(RegWriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    wire [31:0] exd_immd;
    Extend extend(
        .immd16(immd16),
        .extSel(ExtSel),
        .exd_immd(exd_immd)
    );

    wire [31:0] ALUa;
    wire [31:0] zexd_sftamt;
    assign zexd_sftamt = {{27{1'b0}}, sftamt}; //TODO can this work?
    assign ALUa = ALUScrA == `FromData ? ReadData1 : zexd_sftamt;
    wire [31:0] ALUb;
    assign ALUb = ALUScrB == `FromData ? ReadData2 : exd_immd;
    ALU32 alu32(
        .ALUopcode(ALUop),
        .rega(ALUa),
        .regb(ALUb),
        .result(ALUResult),
        .zero(ZERO),
        .sign(SIGN)
    );

    RAM ram(
        .clk(press_clk),
        .address(ALUResult),
        .writeData(ReadData2),
        .nRD(nRD),
        .nWR(nWR),
        .Dataout(RAMOut)
    );

    // below for vitration elimination and display
    wire clk1k5;
    clk_div clk_div_instance(
        .clk(clk),
        .clk1k5(clk1k5)
    );
    wire [15:0] disp_data; 
    DisplaySelection display_selection(
        .dispSel(dispSel),
        .pc(pc[7:0]),
        .newpc(newpc[7:0]),
        .rs({3'b000, rs}),
        .rs_data(ReadData1[7:0]),
        .rt({3'b000, rt}),
        .rt_data(ReadData2[7:0]),
        .ALUResult(ALUResult[7:0]),
        .RegWriteData(RegWriteData[7:0]),
        .disp_data(disp_data)
    );

    displayReg display_reg(
        .CLK_190hz(clk1k5),
        .disp_data(disp_data),
        .clr(RST),
        .pos_ctrl(pos_ctrl),
        .num_ctrl(num_ctrl)
    );
    wire npress_clk;
    assign press_clk = ~npress_clk;
    VibrationEli vibrationeli(
        .clk(clk),
        .key_in(key_in),
        .sig_out(npress_clk)
    );
endmodule