module beqModule (clk,Branch, ZeroFlag, Address, pctoimem,mux2in);
input clk;
input wire Branch;
input wire ZeroFlag;
reg [31:0] PcP4;
input wire [15:0] Address;
reg[31:0] pc=0;
wire PcSrc;
wire [31:0]sign_out;
wire [31:0] add_in;
reg[31:0] add_out;
output wire [31:0]pctoimem;
output wire [31:0] mux2in;
assign mux2in=sign_out;
assign PcSrc = Branch & ZeroFlag;
sign_extend sign_extend(Address,sign_out);
assign add_in = sign_out<<1;
assign pctoimem=pc;
always@(posedge clk)
begin
pc=pc+4;
PcP4=pc;
add_out = PcP4 + add_in;
if(PcSrc==1)
pc=add_out;
end
endmodule