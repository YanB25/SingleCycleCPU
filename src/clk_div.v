`timescale 1ns / 1ps
module clk_div(
    input clk,
    output clk1k5
    );
    reg [15:0]delay_cnt = 0;
    assign clk1k5 = delay_cnt[15];
    always@(posedge clk) begin
        delay_cnt <= delay_cnt + 1;
    end
endmodule