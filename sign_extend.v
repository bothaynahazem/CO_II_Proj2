module sign_extend(in , out)
input reg in[15:0];
output reg out[31:0];
out<={{16{in[15]}} /*sign extend*/, in[15:0] /*16 bit address*/};endmodule
