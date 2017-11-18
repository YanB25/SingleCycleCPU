`timescale 1ns/1ps
module top_tb();
reg clk = 0;
reg RST = 1;
always begin
    #5;
    clk = ~clk;
end
initial begin
    #1;
    RST = 0;
    #1;
    RST = 1;
end
    CPU cpu(
        .clk(clk),
        .RST(RST)
    );
endmodule