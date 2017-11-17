`timescale 1ns / 1ps
module VibrationEli(
    input wire clk,
    input wire key_in,
    output sig_out
    );
    reg [24:0]delay_cnt = 0;
    always@(posedge clk) begin
        if (delay_cnt[24] == 1)
            delay_cnt <= 0;
        else if (delay_cnt != 0)
            delay_cnt <= delay_cnt + 1;
    end
    always@(posedge key_in) begin
        if (delay_cnt== 0) begin
            sig_out <= 1;
            delay_cnt <= 1;
        end
        if (delay_cnt[10] == 1) begin
            sig_out <= 0;
        end
    end
endmodule