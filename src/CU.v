`include "head.v"
`timescale 1ns / 1ps
module CU (
    input [5:0]Op,
    input [5:0]Func,
    input ZERO,
    input SIGN,
    output ALUScrA,
    output reg ALUScrB,
    output DB,
    output reg RegWr,
    output nRD,
    output nWR,
    output RegDst,
    output ExtSel,
    output reg [1:0]PCSel,
    output reg [2:0]ALUop
    );
    assign ALUScrA = (Op == `opSLL && Func == `funcSLL) ? `FromSA : `FromData;
    // ALUScrB
    always@(*) begin
        case (Op)
            `opADDI, `opORI, `opSW, `opLW : ALUScrB = `FromImmd;
            default : ALUScrB = `FromData;
        endcase
    end
    // DB
    assign DB = (Op == `opLW) ? `FromDM : `FromALU;
    //RegWr
    always@(*) begin
        case (Op)
            `opSW, `opBEQ, `opBNE, `opBGTZ, `opJ, `opHALT : RegWr = 0;
            default : RegWr = 1;
        endcase
    end
    // nRD
    assign nRD = (Op == `opLW) ? 0 : 1;
    // nWR
    assign nWR = (Op == `opSW) ? 0: 1;
    // RegDst
    assign RegDst = (Op == `opLW) ? `FromRt : `FromRd;
    // ExtSel
    assign ExtSel = (Op == `opORI) ? `ZeroExd : `SignExd;
    // PCSel
    always@(*) begin
        case (Op) 
            `opBEQ : PCSel = ZERO == 1 ? `RelJmp : `NextIns;
            `opBNE : PCSel = ZERO == 0 ? `RelJmp : `NextIns;
            `opBGTZ : PCSel = SIGN == 0 ? `RelJmp : `NextIns;
            `opJ : PCSel = `AbsJmp;
            `opHALT : PCSel = `HALT;
            default : PCSel =  `NextIns;
        endcase
    end
    
    // ALUop
    always@(*) begin
        case (Op)
            `opRFormat : begin
                case(Func)
                    `funcADD : ALUop = `ALUAdd;
                    `funcSUB : ALUop = `ALUSub;
                    `funcAND : ALUop = `ALUAnd;
                    `funcOR : ALUop = `ALUOr;
                    `funcSLL : ALUop = `ALUSll;
                    `funcSLT : ALUop = `ALUCmps;
                endcase
            end
            `opORI : ALUop = `ALUOr;
            `opBEQ, `opBNE, `opBGTZ : ALUop = `ALUSub;
            default : ALUop = `ALUAdd;
        endcase
    end
endmodule
            


