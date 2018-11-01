module complex_mul(realout,imagout,realin1,realin0,imagin1,imagin0,clk);
parameter totalbits=30;
input signed  [totalbits-1:0]realin1,realin0;
input signed [totalbits-1:0]imagin1,imagin0;
input clk;
output signed [totalbits-1:0]realout;
output signed [totalbits-1:0]imagout;
wire [totalbits-1:0] realpart1,imagpart1,mix11,mix21;
reg [totalbits-1:0] realpart,imagpart,mix1,mix2;



mul mix1gen(mix11,imagin1,realin0,clk);
mul mix2gen(mix21,realin1,imagin0,clk);

mul realpartgen(realpart1,realin0,realin1,clk);
mul imagpartgen(imagpart1,imagin1,imagin0,clk);

always@(posedge clk) begin
mix1<=mix11;
mix2<=mix21;
realpart<= realpart1;
imagpart<= imagpart1;
end

assign imagout=mix1+mix2;
assign realout=realpart-imagpart;
endmodule

