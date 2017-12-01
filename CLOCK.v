module clk(clk);
output reg clk=0;
reg [31:0] invertings;
integer index;
always@(1)
begin
for(index=0;index<32;index=index+1)
begin
invertings[index]=~clk;
end
clk=invertings[31];
end
endmodule