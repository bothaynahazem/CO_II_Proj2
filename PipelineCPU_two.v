module PipelineCPU(clk);

input clk;
reg [31:0] pc=0; //assume
wire [3:0] OpCode;

wire [31:0] Result;

wire [31:0] readdata1,readdata2; //connecting the data read from the register to the ALU input 
wire [4:0] writeregister;//address of register to write 
wire[31:0] writedata;

wire[31:0] instruction;//instruction from imemory

wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;// control unit outputs
wire [1:0] ALUOp;

wire zero_flag;

wire [31:0] mux2in;
wire[31:0] mux3in; //output from Data memory
wire[31:0] mux2out;

reg [31:0] PcP4=0;
wire[31:0] pctoimem;
reg PcSrc;

reg [31:0] Shift_left_2;
reg [31:0] Addition_result;

//1st pipeline reg --> 32 bits represent the instruction, the other represent the PC
reg [31:0] IFIDPC, IFIDIR;

//2nd pipeline reg
reg [31:0] IDEXPC, IDEXA, IDEXB, IDEXSE, IDEXIR; 
reg IDEXRegDst, IDEXBranch, IDEXMemRead, IDEXMemtoReg, IDEXMemWrite, IDEXALUSrc, IDEXRegWrite;
reg [1:0] IDEXALUOp;
//2nd pipeline reg


//3rd pipeline reg
reg [31:0] EXMEMPC, EXMEMIR, EXMEMB, EXMEM_ALURESULT, EXMEM_ADDRESULT;
reg EXMEMRegWrite,EXMEMMemtoReg,EXMEMBranch,EXMEMMemRead,EXMEMMemWrite;
reg EXMEMZero;
reg EXMEMMUX1OUT;
//3rd pipeline reg


//4th pipeline reg
reg [31:0] MEMWB_ReadData, MEMWBIR, MEMWB_ALURESULT, MEMWBMUX1OUT;
reg MEMWBRegWrite, MEMWBMemtoReg;
//4th pipeline reg

assign pctoimem=pc;
always@(negedge clk)
begin
PcP4=pc+4;
end
always@(posedge clk)
begin
pc=PcP4;
Addition_result= PcP4 + Shift_left_2;
if(PcSrc==1)
begin
pc=Addition_result;
end
end

/*1st stage*/
IMem Imemory(clk, pctoimem, instruction);

/*2nd stage*/
regfile R1(IFIDIR[25:21], IFIDIR[20:16], clk, MEMWBMUX1OUT, writedata, readdata1, readdata2, RegWrite);
ControlUnit ControlUnit(clk, IFIDIR[31:26], RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

/*3rd stage*/
MUX_2_to_1 M1(IDEXIR[20:16], IDEXIR[15:11], IDEXRegDst, writeregister);
MUX_2_to_1 M2(IDEXB, IDEXSE, IDEXALUSrc, mux2out);
ALUcontrol ALUcontrol(IDEXIR[5:0], IDEXALUOp, OpCode);
ALU A1(IDEXA, mux2out, OpCode, Result, IDEXIR[10:6], zero_flag);

/*4th stage*/
DataMem Datamemory(clk,EXMEM_ALURESULT,EXMEMB,EXMEMMemWrite,EXMEMMemRead,mux3in);

/*5th stage*/
MUX_2_to_1 M3(MEMWB_ALURESULT,MEMWB_ReadData, MEMWBMemtoReg, writedata);



always@(posedge clk) begin
/*1st stage*/
IFIDIR<=instruction;
IFIDPC<=pctoimem;

/*2nd stage*/
IDEXIR<=IFIDIR;

IDEXPC<=IFIDPC;

IDEXA<=readdata1;
IDEXB<=readdata2;

IDEXSE<={{16{IFIDIR[15]}} /*sign extend*/, IFIDIR[15:0] /*16 bit address*/}; //sign extend

//control signals
IDEXRegDst<=RegDst;
IDEXBranch<=Branch;
IDEXMemRead<=MemRead;
IDEXMemtoReg<=MemtoReg;
IDEXMemWrite<=MemWrite;
IDEXALUSrc<=ALUSrc;
IDEXRegWrite<=RegWrite;
IDEXALUOp<=ALUOp;

/*2nd stage*/


/*3rd stage*/
Shift_left_2<=IDEXSE<<2;
Addition_result=Shift_left_2+IDEXPC; //blocking because it should wait for sll(2) to be executed
/*3rd stage*/


/*4th stage*/
EXMEMIR<=IDEXIR;
EXMEMPC<=IDEXPC;
EXMEMB<=IDEXB;

EXMEM_ALURESULT<=Result;
EXMEMZero<=zero_flag;
EXMEM_ADDRESULT<=Addition_result;

EXMEMMUX1OUT<=writeregister;

EXMEMRegWrite<=IDEXRegWrite;
EXMEMMemRead<=IDEXMemRead;
EXMEMMemWrite<=IDEXMemWrite;
EXMEMMemtoReg<=IDEXMemtoReg;
EXMEMBranch<=IDEXBranch;

PcSrc=EXMEMBranch&EXMEMZero;
/*4th stage*/


/*5th stage*/
MEMWBIR<=EXMEMIR;
MEMWB_ReadData<=mux3in;
MEMWB_ALURESULT<=EXMEM_ALURESULT;
MEMWBMUX1OUT<=EXMEMMUX1OUT;
MEMWBMemtoReg<=EXMEMMemtoReg;
MEMWBRegWrite<=EXMEMRegWrite;
/*5th stage*/

end

endmodule
