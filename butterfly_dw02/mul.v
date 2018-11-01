module mul(z,a,b,clk);
parameter bits=30;
parameter int_bits=bits*2;
input  signed [bits-1:0] a,b;
input clk;
output signed [bits-1:0] z;
wire [int_bits-1:0] internal;
//assign internal=a*b;
DW02_mult_4_stage #(30,30) dw02mul(a,b,1'b1,clk,internal);
roundoff rndoff(z,internal);
endmodule
