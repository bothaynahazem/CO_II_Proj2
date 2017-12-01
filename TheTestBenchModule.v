`timescale 100s/1s
module Final_TestBench();
wire myclk;
clk clock(myclk);
SingleCylceCPU cpu(myclk);
endmodule 