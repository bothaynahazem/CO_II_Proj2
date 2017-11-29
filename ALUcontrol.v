module ALUcontrol(Instruction, ALUOp, OpCode);

input wire [5:0] Instruction; //The part of the instruction where the function of the R-format exists
input wire [1:0] ALUOp; //coming from the Control unit
output wire [3:0] OpCode; //4 bits input (wire) to the ALU 
/*Note for the output OpCode if you wish to add addi for example,
 it'll have to be 5 bits instead of 5*/

if (ALUOp==2'b00) //add ---> loads and stores (lw & sw)
begin
assign OpCode=4'b0000; //because the add opcode is 0000
end

if (ALUOp==2'b01) //sub ---> beq
begin
assign OpCode=4'b0001;
end

if (ALUOp==2'b10) //funct ---> R-format
begin
if
begin
end

end

endmodule