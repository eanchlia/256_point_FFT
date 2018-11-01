module pipe_3stage(out,in,clk);
input in,clk;
output reg out;
reg pipe1,pipe2,pipe3,pipe4;
always@(posedge clk) begin
pipe1<=in;
pipe2<=pipe1;
pipe3<=pipe2;
pipe4<=pipe3;
out<=pipe4; end
endmodule

