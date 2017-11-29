module IMem(input clk,input[31:0] pc,output reg[31:0] instruction);
reg [31:0] IMemory[0:1023];
always@(posedge clk)
begin
instruction<=IMemory[pc>>2]; 
end
endmodule
