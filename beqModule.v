module beqModule (Branch, ZeroFlag, PcP4, Address, pc,mux2in);

input wire Branch;
input wire ZeroFlag;
input wire [31:0] PcP4;
input wire [15:0] Address;

output wire [31:0] pc;

wire PcSrc;
wire [31:0]sign_out;
wire [31:0] add_in;
wire [31:0] add_out;
output wire [31:0] mux2in;
assign mux2in=sign_out;
assign PcSrc = Branch & ZeroFlag;
sign_extend sign_extend(Address,sign_out);
assign add_in = sign_out<<1;
assign add_out = PcP4 + add_in;
MUX_2_to_1 MUX_2_to_1(PcP4,add_out,PcSrc,pc);

endmodule