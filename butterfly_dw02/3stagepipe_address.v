module pipe_3stage_address(out,in,clk);
input [7:0]in;
input clk;
output reg [7:0]out;
reg [7:0]pipe1,pipe2,pipe3,pipe4;
always@(posedge clk) begin
pipe1<=in;
pipe2<=pipe1;
pipe3<=pipe2;
pipe4<=pipe3;
out<=pipe4; end
endmodule

