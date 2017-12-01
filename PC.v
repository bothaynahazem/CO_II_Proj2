module PC(clk,pc,pctoimem,PcP4);
input clk;
input[31:0]pc;
output reg[31:0]pctoimem;
output reg[31:0]PcP4;
always@(posedge clk)
begin
pctoimem=pc;
PcP4=pctoimem+4;
PC=pc;
end
endmodule
