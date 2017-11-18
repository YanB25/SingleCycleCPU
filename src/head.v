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

// for instruction
// op code
`define opRFormat 6'b000000
`define opADD 6'b000000
`define opSUB 6'b000000
`define opAND 6'b000000
`define opOR 6'b000000
`define opSLL 6'b000000
`define opSLT 6'b000000
`define opADDI 6'b001000
`define opORI 6'b001101
`define opSW 6'b101011
`define opLW 6'b100011
`define opBEQ 6'b000100
`define opBNE 6'b000101
`define opBGTZ 6'b000111
`define opJ 6'b000010
`define opHALT 6'b111111
// func code
`define funcADD 6'b100000
`define funcSUB 6'b100011
`define funcAND 6'b100100
`define funcOR 6'b100101
`define funcSLL 6'b000000
`define funcSLT 6'b101010

// for display module
`define PC_NewPC 2'b00
`define Rs_RsData 2'b01
`define Rt_RtData 2'b10
`define ALU_DB 2'b11