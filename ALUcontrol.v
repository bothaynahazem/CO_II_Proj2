module ALUcontrol(Instruction, wire ALUOp, OpCode);

input wire [5:0] Instruction; //The instruction coming from the Imemory
input wire [1:0] ALUOp; //coming from the Control unit
output wire [3:0] OpCode; //4 bits input (wire) to the ALU 
/*Note for the output OpCode if you wish to add addi for example,
 it'll have to be 5 bits instead of 5*/

if (ALUOp==2'b00) //add ---> loads and stores (lw & sw)
begin

end

if (ALUOp==2'b01) //sub ---> beq
begin
end

if (ALUOp==2'b10) //funct ---> R-format
begin
end

endmodule