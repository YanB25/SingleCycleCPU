module ROM (  
    input nrd, 
    input [31:0] addr, 
    output reg [31:0] dataOut
    ); // 存储器模块

    reg [7:0] rom [99:0]; // 存储器定义必须用reg类型，存储器存储单元8位长度，共100个存储单元
    initial begin // 加载数据到存储器rom。注意：必须使用绝对路径，如：E:/Xlinx/VivadoProject/ROM/（自己定）
        $readmemb ("E:/Xlinx/VivadoProject/ROM/rom_data.txt", rom); // 数据文件rom_data（.coe或.txt）。未指定，就从0地址开始存放。
    end
    always @(*) begin
        if (nrd == 0) begin// 为0，读存储器。大端数据存储模式
            dataOut[31:24] = rom[addr];
            dataOut[23:16] = rom[addr+1];
            dataOut[15:8] = rom[addr+2];
            dataOut[7:0] = rom[addr+3];
        end else begin
            dataOut[31:0] = {32{1'bz}}; //TODO : maybe bug
        end
    end
endmodule
 
