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
assign RegDst=1'b1;
assign Branch=1'b0;
assign MemRead=1'b0;
assign MemtoReg=1'b0;
assign ALUOp=2'b10;
assign MemWrite=1'b0;
assign ALUSrc=1'b0;
assign RegWrite=1'b1;
end

//lw instruction
if (OpCode==6'b100011)
begin
assign RegDst=1'b0;
assign Branch=1'b0;
assign MemRead=1'b1;
assign MemtoReg=1'b1;
assign ALUOp=2'b00;
assign MemWrite=1'b0;
assign ALUSrc=1'b1;
assign RegWrite=1'b1;
end

//sw instruction
if (OpCode==6'b101011)
begin
assign RegDst=1'bx;
assign Branch=1'b0;
assign MemRead=1'b0;
assign MemtoReg=1'bx;
assign ALUOp=2'b00;
assign MemWrite=1'b1;
assign ALUSrc=1'b1;
assign RegWrite=1'b0;
end

//beq instruction
if (OpCode==6'b000100)
begin
assign RegDst=1'bx;
assign Branch=1'b1;
assign MemRead=1'b0;
assign MemtoReg=1'bx;
assign ALUOp=2'b01;
assign MemWrite=1'b0;
assign ALUSrc=1'b0;
assign RegWrite=1'b0;
end

endmodule


