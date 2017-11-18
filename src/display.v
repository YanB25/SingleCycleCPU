`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/09 09:29:48
// Design Name: 
// Module Name: displayReg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module displayReg(
        input wire CLK_190hz,
        input wire [15:0]disp_data,
        input wire clr,
        output wire [3:0]pos_ctrl,
        output wire [7:0]num_ctrl
    );
    reg [3:0] pos_sign = 4'b1011;
    
    always@(posedge CLK_190hz) begin
      pos_sign = {pos_sign[0], pos_sign[3:1]};
    end
    assign pos_ctrl = pos_sign;
    
    reg [3:0] cur_data;
    always@(*) begin
        if (clr == 0) 
            cur_data = 4'b1111;
        else
          case(pos_sign)
                4'b0111: cur_data = disp_data[15:12];
                4'b1011: cur_data = disp_data[11:8];
                4'b1101: cur_data = disp_data[7:4];
                4'b1110: cur_data = disp_data[3:0];
                default: cur_data = 4'b0000;
          endcase
    end
    
    reg[7:0] num_sign;
    always @(cur_data) begin
      case(cur_data)
            4'h0:num_sign=8'b1100_0000;//0
            4'h1:num_sign=8'b1111_1001;//1
            4'h2:num_sign=8'b1010_0100;//2
            4'h3:num_sign=8'b1011_0000;//3
            4'h4:num_sign=8'b1001_1001;//4
            4'h5:num_sign=8'b1001_0010;//5
            4'h6:num_sign=8'b1000_0010;//6
            4'h7:num_sign=8'b1111_1000;//7
            4'h8:num_sign=8'b1000_0000;//8
            4'h9:num_sign=8'b1001_0000;//9
            4'ha:num_sign=8'b1000_1000;//A
            4'hb:num_sign=8'b1000_0011;//b
            4'hc:num_sign=8'b1100_0110;//C
            4'hd:num_sign=8'b1010_0001;//d
            4'he:num_sign=8'b1000_0110;//E
            4'hf:num_sign=8'b1000_1110;//F
            default: num_sign = 8'b1111_1111;
       endcase
    end 
    
    assign num_ctrl = num_sign;
endmodule



