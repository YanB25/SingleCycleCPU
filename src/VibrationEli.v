`timescale 1ns / 1ps
//module VibrationEli(
//    input wire clk,
//    input wire key_in,
//    output reg sig_out,
//    input wire RESET
//    );
//    reg [24:0]delay_cnt = 0;
//    reg bloking = 0;
//    reg out = 0;
//    always@(posedge key_in) begin
//        sig_out = 1;
//        if (!clk) delay_cnt = 0; 
//    end
//    always@(posedge clk) begin
//        if (RESET) delay_cnt = 0;
//        else delay_cnt <= delay_cnt + 1;
//        if (delay_cnt[24] == 1 && !key_in) sig_out = 0;
//    end
//endmodule

`define UD #1
module VibrationEli(
     input clk,
     
     input key_in,
     output sig_out
    );

    // inner signal
    reg [1:0] key_in_r;
    wire pp;
    reg [19:0] cnt_base;
    reg key_value_r;
    
    //内部信号
    always @(posedge clk)
        key_in_r<= `UD {key_in_r[0],key_in};
    
    // 检测有输入有没有变化
    assign pp = key_in_r[0]^key_in_r[1]; 
    
    //延迟计数器
    always@(posedge clk)
        if(pp==1'b1)
           cnt_base <= `UD 20'd0;
        else
           cnt_base <= `UD cnt_base + 1;
    
    //输出
    always @(posedge clk)
       if(cnt_base==20'hf_ffff)
            key_value_r <= `UD key_in_r[0];
    
    assign sig_out = key_value_r;
endmodule