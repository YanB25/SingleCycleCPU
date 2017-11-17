`timescale 1ns / 1ps
module display_tb();
    wire clk;
    wire clk1k5;
    wire [15:0]disp_data = 16'h1a9b;
    clk_div clk_div_(
        .clk(clk),
        .clk1k5(clk1k5)
    );
    wire clr = 0;
    wire pos_ctrl;
    wire num_ctrl;
    displayReg display_reg(
        .CLK_190hz(clk1k5),
        .disp_data(disp_data),
        .clr(clr),
        .pos_ctrl(pos_ctrl),
        .num_ctrl(nnum_ctrl)
    );
endmodule