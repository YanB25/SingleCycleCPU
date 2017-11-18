`include "head.v"
`timescale 1ns/ 1ps
module Extend(
    input [15:0] immd16,
    input extSel,
    output [31:0] exd_immd
    );
    wire e;
    assign e = extSel & immd16[15];
    assign exd_immd = {{16{e}}, immd16};
endmodule