`timescale 100s/1s
module clk( myclk);
output reg myclk;
initial
begin
myclk<=1;
end
always
begin
#1 myclk=~myclk;
end
endmodule
