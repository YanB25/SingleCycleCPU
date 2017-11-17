// ALUopcode
`define ALUAdd 3'b000
`define ALUSub 3'b001
`define ALUAnd 3'b010
`define ALUOr 3'b011
`define ALUCmpu 3'b100
`define ALUCmps 3'b101
`define ALUSll 3'b110

// ALUSrcA, ALUSrcB
`define FromData 1'b0
`define FromSA 1'b1
`define FromImmd 1'b1

// DBDataSrc
`define FromALU 1'b0
`define FromDM 1'b1

// RegDst
`define FromRt 1'b0
`define FromRd 1'b1

// ExtSel
`define ZeroExd 1'b0
`define SignExd 1'b1

// PCSrc
`define NextIns 2'b00
`define RelJmp 2'b01 //relative jump
`define AbsJmp 2'b10 //absolute jump
`define HALT 2'b11 // halt