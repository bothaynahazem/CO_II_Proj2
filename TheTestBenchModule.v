module Final_TestBench();

reg mux_ctrl, write_enable;
reg [4:0] readreg1, readreg2, writereg;
reg [3:0] OpCode;
reg [4:0] Shift_amt;
reg [31:0] data_in;//data input to write in the register file 
wire [31:0] Result;
wire [1:0] Overflow;
reg [1:0] Mode;
wire [31:0] mux_data_out; // "mux_data_out" is the output of the mux connected to the register file and is the data going to be written in it
wire [31:0] readdata1,readdata2; //connecting the data read from the register to the ALU input 
integer i; //counter of for loop for filling reg file
reg myclk;


Alu_plus_regfile Test(myclk, readreg1, readreg2, writereg, data_in, mux_ctrl, write_enable,
			 Mode, OpCode, Result, Overflow, Shift_amt,
			 readdata1,readdata2 );

initial
begin
 myclk=0;

for (i=0;i<10;i=i+1)
begin
#10
mux_ctrl<=0;
write_enable<=1;
writereg<=i;
data_in<=i*100+i;
end

for (i=10;i<17;i=i+1)
begin
#10
mux_ctrl<=0;
write_enable<=1;
writereg<=i;
data_in<=-i*10;
end

for (i=17; i<19; i=i+1)
begin
#10
mux_ctrl<=0;
write_enable<=1;
writereg<=i;
data_in<=32'd2147483647;
end

for (i=19; i<21; i=i+1)
begin
#10
mux_ctrl<=0;
write_enable<=1;
writereg<=i;
data_in<=-65000;
end

for (i=21;i<23;i=i+1)
begin
#10
mux_ctrl<=0;
write_enable<=1;
writereg<=i;
data_in<=32'hFFFFFFF0;
end

for (i=23;i<32;i=i+1)
begin
#10
mux_ctrl<=0;
write_enable<=1;
writereg<=i;
data_in<=i+i+600;
end


mux_ctrl<=1;
writereg<=31;

#10
OpCode<=0;
Mode<=1;
readreg1<=17;
readreg2<=18;
$monitor(" Operation:ADD -Mode=%d- OpCode=%d  - A=%b +  B=%b  =  Result=%d - Overflow=%d\n",Mode,OpCode,readdata1, readdata2,Result, Overflow);

#10
OpCode<=0;
Mode<=1;
readreg1<=5;
readreg2<=20;

$monitor(" Operation:ADD -Mode=%d- OpCode=%d  - A=%d  +  B=%d  =  Result=%d - Overflow=%d\n",Mode,OpCode,$signed(readdata1), $signed(readdata2),$signed(Result), Overflow);
#10
OpCode<=1;
Mode<=0;
readreg1<=5;
readreg2<=3;
$monitor("Operation:Subtract  -Mode=%d - OpCode=%d  - A=%d  -  B=%d  =  Result=%d - Overflow=%d\n",Mode, OpCode,readdata1, readdata2,Result, Overflow);

#10
OpCode<=1;
Mode<=1;
readreg1<=5;
readreg2<=20;

$monitor("Operation:Subtract -Mode=%d - OpCode=%d  - A=%d - B=%d - Result=%d - Overflow=%d\n",Mode,OpCode,$signed(readdata1), $signed(readdata2),$signed(Result), Overflow);

#10
OpCode<=2;
Mode<=0;
readreg1<=5;
readreg2<=6;

$monitor("Operation:AND  OpCode=%d   \nA     =%b \nB     =%b \nResult=%b \n", 
			OpCode,readdata1, readdata2,Result);
#10
OpCode<=3;
Mode<=0;
readreg1<=8;
readreg2<=6;
$monitor("Operation:OR  OpCode=%d   \nA     =%b \nB     =%b \nResult=%b \n", 
			OpCode,readdata1, readdata2,Result);

#10
OpCode<=4;
readreg1<=9;
Shift_amt<=15;
$monitor("Operation:SLL  OpCode=%d   \nA     =%b --Shift_amt=%d \nResult=%b \n ", 
			OpCode,readdata1,Shift_amt,Result);
#10
OpCode<=5;
readreg1<=8;
Shift_amt<=5;
$monitor("Operation:SRL  OpCode=%d   \nA     =%b --Shift_amt=%d \nResult=%b \n", 
			OpCode,readdata1,Shift_amt,Result);
#10
OpCode<=6;
Mode<=1;
readreg1<=20;
Shift_amt<=5;
$monitor("Operation:SRA  OpCode=%d   \nA     =%b --Shift_amt=%d \nResult=%b \n", 
			OpCode,readdata1,Shift_amt,Result);
#10
OpCode<=7;
Mode<=1;
readreg1<=6;
readreg2<=7;
$monitor("Operation:Greater than - OpCode=%d  - A=%d - B=%d - Result=%d \n", 
			OpCode,readdata1, readdata2,Result);
#10
OpCode<=7;
Mode<=1;
readreg1<=20;
readreg2<=1;
$monitor("Operation:Greaterthan - OpCode=%d  - Is A=%d  >  B=%d  ?  Result=%d \n ", 
			OpCode,$signed(readdata1), readdata2,Result);
#10
OpCode<=8;
Mode<=0;
readreg1<=6;
readreg2<=7;
$monitor("Operation:LessThan - OpCode=%d  Is  A=%d  <  B=%d  ?  Result=%d \n ", 
			OpCode,readdata1, readdata2,Result);
#10
OpCode<=8;
Mode<=1;
readreg1<=20;
readreg2<=1;
$monitor("Operation:LessThan - OpCode=%d  - Is A=%d  <  B=%d  ?  Result=%d \n", 
			OpCode,$signed(readdata1), readdata2,Result);

#10
OpCode<=8;
Mode<=1;
readreg1<=20;
readreg2<=10;
$monitor("Operation:LessThan - OpCode=%d  - Is A=%d  <  B=%d  ?  Result=%d \n", 
			OpCode,$signed(readdata1), $signed(readdata2),Result);





end

always
 begin
#5 myclk=~myclk;

end

endmodule 