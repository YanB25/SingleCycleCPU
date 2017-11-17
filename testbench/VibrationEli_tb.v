`timescale 1ns / 1ps
module VibrationEli_tb();
    wire clk;
    wire clk1k5;
    wire key_in;
    wire key_out;
    reg [3:0] cnt = 0;
    always@(posedge key_out) begin
        cnt = cnt + 1;
    end
    clk_div clk_div_(
        .clk(clk),
        .clk1k5(clk1k5)
    );
    wire [15:0]disp_data;
    assign disp_data =  {12'b0000_0000_0000, cnt};
    wire [3:0] pos_ctrl;
    wire [7:0]num_ctrl;
    displayReg display_reg(
        .CLK_190hz(clk1k5),
        .disp_data(disp_data),
        .clr(0),
        .pos_ctrl(pos_ctrl),
        .num_ctrl(num_ctrl)
    );
    VibrationEli vibration_eli(
        .clk(clk),
        .key_in(key_in),
        .sig_out(key_out)
    );
endmodule