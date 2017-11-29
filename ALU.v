//this is a test
//ALU Operations (4 bits):

/*first project*/
//0000 Add
//0001 Sub	
//0010 And
//0011 OR
//0100 SLL
//0101 SRL
//0110 SRA
//0111 GreaterThan
//1000 LessThan


//0000 and
//0001 or
//0010 add
//0110 sub
//0111 slt
//1100 nor

// ALU inputs --> A(32 bits),B(32 bits),Mode(1 bit), OpCode(4 bits),Shift amount (no specified number of bits, not necessary)

//Mode=1 -->Signed
//Mode=0 -->Unsigned

//ALU outputs --> Result(32 bits) & Overflow (1 bit --> same as a flag ) 

module ALU(A,B,Mode,OpCode,Result,Overflow,Shift_amt,zero_flag);
output wire zero_flag;
input wire [31:0] A,B;
input wire [1:0] Mode;
input wire [3:0] OpCode; //coming from the ALU control unit
input wire [4:0] Shift_amt;
output wire [31:0] Result;
output wire [1:0] Overflow;
wire [31:0] B_negated;
reg signed [31:0] A_signed;
reg signed [31:0] B_signed;

assign B_negated=-B; //used for overflow in case of subtraction
always@(Mode==1)
begin
A_signed<=A;
B_signed<=B;
end

//0000 and
//0001 or
//0010 add
//0110 sub
//0111 slt
//1100 nor

/*inline cdns for all inputs and what they should result*/
assign Result =(OpCode==4'b0010)&&(Mode==0)?(A+B):
(OpCode==4'b0010)&&(Mode==1)?(A_signed+B_signed):
(OpCode==4'b0110)&&(Mode==0)?(A-B):
(OpCode==4'b0110)&&(Mode==1)?(A_signed-B_signed):
(OpCode==4'b0000)?(A&B):
(OpCode==4'b0001)?(A|B):
(OpCode==4'b0001)?(A~|B):
//(OpCode==4'b0100)?(A<<Shift_amt):
//(OpCode==4'b0101)?(A>>Shift_amt):
//(OpCode==4'b0110)?$signed(($signed (A)>>>Shift_amt)):

/*((OpCode==4'b0111)&&(Mode==1'b0))?((A>B)?32'd1:32'd0):

((OpCode==4'b0111)&&(Mode==1'b1)&&(A[31]==B[31]))?( (A>B)? 32'd1:32'd0 ):
((OpCode==4'b0111) &&(Mode==1'b1)&&(A[31]!=B[31])&& (A[31]==0) )? (32'd1):
((OpCode==4'b0111) &&(Mode==1'b1)&&(A[31]!=B[31])&& (B[31]==0) )? (32'd0):*/

((OpCode==4'b0111)&&(Mode==1'b0))?((A<B)?32'd1:32'd0):

((OpCode==4'b0111)&&(Mode==1'b1)&&(A[31]==B[31]))?( (A<B)? 32'd1:32'd0 ):
((OpCode==4'b0111)&&(Mode==1'b1)&&(A[31]!=B[31])&& (A[31]==0) )? (32'd0):
((OpCode==4'b0111)&&(Mode==1'b1)&&(A[31]!=B[31])&& (B[31]==0) )? (32'd1):
(32'd0);

assign zero_flag = (OpCode==4'b0001)&&(A-B==0)? 1:0;

/*inline cdn for overflow in case of addition(signed & unsigned) or subtraction (signed only)*/
assign Overflow = ((Mode==1'b1)&&(OpCode==4'b0010)&&(A[31]==B[31])&&(Result[31]==~A[31]))? 1'b1:
((Mode==1'b1) && (OpCode==4'b0001)&& (A[31]==B_negated[31]) && (Result[31]==~A[31]))? 1'b1:
((Mode==1'b0)&&(OpCode==4'b0010) &&((A+B)>=33'h100000000))? 1'b1:1'b0;


endmodule
/*
module ALU_TestBench();
reg [31:0] in1,in2;
reg [1:0] mode;
reg [3:0] opcode;
reg shift_amt;
wire [31:0] output1;
wire [1:0] overflow;

ALU first_one(in1,in2,mode,opcode,output1,overflow,shift_amt);

endmodule
*/