`include "head.v"
`timescale 1ns/1ps
module DisplaySelection(
    input [1:0] dispSel,
    input [7:0] pc,
    input [7:0] newpc,
    input [7:0] rs,
    input [7:0] rs_data,
    input [7:0] rt,
    input [7:0] rt_data,
    input [7:0] ALUResult,
    input [7:0] RegWriteData,
    output reg [15:0] disp_data
    );
    always@(*) begin
        case (dispSel)
            `PC_NewPC : disp_data = {pc, newpc};
            `Rs_RsData : disp_data = {rs, rs_data};
            `Rt_RtData : disp_data = {rt, rt_data};
            `ALU_DB : disp_data = {ALUResult, RegWriteData};
        endcase
    end

endmodule