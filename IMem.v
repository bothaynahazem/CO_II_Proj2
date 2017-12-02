module IMem(input clk,input[31:0] pcaddress,output [31:0] instruction);
reg [31:0] IMemory[0:1023];
initial 
begin
$readmemb("input.txt",IMemory);
end
assign instruction=IMemory[pcaddress>>2];
endmodule
