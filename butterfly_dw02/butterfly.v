module butterfly(realout1,realout0,imagout1,imagout0,realin1,realin0,imagin1,imagin0,twiddle_real,twiddle_imag,clk);
parameter totalbits=30;
input signed  [totalbits-1:0]realin1,realin0;
input signed [totalbits-1:0]imagin1,imagin0;
input signed [totalbits-1:0]twiddle_real,twiddle_imag;
input clk;
output signed [totalbits-1:0]realout1,realout0;
output signed [totalbits-1:0]imagout1,imagout0;
wire signed [totalbits-1:0]realin1_int1,imagin1_int1;
reg signed [totalbits-1:0]realin1_int,imagin1_int;

always@(posedge clk) begin
realin1_int<=realin1_int1;
imagin1_int<=imagin1_int1;
end


assign realout0=realin0+realin1_int;
assign imagout0=imagin0+imagin1_int;

assign realout1=realin0-realin1_int;
assign imagout1=imagin0-imagin1_int;


complex_mul complexmult(realin1_int1,imagin1_int1,realin1,twiddle_real,imagin1,twiddle_imag,clk);

endmodule
