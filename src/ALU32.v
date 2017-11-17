`timescale 1ns / 1ps
`include "head.v"
module ALU32(
    input [2:0] ALUopcode,
    input [31:0] rega,
    input [31:0] regb,
    output reg [31:0] result,
    output zero
    );
    assign zero = (result==0)?1:0;
    always @(*) begin
        case (ALUopcode)
            `ALUAdd : result = rega + regb;
            `ALUSub : result = rega - regb;
            `ALUAnd : result = rega & regb;
            `ALUOr : result = rega | regb;
            `ALUCmpu : result = (rega < regb)?1:0; // 不带符号比较
            `ALUCmps : begin // 带符号比较
                if (rega<regb &&(( rega[31] == 0 && regb[31]==0) ||
                    (rega[31] == 1 && regb[31]==1))) result = 1;
                else if (rega[31] == 0 && regb[31]==1) result = 0;
                else if ( rega[31] == 1 && regb[31]==0) result = 1;
                else result = 0;
            `ALUSll : result = regb << reba;
            end
            default : begin
                result = 8'h00000000;
                $display (" no match");
            end
        endcase
    end
endmodule