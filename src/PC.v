`timescale 1ns / 1ps
`include "head.v"
module PC(
    input clk,
    input RST,
    input [31:0]newpc,
    output reg [31:0]pc
    );
    always@(posedge clk or negedge RST) begin
        pc <= RST == 0 ? 0 : newpc;
    end
endmodule

module PCHelper(
    input clk,
    input RST,
    input [31:0] pc,
    input [15:0] immd16,
    input [25:0] immd26,
    input [1:0] sel,
    output reg [31:0] newpc
    );
    initial begin
        newpc = 0;
    end
    wire [31:0]exd_immd16 = { {16{immd16[15]}}, immd16};
    always@(negedge clk or negedge RST) begin
        case (sel)
            `NextIns : newpc <= RST == 0 ? 0 : pc + 4;
            `RelJmp : newpc <= RST == 0 ? 0 : (pc + 4 + (exd_immd16 << 2));
            `AbsJmp : newpc <= RST == 0 ? 0 : {pc[31:28], immd26, 2'b00};
            `HALT : newpc <= RST == 0 ? 0 : pc;
        endcase
    end
endmodule
