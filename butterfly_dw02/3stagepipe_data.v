module pipe_3stage_data(out,in,clk);
input [29:0]in;
input clk;
output reg [29:0]out;
reg [29:0]pipe1,pipe2,pipe3;
always@(posedge clk) begin
pipe1<=in;
//pipe2<=pipe1;
//pipe3<=pipe2;
out<=pipe1; end
endmodule

