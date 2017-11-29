module ContolUnit (OpCode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

input wire [5:0] OpCode;

output wire RegDst;
output wire Branch;
output wire MemRead;
output wire MemtoReg;
output wire [1:0] ALUOp;
output wire MemWrite;
output wire ALUSrc;
output wire RegWrite;

//R instruction
if (OpCode==6'b000000)
begin
RegDst=1'b1;
Branch=1'b0;
MemRead=1'b0;
MemtoReg=1'b0;
ALUOp=2'b10;
MemWrite=1'b0;
ALUSrc=1'b0;
RegWrite=1'b1;
end

//lw instruction
if (OpCode==6'b100011)
begin
RegDst=1'b0;
Branch=1'b0;
MemRead=1'b1;
MemtoReg=1'b1;
ALUOp=2'b00;
MemWrite=1'b0;
ALUSrc=1'b1;
RegWrite=1'b1;
end

//sw instruction
if (OpCode==6'b101011)
begin
RegDst=1'bx;
Branch=1'b0;
MemRead=1'b0;
MemtoReg=1'bx;
ALUOp=2'b00;
MemWrite=1'b1;
ALUSrc=1'b1;
RegWrite=1'b0;
end

//beq instruction
if (OpCode==6'b000100)
begin
RegDst=1'bx;
Branch=1'b1;
MemRead=1'b0;
MemtoReg=1'bx;
ALUOp=2'b01;
MemWrite=1'b0;
ALUSrc=1'b0;
RegWrite=1'b0;
end




