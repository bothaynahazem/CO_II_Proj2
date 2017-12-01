module DataMem(input clk,input [31:0] address,input [31:0] writedata,input MemWrite,input  MemRead,output reg[31:0] ReadData);
 reg[31:0] DMemory[0:1023];
always@(posedge clk)
begin
if(MemWrite)
begin
DMemory[address>>2]<=writedata;
end
if(MemRead)
begin
ReadData<=DMemory[address>>2];
end
end
endmodule