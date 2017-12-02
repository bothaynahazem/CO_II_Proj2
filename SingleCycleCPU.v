module SingleCylceCPU(clk);
input clk;
wire [3:0] OpCode;
wire [31:0] Result;
wire [31:0] readdata1,readdata2; //connecting the data read from the register to the ALU input 
wire[31:0] instruction;//instruction from imemory
wire  RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;// control unit outputs
wire [4:0] writeregister;//address of register to write 
wire [1:0] ALUOp;
wire [31:0]mux2in;
wire[31:0]mux3in;
wire[31:0] mux2out;
wire[31:0] pctoimem;
wire zero_flag;
wire[31:0] writedata;
wire [31:0]sign_out;
wire PcSrc;
wire [31:0] add_in;
reg[31:0] add_out;
reg [31:0] PcP4=0;
reg[31:0] pc=0;
//wire[31:0]PcP4;
//PC PC(clk,pc,pctoimem,PcP4);

assign PcSrc = Branch & zero_flag;
sign_extend sign_extend(instruction[15:0],sign_out);
assign add_in = sign_out<<2;
assign mux2in=sign_out;
assign pctoimem=pc;
always@(negedge clk)
begin
PcP4=pc+4;
end
always@(posedge clk)
begin
pc=PcP4;
add_out = PcP4 + add_in;
if(PcSrc==1)
begin
pc=add_out;
end
end


IMem Imemory(clk,pctoimem,instruction);
ControlUnit ControlUnit(clk,instruction[31:26], RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
regfile R1(instruction[25:21], instruction[20:16], clk, writeregister, writedata, readdata1, readdata2, RegWrite);
MUX_2_to_1 M1(instruction[20:16],instruction[15:11],RegDst,writeregister);
ALUcontrol ALUcontrol(instruction[5:0],ALUOp,OpCode);
ALU A1(readdata1, mux2out, OpCode, Result,instruction[10:6],zero_flag);
DataMem Datamemory(clk,Result,readdata2,MemWrite,MemRead,mux3in);
MUX_2_to_1 M2(readdata2,mux2in,ALUSrc,mux2out);
MUX_2_to_1 M3(Result,mux3in,MemtoReg,writedata);
endmodule

