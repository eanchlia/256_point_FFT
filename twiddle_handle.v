module twiddle_engine(twiddle_real3,twiddle_real2,twiddle_real1,twiddle_real0,twiddle_imag3,twiddle_imag2,twiddle_imag1,twiddle_imag0,clk,reset,startin);
parameter totalbits=30;
input clk,reset,startin;
output reg signed [totalbits-1:0]twiddle_real3,twiddle_real2,twiddle_real1,twiddle_real0,twiddle_imag3,twiddle_imag2,twiddle_imag1,twiddle_imag0;
reg en;
reg [7:0]count;
reg signed [totalbits-1:0]twiddle_real_in[0:127];
reg signed [totalbits-1:0]twiddle_imag_in[0:127];

//Enabling signal for startin=1 and disabling it after 256 clk cycles
always@(posedge clk or posedge reset) begin
if(reset) en<=1'b0;
else if(startin==1) en<=1'b1;
else if(count==8'd255) en<=1'b0;
else en<=en;
end

//Counter for disabling after 256 clk cycles
always@(posedge clk or posedge reset) begin
if(reset) count<=8'd0;
else if(startin) count<= 8'd0;
else begin if(en) count <= count+1'b1;
	   else   count<=count;  end
end

always@(posedge clk) begin
if (en) begin
if((!count[7])&&(!count[6])&&(!count[5])) begin
twiddle_real3<=twiddle_real_in[0]; twiddle_real2<=twiddle_real_in[0]; twiddle_real1<=twiddle_real_in[0]; twiddle_real0<=twiddle_real_in[0]; 
twiddle_imag3<=twiddle_imag_in[0]; twiddle_imag2<=twiddle_imag_in[0]; twiddle_imag1<=twiddle_imag_in[0]; twiddle_imag0<=twiddle_imag_in[0];
end //end for 000
 
else if((!count[7])&&(!count[6])&&(count[5])) begin
twiddle_real3<=twiddle_real_in[0]; twiddle_real2<=twiddle_real_in[64]; twiddle_real1<=twiddle_real_in[0]; twiddle_real0<=twiddle_real_in[64]; 
twiddle_imag3<=twiddle_imag_in[0]; twiddle_imag2<=twiddle_imag_in[64]; twiddle_imag1<=twiddle_imag_in[0]; twiddle_imag0<=twiddle_imag_in[64];
end //end for 001

else if((!count[7])&&(count[6])&&(!count[5])) begin
twiddle_real3<=twiddle_real_in[0]; twiddle_real2<=twiddle_real_in[32]; twiddle_real1<=twiddle_real_in[64]; twiddle_real0<=twiddle_real_in[96]; 
twiddle_imag3<=twiddle_imag_in[0]; twiddle_imag2<=twiddle_imag_in[32]; twiddle_imag1<=twiddle_imag_in[64]; twiddle_imag0<=twiddle_imag_in[96];
end //end for 010

else if((!count[7])&&(count[6])&&(count[5])) begin

if(count[0]==0) begin
twiddle_real3<=twiddle_real_in[0]; twiddle_real2<=twiddle_real_in[16]; twiddle_real1<=twiddle_real_in[32]; twiddle_real0<=twiddle_real_in[48]; 
twiddle_imag3<=twiddle_imag_in[0]; twiddle_imag2<=twiddle_imag_in[16]; twiddle_imag1<=twiddle_imag_in[32]; twiddle_imag0<=twiddle_imag_in[48];
end// end for even terms

if(count[0]==1) begin
twiddle_real3<=twiddle_real_in[64]; twiddle_real2<=twiddle_real_in[80]; twiddle_real1<=twiddle_real_in[96]; twiddle_real0<=twiddle_real_in[112]; 
twiddle_imag3<=twiddle_imag_in[64]; twiddle_imag2<=twiddle_imag_in[80]; twiddle_imag1<=twiddle_imag_in[96]; twiddle_imag0<=twiddle_imag_in[112];
end// end for odd terms

end //end for 011

else if((count[7])&&(!count[6])&&(!count[5])) begin

if(count[1:0]==2'b00) begin
twiddle_real3<=twiddle_real_in[0]; twiddle_real2<=twiddle_real_in[8]; twiddle_real1<=twiddle_real_in[16]; twiddle_real0<=twiddle_real_in[24]; 
twiddle_imag3<=twiddle_imag_in[0]; twiddle_imag2<=twiddle_imag_in[8]; twiddle_imag1<=twiddle_imag_in[16]; twiddle_imag0<=twiddle_imag_in[24];
end// end for 00

else if(count[1:0]==2'b01) begin
twiddle_real3<=twiddle_real_in[32]; twiddle_real2<=twiddle_real_in[40]; twiddle_real1<=twiddle_real_in[48]; twiddle_real0<=twiddle_real_in[56]; 
twiddle_imag3<=twiddle_imag_in[32]; twiddle_imag2<=twiddle_imag_in[40]; twiddle_imag1<=twiddle_imag_in[48]; twiddle_imag0<=twiddle_imag_in[56];
end// end for 01

else if(count[1:0]==2'b10) begin
twiddle_real3<=twiddle_real_in[64]; twiddle_real2<=twiddle_real_in[72]; twiddle_real1<=twiddle_real_in[80]; twiddle_real0<=twiddle_real_in[88]; 
twiddle_imag3<=twiddle_imag_in[64]; twiddle_imag2<=twiddle_imag_in[72]; twiddle_imag1<=twiddle_imag_in[80]; twiddle_imag0<=twiddle_imag_in[88];
end// end for 10

else if(count[1:0]==2'b11) begin
twiddle_real3<=twiddle_real_in[96]; twiddle_real2<=twiddle_real_in[104]; twiddle_real1<=twiddle_real_in[112]; twiddle_real0<=twiddle_real_in[120]; 
twiddle_imag3<=twiddle_imag_in[96]; twiddle_imag2<=twiddle_imag_in[104]; twiddle_imag1<=twiddle_imag_in[112]; twiddle_imag0<=twiddle_imag_in[120];
end// end for 11
end //end for 100

else if((count[7])&&(!count[6])&&(count[5])) begin

if(count[2:0]==3'b000) begin
twiddle_real3<=twiddle_real_in[0]; twiddle_real2<=twiddle_real_in[4]; twiddle_real1<=twiddle_real_in[8]; twiddle_real0<=twiddle_real_in[12]; 
twiddle_imag3<=twiddle_imag_in[0]; twiddle_imag2<=twiddle_imag_in[4]; twiddle_imag1<=twiddle_imag_in[8]; twiddle_imag0<=twiddle_imag_in[12];
end// end for 000

else if(count[2:0]==3'b001) begin
twiddle_real3<=twiddle_real_in[16]; twiddle_real2<=twiddle_real_in[20]; twiddle_real1<=twiddle_real_in[24]; twiddle_real0<=twiddle_real_in[28]; 
twiddle_imag3<=twiddle_imag_in[16]; twiddle_imag2<=twiddle_imag_in[20]; twiddle_imag1<=twiddle_imag_in[24]; twiddle_imag0<=twiddle_imag_in[28];
end// end for 001

else if(count[2:0]==3'b010) begin
twiddle_real3<=twiddle_real_in[32]; twiddle_real2<=twiddle_real_in[36]; twiddle_real1<=twiddle_real_in[40]; twiddle_real0<=twiddle_real_in[44]; 
twiddle_imag3<=twiddle_imag_in[32]; twiddle_imag2<=twiddle_imag_in[36]; twiddle_imag1<=twiddle_imag_in[40]; twiddle_imag0<=twiddle_imag_in[44];
end// end for 010

else if(count[2:0]==3'b011) begin
twiddle_real3<=twiddle_real_in[48]; twiddle_real2<=twiddle_real_in[52]; twiddle_real1<=twiddle_real_in[56]; twiddle_real0<=twiddle_real_in[60]; 
twiddle_imag3<=twiddle_imag_in[48]; twiddle_imag2<=twiddle_imag_in[52]; twiddle_imag1<=twiddle_imag_in[56]; twiddle_imag0<=twiddle_imag_in[60];
end// end for 011

else if(count[2:0]==3'b100) begin
twiddle_real3<=twiddle_real_in[64]; twiddle_real2<=twiddle_real_in[68]; twiddle_real1<=twiddle_real_in[72]; twiddle_real0<=twiddle_real_in[76]; 
twiddle_imag3<=twiddle_imag_in[64]; twiddle_imag2<=twiddle_imag_in[68]; twiddle_imag1<=twiddle_imag_in[72]; twiddle_imag0<=twiddle_imag_in[76];
end// end for 100

else if(count[2:0]==3'b101) begin
twiddle_real3<=twiddle_real_in[80]; twiddle_real2<=twiddle_real_in[84]; twiddle_real1<=twiddle_real_in[88]; twiddle_real0<=twiddle_real_in[92]; 
twiddle_imag3<=twiddle_imag_in[80]; twiddle_imag2<=twiddle_imag_in[84]; twiddle_imag1<=twiddle_imag_in[88]; twiddle_imag0<=twiddle_imag_in[92];
end// end for 101

else if(count[2:0]==3'b110) begin
twiddle_real3<=twiddle_real_in[96]; twiddle_real2<=twiddle_real_in[100]; twiddle_real1<=twiddle_real_in[104]; twiddle_real0<=twiddle_real_in[108]; 
twiddle_imag3<=twiddle_imag_in[96]; twiddle_imag2<=twiddle_imag_in[100]; twiddle_imag1<=twiddle_imag_in[104]; twiddle_imag0<=twiddle_imag_in[108];
end// end for 110

else if(count[2:0]==3'b111) begin
twiddle_real3<=twiddle_real_in[112]; twiddle_real2<=twiddle_real_in[116]; twiddle_real1<=twiddle_real_in[120]; twiddle_real0<=twiddle_real_in[124]; 
twiddle_imag3<=twiddle_imag_in[112]; twiddle_imag2<=twiddle_imag_in[116]; twiddle_imag1<=twiddle_imag_in[120]; twiddle_imag0<=twiddle_imag_in[124];
end// end for 111
end //end for 101

else if((count[7])&&(count[6])&&(!count[5])) begin

if(count[3:0]==4'b0000) begin
twiddle_real3<=twiddle_real_in[0]; twiddle_real2<=twiddle_real_in[2]; twiddle_real1<=twiddle_real_in[4]; twiddle_real0<=twiddle_real_in[6]; 
twiddle_imag3<=twiddle_imag_in[0]; twiddle_imag2<=twiddle_imag_in[2]; twiddle_imag1<=twiddle_imag_in[4]; twiddle_imag0<=twiddle_imag_in[6];
end// end for 0000

else if(count[3:0]==4'b0001) begin
twiddle_real3<=twiddle_real_in[8]; twiddle_real2<=twiddle_real_in[10]; twiddle_real1<=twiddle_real_in[12]; twiddle_real0<=twiddle_real_in[14]; 
twiddle_imag3<=twiddle_imag_in[8]; twiddle_imag2<=twiddle_imag_in[10]; twiddle_imag1<=twiddle_imag_in[12]; twiddle_imag0<=twiddle_imag_in[14];
end// end for 0001

else if(count[3:0]==4'b0010) begin
twiddle_real3<=twiddle_real_in[16]; twiddle_real2<=twiddle_real_in[18]; twiddle_real1<=twiddle_real_in[20]; twiddle_real0<=twiddle_real_in[22]; 
twiddle_imag3<=twiddle_imag_in[16]; twiddle_imag2<=twiddle_imag_in[18]; twiddle_imag1<=twiddle_imag_in[20]; twiddle_imag0<=twiddle_imag_in[22];
end// end for 0010

else if(count[3:0]==4'b0011) begin
twiddle_real3<=twiddle_real_in[24]; twiddle_real2<=twiddle_real_in[26]; twiddle_real1<=twiddle_real_in[28]; twiddle_real0<=twiddle_real_in[30]; 
twiddle_imag3<=twiddle_imag_in[24]; twiddle_imag2<=twiddle_imag_in[26]; twiddle_imag1<=twiddle_imag_in[28]; twiddle_imag0<=twiddle_imag_in[30];
end// end for 0011

else if(count[3:0]==4'b0100) begin
twiddle_real3<=twiddle_real_in[32]; twiddle_real2<=twiddle_real_in[34]; twiddle_real1<=twiddle_real_in[36]; twiddle_real0<=twiddle_real_in[38]; 
twiddle_imag3<=twiddle_imag_in[32]; twiddle_imag2<=twiddle_imag_in[34]; twiddle_imag1<=twiddle_imag_in[36]; twiddle_imag0<=twiddle_imag_in[38];
end// end for 0100

else if(count[3:0]==4'b0101) begin
twiddle_real3<=twiddle_real_in[40]; twiddle_real2<=twiddle_real_in[42]; twiddle_real1<=twiddle_real_in[44]; twiddle_real0<=twiddle_real_in[46]; 
twiddle_imag3<=twiddle_imag_in[40]; twiddle_imag2<=twiddle_imag_in[42]; twiddle_imag1<=twiddle_imag_in[44]; twiddle_imag0<=twiddle_imag_in[46];
end// end for 0101

else if(count[3:0]==4'b0110) begin
twiddle_real3<=twiddle_real_in[48]; twiddle_real2<=twiddle_real_in[50]; twiddle_real1<=twiddle_real_in[52]; twiddle_real0<=twiddle_real_in[54]; 
twiddle_imag3<=twiddle_imag_in[48]; twiddle_imag2<=twiddle_imag_in[50]; twiddle_imag1<=twiddle_imag_in[52]; twiddle_imag0<=twiddle_imag_in[54];
end// end for 0110

else if(count[3:0]==4'b0111) begin
twiddle_real3<=twiddle_real_in[56]; twiddle_real2<=twiddle_real_in[58]; twiddle_real1<=twiddle_real_in[60]; twiddle_real0<=twiddle_real_in[62]; 
twiddle_imag3<=twiddle_imag_in[56]; twiddle_imag2<=twiddle_imag_in[58]; twiddle_imag1<=twiddle_imag_in[60]; twiddle_imag0<=twiddle_imag_in[62];
end// end for 0111

else if(count[3:0]==4'b1000) begin
twiddle_real3<=twiddle_real_in[64]; twiddle_real2<=twiddle_real_in[66]; twiddle_real1<=twiddle_real_in[68]; twiddle_real0<=twiddle_real_in[70]; 
twiddle_imag3<=twiddle_imag_in[64]; twiddle_imag2<=twiddle_imag_in[66]; twiddle_imag1<=twiddle_imag_in[68]; twiddle_imag0<=twiddle_imag_in[70];
end// end for 1000

else if(count[3:0]==4'b1001) begin
twiddle_real3<=twiddle_real_in[72]; twiddle_real2<=twiddle_real_in[74]; twiddle_real1<=twiddle_real_in[76]; twiddle_real0<=twiddle_real_in[78]; 
twiddle_imag3<=twiddle_imag_in[72]; twiddle_imag2<=twiddle_imag_in[74]; twiddle_imag1<=twiddle_imag_in[76]; twiddle_imag0<=twiddle_imag_in[78];
end// end for 1001

else if(count[3:0]==4'b1010) begin
twiddle_real3<=twiddle_real_in[80]; twiddle_real2<=twiddle_real_in[82]; twiddle_real1<=twiddle_real_in[84]; twiddle_real0<=twiddle_real_in[86]; 
twiddle_imag3<=twiddle_imag_in[80]; twiddle_imag2<=twiddle_imag_in[82]; twiddle_imag1<=twiddle_imag_in[84]; twiddle_imag0<=twiddle_imag_in[86];
end// end for 1010

else if(count[3:0]==4'b1011) begin
twiddle_real3<=twiddle_real_in[88]; twiddle_real2<=twiddle_real_in[90]; twiddle_real1<=twiddle_real_in[92]; twiddle_real0<=twiddle_real_in[94]; 
twiddle_imag3<=twiddle_imag_in[88]; twiddle_imag2<=twiddle_imag_in[90]; twiddle_imag1<=twiddle_imag_in[92]; twiddle_imag0<=twiddle_imag_in[94];
end// end for 1011

else if(count[3:0]==4'b1100) begin
twiddle_real3<=twiddle_real_in[96]; twiddle_real2<=twiddle_real_in[98]; twiddle_real1<=twiddle_real_in[100]; twiddle_real0<=twiddle_real_in[102]; 
twiddle_imag3<=twiddle_imag_in[96]; twiddle_imag2<=twiddle_imag_in[98]; twiddle_imag1<=twiddle_imag_in[100]; twiddle_imag0<=twiddle_imag_in[102];
end// end for 1100

else if(count[3:0]==4'b1101) begin
twiddle_real3<=twiddle_real_in[104]; twiddle_real2<=twiddle_real_in[106]; twiddle_real1<=twiddle_real_in[108]; twiddle_real0<=twiddle_real_in[110]; 
twiddle_imag3<=twiddle_imag_in[104]; twiddle_imag2<=twiddle_imag_in[106]; twiddle_imag1<=twiddle_imag_in[108]; twiddle_imag0<=twiddle_imag_in[110];
end// end for 1101

else if(count[3:0]==4'b1110) begin
twiddle_real3<=twiddle_real_in[112]; twiddle_real2<=twiddle_real_in[114]; twiddle_real1<=twiddle_real_in[116]; twiddle_real0<=twiddle_real_in[118]; 
twiddle_imag3<=twiddle_imag_in[112]; twiddle_imag2<=twiddle_imag_in[114]; twiddle_imag1<=twiddle_imag_in[116]; twiddle_imag0<=twiddle_imag_in[118];
end// end for 1110

else if(count[3:0]==4'b1111) begin
twiddle_real3<=twiddle_real_in[120]; twiddle_real2<=twiddle_real_in[122]; twiddle_real1<=twiddle_real_in[124]; twiddle_real0<=twiddle_real_in[126]; 
twiddle_imag3<=twiddle_imag_in[120]; twiddle_imag2<=twiddle_imag_in[122]; twiddle_imag1<=twiddle_imag_in[124]; twiddle_imag0<=twiddle_imag_in[126];
end// end for 1111

end //end for 110

else if((count[7])&&(count[6])&&(count[5])) begin
case (count[4:0])
5'd0: begin twiddle_real3<=twiddle_real_in[0]; twiddle_real2<=twiddle_real_in[1]; twiddle_real1<=twiddle_real_in[2]; twiddle_real0<=twiddle_real_in[3];
	    twiddle_imag3<=twiddle_imag_in[0]; twiddle_imag2<=twiddle_imag_in[1]; twiddle_imag1<=twiddle_imag_in[2]; twiddle_imag0<=twiddle_imag_in[3];
      end
5'd1: begin twiddle_real3<=twiddle_real_in[4]; twiddle_real2<=twiddle_real_in[5]; twiddle_real1<=twiddle_real_in[6]; twiddle_real0<=twiddle_real_in[7];
	    twiddle_imag3<=twiddle_imag_in[4]; twiddle_imag2<=twiddle_imag_in[5]; twiddle_imag1<=twiddle_imag_in[6]; twiddle_imag0<=twiddle_imag_in[7];
      end
5'd2: begin twiddle_real3<=twiddle_real_in[8]; twiddle_real2<=twiddle_real_in[9]; twiddle_real1<=twiddle_real_in[10]; twiddle_real0<=twiddle_real_in[11];
	    twiddle_imag3<=twiddle_imag_in[8]; twiddle_imag2<=twiddle_imag_in[9]; twiddle_imag1<=twiddle_imag_in[10]; twiddle_imag0<=twiddle_imag_in[11];
      end
5'd3: begin twiddle_real3<=twiddle_real_in[12]; twiddle_real2<=twiddle_real_in[13]; twiddle_real1<=twiddle_real_in[14]; twiddle_real0<=twiddle_real_in[15];
	    twiddle_imag3<=twiddle_imag_in[12]; twiddle_imag2<=twiddle_imag_in[13]; twiddle_imag1<=twiddle_imag_in[14]; twiddle_imag0<=twiddle_imag_in[15];
      end
5'd4: begin twiddle_real3<=twiddle_real_in[16]; twiddle_real2<=twiddle_real_in[17]; twiddle_real1<=twiddle_real_in[18]; twiddle_real0<=twiddle_real_in[19];
	    twiddle_imag3<=twiddle_imag_in[16]; twiddle_imag2<=twiddle_imag_in[17]; twiddle_imag1<=twiddle_imag_in[18]; twiddle_imag0<=twiddle_imag_in[19];
      end
5'd5: begin twiddle_real3<=twiddle_real_in[20]; twiddle_real2<=twiddle_real_in[21]; twiddle_real1<=twiddle_real_in[22]; twiddle_real0<=twiddle_real_in[23];
	    twiddle_imag3<=twiddle_imag_in[20]; twiddle_imag2<=twiddle_imag_in[21]; twiddle_imag1<=twiddle_imag_in[22]; twiddle_imag0<=twiddle_imag_in[23];
      end
5'd6: begin twiddle_real3<=twiddle_real_in[24]; twiddle_real2<=twiddle_real_in[25]; twiddle_real1<=twiddle_real_in[26]; twiddle_real0<=twiddle_real_in[27];
	    twiddle_imag3<=twiddle_imag_in[24]; twiddle_imag2<=twiddle_imag_in[25]; twiddle_imag1<=twiddle_imag_in[26]; twiddle_imag0<=twiddle_imag_in[27];
      end
5'd7: begin twiddle_real3<=twiddle_real_in[28]; twiddle_real2<=twiddle_real_in[29]; twiddle_real1<=twiddle_real_in[30]; twiddle_real0<=twiddle_real_in[31];
	    twiddle_imag3<=twiddle_imag_in[28]; twiddle_imag2<=twiddle_imag_in[29]; twiddle_imag1<=twiddle_imag_in[30]; twiddle_imag0<=twiddle_imag_in[31];
      end
5'd8: begin twiddle_real3<=twiddle_real_in[32]; twiddle_real2<=twiddle_real_in[33]; twiddle_real1<=twiddle_real_in[34]; twiddle_real0<=twiddle_real_in[35];
	    twiddle_imag3<=twiddle_imag_in[32]; twiddle_imag2<=twiddle_imag_in[33]; twiddle_imag1<=twiddle_imag_in[34]; twiddle_imag0<=twiddle_imag_in[35];
      end
5'd9: begin twiddle_real3<=twiddle_real_in[36]; twiddle_real2<=twiddle_real_in[37]; twiddle_real1<=twiddle_real_in[38]; twiddle_real0<=twiddle_real_in[39];
	    twiddle_imag3<=twiddle_imag_in[36]; twiddle_imag2<=twiddle_imag_in[37]; twiddle_imag1<=twiddle_imag_in[38]; twiddle_imag0<=twiddle_imag_in[39];
      end
5'd10: begin twiddle_real3<=twiddle_real_in[40]; twiddle_real2<=twiddle_real_in[41]; twiddle_real1<=twiddle_real_in[42]; twiddle_real0<=twiddle_real_in[43];
	    twiddle_imag3<=twiddle_imag_in[40]; twiddle_imag2<=twiddle_imag_in[41]; twiddle_imag1<=twiddle_imag_in[42]; twiddle_imag0<=twiddle_imag_in[43];
      end
5'd11: begin twiddle_real3<=twiddle_real_in[44]; twiddle_real2<=twiddle_real_in[45]; twiddle_real1<=twiddle_real_in[46]; twiddle_real0<=twiddle_real_in[47];
	    twiddle_imag3<=twiddle_imag_in[44]; twiddle_imag2<=twiddle_imag_in[45]; twiddle_imag1<=twiddle_imag_in[46]; twiddle_imag0<=twiddle_imag_in[47];
      end
5'd12: begin twiddle_real3<=twiddle_real_in[48]; twiddle_real2<=twiddle_real_in[49]; twiddle_real1<=twiddle_real_in[50]; twiddle_real0<=twiddle_real_in[51];
	    twiddle_imag3<=twiddle_imag_in[48]; twiddle_imag2<=twiddle_imag_in[49]; twiddle_imag1<=twiddle_imag_in[50]; twiddle_imag0<=twiddle_imag_in[51];
      end
5'd13: begin twiddle_real3<=twiddle_real_in[52]; twiddle_real2<=twiddle_real_in[53]; twiddle_real1<=twiddle_real_in[54]; twiddle_real0<=twiddle_real_in[55];
	    twiddle_imag3<=twiddle_imag_in[52]; twiddle_imag2<=twiddle_imag_in[53]; twiddle_imag1<=twiddle_imag_in[54]; twiddle_imag0<=twiddle_imag_in[55];
      end
5'd14: begin twiddle_real3<=twiddle_real_in[56]; twiddle_real2<=twiddle_real_in[57]; twiddle_real1<=twiddle_real_in[58]; twiddle_real0<=twiddle_real_in[59];
	    twiddle_imag3<=twiddle_imag_in[56]; twiddle_imag2<=twiddle_imag_in[57]; twiddle_imag1<=twiddle_imag_in[58]; twiddle_imag0<=twiddle_imag_in[59];
      end
5'd15: begin twiddle_real3<=twiddle_real_in[60]; twiddle_real2<=twiddle_real_in[61]; twiddle_real1<=twiddle_real_in[62]; twiddle_real0<=twiddle_real_in[63];
	    twiddle_imag3<=twiddle_imag_in[60]; twiddle_imag2<=twiddle_imag_in[61]; twiddle_imag1<=twiddle_imag_in[62]; twiddle_imag0<=twiddle_imag_in[63];
      end
5'd16: begin twiddle_real3<=twiddle_real_in[64]; twiddle_real2<=twiddle_real_in[65]; twiddle_real1<=twiddle_real_in[66]; twiddle_real0<=twiddle_real_in[67];
	    twiddle_imag3<=twiddle_imag_in[64]; twiddle_imag2<=twiddle_imag_in[65]; twiddle_imag1<=twiddle_imag_in[66]; twiddle_imag0<=twiddle_imag_in[67];
      end
5'd17: begin twiddle_real3<=twiddle_real_in[68]; twiddle_real2<=twiddle_real_in[69]; twiddle_real1<=twiddle_real_in[70]; twiddle_real0<=twiddle_real_in[71];
	    twiddle_imag3<=twiddle_imag_in[68]; twiddle_imag2<=twiddle_imag_in[69]; twiddle_imag1<=twiddle_imag_in[70]; twiddle_imag0<=twiddle_imag_in[71];
      end
5'd18: begin twiddle_real3<=twiddle_real_in[72]; twiddle_real2<=twiddle_real_in[73]; twiddle_real1<=twiddle_real_in[74]; twiddle_real0<=twiddle_real_in[75];
	    twiddle_imag3<=twiddle_imag_in[72]; twiddle_imag2<=twiddle_imag_in[73]; twiddle_imag1<=twiddle_imag_in[74]; twiddle_imag0<=twiddle_imag_in[75];
      end
5'd19: begin twiddle_real3<=twiddle_real_in[76]; twiddle_real2<=twiddle_real_in[77]; twiddle_real1<=twiddle_real_in[78]; twiddle_real0<=twiddle_real_in[79];
	    twiddle_imag3<=twiddle_imag_in[76]; twiddle_imag2<=twiddle_imag_in[77]; twiddle_imag1<=twiddle_imag_in[78]; twiddle_imag0<=twiddle_imag_in[79];
      end
5'd20: begin twiddle_real3<=twiddle_real_in[80]; twiddle_real2<=twiddle_real_in[81]; twiddle_real1<=twiddle_real_in[82]; twiddle_real0<=twiddle_real_in[83];
	    twiddle_imag3<=twiddle_imag_in[80]; twiddle_imag2<=twiddle_imag_in[81]; twiddle_imag1<=twiddle_imag_in[82]; twiddle_imag0<=twiddle_imag_in[83];
      end
5'd21: begin twiddle_real3<=twiddle_real_in[84]; twiddle_real2<=twiddle_real_in[85]; twiddle_real1<=twiddle_real_in[86]; twiddle_real0<=twiddle_real_in[87];
	    twiddle_imag3<=twiddle_imag_in[84]; twiddle_imag2<=twiddle_imag_in[85]; twiddle_imag1<=twiddle_imag_in[86]; twiddle_imag0<=twiddle_imag_in[87];
      end
5'd22: begin twiddle_real3<=twiddle_real_in[88]; twiddle_real2<=twiddle_real_in[89]; twiddle_real1<=twiddle_real_in[90]; twiddle_real0<=twiddle_real_in[91];
	    twiddle_imag3<=twiddle_imag_in[88]; twiddle_imag2<=twiddle_imag_in[89]; twiddle_imag1<=twiddle_imag_in[90]; twiddle_imag0<=twiddle_imag_in[91];
      end
5'd23: begin twiddle_real3<=twiddle_real_in[92]; twiddle_real2<=twiddle_real_in[93]; twiddle_real1<=twiddle_real_in[94]; twiddle_real0<=twiddle_real_in[95];
	    twiddle_imag3<=twiddle_imag_in[92]; twiddle_imag2<=twiddle_imag_in[93]; twiddle_imag1<=twiddle_imag_in[94]; twiddle_imag0<=twiddle_imag_in[95];
      end
5'd24: begin twiddle_real3<=twiddle_real_in[96]; twiddle_real2<=twiddle_real_in[97]; twiddle_real1<=twiddle_real_in[98]; twiddle_real0<=twiddle_real_in[99];
	    twiddle_imag3<=twiddle_imag_in[96]; twiddle_imag2<=twiddle_imag_in[97]; twiddle_imag1<=twiddle_imag_in[98]; twiddle_imag0<=twiddle_imag_in[99];
      end
5'd25: begin twiddle_real3<=twiddle_real_in[100]; twiddle_real2<=twiddle_real_in[101]; twiddle_real1<=twiddle_real_in[102]; twiddle_real0<=twiddle_real_in[103];
	    twiddle_imag3<=twiddle_imag_in[100]; twiddle_imag2<=twiddle_imag_in[101]; twiddle_imag1<=twiddle_imag_in[102]; twiddle_imag0<=twiddle_imag_in[103];
      end
5'd26: begin twiddle_real3<=twiddle_real_in[104]; twiddle_real2<=twiddle_real_in[105]; twiddle_real1<=twiddle_real_in[106]; twiddle_real0<=twiddle_real_in[107];
	    twiddle_imag3<=twiddle_imag_in[104]; twiddle_imag2<=twiddle_imag_in[105]; twiddle_imag1<=twiddle_imag_in[106]; twiddle_imag0<=twiddle_imag_in[107];
      end
5'd27: begin twiddle_real3<=twiddle_real_in[108]; twiddle_real2<=twiddle_real_in[109]; twiddle_real1<=twiddle_real_in[110]; twiddle_real0<=twiddle_real_in[111];
	    twiddle_imag3<=twiddle_imag_in[108]; twiddle_imag2<=twiddle_imag_in[109]; twiddle_imag1<=twiddle_imag_in[110]; twiddle_imag0<=twiddle_imag_in[111];
      end
5'd28: begin twiddle_real3<=twiddle_real_in[112]; twiddle_real2<=twiddle_real_in[113]; twiddle_real1<=twiddle_real_in[114]; twiddle_real0<=twiddle_real_in[115];
	    twiddle_imag3<=twiddle_imag_in[112]; twiddle_imag2<=twiddle_imag_in[113]; twiddle_imag1<=twiddle_imag_in[114]; twiddle_imag0<=twiddle_imag_in[115];
      end
5'd29: begin twiddle_real3<=twiddle_real_in[116]; twiddle_real2<=twiddle_real_in[117]; twiddle_real1<=twiddle_real_in[118]; twiddle_real0<=twiddle_real_in[119];
	    twiddle_imag3<=twiddle_imag_in[116]; twiddle_imag2<=twiddle_imag_in[117]; twiddle_imag1<=twiddle_imag_in[118]; twiddle_imag0<=twiddle_imag_in[119];
      end
5'd30: begin twiddle_real3<=twiddle_real_in[120]; twiddle_real2<=twiddle_real_in[121]; twiddle_real1<=twiddle_real_in[122]; twiddle_real0<=twiddle_real_in[123];
	    twiddle_imag3<=twiddle_imag_in[120]; twiddle_imag2<=twiddle_imag_in[121]; twiddle_imag1<=twiddle_imag_in[122]; twiddle_imag0<=twiddle_imag_in[123];
      end
5'd31: begin twiddle_real3<=twiddle_real_in[124]; twiddle_real2<=twiddle_real_in[125]; twiddle_real1<=twiddle_real_in[126]; twiddle_real0<=twiddle_real_in[127];
	    twiddle_imag3<=twiddle_imag_in[124]; twiddle_imag2<=twiddle_imag_in[125]; twiddle_imag1<=twiddle_imag_in[126]; twiddle_imag0<=twiddle_imag_in[127];
      end
endcase
end //end for 111
end //end if en

else begin 
twiddle_real3<=twiddle_real3; twiddle_real2<=twiddle_real2; twiddle_real1<=twiddle_real1; twiddle_real0<=twiddle_real0; 
twiddle_imag3<=twiddle_imag3; twiddle_imag2<=twiddle_imag2; twiddle_imag1<=twiddle_imag1; twiddle_imag0<=twiddle_imag0;
end //else

end // for always block

always@(*) begin
if (en) begin

twiddle_real_in[0]=30'd1048576;
twiddle_real_in[1]=30'd1048260;
twiddle_real_in[2]=30'd1047313;
twiddle_real_in[3]=30'd1045735;
twiddle_real_in[4]=30'd1043527;
twiddle_real_in[5]=30'd1040690;
twiddle_real_in[6]=30'd1037227;
twiddle_real_in[7]=30'd1033138;
twiddle_real_in[8]=30'd1028428;
twiddle_real_in[9]=30'd1023098;
twiddle_real_in[10]=30'd1017151  ;
twiddle_real_in[11]=30'd1010592  ;
twiddle_real_in[12]=30'd1003425  ;
twiddle_real_in[13]=30'd995652   ;
twiddle_real_in[14]=30'd987281   ;
twiddle_real_in[15]=30'd978314   ;
twiddle_real_in[16]=30'd968758   ;
twiddle_real_in[17]=30'd958618   ;
twiddle_real_in[18]=30'd947901   ;
twiddle_real_in[19]=30'd936614   ;
twiddle_real_in[20]=30'd924761   ;
twiddle_real_in[21]=30'd912352   ;
twiddle_real_in[22]=30'd899394   ;
twiddle_real_in[23]=30'd885893   ;
twiddle_real_in[24]=30'd871859   ;
twiddle_real_in[25]=30'd857300   ;
twiddle_real_in[26]=30'd842224   ;
twiddle_real_in[27]=30'd826641   ;
twiddle_real_in[28]=30'd810560   ;
twiddle_real_in[29]=30'd793991   ;
twiddle_real_in[30]=30'd776944   ;
twiddle_real_in[31]=30'd759428   ;
twiddle_real_in[32]=30'd741455   ;
twiddle_real_in[33]=30'd723036   ;
twiddle_real_in[34]=30'd704181   ;
twiddle_real_in[35]=30'd684901   ;
twiddle_real_in[36]=30'd665210   ;
twiddle_real_in[37]=30'd645117   ;
twiddle_real_in[38]=30'd624636   ;
twiddle_real_in[39]=30'd603779   ;
twiddle_real_in[40]=30'd582558   ;
twiddle_real_in[41]=30'd560986   ;
twiddle_real_in[42]=30'd539076   ;
twiddle_real_in[43]=30'd516841   ;
twiddle_real_in[44]=30'd494295   ;
twiddle_real_in[45]=30'd471452   ;
twiddle_real_in[46]=30'd448324   ;
twiddle_real_in[47]=30'd424926   ;
twiddle_real_in[48]=30'd401273   ;
twiddle_real_in[49]=30'd377377   ;
twiddle_real_in[50]=30'd353255   ;
twiddle_real_in[51]=30'd328919   ;
twiddle_real_in[52]=30'd304386   ;
twiddle_real_in[53]=30'd279669   ;
twiddle_real_in[54]=30'd254783   ;
twiddle_real_in[55]=30'd229744   ;
twiddle_real_in[56]=30'd204567   ;
twiddle_real_in[57]=30'd179267   ;
twiddle_real_in[58]=30'd153858   ;
twiddle_real_in[59]=30'd128357   ;
twiddle_real_in[60]=30'd102778   ;
twiddle_real_in[61]=30'd77138    ;
twiddle_real_in[62]=30'd51451    ;
twiddle_real_in[63]=30'd25733    ;
twiddle_real_in[64]=30'd0      	 ;
twiddle_real_in[65]=-30'd25733   ;
twiddle_real_in[66]=-30'd51451   ;
twiddle_real_in[67]=-30'd77138   ;
twiddle_real_in[68]=-30'd102778  ;
twiddle_real_in[69]=-30'd128357  ;
twiddle_real_in[70]=-30'd153858  ;
twiddle_real_in[71]=-30'd179267  ;
twiddle_real_in[72]=-30'd204567  ;
twiddle_real_in[73]=-30'd229744  ;
twiddle_real_in[74]=-30'd254783  ;
twiddle_real_in[75]=-30'd279669  ;
twiddle_real_in[76]=-30'd304386  ;
twiddle_real_in[77]=-30'd328919  ;
twiddle_real_in[78]=-30'd353255  ;
twiddle_real_in[79]=-30'd377377  ;
twiddle_real_in[80]=-30'd401273  ;
twiddle_real_in[81]=-30'd424926  ;
twiddle_real_in[82]=-30'd448324  ;
twiddle_real_in[83]=-30'd471452  ;
twiddle_real_in[84]=-30'd494295  ;
twiddle_real_in[85]=-30'd516841  ;
twiddle_real_in[86]=-30'd539076  ;
twiddle_real_in[87]=-30'd560986  ;
twiddle_real_in[88]=-30'd582558  ;
twiddle_real_in[89]=-30'd603779  ;
twiddle_real_in[90]=-30'd624636  ;
twiddle_real_in[91]=-30'd645117  ;
twiddle_real_in[92]=-30'd665210  ;
twiddle_real_in[93]=-30'd684901  ;
twiddle_real_in[94]=-30'd704181  ;
twiddle_real_in[95]=-30'd723036  ;
twiddle_real_in[96]=-30'd741455  ;
twiddle_real_in[97]=-30'd759428  ;
twiddle_real_in[98]=-30'd776944  ;
twiddle_real_in[99]=-30'd793991  ;
twiddle_real_in[100]=-30'd810560  ;
twiddle_real_in[101]=-30'd826641  ;
twiddle_real_in[102]=-30'd842224  ;
twiddle_real_in[103]=-30'd857300  ;
twiddle_real_in[104]=-30'd871859  ;
twiddle_real_in[105]=-30'd885893  ;
twiddle_real_in[106]=-30'd899394  ;
twiddle_real_in[107]=-30'd912352  ;
twiddle_real_in[108]=-30'd924761  ;
twiddle_real_in[109]=-30'd936614  ;
twiddle_real_in[110]=-30'd947901  ;
twiddle_real_in[111]=-30'd958618  ;
twiddle_real_in[112]=-30'd968758  ;
twiddle_real_in[113]=-30'd978314  ;
twiddle_real_in[114]=-30'd987281  ;
twiddle_real_in[115]=-30'd995652  ;
twiddle_real_in[116]=-30'd1003425 ;
twiddle_real_in[117]=-30'd1010592 ;
twiddle_real_in[118]=-30'd1017151 ;
twiddle_real_in[119]=-30'd1023098 ;
twiddle_real_in[120]=-30'd1028428 ;
twiddle_real_in[121]=-30'd1033138 ;
twiddle_real_in[122]=-30'd1037227 ;
twiddle_real_in[123]=-30'd1040690 ;
twiddle_real_in[124]=-30'd1043527 ;
twiddle_real_in[125]=-30'd1045735 ;
twiddle_real_in[126]=-30'd1047313 ;
twiddle_real_in[127]=-30'd1048260 ;


twiddle_imag_in[0]=30'd0;
twiddle_imag_in[1]=-30'd25733;
twiddle_imag_in[2]=-30'd51451;
twiddle_imag_in[3]=-30'd77138;
twiddle_imag_in[4]=-30'd102778;
twiddle_imag_in[5]=-30'd128357;
twiddle_imag_in[6]=-30'd153858;
twiddle_imag_in[7]=-30'd179267;
twiddle_imag_in[8]=-30'd204567;
twiddle_imag_in[9]=-30'd229744;
twiddle_imag_in[10]=-30'd254783;
twiddle_imag_in[11]=-30'd279669;
twiddle_imag_in[12]=-30'd304386;
twiddle_imag_in[13]=-30'd328919;
twiddle_imag_in[14]=-30'd353255;
twiddle_imag_in[15]=-30'd377377;
twiddle_imag_in[16]=-30'd401273;
twiddle_imag_in[17]=-30'd424926;
twiddle_imag_in[18]=-30'd448324;
twiddle_imag_in[19]=-30'd471452;
twiddle_imag_in[20]=-30'd494295;
twiddle_imag_in[21]=-30'd516841;
twiddle_imag_in[22]=-30'd539076;
twiddle_imag_in[23]=-30'd560986;
twiddle_imag_in[24]=-30'd582558;
twiddle_imag_in[25]=-30'd603779;
twiddle_imag_in[26]=-30'd624636;
twiddle_imag_in[27]=-30'd645117;
twiddle_imag_in[28]=-30'd665210;
twiddle_imag_in[29]=-30'd684901;
twiddle_imag_in[30]=-30'd704181;
twiddle_imag_in[31]=-30'd723036;
twiddle_imag_in[32]=-30'd741455;
twiddle_imag_in[33]=-30'd759428;
twiddle_imag_in[34]=-30'd776944;
twiddle_imag_in[35]=-30'd793991;
twiddle_imag_in[36]=-30'd810560;
twiddle_imag_in[37]=-30'd826641;
twiddle_imag_in[38]=-30'd842224;
twiddle_imag_in[39]=-30'd857300;
twiddle_imag_in[40]=-30'd871859;
twiddle_imag_in[41]=-30'd885893;
twiddle_imag_in[42]=-30'd899394;
twiddle_imag_in[43]=-30'd912352;
twiddle_imag_in[44]=-30'd924761;
twiddle_imag_in[45]=-30'd936614;
twiddle_imag_in[46]=-30'd947901;
twiddle_imag_in[47]=-30'd958618;
twiddle_imag_in[48]=-30'd968758;
twiddle_imag_in[49]=-30'd978314;
twiddle_imag_in[50]=-30'd987281;
twiddle_imag_in[51]=-30'd995652;
twiddle_imag_in[52]=-30'd1003425;
twiddle_imag_in[53]=-30'd1010592;
twiddle_imag_in[54]=-30'd1017151;
twiddle_imag_in[55]=-30'd1023098;
twiddle_imag_in[56]=-30'd1028428;
twiddle_imag_in[57]=-30'd1033138;
twiddle_imag_in[58]=-30'd1037227;
twiddle_imag_in[59]=-30'd1040690;
twiddle_imag_in[60]=-30'd1043527;
twiddle_imag_in[61]=-30'd1045735;
twiddle_imag_in[62]=-30'd1047313;
twiddle_imag_in[63]=-30'd1048260;
twiddle_imag_in[64]=-30'd1048576;
twiddle_imag_in[65]=-30'd1048260;
twiddle_imag_in[66]=-30'd1047313;
twiddle_imag_in[67]=-30'd1045735;
twiddle_imag_in[68]=-30'd1043527;
twiddle_imag_in[69]=-30'd1040690;
twiddle_imag_in[70]=-30'd1037227;
twiddle_imag_in[71]=-30'd1033138;
twiddle_imag_in[72]=-30'd1028428;
twiddle_imag_in[73]=-30'd1023098;
twiddle_imag_in[74]=-30'd1017151;
twiddle_imag_in[75]=-30'd1010592;
twiddle_imag_in[76]=-30'd1003425;
twiddle_imag_in[77]=-30'd995652;
twiddle_imag_in[78]=-30'd987281;
twiddle_imag_in[79]=-30'd978314;
twiddle_imag_in[80]=-30'd968758;
twiddle_imag_in[81]=-30'd958618;
twiddle_imag_in[82]=-30'd947901;
twiddle_imag_in[83]=-30'd936614;
twiddle_imag_in[84]=-30'd924761;
twiddle_imag_in[85]=-30'd912352;
twiddle_imag_in[86]=-30'd899394;
twiddle_imag_in[87]=-30'd885893;
twiddle_imag_in[88]=-30'd871859;
twiddle_imag_in[89]=-30'd857300;
twiddle_imag_in[90]=-30'd842224;
twiddle_imag_in[91]=-30'd826641;
twiddle_imag_in[92]=-30'd810560;
twiddle_imag_in[93]=-30'd793991;
twiddle_imag_in[94]=-30'd776944;
twiddle_imag_in[95]=-30'd759428;
twiddle_imag_in[96]=-30'd741455;
twiddle_imag_in[97]=-30'd723036;
twiddle_imag_in[98]=-30'd704181;
twiddle_imag_in[99]=-30'd684901;
twiddle_imag_in[100]=-30'd665210;
twiddle_imag_in[101]=-30'd645117;
twiddle_imag_in[102]=-30'd624636;
twiddle_imag_in[103]=-30'd603779;
twiddle_imag_in[104]=-30'd582558;
twiddle_imag_in[105]=-30'd560986;
twiddle_imag_in[106]=-30'd539076;
twiddle_imag_in[107]=-30'd516841;
twiddle_imag_in[108]=-30'd494295;
twiddle_imag_in[109]=-30'd471452;
twiddle_imag_in[110]=-30'd448324;
twiddle_imag_in[111]=-30'd424926;
twiddle_imag_in[112]=-30'd401273;
twiddle_imag_in[113]=-30'd377377;
twiddle_imag_in[114]=-30'd353255;
twiddle_imag_in[115]=-30'd328919;
twiddle_imag_in[116]=-30'd304386;
twiddle_imag_in[117]=-30'd279669;
twiddle_imag_in[118]=-30'd254783;
twiddle_imag_in[119]=-30'd229744;
twiddle_imag_in[120]=-30'd204567;
twiddle_imag_in[121]=-30'd179267;
twiddle_imag_in[122]=-30'd153858;
twiddle_imag_in[123]=-30'd128357;
twiddle_imag_in[124]=-30'd102778;
twiddle_imag_in[125]=-30'd77138;
twiddle_imag_in[126]=-30'd51451;
twiddle_imag_in[127]=-30'd25733;
end
else begin

twiddle_real_in[0]=30'd1048576;
twiddle_real_in[1]=30'd1048260;
twiddle_real_in[2]=30'd1047313;
twiddle_real_in[3]=30'd1045735;
twiddle_real_in[4]=30'd1043527;
twiddle_real_in[5]=30'd1040690;
twiddle_real_in[6]=30'd1037227;
twiddle_real_in[7]=30'd1033138;
twiddle_real_in[8]=30'd1028428;
twiddle_real_in[9]=30'd1023098;
twiddle_real_in[10]=30'd1017151  ;
twiddle_real_in[11]=30'd1010592  ;
twiddle_real_in[12]=30'd1003425  ;
twiddle_real_in[13]=30'd995652   ;
twiddle_real_in[14]=30'd987281   ;
twiddle_real_in[15]=30'd978314   ;
twiddle_real_in[16]=30'd968758   ;
twiddle_real_in[17]=30'd958618   ;
twiddle_real_in[18]=30'd947901   ;
twiddle_real_in[19]=30'd936614   ;
twiddle_real_in[20]=30'd924761   ;
twiddle_real_in[21]=30'd912352   ;
twiddle_real_in[22]=30'd899394   ;
twiddle_real_in[23]=30'd885893   ;
twiddle_real_in[24]=30'd871859   ;
twiddle_real_in[25]=30'd857300   ;
twiddle_real_in[26]=30'd842224   ;
twiddle_real_in[27]=30'd826641   ;
twiddle_real_in[28]=30'd810560   ;
twiddle_real_in[29]=30'd793991   ;
twiddle_real_in[30]=30'd776944   ;
twiddle_real_in[31]=30'd759428   ;
twiddle_real_in[32]=30'd741455   ;
twiddle_real_in[33]=30'd723036   ;
twiddle_real_in[34]=30'd704181   ;
twiddle_real_in[35]=30'd684901   ;
twiddle_real_in[36]=30'd665210   ;
twiddle_real_in[37]=30'd645117   ;
twiddle_real_in[38]=30'd624636   ;
twiddle_real_in[39]=30'd603779   ;
twiddle_real_in[40]=30'd582558   ;
twiddle_real_in[41]=30'd560986   ;
twiddle_real_in[42]=30'd539076   ;
twiddle_real_in[43]=30'd516841   ;
twiddle_real_in[44]=30'd494295   ;
twiddle_real_in[45]=30'd471452   ;
twiddle_real_in[46]=30'd448324   ;
twiddle_real_in[47]=30'd424926   ;
twiddle_real_in[48]=30'd401273   ;
twiddle_real_in[49]=30'd377377   ;
twiddle_real_in[50]=30'd353255   ;
twiddle_real_in[51]=30'd328919   ;
twiddle_real_in[52]=30'd304386   ;
twiddle_real_in[53]=30'd279669   ;
twiddle_real_in[54]=30'd254783   ;
twiddle_real_in[55]=30'd229744   ;
twiddle_real_in[56]=30'd204567   ;
twiddle_real_in[57]=30'd179267   ;
twiddle_real_in[58]=30'd153858   ;
twiddle_real_in[59]=30'd128357   ;
twiddle_real_in[60]=30'd102778   ;
twiddle_real_in[61]=30'd77138    ;
twiddle_real_in[62]=30'd51451    ;
twiddle_real_in[63]=30'd25733    ;
twiddle_real_in[64]=30'd0      	 ;
twiddle_real_in[65]=-30'd25733   ;
twiddle_real_in[66]=-30'd51451   ;
twiddle_real_in[67]=-30'd77138   ;
twiddle_real_in[68]=-30'd102778  ;
twiddle_real_in[69]=-30'd128357  ;
twiddle_real_in[70]=-30'd153858  ;
twiddle_real_in[71]=-30'd179267  ;
twiddle_real_in[72]=-30'd204567  ;
twiddle_real_in[73]=-30'd229744  ;
twiddle_real_in[74]=-30'd254783  ;
twiddle_real_in[75]=-30'd279669  ;
twiddle_real_in[76]=-30'd304386  ;
twiddle_real_in[77]=-30'd328919  ;
twiddle_real_in[78]=-30'd353255  ;
twiddle_real_in[79]=-30'd377377  ;
twiddle_real_in[80]=-30'd401273  ;
twiddle_real_in[81]=-30'd424926  ;
twiddle_real_in[82]=-30'd448324  ;
twiddle_real_in[83]=-30'd471452  ;
twiddle_real_in[84]=-30'd494295  ;
twiddle_real_in[85]=-30'd516841  ;
twiddle_real_in[86]=-30'd539076  ;
twiddle_real_in[87]=-30'd560986  ;
twiddle_real_in[88]=-30'd582558  ;
twiddle_real_in[89]=-30'd603779  ;
twiddle_real_in[90]=-30'd624636  ;
twiddle_real_in[91]=-30'd645117  ;
twiddle_real_in[92]=-30'd665210  ;
twiddle_real_in[93]=-30'd684901  ;
twiddle_real_in[94]=-30'd704181  ;
twiddle_real_in[95]=-30'd723036  ;
twiddle_real_in[96]=-30'd741455  ;
twiddle_real_in[97]=-30'd759428  ;
twiddle_real_in[98]=-30'd776944  ;
twiddle_real_in[99]=-30'd793991  ;
twiddle_real_in[100]=-30'd810560  ;
twiddle_real_in[101]=-30'd826641  ;
twiddle_real_in[102]=-30'd842224  ;
twiddle_real_in[103]=-30'd857300  ;
twiddle_real_in[104]=-30'd871859  ;
twiddle_real_in[105]=-30'd885893  ;
twiddle_real_in[106]=-30'd899394  ;
twiddle_real_in[107]=-30'd912352  ;
twiddle_real_in[108]=-30'd924761  ;
twiddle_real_in[109]=-30'd936614  ;
twiddle_real_in[110]=-30'd947901  ;
twiddle_real_in[111]=-30'd958618  ;
twiddle_real_in[112]=-30'd968758  ;
twiddle_real_in[113]=-30'd978314  ;
twiddle_real_in[114]=-30'd987281  ;
twiddle_real_in[115]=-30'd995652  ;
twiddle_real_in[116]=-30'd1003425 ;
twiddle_real_in[117]=-30'd1010592 ;
twiddle_real_in[118]=-30'd1017151 ;
twiddle_real_in[119]=-30'd1023098 ;
twiddle_real_in[120]=-30'd1028428 ;
twiddle_real_in[121]=-30'd1033138 ;
twiddle_real_in[122]=-30'd1037227 ;
twiddle_real_in[123]=-30'd1040690 ;
twiddle_real_in[124]=-30'd1043527 ;
twiddle_real_in[125]=-30'd1045735 ;
twiddle_real_in[126]=-30'd1047313 ;
twiddle_real_in[127]=-30'd1048260 ;


twiddle_imag_in[0]=30'd0;
twiddle_imag_in[1]=-30'd25733;
twiddle_imag_in[2]=-30'd51451;
twiddle_imag_in[3]=-30'd77138;
twiddle_imag_in[4]=-30'd102778;
twiddle_imag_in[5]=-30'd128357;
twiddle_imag_in[6]=-30'd153858;
twiddle_imag_in[7]=-30'd179267;
twiddle_imag_in[8]=-30'd204567;
twiddle_imag_in[9]=-30'd229744;
twiddle_imag_in[10]=-30'd254783;
twiddle_imag_in[11]=-30'd279669;
twiddle_imag_in[12]=-30'd304386;
twiddle_imag_in[13]=-30'd328919;
twiddle_imag_in[14]=-30'd353255;
twiddle_imag_in[15]=-30'd377377;
twiddle_imag_in[16]=-30'd401273;
twiddle_imag_in[17]=-30'd424926;
twiddle_imag_in[18]=-30'd448324;
twiddle_imag_in[19]=-30'd471452;
twiddle_imag_in[20]=-30'd494295;
twiddle_imag_in[21]=-30'd516841;
twiddle_imag_in[22]=-30'd539076;
twiddle_imag_in[23]=-30'd560986;
twiddle_imag_in[24]=-30'd582558;
twiddle_imag_in[25]=-30'd603779;
twiddle_imag_in[26]=-30'd624636;
twiddle_imag_in[27]=-30'd645117;
twiddle_imag_in[28]=-30'd665210;
twiddle_imag_in[29]=-30'd684901;
twiddle_imag_in[30]=-30'd704181;
twiddle_imag_in[31]=-30'd723036;
twiddle_imag_in[32]=-30'd741455;
twiddle_imag_in[33]=-30'd759428;
twiddle_imag_in[34]=-30'd776944;
twiddle_imag_in[35]=-30'd793991;
twiddle_imag_in[36]=-30'd810560;
twiddle_imag_in[37]=-30'd826641;
twiddle_imag_in[38]=-30'd842224;
twiddle_imag_in[39]=-30'd857300;
twiddle_imag_in[40]=-30'd871859;
twiddle_imag_in[41]=-30'd885893;
twiddle_imag_in[42]=-30'd899394;
twiddle_imag_in[43]=-30'd912352;
twiddle_imag_in[44]=-30'd924761;
twiddle_imag_in[45]=-30'd936614;
twiddle_imag_in[46]=-30'd947901;
twiddle_imag_in[47]=-30'd958618;
twiddle_imag_in[48]=-30'd968758;
twiddle_imag_in[49]=-30'd978314;
twiddle_imag_in[50]=-30'd987281;
twiddle_imag_in[51]=-30'd995652;
twiddle_imag_in[52]=-30'd1003425;
twiddle_imag_in[53]=-30'd1010592;
twiddle_imag_in[54]=-30'd1017151;
twiddle_imag_in[55]=-30'd1023098;
twiddle_imag_in[56]=-30'd1028428;
twiddle_imag_in[57]=-30'd1033138;
twiddle_imag_in[58]=-30'd1037227;
twiddle_imag_in[59]=-30'd1040690;
twiddle_imag_in[60]=-30'd1043527;
twiddle_imag_in[61]=-30'd1045735;
twiddle_imag_in[62]=-30'd1047313;
twiddle_imag_in[63]=-30'd1048260;
twiddle_imag_in[64]=-30'd1048576;
twiddle_imag_in[65]=-30'd1048260;
twiddle_imag_in[66]=-30'd1047313;
twiddle_imag_in[67]=-30'd1045735;
twiddle_imag_in[68]=-30'd1043527;
twiddle_imag_in[69]=-30'd1040690;
twiddle_imag_in[70]=-30'd1037227;
twiddle_imag_in[71]=-30'd1033138;
twiddle_imag_in[72]=-30'd1028428;
twiddle_imag_in[73]=-30'd1023098;
twiddle_imag_in[74]=-30'd1017151;
twiddle_imag_in[75]=-30'd1010592;
twiddle_imag_in[76]=-30'd1003425;
twiddle_imag_in[77]=-30'd995652;
twiddle_imag_in[78]=-30'd987281;
twiddle_imag_in[79]=-30'd978314;
twiddle_imag_in[80]=-30'd968758;
twiddle_imag_in[81]=-30'd958618;
twiddle_imag_in[82]=-30'd947901;
twiddle_imag_in[83]=-30'd936614;
twiddle_imag_in[84]=-30'd924761;
twiddle_imag_in[85]=-30'd912352;
twiddle_imag_in[86]=-30'd899394;
twiddle_imag_in[87]=-30'd885893;
twiddle_imag_in[88]=-30'd871859;
twiddle_imag_in[89]=-30'd857300;
twiddle_imag_in[90]=-30'd842224;
twiddle_imag_in[91]=-30'd826641;
twiddle_imag_in[92]=-30'd810560;
twiddle_imag_in[93]=-30'd793991;
twiddle_imag_in[94]=-30'd776944;
twiddle_imag_in[95]=-30'd759428;
twiddle_imag_in[96]=-30'd741455;
twiddle_imag_in[97]=-30'd723036;
twiddle_imag_in[98]=-30'd704181;
twiddle_imag_in[99]=-30'd684901;
twiddle_imag_in[100]=-30'd665210;
twiddle_imag_in[101]=-30'd645117;
twiddle_imag_in[102]=-30'd624636;
twiddle_imag_in[103]=-30'd603779;
twiddle_imag_in[104]=-30'd582558;
twiddle_imag_in[105]=-30'd560986;
twiddle_imag_in[106]=-30'd539076;
twiddle_imag_in[107]=-30'd516841;
twiddle_imag_in[108]=-30'd494295;
twiddle_imag_in[109]=-30'd471452;
twiddle_imag_in[110]=-30'd448324;
twiddle_imag_in[111]=-30'd424926;
twiddle_imag_in[112]=-30'd401273;
twiddle_imag_in[113]=-30'd377377;
twiddle_imag_in[114]=-30'd353255;
twiddle_imag_in[115]=-30'd328919;
twiddle_imag_in[116]=-30'd304386;
twiddle_imag_in[117]=-30'd279669;
twiddle_imag_in[118]=-30'd254783;
twiddle_imag_in[119]=-30'd229744;
twiddle_imag_in[120]=-30'd204567;
twiddle_imag_in[121]=-30'd179267;
twiddle_imag_in[122]=-30'd153858;
twiddle_imag_in[123]=-30'd128357;
twiddle_imag_in[124]=-30'd102778;
twiddle_imag_in[125]=-30'd77138;
twiddle_imag_in[126]=-30'd51451;
twiddle_imag_in[127]=-30'd25733;
end
end //end always block
endmodule



