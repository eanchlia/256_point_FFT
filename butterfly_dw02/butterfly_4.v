module butterfly_4(startout,addr_out_7,addr_out_6,addr_out_5,addr_out_4,addr_out_3,addr_out_2,addr_out_1,addr_out_0,realout_7, realout_6, realout_5, realout_4, realout_3, realout_2, realout_1, realout_0, imagout_7, imagout_6, imagout_5, imagout_4, imagout_3, imagout_2, imagout_1, imagout_0, realin_7, realin_6, realin_5, realin_4, realin_3, realin_2, realin_1, realin_0, imagin_7, imagin_6, imagin_5, imagin_4, imagin_3, imagin_2, imagin_1, imagin_0, twiddle_real_3, twiddle_real_2, twiddle_real_1, twiddle_real_0, twiddle_imag_3, twiddle_imag_2, twiddle_imag_1, twiddle_imag_0,addr_7,addr_6,addr_5,addr_4,addr_3,addr_2,addr_1,addr_0,startin,clk);

parameter totalbits=30;

output signed [totalbits-1:0] realout_7, realout_6, realout_5, realout_4, realout_3, realout_2, realout_1, realout_0, imagout_7, imagout_6, imagout_5, imagout_4, imagout_3, imagout_2, imagout_1, imagout_0;
output reg startout;
output reg [7:0] addr_out_7,addr_out_6,addr_out_5,addr_out_4,addr_out_3,addr_out_2,addr_out_1,addr_out_0;
input [7:0]  addr_7,addr_6,addr_5,addr_4,addr_3,addr_2,addr_1,addr_0;
input clk;

input signed [totalbits-1:0] realin_7, realin_6, realin_5, realin_4, realin_3, realin_2, realin_1, realin_0, imagin_7, imagin_6, imagin_5, imagin_4, imagin_3, imagin_2, imagin_1, imagin_0, twiddle_real_3, twiddle_real_2, twiddle_real_1, twiddle_real_0, twiddle_imag_3, twiddle_imag_2, twiddle_imag_1, twiddle_imag_0;
input startin;

reg [7:0] addr_out_7_pipe, addr_out_6_pipe, addr_out_5_pipe,addr_out_4_pipe,addr_out_3_pipe,addr_out_2_pipe,addr_out_1_pipe,addr_out_0_pipe;

reg startout_pipe1,startout_pipe2,startout_pipe3;

reg signed [totalbits-1:0] real_in_6_pipe,real_in_6_pipe1,real_in_4_pipe,real_in_4_pipe1,real_in_2_pipe,real_in_2_pipe1,real_in_0_pipe,real_in_0_pipe1,imag_in_6_pipe,imag_in_6_pipe1,imag_in_4_pipe,imag_in_4_pipe1,imag_in_2_pipe,imag_in_2_pipe1,imag_in_0_pipe,imag_in_0_pipe1;


butterfly bf4(realout_7,realout_6,imagout_7,imagout_6,realin_7,real_in_6_pipe1,imagin_7,imag_in_6_pipe1,twiddle_real_3,twiddle_imag_3,clk);
butterfly bf3(realout_5,realout_4,imagout_5,imagout_4,realin_5,real_in_4_pipe1,imagin_5,imag_in_4_pipe1,twiddle_real_2,twiddle_imag_2,clk);
butterfly bf2(realout_3,realout_2,imagout_3,imagout_2,realin_3,real_in_2_pipe1,imagin_3,imag_in_2_pipe1,twiddle_real_1,twiddle_imag_1,clk);
butterfly bf1(realout_1,realout_0,imagout_1,imagout_0,realin_1,real_in_0_pipe1,imagin_1,imag_in_0_pipe1,twiddle_real_0,twiddle_imag_0,clk);

//assign startout= startin;
//assign addr_out_7=addr_7;
//assign addr_out_6=addr_6;
//assign addr_out_5=addr_5;
//assign addr_out_4=addr_4;
//assign addr_out_3=addr_3;
//assign addr_out_2=addr_2;
//assign addr_out_1=addr_1;
//assign addr_out_0=addr_0;

pipe_3stage_address u1 (addr_out_7 ,addr_7, clk);
pipe_3stage_address u2 (addr_out_6 ,addr_6, clk);
pipe_3stage_address u3 (addr_out_5 ,addr_5, clk);
pipe_3stage_address u4 (addr_out_4 ,addr_4, clk);
pipe_3stage_address u5 (addr_out_3 ,addr_3, clk);
pipe_3stage_address u6 (addr_out_2 ,addr_2, clk);
pipe_3stage_address u7 (addr_out_1 ,addr_1, clk);
pipe_3stage_address u8 (addr_out_0 ,addr_0, clk);

pipe_3stage u9(startout,startin,clk);

pipe_2stage_data u10 (real_in_6_pipe1 ,realin_6, clk);
pipe_2stage_data u11 (real_in_4_pipe1 ,realin_4, clk);
pipe_2stage_data u12 (real_in_2_pipe1 ,realin_2, clk);
pipe_2stage_data u13 (real_in_0_pipe1 ,realin_0, clk);

pipe_2stage_data u14 (imag_in_6_pipe1 ,imagin_6, clk);
pipe_2stage_data u15 (imag_in_4_pipe1 ,imagin_4, clk);
pipe_2stage_data u16 (imag_in_2_pipe1 ,imagin_2, clk);
pipe_2stage_data u17 (imag_in_0_pipe1 ,imagin_0, clk);

//pipe_3stage_data u22 (twiddle_real_3_pipe1 ,twiddle_real_3, clk);
//pipe_3stage_data u23 (twiddle_real_2_pipe1 ,twiddle_real_2, clk);
//pipe_3stage_data u24 (twiddle_real_1_pipe1 ,twiddle_real_1, clk);
//pipe_3stage_data u25 (twiddle_real_0_pipe1 ,twiddle_real_0, clk);
//
//pipe_3stage_data u30 (twiddle_imag_3_pipe1 ,twiddle_imag_3, clk);
//pipe_3stage_data u31 (twiddle_imag_2_pipe1 ,twiddle_imag_2, clk);
//pipe_3stage_data u32 (twiddle_imag_1_pipe1 ,twiddle_imag_1, clk);
//pipe_3stage_data u33 (twiddle_imag_0_pipe1 ,twiddle_imag_0, clk);

//always @ (posedge clk)
//begin
//
//
//real_in_6_pipe<=realin_6;
//real_in_6_pipe1<=real_in_6_pipe;
//real_in_4_pipe<=realin_4;
//real_in_4_pipe1<=real_in_4_pipe;
//real_in_2_pipe<=realin_2;
//real_in_2_pipe1<=real_in_2_pipe;
//real_in_0_pipe<=realin_0;
//real_in_0_pipe1<=real_in_0_pipe;
//
//imag_in_6_pipe<=imagin_6;
//imag_in_6_pipe1<=imag_in_6_pipe;
//imag_in_4_pipe<=imagin_4;
//imag_in_4_pipe1<=imag_in_4_pipe;
//imag_in_2_pipe<=imagin_2;
//imag_in_2_pipe1<=imag_in_2_pipe;
//imag_in_0_pipe<=imagin_0;
//imag_in_0_pipe1<=imag_in_0_pipe;
//
//
//
//twiddle_real_3_pipe<=twiddle_real_3;
//twiddle_real_3_pipe1<=twiddle_real_3_pipe;
//twiddle_real_2_pipe<=twiddle_real_2;
//twiddle_real_2_pipe1<=twiddle_real_2_pipe;
//twiddle_real_1_pipe<=twiddle_real_1;
//twiddle_real_1_pipe1<=twiddle_real_1_pipe;
//twiddle_real_0_pipe<=twiddle_real_0;
//twiddle_real_0_pipe1<=twiddle_real_0_pipe;
//
//twiddle_imag_3_pipe<=twiddle_imag_3;
//twiddle_imag_3_pipe1<=twiddle_imag_3_pipe;
//twiddle_imag_2_pipe<=twiddle_imag_2;
//twiddle_imag_2_pipe1<=twiddle_imag_2_pipe;
//twiddle_imag_1_pipe<=twiddle_imag_1;
//twiddle_imag_1_pipe1<=twiddle_imag_1_pipe;
//twiddle_imag_0_pipe<=twiddle_imag_0;
//twiddle_imag_0_pipe1<=twiddle_imag_0_pipe;
//
//
//
//end
//

endmodule
