module data_buffer (input_to_butterfly_real, input_to_butterfly_imag, input_to_butterfly_ad, butterfly_output_flush, output_startin, realpart_in, imagpart_in, realin_255, imagin_255, output_from_butterfly_real, output_from_butterfly_imag, output_from_butterfly_ad_0, output_from_butterfly_ad_1, output_from_butterfly_ad_2, output_from_butterfly_ad_3, output_from_butterfly_ad_4, output_from_butterfly_ad_5, output_from_butterfly_ad_6, output_from_butterfly_ad_7, butterfly_input_flush, clk, reset, start_flush);

parameter total_in_bits = 20;
parameter totalbits = 30;
output reg signed [totalbits-1:0] input_to_butterfly_real [7:0];
output reg signed [totalbits-1:0] input_to_butterfly_imag [7:0];
output reg [7:0] input_to_butterfly_ad [7:0];
output reg butterfly_output_flush;
output reg output_startin;
input reg signed [totalbits-1:0] realpart_in [254:0];
input reg signed [totalbits-1:0] imagpart_in [254:0];
input reg signed [total_in_bits-1:0] realin_255;
input reg signed [total_in_bits-1:0] imagin_255;
input reg signed [totalbits-1:0] output_from_butterfly_real [7:0];
input reg signed [totalbits-1:0] output_from_butterfly_imag [7:0];
input reg [7:0] output_from_butterfly_ad_0, output_from_butterfly_ad_1, output_from_butterfly_ad_2, output_from_butterfly_ad_3, output_from_butterfly_ad_4, output_from_butterfly_ad_5, output_from_butterfly_ad_6, output_from_butterfly_ad_7;
reg [7:0] output_from_butterfly_ad_0_test, output_from_butterfly_ad_1_test, output_from_butterfly_ad_2_test, output_from_butterfly_ad_3_test, output_from_butterfly_ad_4_test, output_from_butterfly_ad_5_test, output_from_butterfly_ad_6_test, output_from_butterfly_ad_7_test;
input butterfly_input_flush, clk, reset, start_flush;
wire signed [totalbits-1:0] realin_255_1;
wire signed [totalbits-1:0] imagin_255_1;
reg en, butterfly_en_output, butterfly_en_result,butterfly_en_result_t,output_startin1,output_startin2,output_startin3,output_startin4,output_startin5,butterfly_en_result1,butterfly_en_result2,butterfly_en_result3,butterfly_en_result4,butterfly_en_result5;
reg signed [totalbits-1:0] working_real_buffer [255:0];
reg signed [totalbits-1:0] working_imag_buffer [255:0];
reg [7:0] count, level, level_2;
wire [4:0] butterfly_level_counter;
reg [7:0] butterfly_add_0, butterfly_add_1, butterfly_add_2, butterfly_add_3, butterfly_add_4, butterfly_add_5, butterfly_add_6, butterfly_add_7;
reg [7:0] output_from_butterfly_ad [7:0];
reg [1:0] present_state;
reg [3:0] level_state;

parameter IDLE = 2'b00,
          START = 2'b01;

parameter STAGE_0 = 4'd0,
          STAGE_1 = 4'd1,
          STAGE_2 = 4'd2,
          STAGE_3 = 4'd3,
          STAGE_4 = 4'd4,
          STAGE_5 = 4'd5,
          STAGE_6 = 4'd6,
          STAGE_7 = 4'd7,
          B_IDLE  = 4'd8;
assign realin_255_1 = {{8{realin_255[19]}},realin_255,2'b00};
assign imagin_255_1 = {{8{imagin_255[19]}},imagin_255,2'b00};
assign butterfly_level_counter = count[4:0];
always @(*)
begin
   // if (reset)
   // begin
   // end else if (start_flush || en)
   if (start_flush || en)
   begin
       present_state = START;
   end else begin
       present_state = IDLE;
   end
    if (level == 1) level_state = STAGE_0;
    else if (level == 2) level_state = STAGE_1;
    else if (level == 3) level_state = STAGE_2;
    else if (level == 4) level_state = STAGE_3;
    else if (level == 5) level_state = STAGE_4;
    else if (level == 6) level_state = STAGE_5;
    else if (level == 7) level_state = STAGE_6;
    else if (level == 8) level_state = STAGE_7;
    else level_state = B_IDLE; 

//    always@(level_state or butterfly_add_0 or butterfly_add_1 or butterfly_add_2 or butterfly_add_3 or butterfly_add_4 or butterfly_add_5 or butterfly_add_6 or butterfly_add_7) begin
            //Recirculating logic for Butterfly
     //rak       case (level_state)
     //rak           STAGE_0:
     //rak           begin
     //rak               if (butterfly_level_counter == 0) 
     //rak               begin
     //rak                   butterfly_add_0 =  8'd0;
     //rak                   butterfly_add_1 =  8'd1;
     //rak                   butterfly_add_2 =  8'd2;
     //rak                   butterfly_add_3 =  8'd3;
     //rak                   butterfly_add_4 =  8'd4;
     //rak                   butterfly_add_5 =  8'd5;
     //rak                   butterfly_add_6 =  8'd6;
     //rak                   butterfly_add_7 =  8'd7;
     //rak               end else begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd8;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd8;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd8;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd8;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd8;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd8;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd8;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd8;
     //rak               end


     //rak           end
     //rak           STAGE_1:
     //rak            begin
     //rak               if (butterfly_level_counter == 0) 
     //rak               begin
     //rak                   butterfly_add_0 =  8'd0;
     //rak                   butterfly_add_1 =  8'd2;
     //rak                   butterfly_add_2 =  8'd1;
     //rak                   butterfly_add_3 =  8'd3;
     //rak                   butterfly_add_4 =  8'd4;
     //rak                   butterfly_add_5 =  8'd6;
     //rak                   butterfly_add_6 =  8'd5;
     //rak                   butterfly_add_7 =  8'd7;
     //rak               end else begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd8;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd8;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd8;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd8;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd8;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd8;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd8;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd8;
     //rak               end
     //rak           end 
     //rak           STAGE_2:
     //rak           begin
     //rak               if (butterfly_level_counter == 0)
     //rak               begin
     //rak                   butterfly_add_0 =  8'd0;
     //rak                   butterfly_add_1 =  8'd4;
     //rak                   butterfly_add_2 =  8'd1;
     //rak                   butterfly_add_3 =  8'd5;
     //rak                   butterfly_add_4 =  8'd2;
     //rak                   butterfly_add_5 =  8'd6;
     //rak                   butterfly_add_6 =  8'd3;
     //rak                   butterfly_add_7 =  8'd7;
     //rak               end else 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd8;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd8;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd8;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd8;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd8;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd8;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd8;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd8;
     //rak               end 
     //rak           end 
     //rak           STAGE_3:
     //rak           begin
     //rak               if (butterfly_level_counter == 0)
     //rak               begin
     //rak                   butterfly_add_0 =  8'd0;
     //rak                   butterfly_add_1 =  8'd8;
     //rak                   butterfly_add_2 =  8'd1;
     //rak                   butterfly_add_3 =  8'd9;
     //rak                   butterfly_add_4 =  8'd2;
     //rak                   butterfly_add_5 =  8'd10;
     //rak                   butterfly_add_6 =  8'd3;
     //rak                   butterfly_add_7 =  8'd11;
     //rak               end else if (butterfly_level_counter % 2 == 0) 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd12;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd12;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd12;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd12;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd12;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd12;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd12;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd12;
     //rak               end else 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd4;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd4;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd4;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd4;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd4;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd4;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd4;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd4;
     //rak               end 
     //rak           end 
     //rak           STAGE_4:
     //rak           begin
     //rak               if (butterfly_level_counter == 0)
     //rak               begin
     //rak                   butterfly_add_0 =  8'd0;
     //rak                   butterfly_add_1 =  8'd16;
     //rak                   butterfly_add_2 =  8'd1;
     //rak                   butterfly_add_3 =  8'd17;
     //rak                   butterfly_add_4 =  8'd2;
     //rak                   butterfly_add_5 =  8'd18;
     //rak                   butterfly_add_6 =  8'd3;
     //rak                   butterfly_add_7 =  8'd19;
     //rak               end else if (butterfly_level_counter % 4 == 0) 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd20;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd20;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd20;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd20;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd20;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd20;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd20;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd20;
     //rak               end else 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd4;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd4;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd4;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd4;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd4;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd4;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd4;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd4;
     //rak               end 
     //rak           end 
     //rak           STAGE_5:
     //rak           begin
     //rak               if (butterfly_level_counter == 0)
     //rak               begin
     //rak                   butterfly_add_0 =  8'd0;
     //rak                   butterfly_add_1 =  8'd32;
     //rak                   butterfly_add_2 =  8'd1;
     //rak                   butterfly_add_3 =  8'd33;
     //rak                   butterfly_add_4 =  8'd2;
     //rak                   butterfly_add_5 =  8'd34;
     //rak                   butterfly_add_6 =  8'd3;
     //rak                   butterfly_add_7 =  8'd35;
     //rak               end else if (butterfly_level_counter % 8 == 0) 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd36;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd36;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd36;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd36;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd36;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd36;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd36;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd36;
     //rak               end else 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd4;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd4;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd4;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd4;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd4;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd4;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd4;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd4;
     //rak               end 
     //rak           end 
     //rak           STAGE_6:
     //rak           begin
     //rak               if (butterfly_level_counter == 0)
     //rak               begin
     //rak                   butterfly_add_0 =  8'd0;
     //rak                   butterfly_add_1 =  8'd64;
     //rak                   butterfly_add_2 =  8'd1;
     //rak                   butterfly_add_3 =  8'd65;
     //rak                   butterfly_add_4 =  8'd2;
     //rak                   butterfly_add_5 =  8'd66;
     //rak                   butterfly_add_6 =  8'd3;
     //rak                   butterfly_add_7 =  8'd67;
     //rak               end else if (butterfly_level_counter % 16 == 0) 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd68;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd68;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd68;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd68;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd68;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd68;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd68;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd68;
     //rak               end else 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd4;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd4;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd4;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd4;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd4;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd4;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd4;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd4;
     //rak               end 
     //rak           end 
     //rak           STAGE_7:

     //rak           begin
     //rak               if (butterfly_level_counter == 0)
     //rak               begin
     //rak                   butterfly_add_0 =  8'd0;
     //rak                   butterfly_add_1 =  8'd128;
     //rak                   butterfly_add_2 =  8'd1;
     //rak                   butterfly_add_3 =  8'd129;
     //rak                   butterfly_add_4 =  8'd2;
     //rak                   butterfly_add_5 =  8'd130;
     //rak                   butterfly_add_6 =  8'd3;
     //rak                   butterfly_add_7 =  8'd131;
     //rak               end else 
     //rak               begin
     //rak                   butterfly_add_0 =  butterfly_add_0 + 8'd4;
     //rak                   butterfly_add_1 =  butterfly_add_1 + 8'd4;
     //rak                   butterfly_add_2 =  butterfly_add_2 + 8'd4;
     //rak                   butterfly_add_3 =  butterfly_add_3 + 8'd4;
     //rak                   butterfly_add_4 =  butterfly_add_4 + 8'd4;
     //rak                   butterfly_add_5 =  butterfly_add_5 + 8'd4;
     //rak                   butterfly_add_6 =  butterfly_add_6 + 8'd4;
     //rak                   butterfly_add_7 =  butterfly_add_7 + 8'd4;
     //rak               end 
     //rak           end
     //rak           B_IDLE:
     //rak           begin
     //rak               butterfly_add_0 =  8'd0;
     //rak               butterfly_add_1 =  8'd0;
     //rak               butterfly_add_2 =  8'd0;
     //rak               butterfly_add_3 =  8'd0;
     //rak               butterfly_add_4 =  8'd0;
     //rak               butterfly_add_5 =  8'd0;
     //rak               butterfly_add_6 =  8'd0;
     //rak               butterfly_add_7 =  8'd0;

     //rak           end
//rak default:
//rak begin
//rak     butterfly_add_0 =  8'd0;
//rak     butterfly_add_1 =  8'd0;
//rak     butterfly_add_2 =  8'd0;
//rak     butterfly_add_3 =  8'd0;
//rak     butterfly_add_4 =  8'd0;
//rak     butterfly_add_5 =  8'd0;
//rak     butterfly_add_6 =  8'd0;
//rak     butterfly_add_7 =  8'd0;
//rak                             
//rak end
//rak     endcase
end

always@(*) begin
	if (level==0) begin	
                        butterfly_add_0 =  8'd0;
                        butterfly_add_1 =  8'd0;
                        butterfly_add_2 =  8'd0;
                        butterfly_add_3 =  8'd0;
                        butterfly_add_4 =  8'd0;
                        butterfly_add_5 =  8'd0;
                        butterfly_add_6 =  8'd0;
                        butterfly_add_7 =  8'd0;
		end
		else begin
			if (count==0) begin
			butterfly_add_0 =  8'd0;
			butterfly_add_1 =  8'd1;
			butterfly_add_2 =  8'd2;
			butterfly_add_3 =  8'd3;
			butterfly_add_4 =  8'd4;
			butterfly_add_5 =  8'd5;
			butterfly_add_6 =  8'd6;
			butterfly_add_7 =  8'd7;
			end
		   else	if (count==1) begin
			butterfly_add_0 =  8'd8;
			butterfly_add_1 =  8'd9;
			butterfly_add_2 =  8'd10;
			butterfly_add_3 =  8'd11;
			butterfly_add_4 =  8'd12;
			butterfly_add_5 =  8'd13;
			butterfly_add_6 =  8'd14;
			butterfly_add_7 =  8'd15;
			end
		   else	if (count==2) begin
			butterfly_add_0 =  8'd16;
			butterfly_add_1 =  8'd17;
			butterfly_add_2 =  8'd18;
			butterfly_add_3 =  8'd19;
			butterfly_add_4 =  8'd20;
			butterfly_add_5 =  8'd21;
			butterfly_add_6 =  8'd22;
			butterfly_add_7 =  8'd23;
			end
		   else	if (count==3) begin
			butterfly_add_0 =  8'd24;
			butterfly_add_1 =  8'd25;
			butterfly_add_2 =  8'd26;
			butterfly_add_3 =  8'd27;
			butterfly_add_4 =  8'd28;
			butterfly_add_5 =  8'd29;
			butterfly_add_6 =  8'd30;
			butterfly_add_7 =  8'd31;
			end
		   else	if (count==4) begin
			butterfly_add_0 =  8'd32;
			butterfly_add_1 =  8'd33;
			butterfly_add_2 =  8'd34;
			butterfly_add_3 =  8'd35;
			butterfly_add_4 =  8'd36;
			butterfly_add_5 =  8'd37;
			butterfly_add_6 =  8'd38;
			butterfly_add_7 =  8'd39;
			end
		   else	if (count==5) begin
			butterfly_add_0 =  8'd40;
			butterfly_add_1 =  8'd41;
			butterfly_add_2 =  8'd42;
			butterfly_add_3 =  8'd43;
			butterfly_add_4 =  8'd44;
			butterfly_add_5 =  8'd45;
			butterfly_add_6 =  8'd46;
			butterfly_add_7 =  8'd47;
			end
		   else	if (count==6) begin
			butterfly_add_0 =  8'd48;
			butterfly_add_1 =  8'd49;
			butterfly_add_2 =  8'd50;
			butterfly_add_3 =  8'd51;
			butterfly_add_4 =  8'd52;
			butterfly_add_5 =  8'd53;
			butterfly_add_6 =  8'd54;
			butterfly_add_7 =  8'd55;
			end
		   else	if (count==7) begin
			butterfly_add_0 =  8'd56;
			butterfly_add_1 =  8'd57;
			butterfly_add_2 =  8'd58;
			butterfly_add_3 =  8'd59;
			butterfly_add_4 =  8'd60;
			butterfly_add_5 =  8'd61;
			butterfly_add_6 =  8'd62;
			butterfly_add_7 =  8'd63;
			end
		   else	if (count==8) begin
			butterfly_add_0 =  8'd64;
			butterfly_add_1 =  8'd65;
			butterfly_add_2 =  8'd66;
			butterfly_add_3 =  8'd67;
			butterfly_add_4 =  8'd68;
			butterfly_add_5 =  8'd69;
			butterfly_add_6 =  8'd70;
			butterfly_add_7 =  8'd71;
			end
		   else	if (count==9) begin
			butterfly_add_0 =  8'd72;
			butterfly_add_1 =  8'd73;
			butterfly_add_2 =  8'd74;
			butterfly_add_3 =  8'd75;
			butterfly_add_4 =  8'd76;
			butterfly_add_5 =  8'd77;
			butterfly_add_6 =  8'd78;
			butterfly_add_7 =  8'd79;
			end
		   else	if (count==10) begin
			butterfly_add_0 =  8'd80;
			butterfly_add_1 =  8'd81;
			butterfly_add_2 =  8'd82;
			butterfly_add_3 =  8'd83;
			butterfly_add_4 =  8'd84;
			butterfly_add_5 =  8'd85;
			butterfly_add_6 =  8'd86;
			butterfly_add_7 =  8'd87;
			end
		   else	if (count==11) begin
			butterfly_add_0 =  8'd88;
			butterfly_add_1 =  8'd89;
			butterfly_add_2 =  8'd90;
			butterfly_add_3 =  8'd91;
			butterfly_add_4 =  8'd92;
			butterfly_add_5 =  8'd93;
			butterfly_add_6 =  8'd94;
			butterfly_add_7 =  8'd95;
			end
		   else	if (count==12) begin
			butterfly_add_0 =  8'd96;
			butterfly_add_1 =  8'd97;
			butterfly_add_2 =  8'd98;
			butterfly_add_3 =  8'd99;
			butterfly_add_4 =  8'd100;
			butterfly_add_5 =  8'd101;
			butterfly_add_6 =  8'd102;
			butterfly_add_7 =  8'd103;
			end
		   else	if (count==13) begin
			butterfly_add_0 =  8'd104;
			butterfly_add_1 =  8'd105;
			butterfly_add_2 =  8'd106;
			butterfly_add_3 =  8'd107;
			butterfly_add_4 =  8'd108;
			butterfly_add_5 =  8'd109;
			butterfly_add_6 =  8'd110;
			butterfly_add_7 =  8'd111;
			end
		   else	if (count==14) begin
			butterfly_add_0 =  8'd112;
			butterfly_add_1 =  8'd113;
			butterfly_add_2 =  8'd114;
			butterfly_add_3 =  8'd115;
			butterfly_add_4 =  8'd116;
			butterfly_add_5 =  8'd117;
			butterfly_add_6 =  8'd118;
			butterfly_add_7 =  8'd119;
			end
		   else	if (count==15) begin
			butterfly_add_0 =  8'd120;
			butterfly_add_1 =  8'd121;
			butterfly_add_2 =  8'd122;
			butterfly_add_3 =  8'd123;
			butterfly_add_4 =  8'd124;
			butterfly_add_5 =  8'd125;
			butterfly_add_6 =  8'd126;
			butterfly_add_7 =  8'd127;
			end
		   else	if (count==16) begin
			butterfly_add_0 =  8'd128;
			butterfly_add_1 =  8'd129;
			butterfly_add_2 =  8'd130;
			butterfly_add_3 =  8'd131;
			butterfly_add_4 =  8'd132;
			butterfly_add_5 =  8'd133;
			butterfly_add_6 =  8'd134;
			butterfly_add_7 =  8'd135;
			end
		   else	if (count==17) begin
			butterfly_add_0 =  8'd136;
			butterfly_add_1 =  8'd137;
			butterfly_add_2 =  8'd138;
			butterfly_add_3 =  8'd139;
			butterfly_add_4 =  8'd140;
			butterfly_add_5 =  8'd141;
			butterfly_add_6 =  8'd142;
			butterfly_add_7 =  8'd143;
			end
		   else	if (count==18) begin
			butterfly_add_0 =  8'd144;
			butterfly_add_1 =  8'd145;
			butterfly_add_2 =  8'd146;
			butterfly_add_3 =  8'd147;
			butterfly_add_4 =  8'd148;
			butterfly_add_5 =  8'd149;
			butterfly_add_6 =  8'd150;
			butterfly_add_7 =  8'd151;
			end
		   else	if (count==19) begin
			butterfly_add_0 =  8'd152;
			butterfly_add_1 =  8'd153;
			butterfly_add_2 =  8'd154;
			butterfly_add_3 =  8'd155;
			butterfly_add_4 =  8'd156;
			butterfly_add_5 =  8'd157;
			butterfly_add_6 =  8'd158;
			butterfly_add_7 =  8'd159;
			end
		   else	if (count==20) begin
			butterfly_add_0 =  8'd160;
			butterfly_add_1 =  8'd161;
			butterfly_add_2 =  8'd162;
			butterfly_add_3 =  8'd163;
			butterfly_add_4 =  8'd164;
			butterfly_add_5 =  8'd165;
			butterfly_add_6 =  8'd166;
			butterfly_add_7 =  8'd167;
			end
		   else	if (count==21) begin
			butterfly_add_0 =  8'd168;
			butterfly_add_1 =  8'd169;
			butterfly_add_2 =  8'd170;
			butterfly_add_3 =  8'd171;
			butterfly_add_4 =  8'd172;
			butterfly_add_5 =  8'd173;
			butterfly_add_6 =  8'd174;
			butterfly_add_7 =  8'd175;
			end
		   else	if (count==22) begin
			butterfly_add_0 =  8'd176;
			butterfly_add_1 =  8'd177;
			butterfly_add_2 =  8'd178;
			butterfly_add_3 =  8'd179;
			butterfly_add_4 =  8'd180;
			butterfly_add_5 =  8'd181;
			butterfly_add_6 =  8'd182;
			butterfly_add_7 =  8'd183;
			end
		   else	if (count==23) begin
			butterfly_add_0 =  8'd184;
			butterfly_add_1 =  8'd185;
			butterfly_add_2 =  8'd186;
			butterfly_add_3 =  8'd187;
			butterfly_add_4 =  8'd188;
			butterfly_add_5 =  8'd189;
			butterfly_add_6 =  8'd190;
			butterfly_add_7 =  8'd191;
			end
		   else	if (count==24) begin
			butterfly_add_0 =  8'd192;
			butterfly_add_1 =  8'd193;
			butterfly_add_2 =  8'd194;
			butterfly_add_3 =  8'd195;
			butterfly_add_4 =  8'd196;
			butterfly_add_5 =  8'd197;
			butterfly_add_6 =  8'd198;
			butterfly_add_7 =  8'd199;
			end
		   else	if (count==25) begin
			butterfly_add_0 =  8'd200;
			butterfly_add_1 =  8'd201;
			butterfly_add_2 =  8'd202;
			butterfly_add_3 =  8'd203;
			butterfly_add_4 =  8'd204;
			butterfly_add_5 =  8'd205;
			butterfly_add_6 =  8'd206;
			butterfly_add_7 =  8'd207;
			end
		   else	if (count==26) begin
			butterfly_add_0 =  8'd208;
			butterfly_add_1 =  8'd209;
			butterfly_add_2 =  8'd210;
			butterfly_add_3 =  8'd211;
			butterfly_add_4 =  8'd212;
			butterfly_add_5 =  8'd213;
			butterfly_add_6 =  8'd214;
			butterfly_add_7 =  8'd215;
			end
		   else	if (count==27) begin
			butterfly_add_0 =  8'd216;
			butterfly_add_1 =  8'd217;
			butterfly_add_2 =  8'd218;
			butterfly_add_3 =  8'd219;
			butterfly_add_4 =  8'd220;
			butterfly_add_5 =  8'd221;
			butterfly_add_6 =  8'd222;
			butterfly_add_7 =  8'd223;
			end
		   else	if (count==28) begin
			butterfly_add_0 =  8'd224;
			butterfly_add_1 =  8'd225;
			butterfly_add_2 =  8'd226;
			butterfly_add_3 =  8'd227;
			butterfly_add_4 =  8'd228;
			butterfly_add_5 =  8'd229;
			butterfly_add_6 =  8'd230;
			butterfly_add_7 =  8'd231;
			end
		   else	if (count==29) begin
			butterfly_add_0 =  8'd232;
			butterfly_add_1 =  8'd233;
			butterfly_add_2 =  8'd234;
			butterfly_add_3 =  8'd235;
			butterfly_add_4 =  8'd236;
			butterfly_add_5 =  8'd237;
			butterfly_add_6 =  8'd238;
			butterfly_add_7 =  8'd239;
			end
		   else	if (count==30) begin
			butterfly_add_0 =  8'd240;
			butterfly_add_1 =  8'd241;
			butterfly_add_2 =  8'd242;
			butterfly_add_3 =  8'd243;
			butterfly_add_4 =  8'd244;
			butterfly_add_5 =  8'd245;
			butterfly_add_6 =  8'd246;
			butterfly_add_7 =  8'd247;
			end
		   else	if (count==31) begin
			butterfly_add_0 =  8'd248;
			butterfly_add_1 =  8'd249;
			butterfly_add_2 =  8'd250;
			butterfly_add_3 =  8'd251;
			butterfly_add_4 =  8'd252;
			butterfly_add_5 =  8'd253;
			butterfly_add_6 =  8'd254;
			butterfly_add_7 =  8'd255;
			end
		   else	if (count==32) begin
			butterfly_add_0 =  8'd0;
			butterfly_add_1 =  8'd2;
			butterfly_add_2 =  8'd1;
			butterfly_add_3 =  8'd3;
			butterfly_add_4 =  8'd4;
			butterfly_add_5 =  8'd6;
			butterfly_add_6 =  8'd5;
			butterfly_add_7 =  8'd7;
			end
		   else	if (count==33) begin
			butterfly_add_0 =  8'd8;
			butterfly_add_1 =  8'd10;
			butterfly_add_2 =  8'd9;
			butterfly_add_3 =  8'd11;
			butterfly_add_4 =  8'd12;
			butterfly_add_5 =  8'd14;
			butterfly_add_6 =  8'd13;
			butterfly_add_7 =  8'd15;
			end
		   else	if (count==34) begin
			butterfly_add_0 =  8'd16;
			butterfly_add_1 =  8'd18;
			butterfly_add_2 =  8'd17;
			butterfly_add_3 =  8'd19;
			butterfly_add_4 =  8'd20;
			butterfly_add_5 =  8'd22;
			butterfly_add_6 =  8'd21;
			butterfly_add_7 =  8'd23;
			end
		   else	if (count==35) begin
			butterfly_add_0 =  8'd24;
			butterfly_add_1 =  8'd26;
			butterfly_add_2 =  8'd25;
			butterfly_add_3 =  8'd27;
			butterfly_add_4 =  8'd28;
			butterfly_add_5 =  8'd30;
			butterfly_add_6 =  8'd29;
			butterfly_add_7 =  8'd31;
			end
		   else	if (count==36) begin
			butterfly_add_0 =  8'd32;
			butterfly_add_1 =  8'd34;
			butterfly_add_2 =  8'd33;
			butterfly_add_3 =  8'd35;
			butterfly_add_4 =  8'd36;
			butterfly_add_5 =  8'd38;
			butterfly_add_6 =  8'd37;
			butterfly_add_7 =  8'd39;
			end
		   else	if (count==37) begin
			butterfly_add_0 =  8'd40;
			butterfly_add_1 =  8'd42;
			butterfly_add_2 =  8'd41;
			butterfly_add_3 =  8'd43;
			butterfly_add_4 =  8'd44;
			butterfly_add_5 =  8'd46;
			butterfly_add_6 =  8'd45;
			butterfly_add_7 =  8'd47;
			end
		   else	if (count==38) begin
			butterfly_add_0 =  8'd48;
			butterfly_add_1 =  8'd50;
			butterfly_add_2 =  8'd49;
			butterfly_add_3 =  8'd51;
			butterfly_add_4 =  8'd52;
			butterfly_add_5 =  8'd54;
			butterfly_add_6 =  8'd53;
			butterfly_add_7 =  8'd55;
			end
		   else	if (count==39) begin
			butterfly_add_0 =  8'd56;
			butterfly_add_1 =  8'd58;
			butterfly_add_2 =  8'd57;
			butterfly_add_3 =  8'd59;
			butterfly_add_4 =  8'd60;
			butterfly_add_5 =  8'd62;
			butterfly_add_6 =  8'd61;
			butterfly_add_7 =  8'd63;
			end
		   else	if (count==40) begin
			butterfly_add_0 =  8'd64;
			butterfly_add_1 =  8'd66;
			butterfly_add_2 =  8'd65;
			butterfly_add_3 =  8'd67;
			butterfly_add_4 =  8'd68;
			butterfly_add_5 =  8'd70;
			butterfly_add_6 =  8'd69;
			butterfly_add_7 =  8'd71;
			end
		   else	if (count==41) begin
			butterfly_add_0 =  8'd72;
			butterfly_add_1 =  8'd74;
			butterfly_add_2 =  8'd73;
			butterfly_add_3 =  8'd75;
			butterfly_add_4 =  8'd76;
			butterfly_add_5 =  8'd78;
			butterfly_add_6 =  8'd77;
			butterfly_add_7 =  8'd79;
			end
		   else	if (count==42) begin
			butterfly_add_0 =  8'd80;
			butterfly_add_1 =  8'd82;
			butterfly_add_2 =  8'd81;
			butterfly_add_3 =  8'd83;
			butterfly_add_4 =  8'd84;
			butterfly_add_5 =  8'd86;
			butterfly_add_6 =  8'd85;
			butterfly_add_7 =  8'd87;
			end
		   else	if (count==43) begin
			butterfly_add_0 =  8'd88;
			butterfly_add_1 =  8'd90;
			butterfly_add_2 =  8'd89;
			butterfly_add_3 =  8'd91;
			butterfly_add_4 =  8'd92;
			butterfly_add_5 =  8'd94;
			butterfly_add_6 =  8'd93;
			butterfly_add_7 =  8'd95;
			end
		   else	if (count==44) begin
			butterfly_add_0 =  8'd96;
			butterfly_add_1 =  8'd98;
			butterfly_add_2 =  8'd97;
			butterfly_add_3 =  8'd99;
			butterfly_add_4 =  8'd100;
			butterfly_add_5 =  8'd102;
			butterfly_add_6 =  8'd101;
			butterfly_add_7 =  8'd103;
			end
		   else	if (count==45) begin
			butterfly_add_0 =  8'd104;
			butterfly_add_1 =  8'd106;
			butterfly_add_2 =  8'd105;
			butterfly_add_3 =  8'd107;
			butterfly_add_4 =  8'd108;
			butterfly_add_5 =  8'd110;
			butterfly_add_6 =  8'd109;
			butterfly_add_7 =  8'd111;
			end
		   else	if (count==46) begin
			butterfly_add_0 =  8'd112;
			butterfly_add_1 =  8'd114;
			butterfly_add_2 =  8'd113;
			butterfly_add_3 =  8'd115;
			butterfly_add_4 =  8'd116;
			butterfly_add_5 =  8'd118;
			butterfly_add_6 =  8'd117;
			butterfly_add_7 =  8'd119;
			end
		   else	if (count==47) begin
			butterfly_add_0 =  8'd120;
			butterfly_add_1 =  8'd122;
			butterfly_add_2 =  8'd121;
			butterfly_add_3 =  8'd123;
			butterfly_add_4 =  8'd124;
			butterfly_add_5 =  8'd126;
			butterfly_add_6 =  8'd125;
			butterfly_add_7 =  8'd127;
			end
		   else	if (count==48) begin
			butterfly_add_0 =  8'd128;
			butterfly_add_1 =  8'd130;
			butterfly_add_2 =  8'd129;
			butterfly_add_3 =  8'd131;
			butterfly_add_4 =  8'd132;
			butterfly_add_5 =  8'd134;
			butterfly_add_6 =  8'd133;
			butterfly_add_7 =  8'd135;
			end
		   else	if (count==49) begin
			butterfly_add_0 =  8'd136;
			butterfly_add_1 =  8'd138;
			butterfly_add_2 =  8'd137;
			butterfly_add_3 =  8'd139;
			butterfly_add_4 =  8'd140;
			butterfly_add_5 =  8'd142;
			butterfly_add_6 =  8'd141;
			butterfly_add_7 =  8'd143;
			end
		   else	if (count==50) begin
			butterfly_add_0 =  8'd144;
			butterfly_add_1 =  8'd146;
			butterfly_add_2 =  8'd145;
			butterfly_add_3 =  8'd147;
			butterfly_add_4 =  8'd148;
			butterfly_add_5 =  8'd150;
			butterfly_add_6 =  8'd149;
			butterfly_add_7 =  8'd151;
			end
		   else	if (count==51) begin
			butterfly_add_0 =  8'd152;
			butterfly_add_1 =  8'd154;
			butterfly_add_2 =  8'd153;
			butterfly_add_3 =  8'd155;
			butterfly_add_4 =  8'd156;
			butterfly_add_5 =  8'd158;
			butterfly_add_6 =  8'd157;
			butterfly_add_7 =  8'd159;
			end
		   else	if (count==52) begin
			butterfly_add_0 =  8'd160;
			butterfly_add_1 =  8'd162;
			butterfly_add_2 =  8'd161;
			butterfly_add_3 =  8'd163;
			butterfly_add_4 =  8'd164;
			butterfly_add_5 =  8'd166;
			butterfly_add_6 =  8'd165;
			butterfly_add_7 =  8'd167;
			end
		   else	if (count==53) begin
			butterfly_add_0 =  8'd168;
			butterfly_add_1 =  8'd170;
			butterfly_add_2 =  8'd169;
			butterfly_add_3 =  8'd171;
			butterfly_add_4 =  8'd172;
			butterfly_add_5 =  8'd174;
			butterfly_add_6 =  8'd173;
			butterfly_add_7 =  8'd175;
			end
		   else	if (count==54) begin
			butterfly_add_0 =  8'd176;
			butterfly_add_1 =  8'd178;
			butterfly_add_2 =  8'd177;
			butterfly_add_3 =  8'd179;
			butterfly_add_4 =  8'd180;
			butterfly_add_5 =  8'd182;
			butterfly_add_6 =  8'd181;
			butterfly_add_7 =  8'd183;
			end
		   else	if (count==55) begin
			butterfly_add_0 =  8'd184;
			butterfly_add_1 =  8'd186;
			butterfly_add_2 =  8'd185;
			butterfly_add_3 =  8'd187;
			butterfly_add_4 =  8'd188;
			butterfly_add_5 =  8'd190;
			butterfly_add_6 =  8'd189;
			butterfly_add_7 =  8'd191;
			end
		   else	if (count==56) begin
			butterfly_add_0 =  8'd192;
			butterfly_add_1 =  8'd194;
			butterfly_add_2 =  8'd193;
			butterfly_add_3 =  8'd195;
			butterfly_add_4 =  8'd196;
			butterfly_add_5 =  8'd198;
			butterfly_add_6 =  8'd197;
			butterfly_add_7 =  8'd199;
			end
		   else	if (count==57) begin
			butterfly_add_0 =  8'd200;
			butterfly_add_1 =  8'd202;
			butterfly_add_2 =  8'd201;
			butterfly_add_3 =  8'd203;
			butterfly_add_4 =  8'd204;
			butterfly_add_5 =  8'd206;
			butterfly_add_6 =  8'd205;
			butterfly_add_7 =  8'd207;
			end
		   else	if (count==58) begin
			butterfly_add_0 =  8'd208;
			butterfly_add_1 =  8'd210;
			butterfly_add_2 =  8'd209;
			butterfly_add_3 =  8'd211;
			butterfly_add_4 =  8'd212;
			butterfly_add_5 =  8'd214;
			butterfly_add_6 =  8'd213;
			butterfly_add_7 =  8'd215;
			end
		   else	if (count==59) begin
			butterfly_add_0 =  8'd216;
			butterfly_add_1 =  8'd218;
			butterfly_add_2 =  8'd217;
			butterfly_add_3 =  8'd219;
			butterfly_add_4 =  8'd220;
			butterfly_add_5 =  8'd222;
			butterfly_add_6 =  8'd221;
			butterfly_add_7 =  8'd223;
			end
		   else	if (count==60) begin
			butterfly_add_0 =  8'd224;
			butterfly_add_1 =  8'd226;
			butterfly_add_2 =  8'd225;
			butterfly_add_3 =  8'd227;
			butterfly_add_4 =  8'd228;
			butterfly_add_5 =  8'd230;
			butterfly_add_6 =  8'd229;
			butterfly_add_7 =  8'd231;
			end
		   else	if (count==61) begin
			butterfly_add_0 =  8'd232;
			butterfly_add_1 =  8'd234;
			butterfly_add_2 =  8'd233;
			butterfly_add_3 =  8'd235;
			butterfly_add_4 =  8'd236;
			butterfly_add_5 =  8'd238;
			butterfly_add_6 =  8'd237;
			butterfly_add_7 =  8'd239;
			end
		   else	if (count==62) begin
			butterfly_add_0 =  8'd240;
			butterfly_add_1 =  8'd242;
			butterfly_add_2 =  8'd241;
			butterfly_add_3 =  8'd243;
			butterfly_add_4 =  8'd244;
			butterfly_add_5 =  8'd246;
			butterfly_add_6 =  8'd245;
			butterfly_add_7 =  8'd247;
			end
		   else	if (count==63) begin
			butterfly_add_0 =  8'd248;
			butterfly_add_1 =  8'd250;
			butterfly_add_2 =  8'd249;
			butterfly_add_3 =  8'd251;
			butterfly_add_4 =  8'd252;
			butterfly_add_5 =  8'd254;
			butterfly_add_6 =  8'd253;
			butterfly_add_7 =  8'd255;
			end
		   else	if (count==64) begin
			butterfly_add_0 =  8'd0;
			butterfly_add_1 =  8'd4;
			butterfly_add_2 =  8'd1;
			butterfly_add_3 =  8'd5;
			butterfly_add_4 =  8'd2;
			butterfly_add_5 =  8'd6;
			butterfly_add_6 =  8'd3;
			butterfly_add_7 =  8'd7;
			end
		   else	if (count==65) begin
			butterfly_add_0 =  8'd8;
			butterfly_add_1 =  8'd12;
			butterfly_add_2 =  8'd9;
			butterfly_add_3 =  8'd13;
			butterfly_add_4 =  8'd10;
			butterfly_add_5 =  8'd14;
			butterfly_add_6 =  8'd11;
			butterfly_add_7 =  8'd15;
			end
		   else	if (count==66) begin
			butterfly_add_0 =  8'd16;
			butterfly_add_1 =  8'd20;
			butterfly_add_2 =  8'd17;
			butterfly_add_3 =  8'd21;
			butterfly_add_4 =  8'd18;
			butterfly_add_5 =  8'd22;
			butterfly_add_6 =  8'd19;
			butterfly_add_7 =  8'd23;
			end
		   else	if (count==67) begin
			butterfly_add_0 =  8'd24;
			butterfly_add_1 =  8'd28;
			butterfly_add_2 =  8'd25;
			butterfly_add_3 =  8'd29;
			butterfly_add_4 =  8'd26;
			butterfly_add_5 =  8'd30;
			butterfly_add_6 =  8'd27;
			butterfly_add_7 =  8'd31;
			end
		   else	if (count==68) begin
			butterfly_add_0 =  8'd32;
			butterfly_add_1 =  8'd36;
			butterfly_add_2 =  8'd33;
			butterfly_add_3 =  8'd37;
			butterfly_add_4 =  8'd34;
			butterfly_add_5 =  8'd38;
			butterfly_add_6 =  8'd35;
			butterfly_add_7 =  8'd39;
			end
		   else	if (count==69) begin
			butterfly_add_0 =  8'd40;
			butterfly_add_1 =  8'd44;
			butterfly_add_2 =  8'd41;
			butterfly_add_3 =  8'd45;
			butterfly_add_4 =  8'd42;
			butterfly_add_5 =  8'd46;
			butterfly_add_6 =  8'd43;
			butterfly_add_7 =  8'd47;
			end
		   else	if (count==70) begin
			butterfly_add_0 =  8'd48;
			butterfly_add_1 =  8'd52;
			butterfly_add_2 =  8'd49;
			butterfly_add_3 =  8'd53;
			butterfly_add_4 =  8'd50;
			butterfly_add_5 =  8'd54;
			butterfly_add_6 =  8'd51;
			butterfly_add_7 =  8'd55;
			end
		   else	if (count==71) begin
			butterfly_add_0 =  8'd56;
			butterfly_add_1 =  8'd60;
			butterfly_add_2 =  8'd57;
			butterfly_add_3 =  8'd61;
			butterfly_add_4 =  8'd58;
			butterfly_add_5 =  8'd62;
			butterfly_add_6 =  8'd59;
			butterfly_add_7 =  8'd63;
			end
		   else	if (count==72) begin
			butterfly_add_0 =  8'd64;
			butterfly_add_1 =  8'd68;
			butterfly_add_2 =  8'd65;
			butterfly_add_3 =  8'd69;
			butterfly_add_4 =  8'd66;
			butterfly_add_5 =  8'd70;
			butterfly_add_6 =  8'd67;
			butterfly_add_7 =  8'd71;
			end
		   else	if (count==73) begin
			butterfly_add_0 =  8'd72;
			butterfly_add_1 =  8'd76;
			butterfly_add_2 =  8'd73;
			butterfly_add_3 =  8'd77;
			butterfly_add_4 =  8'd74;
			butterfly_add_5 =  8'd78;
			butterfly_add_6 =  8'd75;
			butterfly_add_7 =  8'd79;
			end
		   else	if (count==74) begin
			butterfly_add_0 =  8'd80;
			butterfly_add_1 =  8'd84;
			butterfly_add_2 =  8'd81;
			butterfly_add_3 =  8'd85;
			butterfly_add_4 =  8'd82;
			butterfly_add_5 =  8'd86;
			butterfly_add_6 =  8'd83;
			butterfly_add_7 =  8'd87;
			end
		   else	if (count==75) begin
			butterfly_add_0 =  8'd88;
			butterfly_add_1 =  8'd92;
			butterfly_add_2 =  8'd89;
			butterfly_add_3 =  8'd93;
			butterfly_add_4 =  8'd90;
			butterfly_add_5 =  8'd94;
			butterfly_add_6 =  8'd91;
			butterfly_add_7 =  8'd95;
			end
		   else	if (count==76) begin
			butterfly_add_0 =  8'd96;
			butterfly_add_1 =  8'd100;
			butterfly_add_2 =  8'd97;
			butterfly_add_3 =  8'd101;
			butterfly_add_4 =  8'd98;
			butterfly_add_5 =  8'd102;
			butterfly_add_6 =  8'd99;
			butterfly_add_7 =  8'd103;
			end
		   else	if (count==77) begin
			butterfly_add_0 =  8'd104;
			butterfly_add_1 =  8'd108;
			butterfly_add_2 =  8'd105;
			butterfly_add_3 =  8'd109;
			butterfly_add_4 =  8'd106;
			butterfly_add_5 =  8'd110;
			butterfly_add_6 =  8'd107;
			butterfly_add_7 =  8'd111;
			end
		   else	if (count==78) begin
			butterfly_add_0 =  8'd112;
			butterfly_add_1 =  8'd116;
			butterfly_add_2 =  8'd113;
			butterfly_add_3 =  8'd117;
			butterfly_add_4 =  8'd114;
			butterfly_add_5 =  8'd118;
			butterfly_add_6 =  8'd115;
			butterfly_add_7 =  8'd119;
			end
		   else	if (count==79) begin
			butterfly_add_0 =  8'd120;
			butterfly_add_1 =  8'd124;
			butterfly_add_2 =  8'd121;
			butterfly_add_3 =  8'd125;
			butterfly_add_4 =  8'd122;
			butterfly_add_5 =  8'd126;
			butterfly_add_6 =  8'd123;
			butterfly_add_7 =  8'd127;
			end
		   else	if (count==80) begin
			butterfly_add_0 =  8'd128;
			butterfly_add_1 =  8'd132;
			butterfly_add_2 =  8'd129;
			butterfly_add_3 =  8'd133;
			butterfly_add_4 =  8'd130;
			butterfly_add_5 =  8'd134;
			butterfly_add_6 =  8'd131;
			butterfly_add_7 =  8'd135;
			end
		   else	if (count==81) begin
			butterfly_add_0 =  8'd136;
			butterfly_add_1 =  8'd140;
			butterfly_add_2 =  8'd137;
			butterfly_add_3 =  8'd141;
			butterfly_add_4 =  8'd138;
			butterfly_add_5 =  8'd142;
			butterfly_add_6 =  8'd139;
			butterfly_add_7 =  8'd143;
			end
		   else	if (count==82) begin
			butterfly_add_0 =  8'd144;
			butterfly_add_1 =  8'd148;
			butterfly_add_2 =  8'd145;
			butterfly_add_3 =  8'd149;
			butterfly_add_4 =  8'd146;
			butterfly_add_5 =  8'd150;
			butterfly_add_6 =  8'd147;
			butterfly_add_7 =  8'd151;
			end
		   else	if (count==83) begin
			butterfly_add_0 =  8'd152;
			butterfly_add_1 =  8'd156;
			butterfly_add_2 =  8'd153;
			butterfly_add_3 =  8'd157;
			butterfly_add_4 =  8'd154;
			butterfly_add_5 =  8'd158;
			butterfly_add_6 =  8'd155;
			butterfly_add_7 =  8'd159;
			end
		   else	if (count==84) begin
			butterfly_add_0 =  8'd160;
			butterfly_add_1 =  8'd164;
			butterfly_add_2 =  8'd161;
			butterfly_add_3 =  8'd165;
			butterfly_add_4 =  8'd162;
			butterfly_add_5 =  8'd166;
			butterfly_add_6 =  8'd163;
			butterfly_add_7 =  8'd167;
			end
		   else	if (count==85) begin
			butterfly_add_0 =  8'd168;
			butterfly_add_1 =  8'd172;
			butterfly_add_2 =  8'd169;
			butterfly_add_3 =  8'd173;
			butterfly_add_4 =  8'd170;
			butterfly_add_5 =  8'd174;
			butterfly_add_6 =  8'd171;
			butterfly_add_7 =  8'd175;
			end
		   else	if (count==86) begin
			butterfly_add_0 =  8'd176;
			butterfly_add_1 =  8'd180;
			butterfly_add_2 =  8'd177;
			butterfly_add_3 =  8'd181;
			butterfly_add_4 =  8'd178;
			butterfly_add_5 =  8'd182;
			butterfly_add_6 =  8'd179;
			butterfly_add_7 =  8'd183;
			end
		   else	if (count==87) begin
			butterfly_add_0 =  8'd184;
			butterfly_add_1 =  8'd188;
			butterfly_add_2 =  8'd185;
			butterfly_add_3 =  8'd189;
			butterfly_add_4 =  8'd186;
			butterfly_add_5 =  8'd190;
			butterfly_add_6 =  8'd187;
			butterfly_add_7 =  8'd191;
			end
		   else	if (count==88) begin
			butterfly_add_0 =  8'd192;
			butterfly_add_1 =  8'd196;
			butterfly_add_2 =  8'd193;
			butterfly_add_3 =  8'd197;
			butterfly_add_4 =  8'd194;
			butterfly_add_5 =  8'd198;
			butterfly_add_6 =  8'd195;
			butterfly_add_7 =  8'd199;
			end
		   else	if (count==89) begin
			butterfly_add_0 =  8'd200;
			butterfly_add_1 =  8'd204;
			butterfly_add_2 =  8'd201;
			butterfly_add_3 =  8'd205;
			butterfly_add_4 =  8'd202;
			butterfly_add_5 =  8'd206;
			butterfly_add_6 =  8'd203;
			butterfly_add_7 =  8'd207;
			end
		   else	if (count==90) begin
			butterfly_add_0 =  8'd208;
			butterfly_add_1 =  8'd212;
			butterfly_add_2 =  8'd209;
			butterfly_add_3 =  8'd213;
			butterfly_add_4 =  8'd210;
			butterfly_add_5 =  8'd214;
			butterfly_add_6 =  8'd211;
			butterfly_add_7 =  8'd215;
			end
		   else	if (count==91) begin
			butterfly_add_0 =  8'd216;
			butterfly_add_1 =  8'd220;
			butterfly_add_2 =  8'd217;
			butterfly_add_3 =  8'd221;
			butterfly_add_4 =  8'd218;
			butterfly_add_5 =  8'd222;
			butterfly_add_6 =  8'd219;
			butterfly_add_7 =  8'd223;
			end
		   else	if (count==92) begin
			butterfly_add_0 =  8'd224;
			butterfly_add_1 =  8'd228;
			butterfly_add_2 =  8'd225;
			butterfly_add_3 =  8'd229;
			butterfly_add_4 =  8'd226;
			butterfly_add_5 =  8'd230;
			butterfly_add_6 =  8'd227;
			butterfly_add_7 =  8'd231;
			end
		   else	if (count==93) begin
			butterfly_add_0 =  8'd232;
			butterfly_add_1 =  8'd236;
			butterfly_add_2 =  8'd233;
			butterfly_add_3 =  8'd237;
			butterfly_add_4 =  8'd234;
			butterfly_add_5 =  8'd238;
			butterfly_add_6 =  8'd235;
			butterfly_add_7 =  8'd239;
			end
		   else	if (count==94) begin
			butterfly_add_0 =  8'd240;
			butterfly_add_1 =  8'd244;
			butterfly_add_2 =  8'd241;
			butterfly_add_3 =  8'd245;
			butterfly_add_4 =  8'd242;
			butterfly_add_5 =  8'd246;
			butterfly_add_6 =  8'd243;
			butterfly_add_7 =  8'd247;
			end
		   else	if (count==95) begin
			butterfly_add_0 =  8'd248;
			butterfly_add_1 =  8'd252;
			butterfly_add_2 =  8'd249;
			butterfly_add_3 =  8'd253;
			butterfly_add_4 =  8'd250;
			butterfly_add_5 =  8'd254;
			butterfly_add_6 =  8'd251;
			butterfly_add_7 =  8'd255;
			end
		   else	if (count==96) begin
			butterfly_add_0 =  8'd0;
			butterfly_add_1 =  8'd8;
			butterfly_add_2 =  8'd1;
			butterfly_add_3 =  8'd9;
			butterfly_add_4 =  8'd2;
			butterfly_add_5 =  8'd10;
			butterfly_add_6 =  8'd3;
			butterfly_add_7 =  8'd11;
			end
		   else	if (count==97) begin
			butterfly_add_0 =  8'd4;
			butterfly_add_1 =  8'd12;
			butterfly_add_2 =  8'd5;
			butterfly_add_3 =  8'd13;
			butterfly_add_4 =  8'd6;
			butterfly_add_5 =  8'd14;
			butterfly_add_6 =  8'd7;
			butterfly_add_7 =  8'd15;
			end
		   else	if (count==98) begin
			butterfly_add_0 =  8'd16;
			butterfly_add_1 =  8'd24;
			butterfly_add_2 =  8'd17;
			butterfly_add_3 =  8'd25;
			butterfly_add_4 =  8'd18;
			butterfly_add_5 =  8'd26;
			butterfly_add_6 =  8'd19;
			butterfly_add_7 =  8'd27;
			end
		   else	if (count==99) begin
			butterfly_add_0 =  8'd20;
			butterfly_add_1 =  8'd28;
			butterfly_add_2 =  8'd21;
			butterfly_add_3 =  8'd29;
			butterfly_add_4 =  8'd22;
			butterfly_add_5 =  8'd30;
			butterfly_add_6 =  8'd23;
			butterfly_add_7 =  8'd31;
			end
		   else	if (count==100) begin
			butterfly_add_0 =  8'd32;
			butterfly_add_1 =  8'd40;
			butterfly_add_2 =  8'd33;
			butterfly_add_3 =  8'd41;
			butterfly_add_4 =  8'd34;
			butterfly_add_5 =  8'd42;
			butterfly_add_6 =  8'd35;
			butterfly_add_7 =  8'd43;
			end
		   else	if (count==101) begin
			butterfly_add_0 =  8'd36;
			butterfly_add_1 =  8'd44;
			butterfly_add_2 =  8'd37;
			butterfly_add_3 =  8'd45;
			butterfly_add_4 =  8'd38;
			butterfly_add_5 =  8'd46;
			butterfly_add_6 =  8'd39;
			butterfly_add_7 =  8'd47;
			end
		   else	if (count==102) begin
			butterfly_add_0 =  8'd48;
			butterfly_add_1 =  8'd56;
			butterfly_add_2 =  8'd49;
			butterfly_add_3 =  8'd57;
			butterfly_add_4 =  8'd50;
			butterfly_add_5 =  8'd58;
			butterfly_add_6 =  8'd51;
			butterfly_add_7 =  8'd59;
			end
		   else	if (count==103) begin
			butterfly_add_0 =  8'd52;
			butterfly_add_1 =  8'd60;
			butterfly_add_2 =  8'd53;
			butterfly_add_3 =  8'd61;
			butterfly_add_4 =  8'd54;
			butterfly_add_5 =  8'd62;
			butterfly_add_6 =  8'd55;
			butterfly_add_7 =  8'd63;
			end
		   else	if (count==104) begin
			butterfly_add_0 =  8'd64;
			butterfly_add_1 =  8'd72;
			butterfly_add_2 =  8'd65;
			butterfly_add_3 =  8'd73;
			butterfly_add_4 =  8'd66;
			butterfly_add_5 =  8'd74;
			butterfly_add_6 =  8'd67;
			butterfly_add_7 =  8'd75;
			end
		   else	if (count==105) begin
			butterfly_add_0 =  8'd68;
			butterfly_add_1 =  8'd76;
			butterfly_add_2 =  8'd69;
			butterfly_add_3 =  8'd77;
			butterfly_add_4 =  8'd70;
			butterfly_add_5 =  8'd78;
			butterfly_add_6 =  8'd71;
			butterfly_add_7 =  8'd79;
			end
		   else	if (count==106) begin
			butterfly_add_0 =  8'd80;
			butterfly_add_1 =  8'd88;
			butterfly_add_2 =  8'd81;
			butterfly_add_3 =  8'd89;
			butterfly_add_4 =  8'd82;
			butterfly_add_5 =  8'd90;
			butterfly_add_6 =  8'd83;
			butterfly_add_7 =  8'd91;
			end
		   else	if (count==107) begin
			butterfly_add_0 =  8'd84;
			butterfly_add_1 =  8'd92;
			butterfly_add_2 =  8'd85;
			butterfly_add_3 =  8'd93;
			butterfly_add_4 =  8'd86;
			butterfly_add_5 =  8'd94;
			butterfly_add_6 =  8'd87;
			butterfly_add_7 =  8'd95;
			end
		   else	if (count==108) begin
			butterfly_add_0 =  8'd96;
			butterfly_add_1 =  8'd104;
			butterfly_add_2 =  8'd97;
			butterfly_add_3 =  8'd105;
			butterfly_add_4 =  8'd98;
			butterfly_add_5 =  8'd106;
			butterfly_add_6 =  8'd99;
			butterfly_add_7 =  8'd107;
			end
		   else	if (count==109) begin
			butterfly_add_0 =  8'd100;
			butterfly_add_1 =  8'd108;
			butterfly_add_2 =  8'd101;
			butterfly_add_3 =  8'd109;
			butterfly_add_4 =  8'd102;
			butterfly_add_5 =  8'd110;
			butterfly_add_6 =  8'd103;
			butterfly_add_7 =  8'd111;
			end
		   else	if (count==110) begin
			butterfly_add_0 =  8'd112;
			butterfly_add_1 =  8'd120;
			butterfly_add_2 =  8'd113;
			butterfly_add_3 =  8'd121;
			butterfly_add_4 =  8'd114;
			butterfly_add_5 =  8'd122;
			butterfly_add_6 =  8'd115;
			butterfly_add_7 =  8'd123;
			end
		   else	if (count==111) begin
			butterfly_add_0 =  8'd116;
			butterfly_add_1 =  8'd124;
			butterfly_add_2 =  8'd117;
			butterfly_add_3 =  8'd125;
			butterfly_add_4 =  8'd118;
			butterfly_add_5 =  8'd126;
			butterfly_add_6 =  8'd119;
			butterfly_add_7 =  8'd127;
			end
		   else	if (count==112) begin
			butterfly_add_0 =  8'd128;
			butterfly_add_1 =  8'd136;
			butterfly_add_2 =  8'd129;
			butterfly_add_3 =  8'd137;
			butterfly_add_4 =  8'd130;
			butterfly_add_5 =  8'd138;
			butterfly_add_6 =  8'd131;
			butterfly_add_7 =  8'd139;
			end
		   else	if (count==113) begin
			butterfly_add_0 =  8'd132;
			butterfly_add_1 =  8'd140;
			butterfly_add_2 =  8'd133;
			butterfly_add_3 =  8'd141;
			butterfly_add_4 =  8'd134;
			butterfly_add_5 =  8'd142;
			butterfly_add_6 =  8'd135;
			butterfly_add_7 =  8'd143;
			end
		   else	if (count==114) begin
			butterfly_add_0 =  8'd144;
			butterfly_add_1 =  8'd152;
			butterfly_add_2 =  8'd145;
			butterfly_add_3 =  8'd153;
			butterfly_add_4 =  8'd146;
			butterfly_add_5 =  8'd154;
			butterfly_add_6 =  8'd147;
			butterfly_add_7 =  8'd155;
			end
		   else	if (count==115) begin
			butterfly_add_0 =  8'd148;
			butterfly_add_1 =  8'd156;
			butterfly_add_2 =  8'd149;
			butterfly_add_3 =  8'd157;
			butterfly_add_4 =  8'd150;
			butterfly_add_5 =  8'd158;
			butterfly_add_6 =  8'd151;
			butterfly_add_7 =  8'd159;
			end
		   else	if (count==116) begin
			butterfly_add_0 =  8'd160;
			butterfly_add_1 =  8'd168;
			butterfly_add_2 =  8'd161;
			butterfly_add_3 =  8'd169;
			butterfly_add_4 =  8'd162;
			butterfly_add_5 =  8'd170;
			butterfly_add_6 =  8'd163;
			butterfly_add_7 =  8'd171;
			end
		   else	if (count==117) begin
			butterfly_add_0 =  8'd164;
			butterfly_add_1 =  8'd172;
			butterfly_add_2 =  8'd165;
			butterfly_add_3 =  8'd173;
			butterfly_add_4 =  8'd166;
			butterfly_add_5 =  8'd174;
			butterfly_add_6 =  8'd167;
			butterfly_add_7 =  8'd175;
			end
		   else	if (count==118) begin
			butterfly_add_0 =  8'd176;
			butterfly_add_1 =  8'd184;
			butterfly_add_2 =  8'd177;
			butterfly_add_3 =  8'd185;
			butterfly_add_4 =  8'd178;
			butterfly_add_5 =  8'd186;
			butterfly_add_6 =  8'd179;
			butterfly_add_7 =  8'd187;
			end
		   else	if (count==119) begin
			butterfly_add_0 =  8'd180;
			butterfly_add_1 =  8'd188;
			butterfly_add_2 =  8'd181;
			butterfly_add_3 =  8'd189;
			butterfly_add_4 =  8'd182;
			butterfly_add_5 =  8'd190;
			butterfly_add_6 =  8'd183;
			butterfly_add_7 =  8'd191;
			end
		   else	if (count==120) begin
			butterfly_add_0 =  8'd192;
			butterfly_add_1 =  8'd200;
			butterfly_add_2 =  8'd193;
			butterfly_add_3 =  8'd201;
			butterfly_add_4 =  8'd194;
			butterfly_add_5 =  8'd202;
			butterfly_add_6 =  8'd195;
			butterfly_add_7 =  8'd203;
			end
		   else	if (count==121) begin
			butterfly_add_0 =  8'd196;
			butterfly_add_1 =  8'd204;
			butterfly_add_2 =  8'd197;
			butterfly_add_3 =  8'd205;
			butterfly_add_4 =  8'd198;
			butterfly_add_5 =  8'd206;
			butterfly_add_6 =  8'd199;
			butterfly_add_7 =  8'd207;
			end
		   else	if (count==122) begin
			butterfly_add_0 =  8'd208;
			butterfly_add_1 =  8'd216;
			butterfly_add_2 =  8'd209;
			butterfly_add_3 =  8'd217;
			butterfly_add_4 =  8'd210;
			butterfly_add_5 =  8'd218;
			butterfly_add_6 =  8'd211;
			butterfly_add_7 =  8'd219;
			end
		   else	if (count==123) begin
			butterfly_add_0 =  8'd212;
			butterfly_add_1 =  8'd220;
			butterfly_add_2 =  8'd213;
			butterfly_add_3 =  8'd221;
			butterfly_add_4 =  8'd214;
			butterfly_add_5 =  8'd222;
			butterfly_add_6 =  8'd215;
			butterfly_add_7 =  8'd223;
			end
		   else	if (count==124) begin
			butterfly_add_0 =  8'd224;
			butterfly_add_1 =  8'd232;
			butterfly_add_2 =  8'd225;
			butterfly_add_3 =  8'd233;
			butterfly_add_4 =  8'd226;
			butterfly_add_5 =  8'd234;
			butterfly_add_6 =  8'd227;
			butterfly_add_7 =  8'd235;
			end
		   else	if (count==125) begin
			butterfly_add_0 =  8'd228;
			butterfly_add_1 =  8'd236;
			butterfly_add_2 =  8'd229;
			butterfly_add_3 =  8'd237;
			butterfly_add_4 =  8'd230;
			butterfly_add_5 =  8'd238;
			butterfly_add_6 =  8'd231;
			butterfly_add_7 =  8'd239;
			end
		   else	if (count==126) begin
			butterfly_add_0 =  8'd240;
			butterfly_add_1 =  8'd248;
			butterfly_add_2 =  8'd241;
			butterfly_add_3 =  8'd249;
			butterfly_add_4 =  8'd242;
			butterfly_add_5 =  8'd250;
			butterfly_add_6 =  8'd243;
			butterfly_add_7 =  8'd251;
			end
		   else	if (count==127) begin
			butterfly_add_0 =  8'd244;
			butterfly_add_1 =  8'd252;
			butterfly_add_2 =  8'd245;
			butterfly_add_3 =  8'd253;
			butterfly_add_4 =  8'd246;
			butterfly_add_5 =  8'd254;
			butterfly_add_6 =  8'd247;
			butterfly_add_7 =  8'd255;
			end
		   else	if (count==128) begin
			butterfly_add_0 =  8'd0;
			butterfly_add_1 =  8'd16;
			butterfly_add_2 =  8'd1;
			butterfly_add_3 =  8'd17;
			butterfly_add_4 =  8'd2;
			butterfly_add_5 =  8'd18;
			butterfly_add_6 =  8'd3;
			butterfly_add_7 =  8'd19;
			end
		   else	if (count==129) begin
			butterfly_add_0 =  8'd4;
			butterfly_add_1 =  8'd20;
			butterfly_add_2 =  8'd5;
			butterfly_add_3 =  8'd21;
			butterfly_add_4 =  8'd6;
			butterfly_add_5 =  8'd22;
			butterfly_add_6 =  8'd7;
			butterfly_add_7 =  8'd23;
			end
		   else	if (count==130) begin
			butterfly_add_0 =  8'd8;
			butterfly_add_1 =  8'd24;
			butterfly_add_2 =  8'd9;
			butterfly_add_3 =  8'd25;
			butterfly_add_4 =  8'd10;
			butterfly_add_5 =  8'd26;
			butterfly_add_6 =  8'd11;
			butterfly_add_7 =  8'd27;
			end
		   else	if (count==131) begin
			butterfly_add_0 =  8'd12;
			butterfly_add_1 =  8'd28;
			butterfly_add_2 =  8'd13;
			butterfly_add_3 =  8'd29;
			butterfly_add_4 =  8'd14;
			butterfly_add_5 =  8'd30;
			butterfly_add_6 =  8'd15;
			butterfly_add_7 =  8'd31;
			end
		   else	if (count==132) begin
			butterfly_add_0 =  8'd32;
			butterfly_add_1 =  8'd48;
			butterfly_add_2 =  8'd33;
			butterfly_add_3 =  8'd49;
			butterfly_add_4 =  8'd34;
			butterfly_add_5 =  8'd50;
			butterfly_add_6 =  8'd35;
			butterfly_add_7 =  8'd51;
			end
		   else	if (count==133) begin
			butterfly_add_0 =  8'd36;
			butterfly_add_1 =  8'd52;
			butterfly_add_2 =  8'd37;
			butterfly_add_3 =  8'd53;
			butterfly_add_4 =  8'd38;
			butterfly_add_5 =  8'd54;
			butterfly_add_6 =  8'd39;
			butterfly_add_7 =  8'd55;
			end
		   else	if (count==134) begin
			butterfly_add_0 =  8'd40;
			butterfly_add_1 =  8'd56;
			butterfly_add_2 =  8'd41;
			butterfly_add_3 =  8'd57;
			butterfly_add_4 =  8'd42;
			butterfly_add_5 =  8'd58;
			butterfly_add_6 =  8'd43;
			butterfly_add_7 =  8'd59;
			end
		   else	if (count==135) begin
			butterfly_add_0 =  8'd44;
			butterfly_add_1 =  8'd60;
			butterfly_add_2 =  8'd45;
			butterfly_add_3 =  8'd61;
			butterfly_add_4 =  8'd46;
			butterfly_add_5 =  8'd62;
			butterfly_add_6 =  8'd47;
			butterfly_add_7 =  8'd63;
			end
		   else	if (count==136) begin
			butterfly_add_0 =  8'd64;
			butterfly_add_1 =  8'd80;
			butterfly_add_2 =  8'd65;
			butterfly_add_3 =  8'd81;
			butterfly_add_4 =  8'd66;
			butterfly_add_5 =  8'd82;
			butterfly_add_6 =  8'd67;
			butterfly_add_7 =  8'd83;
			end
		   else	if (count==137) begin
			butterfly_add_0 =  8'd68;
			butterfly_add_1 =  8'd84;
			butterfly_add_2 =  8'd69;
			butterfly_add_3 =  8'd85;
			butterfly_add_4 =  8'd70;
			butterfly_add_5 =  8'd86;
			butterfly_add_6 =  8'd71;
			butterfly_add_7 =  8'd87;
			end
		   else	if (count==138) begin
			butterfly_add_0 =  8'd72;
			butterfly_add_1 =  8'd88;
			butterfly_add_2 =  8'd73;
			butterfly_add_3 =  8'd89;
			butterfly_add_4 =  8'd74;
			butterfly_add_5 =  8'd90;
			butterfly_add_6 =  8'd75;
			butterfly_add_7 =  8'd91;
			end
		   else	if (count==139) begin
			butterfly_add_0 =  8'd76;
			butterfly_add_1 =  8'd92;
			butterfly_add_2 =  8'd77;
			butterfly_add_3 =  8'd93;
			butterfly_add_4 =  8'd78;
			butterfly_add_5 =  8'd94;
			butterfly_add_6 =  8'd79;
			butterfly_add_7 =  8'd95;
			end
		   else	if (count==140) begin
			butterfly_add_0 =  8'd96;
			butterfly_add_1 =  8'd112;
			butterfly_add_2 =  8'd97;
			butterfly_add_3 =  8'd113;
			butterfly_add_4 =  8'd98;
			butterfly_add_5 =  8'd114;
			butterfly_add_6 =  8'd99;
			butterfly_add_7 =  8'd115;
			end
		   else	if (count==141) begin
			butterfly_add_0 =  8'd100;
			butterfly_add_1 =  8'd116;
			butterfly_add_2 =  8'd101;
			butterfly_add_3 =  8'd117;
			butterfly_add_4 =  8'd102;
			butterfly_add_5 =  8'd118;
			butterfly_add_6 =  8'd103;
			butterfly_add_7 =  8'd119;
			end
		   else	if (count==142) begin
			butterfly_add_0 =  8'd104;
			butterfly_add_1 =  8'd120;
			butterfly_add_2 =  8'd105;
			butterfly_add_3 =  8'd121;
			butterfly_add_4 =  8'd106;
			butterfly_add_5 =  8'd122;
			butterfly_add_6 =  8'd107;
			butterfly_add_7 =  8'd123;
			end
		   else	if (count==143) begin
			butterfly_add_0 =  8'd108;
			butterfly_add_1 =  8'd124;
			butterfly_add_2 =  8'd109;
			butterfly_add_3 =  8'd125;
			butterfly_add_4 =  8'd110;
			butterfly_add_5 =  8'd126;
			butterfly_add_6 =  8'd111;
			butterfly_add_7 =  8'd127;
			end
		   else	if (count==144) begin
			butterfly_add_0 =  8'd128;
			butterfly_add_1 =  8'd144;
			butterfly_add_2 =  8'd129;
			butterfly_add_3 =  8'd145;
			butterfly_add_4 =  8'd130;
			butterfly_add_5 =  8'd146;
			butterfly_add_6 =  8'd131;
			butterfly_add_7 =  8'd147;
			end
		   else	if (count==145) begin
			butterfly_add_0 =  8'd132;
			butterfly_add_1 =  8'd148;
			butterfly_add_2 =  8'd133;
			butterfly_add_3 =  8'd149;
			butterfly_add_4 =  8'd134;
			butterfly_add_5 =  8'd150;
			butterfly_add_6 =  8'd135;
			butterfly_add_7 =  8'd151;
			end
		   else	if (count==146) begin
			butterfly_add_0 =  8'd136;
			butterfly_add_1 =  8'd152;
			butterfly_add_2 =  8'd137;
			butterfly_add_3 =  8'd153;
			butterfly_add_4 =  8'd138;
			butterfly_add_5 =  8'd154;
			butterfly_add_6 =  8'd139;
			butterfly_add_7 =  8'd155;
			end
		   else	if (count==147) begin
			butterfly_add_0 =  8'd140;
			butterfly_add_1 =  8'd156;
			butterfly_add_2 =  8'd141;
			butterfly_add_3 =  8'd157;
			butterfly_add_4 =  8'd142;
			butterfly_add_5 =  8'd158;
			butterfly_add_6 =  8'd143;
			butterfly_add_7 =  8'd159;
			end
		   else	if (count==148) begin
			butterfly_add_0 =  8'd160;
			butterfly_add_1 =  8'd176;
			butterfly_add_2 =  8'd161;
			butterfly_add_3 =  8'd177;
			butterfly_add_4 =  8'd162;
			butterfly_add_5 =  8'd178;
			butterfly_add_6 =  8'd163;
			butterfly_add_7 =  8'd179;
			end
		   else	if (count==149) begin
			butterfly_add_0 =  8'd164;
			butterfly_add_1 =  8'd180;
			butterfly_add_2 =  8'd165;
			butterfly_add_3 =  8'd181;
			butterfly_add_4 =  8'd166;
			butterfly_add_5 =  8'd182;
			butterfly_add_6 =  8'd167;
			butterfly_add_7 =  8'd183;
			end
		   else	if (count==150) begin
			butterfly_add_0 =  8'd168;
			butterfly_add_1 =  8'd184;
			butterfly_add_2 =  8'd169;
			butterfly_add_3 =  8'd185;
			butterfly_add_4 =  8'd170;
			butterfly_add_5 =  8'd186;
			butterfly_add_6 =  8'd171;
			butterfly_add_7 =  8'd187;
			end
		   else	if (count==151) begin
			butterfly_add_0 =  8'd172;
			butterfly_add_1 =  8'd188;
			butterfly_add_2 =  8'd173;
			butterfly_add_3 =  8'd189;
			butterfly_add_4 =  8'd174;
			butterfly_add_5 =  8'd190;
			butterfly_add_6 =  8'd175;
			butterfly_add_7 =  8'd191;
			end
		   else	if (count==152) begin
			butterfly_add_0 =  8'd192;
			butterfly_add_1 =  8'd208;
			butterfly_add_2 =  8'd193;
			butterfly_add_3 =  8'd209;
			butterfly_add_4 =  8'd194;
			butterfly_add_5 =  8'd210;
			butterfly_add_6 =  8'd195;
			butterfly_add_7 =  8'd211;
			end
		   else	if (count==153) begin
			butterfly_add_0 =  8'd196;
			butterfly_add_1 =  8'd212;
			butterfly_add_2 =  8'd197;
			butterfly_add_3 =  8'd213;
			butterfly_add_4 =  8'd198;
			butterfly_add_5 =  8'd214;
			butterfly_add_6 =  8'd199;
			butterfly_add_7 =  8'd215;
			end
		   else	if (count==154) begin
			butterfly_add_0 =  8'd200;
			butterfly_add_1 =  8'd216;
			butterfly_add_2 =  8'd201;
			butterfly_add_3 =  8'd217;
			butterfly_add_4 =  8'd202;
			butterfly_add_5 =  8'd218;
			butterfly_add_6 =  8'd203;
			butterfly_add_7 =  8'd219;
			end
		   else	if (count==155) begin
			butterfly_add_0 =  8'd204;
			butterfly_add_1 =  8'd220;
			butterfly_add_2 =  8'd205;
			butterfly_add_3 =  8'd221;
			butterfly_add_4 =  8'd206;
			butterfly_add_5 =  8'd222;
			butterfly_add_6 =  8'd207;
			butterfly_add_7 =  8'd223;
			end
		   else	if (count==156) begin
			butterfly_add_0 =  8'd224;
			butterfly_add_1 =  8'd240;
			butterfly_add_2 =  8'd225;
			butterfly_add_3 =  8'd241;
			butterfly_add_4 =  8'd226;
			butterfly_add_5 =  8'd242;
			butterfly_add_6 =  8'd227;
			butterfly_add_7 =  8'd243;
			end
		   else	if (count==157) begin
			butterfly_add_0 =  8'd228;
			butterfly_add_1 =  8'd244;
			butterfly_add_2 =  8'd229;
			butterfly_add_3 =  8'd245;
			butterfly_add_4 =  8'd230;
			butterfly_add_5 =  8'd246;
			butterfly_add_6 =  8'd231;
			butterfly_add_7 =  8'd247;
			end
		   else	if (count==158) begin
			butterfly_add_0 =  8'd232;
			butterfly_add_1 =  8'd248;
			butterfly_add_2 =  8'd233;
			butterfly_add_3 =  8'd249;
			butterfly_add_4 =  8'd234;
			butterfly_add_5 =  8'd250;
			butterfly_add_6 =  8'd235;
			butterfly_add_7 =  8'd251;
			end
		   else	if (count==159) begin
			butterfly_add_0 =  8'd236;
			butterfly_add_1 =  8'd252;
			butterfly_add_2 =  8'd237;
			butterfly_add_3 =  8'd253;
			butterfly_add_4 =  8'd238;
			butterfly_add_5 =  8'd254;
			butterfly_add_6 =  8'd239;
			butterfly_add_7 =  8'd255;
			end
		   else	if (count==160) begin
			butterfly_add_0 =  8'd0;
			butterfly_add_1 =  8'd32;
			butterfly_add_2 =  8'd1;
			butterfly_add_3 =  8'd33;
			butterfly_add_4 =  8'd2;
			butterfly_add_5 =  8'd34;
			butterfly_add_6 =  8'd3;
			butterfly_add_7 =  8'd35;
			end
		   else	if (count==161) begin
			butterfly_add_0 =  8'd4;
			butterfly_add_1 =  8'd36;
			butterfly_add_2 =  8'd5;
			butterfly_add_3 =  8'd37;
			butterfly_add_4 =  8'd6;
			butterfly_add_5 =  8'd38;
			butterfly_add_6 =  8'd7;
			butterfly_add_7 =  8'd39;
			end
		   else	if (count==162) begin
			butterfly_add_0 =  8'd8;
			butterfly_add_1 =  8'd40;
			butterfly_add_2 =  8'd9;
			butterfly_add_3 =  8'd41;
			butterfly_add_4 =  8'd10;
			butterfly_add_5 =  8'd42;
			butterfly_add_6 =  8'd11;
			butterfly_add_7 =  8'd43;
			end
		   else	if (count==163) begin
			butterfly_add_0 =  8'd12;
			butterfly_add_1 =  8'd44;
			butterfly_add_2 =  8'd13;
			butterfly_add_3 =  8'd45;
			butterfly_add_4 =  8'd14;
			butterfly_add_5 =  8'd46;
			butterfly_add_6 =  8'd15;
			butterfly_add_7 =  8'd47;
			end
		   else	if (count==164) begin
			butterfly_add_0 =  8'd16;
			butterfly_add_1 =  8'd48;
			butterfly_add_2 =  8'd17;
			butterfly_add_3 =  8'd49;
			butterfly_add_4 =  8'd18;
			butterfly_add_5 =  8'd50;
			butterfly_add_6 =  8'd19;
			butterfly_add_7 =  8'd51;
			end
		   else	if (count==165) begin
			butterfly_add_0 =  8'd20;
			butterfly_add_1 =  8'd52;
			butterfly_add_2 =  8'd21;
			butterfly_add_3 =  8'd53;
			butterfly_add_4 =  8'd22;
			butterfly_add_5 =  8'd54;
			butterfly_add_6 =  8'd23;
			butterfly_add_7 =  8'd55;
			end
		   else	if (count==166) begin
			butterfly_add_0 =  8'd24;
			butterfly_add_1 =  8'd56;
			butterfly_add_2 =  8'd25;
			butterfly_add_3 =  8'd57;
			butterfly_add_4 =  8'd26;
			butterfly_add_5 =  8'd58;
			butterfly_add_6 =  8'd27;
			butterfly_add_7 =  8'd59;
			end
		   else	if (count==167) begin
			butterfly_add_0 =  8'd28;
			butterfly_add_1 =  8'd60;
			butterfly_add_2 =  8'd29;
			butterfly_add_3 =  8'd61;
			butterfly_add_4 =  8'd30;
			butterfly_add_5 =  8'd62;
			butterfly_add_6 =  8'd31;
			butterfly_add_7 =  8'd63;
			end
		   else	if (count==168) begin
			butterfly_add_0 =  8'd64;
			butterfly_add_1 =  8'd96;
			butterfly_add_2 =  8'd65;
			butterfly_add_3 =  8'd97;
			butterfly_add_4 =  8'd66;
			butterfly_add_5 =  8'd98;
			butterfly_add_6 =  8'd67;
			butterfly_add_7 =  8'd99;
			end
		   else	if (count==169) begin
			butterfly_add_0 =  8'd68;
			butterfly_add_1 =  8'd100;
			butterfly_add_2 =  8'd69;
			butterfly_add_3 =  8'd101;
			butterfly_add_4 =  8'd70;
			butterfly_add_5 =  8'd102;
			butterfly_add_6 =  8'd71;
			butterfly_add_7 =  8'd103;
			end
		   else	if (count==170) begin
			butterfly_add_0 =  8'd72;
			butterfly_add_1 =  8'd104;
			butterfly_add_2 =  8'd73;
			butterfly_add_3 =  8'd105;
			butterfly_add_4 =  8'd74;
			butterfly_add_5 =  8'd106;
			butterfly_add_6 =  8'd75;
			butterfly_add_7 =  8'd107;
			end
		   else	if (count==171) begin
			butterfly_add_0 =  8'd76;
			butterfly_add_1 =  8'd108;
			butterfly_add_2 =  8'd77;
			butterfly_add_3 =  8'd109;
			butterfly_add_4 =  8'd78;
			butterfly_add_5 =  8'd110;
			butterfly_add_6 =  8'd79;
			butterfly_add_7 =  8'd111;
			end
		   else	if (count==172) begin
			butterfly_add_0 =  8'd80;
			butterfly_add_1 =  8'd112;
			butterfly_add_2 =  8'd81;
			butterfly_add_3 =  8'd113;
			butterfly_add_4 =  8'd82;
			butterfly_add_5 =  8'd114;
			butterfly_add_6 =  8'd83;
			butterfly_add_7 =  8'd115;
			end
		   else	if (count==173) begin
			butterfly_add_0 =  8'd84;
			butterfly_add_1 =  8'd116;
			butterfly_add_2 =  8'd85;
			butterfly_add_3 =  8'd117;
			butterfly_add_4 =  8'd86;
			butterfly_add_5 =  8'd118;
			butterfly_add_6 =  8'd87;
			butterfly_add_7 =  8'd119;
			end
		   else	if (count==174) begin
			butterfly_add_0 =  8'd88;
			butterfly_add_1 =  8'd120;
			butterfly_add_2 =  8'd89;
			butterfly_add_3 =  8'd121;
			butterfly_add_4 =  8'd90;
			butterfly_add_5 =  8'd122;
			butterfly_add_6 =  8'd91;
			butterfly_add_7 =  8'd123;
			end
		   else	if (count==175) begin
			butterfly_add_0 =  8'd92;
			butterfly_add_1 =  8'd124;
			butterfly_add_2 =  8'd93;
			butterfly_add_3 =  8'd125;
			butterfly_add_4 =  8'd94;
			butterfly_add_5 =  8'd126;
			butterfly_add_6 =  8'd95;
			butterfly_add_7 =  8'd127;
			end
		   else	if (count==176) begin
			butterfly_add_0 =  8'd128;
			butterfly_add_1 =  8'd160;
			butterfly_add_2 =  8'd129;
			butterfly_add_3 =  8'd161;
			butterfly_add_4 =  8'd130;
			butterfly_add_5 =  8'd162;
			butterfly_add_6 =  8'd131;
			butterfly_add_7 =  8'd163;
			end
		   else	if (count==177) begin
			butterfly_add_0 =  8'd132;
			butterfly_add_1 =  8'd164;
			butterfly_add_2 =  8'd133;
			butterfly_add_3 =  8'd165;
			butterfly_add_4 =  8'd134;
			butterfly_add_5 =  8'd166;
			butterfly_add_6 =  8'd135;
			butterfly_add_7 =  8'd167;
			end
		   else	if (count==178) begin
			butterfly_add_0 =  8'd136;
			butterfly_add_1 =  8'd168;
			butterfly_add_2 =  8'd137;
			butterfly_add_3 =  8'd169;
			butterfly_add_4 =  8'd138;
			butterfly_add_5 =  8'd170;
			butterfly_add_6 =  8'd139;
			butterfly_add_7 =  8'd171;
			end
		   else	if (count==179) begin
			butterfly_add_0 =  8'd140;
			butterfly_add_1 =  8'd172;
			butterfly_add_2 =  8'd141;
			butterfly_add_3 =  8'd173;
			butterfly_add_4 =  8'd142;
			butterfly_add_5 =  8'd174;
			butterfly_add_6 =  8'd143;
			butterfly_add_7 =  8'd175;
			end
		   else	if (count==180) begin
			butterfly_add_0 =  8'd144;
			butterfly_add_1 =  8'd176;
			butterfly_add_2 =  8'd145;
			butterfly_add_3 =  8'd177;
			butterfly_add_4 =  8'd146;
			butterfly_add_5 =  8'd178;
			butterfly_add_6 =  8'd147;
			butterfly_add_7 =  8'd179;
			end
		   else	if (count==181) begin
			butterfly_add_0 =  8'd148;
			butterfly_add_1 =  8'd180;
			butterfly_add_2 =  8'd149;
			butterfly_add_3 =  8'd181;
			butterfly_add_4 =  8'd150;
			butterfly_add_5 =  8'd182;
			butterfly_add_6 =  8'd151;
			butterfly_add_7 =  8'd183;
			end
		   else	if (count==182) begin
			butterfly_add_0 =  8'd152;
			butterfly_add_1 =  8'd184;
			butterfly_add_2 =  8'd153;
			butterfly_add_3 =  8'd185;
			butterfly_add_4 =  8'd154;
			butterfly_add_5 =  8'd186;
			butterfly_add_6 =  8'd155;
			butterfly_add_7 =  8'd187;
			end
		   else	if (count==183) begin
			butterfly_add_0 =  8'd156;
			butterfly_add_1 =  8'd188;
			butterfly_add_2 =  8'd157;
			butterfly_add_3 =  8'd189;
			butterfly_add_4 =  8'd158;
			butterfly_add_5 =  8'd190;
			butterfly_add_6 =  8'd159;
			butterfly_add_7 =  8'd191;
			end
		   else	if (count==184) begin
			butterfly_add_0 =  8'd192;
			butterfly_add_1 =  8'd224;
			butterfly_add_2 =  8'd193;
			butterfly_add_3 =  8'd225;
			butterfly_add_4 =  8'd194;
			butterfly_add_5 =  8'd226;
			butterfly_add_6 =  8'd195;
			butterfly_add_7 =  8'd227;
			end
		   else	if (count==185) begin
			butterfly_add_0 =  8'd196;
			butterfly_add_1 =  8'd228;
			butterfly_add_2 =  8'd197;
			butterfly_add_3 =  8'd229;
			butterfly_add_4 =  8'd198;
			butterfly_add_5 =  8'd230;
			butterfly_add_6 =  8'd199;
			butterfly_add_7 =  8'd231;
			end
		   else	if (count==186) begin
			butterfly_add_0 =  8'd200;
			butterfly_add_1 =  8'd232;
			butterfly_add_2 =  8'd201;
			butterfly_add_3 =  8'd233;
			butterfly_add_4 =  8'd202;
			butterfly_add_5 =  8'd234;
			butterfly_add_6 =  8'd203;
			butterfly_add_7 =  8'd235;
			end
		   else	if (count==187) begin
			butterfly_add_0 =  8'd204;
			butterfly_add_1 =  8'd236;
			butterfly_add_2 =  8'd205;
			butterfly_add_3 =  8'd237;
			butterfly_add_4 =  8'd206;
			butterfly_add_5 =  8'd238;
			butterfly_add_6 =  8'd207;
			butterfly_add_7 =  8'd239;
			end
		   else	if (count==188) begin
			butterfly_add_0 =  8'd208;
			butterfly_add_1 =  8'd240;
			butterfly_add_2 =  8'd209;
			butterfly_add_3 =  8'd241;
			butterfly_add_4 =  8'd210;
			butterfly_add_5 =  8'd242;
			butterfly_add_6 =  8'd211;
			butterfly_add_7 =  8'd243;
			end
		   else	if (count==189) begin
			butterfly_add_0 =  8'd212;
			butterfly_add_1 =  8'd244;
			butterfly_add_2 =  8'd213;
			butterfly_add_3 =  8'd245;
			butterfly_add_4 =  8'd214;
			butterfly_add_5 =  8'd246;
			butterfly_add_6 =  8'd215;
			butterfly_add_7 =  8'd247;
			end
		   else	if (count==190) begin
			butterfly_add_0 =  8'd216;
			butterfly_add_1 =  8'd248;
			butterfly_add_2 =  8'd217;
			butterfly_add_3 =  8'd249;
			butterfly_add_4 =  8'd218;
			butterfly_add_5 =  8'd250;
			butterfly_add_6 =  8'd219;
			butterfly_add_7 =  8'd251;
			end
		   else	if (count==191) begin
			butterfly_add_0 =  8'd220;
			butterfly_add_1 =  8'd252;
			butterfly_add_2 =  8'd221;
			butterfly_add_3 =  8'd253;
			butterfly_add_4 =  8'd222;
			butterfly_add_5 =  8'd254;
			butterfly_add_6 =  8'd223;
			butterfly_add_7 =  8'd255;
			end
		   else	if (count==192) begin
			butterfly_add_0 =  8'd0;
			butterfly_add_1 =  8'd64;
			butterfly_add_2 =  8'd1;
			butterfly_add_3 =  8'd65;
			butterfly_add_4 =  8'd2;
			butterfly_add_5 =  8'd66;
			butterfly_add_6 =  8'd3;
			butterfly_add_7 =  8'd67;
			end
		   else	if (count==193) begin
			butterfly_add_0 =  8'd4;
			butterfly_add_1 =  8'd68;
			butterfly_add_2 =  8'd5;
			butterfly_add_3 =  8'd69;
			butterfly_add_4 =  8'd6;
			butterfly_add_5 =  8'd70;
			butterfly_add_6 =  8'd7;
			butterfly_add_7 =  8'd71;
			end
		   else	if (count==194) begin
			butterfly_add_0 =  8'd8;
			butterfly_add_1 =  8'd72;
			butterfly_add_2 =  8'd9;
			butterfly_add_3 =  8'd73;
			butterfly_add_4 =  8'd10;
			butterfly_add_5 =  8'd74;
			butterfly_add_6 =  8'd11;
			butterfly_add_7 =  8'd75;
			end
		   else	if (count==195) begin
			butterfly_add_0 =  8'd12;
			butterfly_add_1 =  8'd76;
			butterfly_add_2 =  8'd13;
			butterfly_add_3 =  8'd77;
			butterfly_add_4 =  8'd14;
			butterfly_add_5 =  8'd78;
			butterfly_add_6 =  8'd15;
			butterfly_add_7 =  8'd79;
			end
		   else	if (count==196) begin
			butterfly_add_0 =  8'd16;
			butterfly_add_1 =  8'd80;
			butterfly_add_2 =  8'd17;
			butterfly_add_3 =  8'd81;
			butterfly_add_4 =  8'd18;
			butterfly_add_5 =  8'd82;
			butterfly_add_6 =  8'd19;
			butterfly_add_7 =  8'd83;
			end
		   else	if (count==197) begin
			butterfly_add_0 =  8'd20;
			butterfly_add_1 =  8'd84;
			butterfly_add_2 =  8'd21;
			butterfly_add_3 =  8'd85;
			butterfly_add_4 =  8'd22;
			butterfly_add_5 =  8'd86;
			butterfly_add_6 =  8'd23;
			butterfly_add_7 =  8'd87;
			end
		   else	if (count==198) begin
			butterfly_add_0 =  8'd24;
			butterfly_add_1 =  8'd88;
			butterfly_add_2 =  8'd25;
			butterfly_add_3 =  8'd89;
			butterfly_add_4 =  8'd26;
			butterfly_add_5 =  8'd90;
			butterfly_add_6 =  8'd27;
			butterfly_add_7 =  8'd91;
			end
		   else	if (count==199) begin
			butterfly_add_0 =  8'd28;
			butterfly_add_1 =  8'd92;
			butterfly_add_2 =  8'd29;
			butterfly_add_3 =  8'd93;
			butterfly_add_4 =  8'd30;
			butterfly_add_5 =  8'd94;
			butterfly_add_6 =  8'd31;
			butterfly_add_7 =  8'd95;
			end
		   else	if (count==200) begin
			butterfly_add_0 =  8'd32;
			butterfly_add_1 =  8'd96;
			butterfly_add_2 =  8'd33;
			butterfly_add_3 =  8'd97;
			butterfly_add_4 =  8'd34;
			butterfly_add_5 =  8'd98;
			butterfly_add_6 =  8'd35;
			butterfly_add_7 =  8'd99;
			end
		   else	if (count==201) begin
			butterfly_add_0 =  8'd36;
			butterfly_add_1 =  8'd100;
			butterfly_add_2 =  8'd37;
			butterfly_add_3 =  8'd101;
			butterfly_add_4 =  8'd38;
			butterfly_add_5 =  8'd102;
			butterfly_add_6 =  8'd39;
			butterfly_add_7 =  8'd103;
			end
		   else	if (count==202) begin
			butterfly_add_0 =  8'd40;
			butterfly_add_1 =  8'd104;
			butterfly_add_2 =  8'd41;
			butterfly_add_3 =  8'd105;
			butterfly_add_4 =  8'd42;
			butterfly_add_5 =  8'd106;
			butterfly_add_6 =  8'd43;
			butterfly_add_7 =  8'd107;
			end
		   else	if (count==203) begin
			butterfly_add_0 =  8'd44;
			butterfly_add_1 =  8'd108;
			butterfly_add_2 =  8'd45;
			butterfly_add_3 =  8'd109;
			butterfly_add_4 =  8'd46;
			butterfly_add_5 =  8'd110;
			butterfly_add_6 =  8'd47;
			butterfly_add_7 =  8'd111;
			end
		   else	if (count==204) begin
			butterfly_add_0 =  8'd48;
			butterfly_add_1 =  8'd112;
			butterfly_add_2 =  8'd49;
			butterfly_add_3 =  8'd113;
			butterfly_add_4 =  8'd50;
			butterfly_add_5 =  8'd114;
			butterfly_add_6 =  8'd51;
			butterfly_add_7 =  8'd115;
			end
		   else	if (count==205) begin
			butterfly_add_0 =  8'd52;
			butterfly_add_1 =  8'd116;
			butterfly_add_2 =  8'd53;
			butterfly_add_3 =  8'd117;
			butterfly_add_4 =  8'd54;
			butterfly_add_5 =  8'd118;
			butterfly_add_6 =  8'd55;
			butterfly_add_7 =  8'd119;
			end
		   else	if (count==206) begin
			butterfly_add_0 =  8'd56;
			butterfly_add_1 =  8'd120;
			butterfly_add_2 =  8'd57;
			butterfly_add_3 =  8'd121;
			butterfly_add_4 =  8'd58;
			butterfly_add_5 =  8'd122;
			butterfly_add_6 =  8'd59;
			butterfly_add_7 =  8'd123;
			end
		   else	if (count==207) begin
			butterfly_add_0 =  8'd60;
			butterfly_add_1 =  8'd124;
			butterfly_add_2 =  8'd61;
			butterfly_add_3 =  8'd125;
			butterfly_add_4 =  8'd62;
			butterfly_add_5 =  8'd126;
			butterfly_add_6 =  8'd63;
			butterfly_add_7 =  8'd127;
			end
		   else	if (count==208) begin
			butterfly_add_0 =  8'd128;
			butterfly_add_1 =  8'd192;
			butterfly_add_2 =  8'd129;
			butterfly_add_3 =  8'd193;
			butterfly_add_4 =  8'd130;
			butterfly_add_5 =  8'd194;
			butterfly_add_6 =  8'd131;
			butterfly_add_7 =  8'd195;
			end
		   else	if (count==209) begin
			butterfly_add_0 =  8'd132;
			butterfly_add_1 =  8'd196;
			butterfly_add_2 =  8'd133;
			butterfly_add_3 =  8'd197;
			butterfly_add_4 =  8'd134;
			butterfly_add_5 =  8'd198;
			butterfly_add_6 =  8'd135;
			butterfly_add_7 =  8'd199;
			end
		   else	if (count==210) begin
			butterfly_add_0 =  8'd136;
			butterfly_add_1 =  8'd200;
			butterfly_add_2 =  8'd137;
			butterfly_add_3 =  8'd201;
			butterfly_add_4 =  8'd138;
			butterfly_add_5 =  8'd202;
			butterfly_add_6 =  8'd139;
			butterfly_add_7 =  8'd203;
			end
		   else	if (count==211) begin
			butterfly_add_0 =  8'd140;
			butterfly_add_1 =  8'd204;
			butterfly_add_2 =  8'd141;
			butterfly_add_3 =  8'd205;
			butterfly_add_4 =  8'd142;
			butterfly_add_5 =  8'd206;
			butterfly_add_6 =  8'd143;
			butterfly_add_7 =  8'd207;
			end
		   else	if (count==212) begin
			butterfly_add_0 =  8'd144;
			butterfly_add_1 =  8'd208;
			butterfly_add_2 =  8'd145;
			butterfly_add_3 =  8'd209;
			butterfly_add_4 =  8'd146;
			butterfly_add_5 =  8'd210;
			butterfly_add_6 =  8'd147;
			butterfly_add_7 =  8'd211;
			end
		   else	if (count==213) begin
			butterfly_add_0 =  8'd148;
			butterfly_add_1 =  8'd212;
			butterfly_add_2 =  8'd149;
			butterfly_add_3 =  8'd213;
			butterfly_add_4 =  8'd150;
			butterfly_add_5 =  8'd214;
			butterfly_add_6 =  8'd151;
			butterfly_add_7 =  8'd215;
			end
		   else	if (count==214) begin
			butterfly_add_0 =  8'd152;
			butterfly_add_1 =  8'd216;
			butterfly_add_2 =  8'd153;
			butterfly_add_3 =  8'd217;
			butterfly_add_4 =  8'd154;
			butterfly_add_5 =  8'd218;
			butterfly_add_6 =  8'd155;
			butterfly_add_7 =  8'd219;
			end
		   else	if (count==215) begin
			butterfly_add_0 =  8'd156;
			butterfly_add_1 =  8'd220;
			butterfly_add_2 =  8'd157;
			butterfly_add_3 =  8'd221;
			butterfly_add_4 =  8'd158;
			butterfly_add_5 =  8'd222;
			butterfly_add_6 =  8'd159;
			butterfly_add_7 =  8'd223;
			end
		   else	if (count==216) begin
			butterfly_add_0 =  8'd160;
			butterfly_add_1 =  8'd224;
			butterfly_add_2 =  8'd161;
			butterfly_add_3 =  8'd225;
			butterfly_add_4 =  8'd162;
			butterfly_add_5 =  8'd226;
			butterfly_add_6 =  8'd163;
			butterfly_add_7 =  8'd227;
			end
		   else	if (count==217) begin
			butterfly_add_0 =  8'd164;
			butterfly_add_1 =  8'd228;
			butterfly_add_2 =  8'd165;
			butterfly_add_3 =  8'd229;
			butterfly_add_4 =  8'd166;
			butterfly_add_5 =  8'd230;
			butterfly_add_6 =  8'd167;
			butterfly_add_7 =  8'd231;
			end
		   else	if (count==218) begin
			butterfly_add_0 =  8'd168;
			butterfly_add_1 =  8'd232;
			butterfly_add_2 =  8'd169;
			butterfly_add_3 =  8'd233;
			butterfly_add_4 =  8'd170;
			butterfly_add_5 =  8'd234;
			butterfly_add_6 =  8'd171;
			butterfly_add_7 =  8'd235;
			end
		   else	if (count==219) begin
			butterfly_add_0 =  8'd172;
			butterfly_add_1 =  8'd236;
			butterfly_add_2 =  8'd173;
			butterfly_add_3 =  8'd237;
			butterfly_add_4 =  8'd174;
			butterfly_add_5 =  8'd238;
			butterfly_add_6 =  8'd175;
			butterfly_add_7 =  8'd239;
			end
		   else	if (count==220) begin
			butterfly_add_0 =  8'd176;
			butterfly_add_1 =  8'd240;
			butterfly_add_2 =  8'd177;
			butterfly_add_3 =  8'd241;
			butterfly_add_4 =  8'd178;
			butterfly_add_5 =  8'd242;
			butterfly_add_6 =  8'd179;
			butterfly_add_7 =  8'd243;
			end
		   else	if (count==221) begin
			butterfly_add_0 =  8'd180;
			butterfly_add_1 =  8'd244;
			butterfly_add_2 =  8'd181;
			butterfly_add_3 =  8'd245;
			butterfly_add_4 =  8'd182;
			butterfly_add_5 =  8'd246;
			butterfly_add_6 =  8'd183;
			butterfly_add_7 =  8'd247;
			end
		   else	if (count==222) begin
			butterfly_add_0 =  8'd184;
			butterfly_add_1 =  8'd248;
			butterfly_add_2 =  8'd185;
			butterfly_add_3 =  8'd249;
			butterfly_add_4 =  8'd186;
			butterfly_add_5 =  8'd250;
			butterfly_add_6 =  8'd187;
			butterfly_add_7 =  8'd251;
			end
		   else	if (count==223) begin
			butterfly_add_0 =  8'd188;
			butterfly_add_1 =  8'd252;
			butterfly_add_2 =  8'd189;
			butterfly_add_3 =  8'd253;
			butterfly_add_4 =  8'd190;
			butterfly_add_5 =  8'd254;
			butterfly_add_6 =  8'd191;
			butterfly_add_7 =  8'd255;
			end
		   else	if (count==224) begin
			butterfly_add_0 =  8'd0;
			butterfly_add_1 =  8'd128;
			butterfly_add_2 =  8'd1;
			butterfly_add_3 =  8'd129;
			butterfly_add_4 =  8'd2;
			butterfly_add_5 =  8'd130;
			butterfly_add_6 =  8'd3;
			butterfly_add_7 =  8'd131;
			end
		   else	if (count==225) begin
			butterfly_add_0 =  8'd4;
			butterfly_add_1 =  8'd132;
			butterfly_add_2 =  8'd5;
			butterfly_add_3 =  8'd133;
			butterfly_add_4 =  8'd6;
			butterfly_add_5 =  8'd134;
			butterfly_add_6 =  8'd7;
			butterfly_add_7 =  8'd135;
			end
		   else	if (count==226) begin
			butterfly_add_0 =  8'd8;
			butterfly_add_1 =  8'd136;
			butterfly_add_2 =  8'd9;
			butterfly_add_3 =  8'd137;
			butterfly_add_4 =  8'd10;
			butterfly_add_5 =  8'd138;
			butterfly_add_6 =  8'd11;
			butterfly_add_7 =  8'd139;
			end
		   else	if (count==227) begin
			butterfly_add_0 =  8'd12;
			butterfly_add_1 =  8'd140;
			butterfly_add_2 =  8'd13;
			butterfly_add_3 =  8'd141;
			butterfly_add_4 =  8'd14;
			butterfly_add_5 =  8'd142;
			butterfly_add_6 =  8'd15;
			butterfly_add_7 =  8'd143;
			end
		   else	if (count==228) begin
			butterfly_add_0 =  8'd16;
			butterfly_add_1 =  8'd144;
			butterfly_add_2 =  8'd17;
			butterfly_add_3 =  8'd145;
			butterfly_add_4 =  8'd18;
			butterfly_add_5 =  8'd146;
			butterfly_add_6 =  8'd19;
			butterfly_add_7 =  8'd147;
			end
		   else	if (count==229) begin
			butterfly_add_0 =  8'd20;
			butterfly_add_1 =  8'd148;
			butterfly_add_2 =  8'd21;
			butterfly_add_3 =  8'd149;
			butterfly_add_4 =  8'd22;
			butterfly_add_5 =  8'd150;
			butterfly_add_6 =  8'd23;
			butterfly_add_7 =  8'd151;
			end
		   else	if (count==230) begin
			butterfly_add_0 =  8'd24;
			butterfly_add_1 =  8'd152;
			butterfly_add_2 =  8'd25;
			butterfly_add_3 =  8'd153;
			butterfly_add_4 =  8'd26;
			butterfly_add_5 =  8'd154;
			butterfly_add_6 =  8'd27;
			butterfly_add_7 =  8'd155;
			end
		   else	if (count==231) begin
			butterfly_add_0 =  8'd28;
			butterfly_add_1 =  8'd156;
			butterfly_add_2 =  8'd29;
			butterfly_add_3 =  8'd157;
			butterfly_add_4 =  8'd30;
			butterfly_add_5 =  8'd158;
			butterfly_add_6 =  8'd31;
			butterfly_add_7 =  8'd159;
			end
		   else	if (count==232) begin
			butterfly_add_0 =  8'd32;
			butterfly_add_1 =  8'd160;
			butterfly_add_2 =  8'd33;
			butterfly_add_3 =  8'd161;
			butterfly_add_4 =  8'd34;
			butterfly_add_5 =  8'd162;
			butterfly_add_6 =  8'd35;
			butterfly_add_7 =  8'd163;
			end
		   else	if (count==233) begin
			butterfly_add_0 =  8'd36;
			butterfly_add_1 =  8'd164;
			butterfly_add_2 =  8'd37;
			butterfly_add_3 =  8'd165;
			butterfly_add_4 =  8'd38;
			butterfly_add_5 =  8'd166;
			butterfly_add_6 =  8'd39;
			butterfly_add_7 =  8'd167;
			end
		   else	if (count==234) begin
			butterfly_add_0 =  8'd40;
			butterfly_add_1 =  8'd168;
			butterfly_add_2 =  8'd41;
			butterfly_add_3 =  8'd169;
			butterfly_add_4 =  8'd42;
			butterfly_add_5 =  8'd170;
			butterfly_add_6 =  8'd43;
			butterfly_add_7 =  8'd171;
			end
		   else	if (count==235) begin
			butterfly_add_0 =  8'd44;
			butterfly_add_1 =  8'd172;
			butterfly_add_2 =  8'd45;
			butterfly_add_3 =  8'd173;
			butterfly_add_4 =  8'd46;
			butterfly_add_5 =  8'd174;
			butterfly_add_6 =  8'd47;
			butterfly_add_7 =  8'd175;
			end
		   else	if (count==236) begin
			butterfly_add_0 =  8'd48;
			butterfly_add_1 =  8'd176;
			butterfly_add_2 =  8'd49;
			butterfly_add_3 =  8'd177;
			butterfly_add_4 =  8'd50;
			butterfly_add_5 =  8'd178;
			butterfly_add_6 =  8'd51;
			butterfly_add_7 =  8'd179;
			end
		   else	if (count==237) begin
			butterfly_add_0 =  8'd52;
			butterfly_add_1 =  8'd180;
			butterfly_add_2 =  8'd53;
			butterfly_add_3 =  8'd181;
			butterfly_add_4 =  8'd54;
			butterfly_add_5 =  8'd182;
			butterfly_add_6 =  8'd55;
			butterfly_add_7 =  8'd183;
			end
		   else	if (count==238) begin
			butterfly_add_0 =  8'd56;
			butterfly_add_1 =  8'd184;
			butterfly_add_2 =  8'd57;
			butterfly_add_3 =  8'd185;
			butterfly_add_4 =  8'd58;
			butterfly_add_5 =  8'd186;
			butterfly_add_6 =  8'd59;
			butterfly_add_7 =  8'd187;
			end
		   else	if (count==239) begin
			butterfly_add_0 =  8'd60;
			butterfly_add_1 =  8'd188;
			butterfly_add_2 =  8'd61;
			butterfly_add_3 =  8'd189;
			butterfly_add_4 =  8'd62;
			butterfly_add_5 =  8'd190;
			butterfly_add_6 =  8'd63;
			butterfly_add_7 =  8'd191;
			end
		   else	if (count==240) begin
			butterfly_add_0 =  8'd64;
			butterfly_add_1 =  8'd192;
			butterfly_add_2 =  8'd65;
			butterfly_add_3 =  8'd193;
			butterfly_add_4 =  8'd66;
			butterfly_add_5 =  8'd194;
			butterfly_add_6 =  8'd67;
			butterfly_add_7 =  8'd195;
			end
		   else	if (count==241) begin
			butterfly_add_0 =  8'd68;
			butterfly_add_1 =  8'd196;
			butterfly_add_2 =  8'd69;
			butterfly_add_3 =  8'd197;
			butterfly_add_4 =  8'd70;
			butterfly_add_5 =  8'd198;
			butterfly_add_6 =  8'd71;
			butterfly_add_7 =  8'd199;
			end
		   else	if (count==242) begin
			butterfly_add_0 =  8'd72;
			butterfly_add_1 =  8'd200;
			butterfly_add_2 =  8'd73;
			butterfly_add_3 =  8'd201;
			butterfly_add_4 =  8'd74;
			butterfly_add_5 =  8'd202;
			butterfly_add_6 =  8'd75;
			butterfly_add_7 =  8'd203;
			end
		   else	if (count==243) begin
			butterfly_add_0 =  8'd76;
			butterfly_add_1 =  8'd204;
			butterfly_add_2 =  8'd77;
			butterfly_add_3 =  8'd205;
			butterfly_add_4 =  8'd78;
			butterfly_add_5 =  8'd206;
			butterfly_add_6 =  8'd79;
			butterfly_add_7 =  8'd207;
			end
		   else	if (count==244) begin
			butterfly_add_0 =  8'd80;
			butterfly_add_1 =  8'd208;
			butterfly_add_2 =  8'd81;
			butterfly_add_3 =  8'd209;
			butterfly_add_4 =  8'd82;
			butterfly_add_5 =  8'd210;
			butterfly_add_6 =  8'd83;
			butterfly_add_7 =  8'd211;
			end
		   else	if (count==245) begin
			butterfly_add_0 =  8'd84;
			butterfly_add_1 =  8'd212;
			butterfly_add_2 =  8'd85;
			butterfly_add_3 =  8'd213;
			butterfly_add_4 =  8'd86;
			butterfly_add_5 =  8'd214;
			butterfly_add_6 =  8'd87;
			butterfly_add_7 =  8'd215;
			end
		   else	if (count==246) begin
			butterfly_add_0 =  8'd88;
			butterfly_add_1 =  8'd216;
			butterfly_add_2 =  8'd89;
			butterfly_add_3 =  8'd217;
			butterfly_add_4 =  8'd90;
			butterfly_add_5 =  8'd218;
			butterfly_add_6 =  8'd91;
			butterfly_add_7 =  8'd219;
			end
		   else	if (count==247) begin
			butterfly_add_0 =  8'd92;
			butterfly_add_1 =  8'd220;
			butterfly_add_2 =  8'd93;
			butterfly_add_3 =  8'd221;
			butterfly_add_4 =  8'd94;
			butterfly_add_5 =  8'd222;
			butterfly_add_6 =  8'd95;
			butterfly_add_7 =  8'd223;
			end
		   else	if (count==248) begin
			butterfly_add_0 =  8'd96;
			butterfly_add_1 =  8'd224;
			butterfly_add_2 =  8'd97;
			butterfly_add_3 =  8'd225;
			butterfly_add_4 =  8'd98;
			butterfly_add_5 =  8'd226;
			butterfly_add_6 =  8'd99;
			butterfly_add_7 =  8'd227;
			end
		   else	if (count==249) begin
			butterfly_add_0 =  8'd100;
			butterfly_add_1 =  8'd228;
			butterfly_add_2 =  8'd101;
			butterfly_add_3 =  8'd229;
			butterfly_add_4 =  8'd102;
			butterfly_add_5 =  8'd230;
			butterfly_add_6 =  8'd103;
			butterfly_add_7 =  8'd231;
			end
		   else	if (count==250) begin
			butterfly_add_0 =  8'd104;
			butterfly_add_1 =  8'd232;
			butterfly_add_2 =  8'd105;
			butterfly_add_3 =  8'd233;
			butterfly_add_4 =  8'd106;
			butterfly_add_5 =  8'd234;
			butterfly_add_6 =  8'd107;
			butterfly_add_7 =  8'd235;
			end
		   else	if (count==251) begin
			butterfly_add_0 =  8'd108;
			butterfly_add_1 =  8'd236;
			butterfly_add_2 =  8'd109;
			butterfly_add_3 =  8'd237;
			butterfly_add_4 =  8'd110;
			butterfly_add_5 =  8'd238;
			butterfly_add_6 =  8'd111;
			butterfly_add_7 =  8'd239;
			end
		   else	if (count==252) begin
			butterfly_add_0 =  8'd112;
			butterfly_add_1 =  8'd240;
			butterfly_add_2 =  8'd113;
			butterfly_add_3 =  8'd241;
			butterfly_add_4 =  8'd114;
			butterfly_add_5 =  8'd242;
			butterfly_add_6 =  8'd115;
			butterfly_add_7 =  8'd243;
			end
		   else	if (count==253) begin
			butterfly_add_0 =  8'd116;
			butterfly_add_1 =  8'd244;
			butterfly_add_2 =  8'd117;
			butterfly_add_3 =  8'd245;
			butterfly_add_4 =  8'd118;
			butterfly_add_5 =  8'd246;
			butterfly_add_6 =  8'd119;
			butterfly_add_7 =  8'd247;
			end
		   else	if (count==254) begin
			butterfly_add_0 =  8'd120;
			butterfly_add_1 =  8'd248;
			butterfly_add_2 =  8'd121;
			butterfly_add_3 =  8'd249;
			butterfly_add_4 =  8'd122;
			butterfly_add_5 =  8'd250;
			butterfly_add_6 =  8'd123;
			butterfly_add_7 =  8'd251;
			end
		   else	if (count==255) begin
			butterfly_add_0 =  8'd124;
			butterfly_add_1 =  8'd252;
			butterfly_add_2 =  8'd125;
			butterfly_add_3 =  8'd253;
			butterfly_add_4 =  8'd126;
			butterfly_add_5 =  8'd254;
			butterfly_add_6 =  8'd127;
			butterfly_add_7 =  8'd255;
			end
			else begin 
				   butterfly_add_0 =  8'd0;
                                   butterfly_add_1 =  8'd0;
                                   butterfly_add_2 =  8'd0;
                                   butterfly_add_3 =  8'd0;
                                   butterfly_add_4 =  8'd0;
                                   butterfly_add_5 =  8'd0;
                                   butterfly_add_6 =  8'd0;
                                   butterfly_add_7 =  8'd0;
                                   end
			   end
		   end





always@(posedge clk or posedge reset) begin
if (reset)
    begin    
        working_real_buffer[255] <= 0;
        working_real_buffer[254] <= 0;
        working_real_buffer[253] <= 0;
        working_real_buffer[252] <= 0;
        working_real_buffer[251] <= 0;
        working_real_buffer[250] <= 0;
        working_real_buffer[249] <= 0;
        working_real_buffer[248] <= 0;
        working_real_buffer[247] <= 0;
        working_real_buffer[246] <= 0;
        working_real_buffer[245] <= 0;
        working_real_buffer[244] <= 0;
        working_real_buffer[243] <= 0;
        working_real_buffer[242] <= 0;
        working_real_buffer[241] <= 0;
        working_real_buffer[240] <= 0;
        working_real_buffer[239] <= 0;
        working_real_buffer[238] <= 0;
        working_real_buffer[237] <= 0;
        working_real_buffer[236] <= 0;
        working_real_buffer[235] <= 0;
        working_real_buffer[234] <= 0;
        working_real_buffer[233] <= 0;
        working_real_buffer[232] <= 0;
        working_real_buffer[231] <= 0;
        working_real_buffer[230] <= 0;
        working_real_buffer[229] <= 0;
        working_real_buffer[228] <= 0;
        working_real_buffer[227] <= 0;
        working_real_buffer[226] <= 0;
        working_real_buffer[225] <= 0;
        working_real_buffer[224] <= 0;
        working_real_buffer[223] <= 0;
        working_real_buffer[222] <= 0;
        working_real_buffer[221] <= 0;
        working_real_buffer[220] <= 0;
        working_real_buffer[219] <= 0;
        working_real_buffer[218] <= 0;
        working_real_buffer[217] <= 0;
        working_real_buffer[216] <= 0;
        working_real_buffer[215] <= 0;
        working_real_buffer[214] <= 0;
        working_real_buffer[213] <= 0;
        working_real_buffer[212] <= 0;
        working_real_buffer[211] <= 0;
        working_real_buffer[210] <= 0;
        working_real_buffer[209] <= 0;
        working_real_buffer[208] <= 0;
        working_real_buffer[207] <= 0;
        working_real_buffer[206] <= 0;
        working_real_buffer[205] <= 0;
        working_real_buffer[204] <= 0;
        working_real_buffer[203] <= 0;
        working_real_buffer[202] <= 0;
        working_real_buffer[201] <= 0;
        working_real_buffer[200] <= 0;
        working_real_buffer[199] <= 0;
        working_real_buffer[198] <= 0;
        working_real_buffer[197] <= 0;
        working_real_buffer[196] <= 0;
        working_real_buffer[195] <= 0;
        working_real_buffer[194] <= 0;
        working_real_buffer[193] <= 0;
        working_real_buffer[192] <= 0;
        working_real_buffer[191] <= 0;
        working_real_buffer[190] <= 0;
        working_real_buffer[189] <= 0;
        working_real_buffer[188] <= 0;
        working_real_buffer[187] <= 0;
        working_real_buffer[186] <= 0;
        working_real_buffer[185] <= 0;
        working_real_buffer[184] <= 0;
        working_real_buffer[183] <= 0;
        working_real_buffer[182] <= 0;
        working_real_buffer[181] <= 0;
        working_real_buffer[180] <= 0;
        working_real_buffer[179] <= 0;
        working_real_buffer[178] <= 0;
        working_real_buffer[177] <= 0;
        working_real_buffer[176] <= 0;
        working_real_buffer[175] <= 0;
        working_real_buffer[174] <= 0;
        working_real_buffer[173] <= 0;
        working_real_buffer[172] <= 0;
        working_real_buffer[171] <= 0;
        working_real_buffer[170] <= 0;
        working_real_buffer[169] <= 0;
        working_real_buffer[168] <= 0;
        working_real_buffer[167] <= 0;
        working_real_buffer[166] <= 0;
        working_real_buffer[165] <= 0;
        working_real_buffer[164] <= 0;
        working_real_buffer[163] <= 0;
        working_real_buffer[162] <= 0;
        working_real_buffer[161] <= 0;
        working_real_buffer[160] <= 0;
        working_real_buffer[159] <= 0;
        working_real_buffer[158] <= 0;
        working_real_buffer[157] <= 0;
        working_real_buffer[156] <= 0;
        working_real_buffer[155] <= 0;
        working_real_buffer[154] <= 0;
        working_real_buffer[153] <= 0;
        working_real_buffer[152] <= 0;
        working_real_buffer[151] <= 0;
        working_real_buffer[150] <= 0;
        working_real_buffer[149] <= 0;
        working_real_buffer[148] <= 0;
        working_real_buffer[147] <= 0;
        working_real_buffer[146] <= 0;
        working_real_buffer[145] <= 0;
        working_real_buffer[144] <= 0;
        working_real_buffer[143] <= 0;
        working_real_buffer[142] <= 0;
        working_real_buffer[141] <= 0;
        working_real_buffer[140] <= 0;
        working_real_buffer[139] <= 0;
        working_real_buffer[138] <= 0;
        working_real_buffer[137] <= 0;
        working_real_buffer[136] <= 0;
        working_real_buffer[135] <= 0;
        working_real_buffer[134] <= 0;
        working_real_buffer[133] <= 0;
        working_real_buffer[132] <= 0;
        working_real_buffer[131] <= 0;
        working_real_buffer[130] <= 0;
        working_real_buffer[129] <= 0;
        working_real_buffer[128] <= 0;
        working_real_buffer[127] <= 0;
        working_real_buffer[126] <= 0;
        working_real_buffer[125] <= 0;
        working_real_buffer[124] <= 0;
        working_real_buffer[123] <= 0;
        working_real_buffer[122] <= 0;
        working_real_buffer[121] <= 0;
        working_real_buffer[120] <= 0;
        working_real_buffer[119] <= 0;
        working_real_buffer[118] <= 0;
        working_real_buffer[117] <= 0;
        working_real_buffer[116] <= 0;
        working_real_buffer[115] <= 0;
        working_real_buffer[114] <= 0;
        working_real_buffer[113] <= 0;
        working_real_buffer[112] <= 0;
        working_real_buffer[111] <= 0;
        working_real_buffer[110] <= 0;
        working_real_buffer[109] <= 0;
        working_real_buffer[108] <= 0;
        working_real_buffer[107] <= 0;
        working_real_buffer[106] <= 0;
        working_real_buffer[105] <= 0;
        working_real_buffer[104] <= 0;
        working_real_buffer[103] <= 0;
        working_real_buffer[102] <= 0;
        working_real_buffer[101] <= 0;
        working_real_buffer[100] <= 0;
        working_real_buffer[99]  <= 0;
        working_real_buffer[98]  <= 0;
        working_real_buffer[97]  <= 0;
        working_real_buffer[96]  <= 0;
        working_real_buffer[95]  <= 0;
        working_real_buffer[94]  <= 0;
        working_real_buffer[93]  <= 0;
        working_real_buffer[92]  <= 0;
        working_real_buffer[91]  <= 0;
        working_real_buffer[90]  <= 0;
        working_real_buffer[89]  <= 0;
        working_real_buffer[88]  <= 0;
        working_real_buffer[87]  <= 0;
        working_real_buffer[86]  <= 0;
        working_real_buffer[85]  <= 0;
        working_real_buffer[84]  <= 0;
        working_real_buffer[83]  <= 0;
        working_real_buffer[82]  <= 0;
        working_real_buffer[81]  <= 0;
        working_real_buffer[80]  <= 0;
        working_real_buffer[79]  <= 0;
        working_real_buffer[78]  <= 0;
        working_real_buffer[77]  <= 0;
        working_real_buffer[76]  <= 0;
        working_real_buffer[75]  <= 0;
        working_real_buffer[74]  <= 0;
        working_real_buffer[73]  <= 0;
        working_real_buffer[72]  <= 0;
        working_real_buffer[71]  <= 0;
        working_real_buffer[70]  <= 0;
        working_real_buffer[69]  <= 0;
        working_real_buffer[68]  <= 0;
        working_real_buffer[67]  <= 0;
        working_real_buffer[66]  <= 0;
        working_real_buffer[65]  <= 0;
        working_real_buffer[64]  <= 0;
        working_real_buffer[63]  <= 0;
        working_real_buffer[62]  <= 0;
        working_real_buffer[61]  <= 0;
        working_real_buffer[60]  <= 0;
        working_real_buffer[59]  <= 0;
        working_real_buffer[58]  <= 0;
        working_real_buffer[57]  <= 0;
        working_real_buffer[56]  <= 0;
        working_real_buffer[55]  <= 0;
        working_real_buffer[54]  <= 0;
        working_real_buffer[53]  <= 0;
        working_real_buffer[52]  <= 0;
        working_real_buffer[51]  <= 0;
        working_real_buffer[50]  <= 0;
        working_real_buffer[49]  <= 0;
        working_real_buffer[48]  <= 0;
        working_real_buffer[47]  <= 0;
        working_real_buffer[46]  <= 0;
        working_real_buffer[45]  <= 0;
        working_real_buffer[44]  <= 0;
        working_real_buffer[43]  <= 0;
        working_real_buffer[42]  <= 0;
        working_real_buffer[41]  <= 0;
        working_real_buffer[40]  <= 0;
        working_real_buffer[39]  <= 0;
        working_real_buffer[38]  <= 0;
        working_real_buffer[37]  <= 0;
        working_real_buffer[36]  <= 0;
        working_real_buffer[35]  <= 0;
        working_real_buffer[34]  <= 0;
        working_real_buffer[33]  <= 0;
        working_real_buffer[32]  <= 0;
        working_real_buffer[31]  <= 0;
        working_real_buffer[30]  <= 0;
        working_real_buffer[29]  <= 0;
        working_real_buffer[28]  <= 0;
        working_real_buffer[27]  <= 0;
        working_real_buffer[26]  <= 0;
        working_real_buffer[25]  <= 0;
        working_real_buffer[24]  <= 0;
        working_real_buffer[23]  <= 0;
        working_real_buffer[22]  <= 0;
        working_real_buffer[21]  <= 0;
        working_real_buffer[20]  <= 0;
        working_real_buffer[19]  <= 0;
        working_real_buffer[18]  <= 0;
        working_real_buffer[17]  <= 0;
        working_real_buffer[16]  <= 0;
        working_real_buffer[15]  <= 0;
        working_real_buffer[14]  <= 0;
        working_real_buffer[13]  <= 0;
        working_real_buffer[12]  <= 0;
        working_real_buffer[11]  <= 0;
        working_real_buffer[10]  <= 0;
        working_real_buffer[9]   <= 0;
        working_real_buffer[8]   <= 0;
        working_real_buffer[7]   <= 0;
        working_real_buffer[6]   <= 0;
        working_real_buffer[5]   <= 0;
        working_real_buffer[4]   <= 0;
        working_real_buffer[3]   <= 0;
        working_real_buffer[2]   <= 0;
        working_real_buffer[1]   <= 0;
        working_real_buffer[0]   <= 0;
        working_imag_buffer[255] <= 0;
        working_imag_buffer[254] <= 0;
        working_imag_buffer[253] <= 0;
        working_imag_buffer[252] <= 0;
        working_imag_buffer[251] <= 0;
        working_imag_buffer[250] <= 0;
        working_imag_buffer[249] <= 0;
        working_imag_buffer[248] <= 0;
        working_imag_buffer[247] <= 0;
        working_imag_buffer[246] <= 0;
        working_imag_buffer[245] <= 0;
        working_imag_buffer[244] <= 0;
        working_imag_buffer[243] <= 0;
        working_imag_buffer[242] <= 0;
        working_imag_buffer[241] <= 0;
        working_imag_buffer[240] <= 0;
        working_imag_buffer[239] <= 0;
        working_imag_buffer[238] <= 0;
        working_imag_buffer[237] <= 0;
        working_imag_buffer[236] <= 0;
        working_imag_buffer[235] <= 0;
        working_imag_buffer[234] <= 0;
        working_imag_buffer[233] <= 0;
        working_imag_buffer[232] <= 0;
        working_imag_buffer[231] <= 0;
        working_imag_buffer[230] <= 0;
        working_imag_buffer[229] <= 0;
        working_imag_buffer[228] <= 0;
        working_imag_buffer[227] <= 0;
        working_imag_buffer[226] <= 0;
        working_imag_buffer[225] <= 0;
        working_imag_buffer[224] <= 0;
        working_imag_buffer[223] <= 0;
        working_imag_buffer[222] <= 0;
        working_imag_buffer[221] <= 0;
        working_imag_buffer[220] <= 0;
        working_imag_buffer[219] <= 0;
        working_imag_buffer[218] <= 0;
        working_imag_buffer[217] <= 0;
        working_imag_buffer[216] <= 0;
        working_imag_buffer[215] <= 0;
        working_imag_buffer[214] <= 0;
        working_imag_buffer[213] <= 0;
        working_imag_buffer[212] <= 0;
        working_imag_buffer[211] <= 0;
        working_imag_buffer[210] <= 0;
        working_imag_buffer[209] <= 0;
        working_imag_buffer[208] <= 0;
        working_imag_buffer[207] <= 0;
        working_imag_buffer[206] <= 0;
        working_imag_buffer[205] <= 0;
        working_imag_buffer[204] <= 0;
        working_imag_buffer[203] <= 0;
        working_imag_buffer[202] <= 0;
        working_imag_buffer[201] <= 0;
        working_imag_buffer[200] <= 0;
        working_imag_buffer[199] <= 0;
        working_imag_buffer[198] <= 0;
        working_imag_buffer[197] <= 0;
        working_imag_buffer[196] <= 0;
        working_imag_buffer[195] <= 0;
        working_imag_buffer[194] <= 0;
        working_imag_buffer[193] <= 0;
        working_imag_buffer[192] <= 0;
        working_imag_buffer[191] <= 0;
        working_imag_buffer[190] <= 0;
        working_imag_buffer[189] <= 0;
        working_imag_buffer[188] <= 0;
        working_imag_buffer[187] <= 0;
        working_imag_buffer[186] <= 0;
        working_imag_buffer[185] <= 0;
        working_imag_buffer[184] <= 0;
        working_imag_buffer[183] <= 0;
        working_imag_buffer[182] <= 0;
        working_imag_buffer[181] <= 0;
        working_imag_buffer[180] <= 0;
        working_imag_buffer[179] <= 0;
        working_imag_buffer[178] <= 0;
        working_imag_buffer[177] <= 0;
        working_imag_buffer[176] <= 0;
        working_imag_buffer[175] <= 0;
        working_imag_buffer[174] <= 0;
        working_imag_buffer[173] <= 0;
        working_imag_buffer[172] <= 0;
        working_imag_buffer[171] <= 0;
        working_imag_buffer[170] <= 0;
        working_imag_buffer[169] <= 0;
        working_imag_buffer[168] <= 0;
        working_imag_buffer[167] <= 0;
        working_imag_buffer[166] <= 0;
        working_imag_buffer[165] <= 0;
        working_imag_buffer[164] <= 0;
        working_imag_buffer[163] <= 0;
        working_imag_buffer[162] <= 0;
        working_imag_buffer[161] <= 0;
        working_imag_buffer[160] <= 0;
        working_imag_buffer[159] <= 0;
        working_imag_buffer[158] <= 0;
        working_imag_buffer[157] <= 0;
        working_imag_buffer[156] <= 0;
        working_imag_buffer[155] <= 0;
        working_imag_buffer[154] <= 0;
        working_imag_buffer[153] <= 0;
        working_imag_buffer[152] <= 0;
        working_imag_buffer[151] <= 0;
        working_imag_buffer[150] <= 0;
        working_imag_buffer[149] <= 0;
        working_imag_buffer[148] <= 0;
        working_imag_buffer[147] <= 0;
        working_imag_buffer[146] <= 0;
        working_imag_buffer[145] <= 0;
        working_imag_buffer[144] <= 0;
        working_imag_buffer[143] <= 0;
        working_imag_buffer[142] <= 0;
        working_imag_buffer[141] <= 0;
        working_imag_buffer[140] <= 0;
        working_imag_buffer[139] <= 0;
        working_imag_buffer[138] <= 0;
        working_imag_buffer[137] <= 0;
        working_imag_buffer[136] <= 0;
        working_imag_buffer[135] <= 0;
        working_imag_buffer[134] <= 0;
        working_imag_buffer[133] <= 0;
        working_imag_buffer[132] <= 0;
        working_imag_buffer[131] <= 0;
        working_imag_buffer[130] <= 0;
        working_imag_buffer[129] <= 0;
        working_imag_buffer[128] <= 0;
        working_imag_buffer[127] <= 0;
        working_imag_buffer[126] <= 0;
        working_imag_buffer[125] <= 0;
        working_imag_buffer[124] <= 0;
        working_imag_buffer[123] <= 0;
        working_imag_buffer[122] <= 0;
        working_imag_buffer[121] <= 0;
        working_imag_buffer[120] <= 0;
        working_imag_buffer[119] <= 0;
        working_imag_buffer[118] <= 0;
        working_imag_buffer[117] <= 0;
        working_imag_buffer[116] <= 0;
        working_imag_buffer[115] <= 0;
        working_imag_buffer[114] <= 0;
        working_imag_buffer[113] <= 0;
        working_imag_buffer[112] <= 0;
        working_imag_buffer[111] <= 0;
        working_imag_buffer[110] <= 0;
        working_imag_buffer[109] <= 0;
        working_imag_buffer[108] <= 0;
        working_imag_buffer[107] <= 0;
        working_imag_buffer[106] <= 0;
        working_imag_buffer[105] <= 0;
        working_imag_buffer[104] <= 0;
        working_imag_buffer[103] <= 0;
        working_imag_buffer[102] <= 0;
        working_imag_buffer[101] <= 0;
        working_imag_buffer[100] <= 0;
        working_imag_buffer[99]  <= 0;
        working_imag_buffer[98]  <= 0;
        working_imag_buffer[97]  <= 0;
        working_imag_buffer[96]  <= 0;
        working_imag_buffer[95]  <= 0;
        working_imag_buffer[94]  <= 0;
        working_imag_buffer[93]  <= 0;
        working_imag_buffer[92]  <= 0;
        working_imag_buffer[91]  <= 0;
        working_imag_buffer[90]  <= 0;
        working_imag_buffer[89]  <= 0;
        working_imag_buffer[88]  <= 0;
        working_imag_buffer[87]  <= 0;
        working_imag_buffer[86]  <= 0;
        working_imag_buffer[85]  <= 0;
        working_imag_buffer[84]  <= 0;
        working_imag_buffer[83]  <= 0;
        working_imag_buffer[82]  <= 0;
        working_imag_buffer[81]  <= 0;
        working_imag_buffer[80]  <= 0;
        working_imag_buffer[79]  <= 0;
        working_imag_buffer[78]  <= 0;
        working_imag_buffer[77]  <= 0;
        working_imag_buffer[76]  <= 0;
        working_imag_buffer[75]  <= 0;
        working_imag_buffer[74]  <= 0;
        working_imag_buffer[73]  <= 0;
        working_imag_buffer[72]  <= 0;
        working_imag_buffer[71]  <= 0;
        working_imag_buffer[70]  <= 0;
        working_imag_buffer[69]  <= 0;
        working_imag_buffer[68]  <= 0;
        working_imag_buffer[67]  <= 0;
        working_imag_buffer[66]  <= 0;
        working_imag_buffer[65]  <= 0;
        working_imag_buffer[64]  <= 0;
        working_imag_buffer[63]  <= 0;
        working_imag_buffer[62]  <= 0;
        working_imag_buffer[61]  <= 0;
        working_imag_buffer[60]  <= 0;
        working_imag_buffer[59]  <= 0;
        working_imag_buffer[58]  <= 0;
        working_imag_buffer[57]  <= 0;
        working_imag_buffer[56]  <= 0;
        working_imag_buffer[55]  <= 0;
        working_imag_buffer[54]  <= 0;
        working_imag_buffer[53]  <= 0;
        working_imag_buffer[52]  <= 0;
        working_imag_buffer[51]  <= 0;
        working_imag_buffer[50]  <= 0;
        working_imag_buffer[49]  <= 0;
        working_imag_buffer[48]  <= 0;
        working_imag_buffer[47]  <= 0;
        working_imag_buffer[46]  <= 0;
        working_imag_buffer[45]  <= 0;
        working_imag_buffer[44]  <= 0;
        working_imag_buffer[43]  <= 0;
        working_imag_buffer[42]  <= 0;
        working_imag_buffer[41]  <= 0;
        working_imag_buffer[40]  <= 0;
        working_imag_buffer[39]  <= 0;
        working_imag_buffer[38]  <= 0;
        working_imag_buffer[37]  <= 0;
        working_imag_buffer[36]  <= 0;
        working_imag_buffer[35]  <= 0;
        working_imag_buffer[34]  <= 0;
        working_imag_buffer[33]  <= 0;
        working_imag_buffer[32]  <= 0;
        working_imag_buffer[31]  <= 0;
        working_imag_buffer[30]  <= 0;
        working_imag_buffer[29]  <= 0;
        working_imag_buffer[28]  <= 0;
        working_imag_buffer[27]  <= 0;
        working_imag_buffer[26]  <= 0;
        working_imag_buffer[25]  <= 0;
        working_imag_buffer[24]  <= 0;
        working_imag_buffer[23]  <= 0;
        working_imag_buffer[22]  <= 0;
        working_imag_buffer[21]  <= 0;
        working_imag_buffer[20]  <= 0;
        working_imag_buffer[19]  <= 0;
        working_imag_buffer[18]  <= 0;
        working_imag_buffer[17]  <= 0;
        working_imag_buffer[16]  <= 0;
        working_imag_buffer[15]  <= 0;
        working_imag_buffer[14]  <= 0;
        working_imag_buffer[13]  <= 0;
        working_imag_buffer[12]  <= 0;
        working_imag_buffer[11]  <= 0;
        working_imag_buffer[10]  <= 0;
        working_imag_buffer[9]   <= 0;
        working_imag_buffer[8]   <= 0;
        working_imag_buffer[7]   <= 0;
        working_imag_buffer[6]   <= 0;
        working_imag_buffer[5]   <= 0;
        working_imag_buffer[4]   <= 0;
        working_imag_buffer[3]   <= 0;
        working_imag_buffer[2]   <= 0;
        working_imag_buffer[1]   <= 0;
        working_imag_buffer[0]   <= 0;
    end 
else    if (start_flush)
    begin
        working_real_buffer[0]   <= realpart_in[0];  
        working_real_buffer[1]   <= realpart_in[1]; 
        working_real_buffer[2]   <= realpart_in[2]; 
        working_real_buffer[3]   <= realpart_in[3]; 
        working_real_buffer[4]   <= realpart_in[4]; 
        working_real_buffer[5]   <= realpart_in[5]; 
        working_real_buffer[6]   <= realpart_in[6]; 
        working_real_buffer[7]   <= realpart_in[7]; 
        working_real_buffer[8]   <= realpart_in[8]; 
        working_real_buffer[9]   <= realpart_in[9]; 
        working_real_buffer[10]  <= realpart_in[10]; 
        working_real_buffer[11]  <= realpart_in[11]; 
        working_real_buffer[12]  <= realpart_in[12]; 
        working_real_buffer[13]  <= realpart_in[13]; 
        working_real_buffer[14]  <= realpart_in[14]; 
        working_real_buffer[15]  <= realpart_in[15]; 
        working_real_buffer[16]  <= realpart_in[16]; 
        working_real_buffer[17]  <= realpart_in[17]; 
        working_real_buffer[18]  <= realpart_in[18]; 
        working_real_buffer[19]  <= realpart_in[19]; 
        working_real_buffer[20]  <= realpart_in[20]; 
        working_real_buffer[21]  <= realpart_in[21]; 
        working_real_buffer[22]  <= realpart_in[22]; 
        working_real_buffer[23]  <= realpart_in[23]; 
        working_real_buffer[24]  <= realpart_in[24]; 
        working_real_buffer[25]  <= realpart_in[25]; 
        working_real_buffer[26]  <= realpart_in[26]; 
        working_real_buffer[27]  <= realpart_in[27]; 
        working_real_buffer[28]  <= realpart_in[28]; 
        working_real_buffer[29]  <= realpart_in[29]; 
        working_real_buffer[30]  <= realpart_in[30]; 
        working_real_buffer[31]  <= realpart_in[31]; 
        working_real_buffer[32]  <= realpart_in[32]; 
        working_real_buffer[33]  <= realpart_in[33]; 
        working_real_buffer[34]  <= realpart_in[34]; 
        working_real_buffer[35]  <= realpart_in[35]; 
        working_real_buffer[36]  <= realpart_in[36]; 
        working_real_buffer[37]  <= realpart_in[37]; 
        working_real_buffer[38]  <= realpart_in[38]; 
        working_real_buffer[39]  <= realpart_in[39]; 
        working_real_buffer[40]  <= realpart_in[40]; 
        working_real_buffer[41]  <= realpart_in[41]; 
        working_real_buffer[42]  <= realpart_in[42]; 
        working_real_buffer[43]  <= realpart_in[43]; 
        working_real_buffer[44]  <= realpart_in[44]; 
        working_real_buffer[45]  <= realpart_in[45]; 
        working_real_buffer[46]  <= realpart_in[46]; 
        working_real_buffer[47]  <= realpart_in[47]; 
        working_real_buffer[48]  <= realpart_in[48]; 
        working_real_buffer[49]  <= realpart_in[49]; 
        working_real_buffer[50]  <= realpart_in[50]; 
        working_real_buffer[51]  <= realpart_in[51]; 
        working_real_buffer[52]  <= realpart_in[52]; 
        working_real_buffer[53]  <= realpart_in[53]; 
        working_real_buffer[54]  <= realpart_in[54]; 
        working_real_buffer[55]  <= realpart_in[55]; 
        working_real_buffer[56]  <= realpart_in[56]; 
        working_real_buffer[57]  <= realpart_in[57]; 
        working_real_buffer[58]  <= realpart_in[58]; 
        working_real_buffer[59]  <= realpart_in[59]; 
        working_real_buffer[60]  <= realpart_in[60]; 
        working_real_buffer[61]  <= realpart_in[61]; 
        working_real_buffer[62]  <= realpart_in[62]; 
        working_real_buffer[63]  <= realpart_in[63]; 
        working_real_buffer[64]  <= realpart_in[64]; 
        working_real_buffer[65]  <= realpart_in[65]; 
        working_real_buffer[66]  <= realpart_in[66]; 
        working_real_buffer[67]  <= realpart_in[67]; 
        working_real_buffer[68]  <= realpart_in[68]; 
        working_real_buffer[69]  <= realpart_in[69]; 
        working_real_buffer[70]  <= realpart_in[70]; 
        working_real_buffer[71]  <= realpart_in[71]; 
        working_real_buffer[72]  <= realpart_in[72]; 
        working_real_buffer[73]  <= realpart_in[73]; 
        working_real_buffer[74]  <= realpart_in[74]; 
        working_real_buffer[75]  <= realpart_in[75]; 
        working_real_buffer[76]  <= realpart_in[76]; 
        working_real_buffer[77]  <= realpart_in[77]; 
        working_real_buffer[78]  <= realpart_in[78]; 
        working_real_buffer[79]  <= realpart_in[79]; 
        working_real_buffer[80]  <= realpart_in[80]; 
        working_real_buffer[81]  <= realpart_in[81]; 
        working_real_buffer[82]  <= realpart_in[82]; 
        working_real_buffer[83]  <= realpart_in[83]; 
        working_real_buffer[84]  <= realpart_in[84]; 
        working_real_buffer[85]  <= realpart_in[85]; 
        working_real_buffer[86]  <= realpart_in[86]; 
        working_real_buffer[87]  <= realpart_in[87]; 
        working_real_buffer[88]  <= realpart_in[88]; 
        working_real_buffer[89]  <= realpart_in[89]; 
        working_real_buffer[90]  <= realpart_in[90]; 
        working_real_buffer[91]  <= realpart_in[91]; 
        working_real_buffer[92]  <= realpart_in[92]; 
        working_real_buffer[93]  <= realpart_in[93]; 
        working_real_buffer[94]  <= realpart_in[94]; 
        working_real_buffer[95]  <= realpart_in[95]; 
        working_real_buffer[96]  <= realpart_in[96]; 
        working_real_buffer[97]  <= realpart_in[97]; 
        working_real_buffer[98]  <= realpart_in[98]; 
        working_real_buffer[99]  <= realpart_in[99]; 
        working_real_buffer[100] <= realpart_in[100]; 
        working_real_buffer[101] <= realpart_in[101]; 
        working_real_buffer[102] <= realpart_in[102]; 
        working_real_buffer[103] <= realpart_in[103]; 
        working_real_buffer[104] <= realpart_in[104]; 
        working_real_buffer[105] <= realpart_in[105]; 
        working_real_buffer[106] <= realpart_in[106]; 
        working_real_buffer[107] <= realpart_in[107]; 
        working_real_buffer[108] <= realpart_in[108]; 
        working_real_buffer[109] <= realpart_in[109]; 
        working_real_buffer[110] <= realpart_in[110]; 
        working_real_buffer[111] <= realpart_in[111]; 
        working_real_buffer[112] <= realpart_in[112]; 
        working_real_buffer[113] <= realpart_in[113]; 
        working_real_buffer[114] <= realpart_in[114]; 
        working_real_buffer[115] <= realpart_in[115]; 
        working_real_buffer[116] <= realpart_in[116]; 
        working_real_buffer[117] <= realpart_in[117]; 
        working_real_buffer[118] <= realpart_in[118]; 
        working_real_buffer[119] <= realpart_in[119]; 
        working_real_buffer[120] <= realpart_in[120]; 
        working_real_buffer[121] <= realpart_in[121]; 
        working_real_buffer[122] <= realpart_in[122]; 
        working_real_buffer[123] <= realpart_in[123]; 
        working_real_buffer[124] <= realpart_in[124]; 
        working_real_buffer[125] <= realpart_in[125]; 
        working_real_buffer[126] <= realpart_in[126]; 
        working_real_buffer[127] <= realpart_in[127]; 
        working_real_buffer[128] <= realpart_in[128]; 
        working_real_buffer[129] <= realpart_in[129]; 
        working_real_buffer[130] <= realpart_in[130]; 
        working_real_buffer[131] <= realpart_in[131]; 
        working_real_buffer[132] <= realpart_in[132]; 
        working_real_buffer[133] <= realpart_in[133]; 
        working_real_buffer[134] <= realpart_in[134]; 
        working_real_buffer[135] <= realpart_in[135]; 
        working_real_buffer[136] <= realpart_in[136]; 
        working_real_buffer[137] <= realpart_in[137]; 
        working_real_buffer[138] <= realpart_in[138]; 
        working_real_buffer[139] <= realpart_in[139]; 
        working_real_buffer[140] <= realpart_in[140]; 
        working_real_buffer[141] <= realpart_in[141]; 
        working_real_buffer[142] <= realpart_in[142]; 
        working_real_buffer[143] <= realpart_in[143]; 
        working_real_buffer[144] <= realpart_in[144]; 
        working_real_buffer[145] <= realpart_in[145]; 
        working_real_buffer[146] <= realpart_in[146]; 
        working_real_buffer[147] <= realpart_in[147]; 
        working_real_buffer[148] <= realpart_in[148]; 
        working_real_buffer[149] <= realpart_in[149]; 
        working_real_buffer[150] <= realpart_in[150]; 
        working_real_buffer[151] <= realpart_in[151]; 
        working_real_buffer[152] <= realpart_in[152]; 
        working_real_buffer[153] <= realpart_in[153]; 
        working_real_buffer[154] <= realpart_in[154]; 
        working_real_buffer[155] <= realpart_in[155]; 
        working_real_buffer[156] <= realpart_in[156]; 
        working_real_buffer[157] <= realpart_in[157]; 
        working_real_buffer[158] <= realpart_in[158]; 
        working_real_buffer[159] <= realpart_in[159]; 
        working_real_buffer[160] <= realpart_in[160]; 
        working_real_buffer[161] <= realpart_in[161]; 
        working_real_buffer[162] <= realpart_in[162]; 
        working_real_buffer[163] <= realpart_in[163]; 
        working_real_buffer[164] <= realpart_in[164]; 
        working_real_buffer[165] <= realpart_in[165]; 
        working_real_buffer[166] <= realpart_in[166]; 
        working_real_buffer[167] <= realpart_in[167]; 
        working_real_buffer[168] <= realpart_in[168]; 
        working_real_buffer[169] <= realpart_in[169]; 
        working_real_buffer[170] <= realpart_in[170]; 
        working_real_buffer[171] <= realpart_in[171]; 
        working_real_buffer[172] <= realpart_in[172]; 
        working_real_buffer[173] <= realpart_in[173]; 
        working_real_buffer[174] <= realpart_in[174]; 
        working_real_buffer[175] <= realpart_in[175]; 
        working_real_buffer[176] <= realpart_in[176]; 
        working_real_buffer[177] <= realpart_in[177]; 
        working_real_buffer[178] <= realpart_in[178]; 
        working_real_buffer[179] <= realpart_in[179]; 
        working_real_buffer[180] <= realpart_in[180]; 
        working_real_buffer[181] <= realpart_in[181]; 
        working_real_buffer[182] <= realpart_in[182]; 
        working_real_buffer[183] <= realpart_in[183]; 
        working_real_buffer[184] <= realpart_in[184]; 
        working_real_buffer[185] <= realpart_in[185]; 
        working_real_buffer[186] <= realpart_in[186]; 
        working_real_buffer[187] <= realpart_in[187]; 
        working_real_buffer[188] <= realpart_in[188]; 
        working_real_buffer[189] <= realpart_in[189]; 
        working_real_buffer[190] <= realpart_in[190]; 
        working_real_buffer[191] <= realpart_in[191]; 
        working_real_buffer[192] <= realpart_in[192]; 
        working_real_buffer[193] <= realpart_in[193]; 
        working_real_buffer[194] <= realpart_in[194]; 
        working_real_buffer[195] <= realpart_in[195]; 
        working_real_buffer[196] <= realpart_in[196]; 
        working_real_buffer[197] <= realpart_in[197]; 
        working_real_buffer[198] <= realpart_in[198]; 
        working_real_buffer[199] <= realpart_in[199]; 
        working_real_buffer[200] <= realpart_in[200]; 
        working_real_buffer[201] <= realpart_in[201]; 
        working_real_buffer[202] <= realpart_in[202]; 
        working_real_buffer[203] <= realpart_in[203]; 
        working_real_buffer[204] <= realpart_in[204]; 
        working_real_buffer[205] <= realpart_in[205]; 
        working_real_buffer[206] <= realpart_in[206]; 
        working_real_buffer[207] <= realpart_in[207]; 
        working_real_buffer[208] <= realpart_in[208]; 
        working_real_buffer[209] <= realpart_in[209]; 
        working_real_buffer[210] <= realpart_in[210]; 
        working_real_buffer[211] <= realpart_in[211]; 
        working_real_buffer[212] <= realpart_in[212]; 
        working_real_buffer[213] <= realpart_in[213]; 
        working_real_buffer[214] <= realpart_in[214]; 
        working_real_buffer[215] <= realpart_in[215]; 
        working_real_buffer[216] <= realpart_in[216]; 
        working_real_buffer[217] <= realpart_in[217]; 
        working_real_buffer[218] <= realpart_in[218]; 
        working_real_buffer[219] <= realpart_in[219]; 
        working_real_buffer[220] <= realpart_in[220]; 
        working_real_buffer[221] <= realpart_in[221]; 
        working_real_buffer[222] <= realpart_in[222]; 
        working_real_buffer[223] <= realpart_in[223]; 
        working_real_buffer[224] <= realpart_in[224]; 
        working_real_buffer[225] <= realpart_in[225]; 
        working_real_buffer[226] <= realpart_in[226]; 
        working_real_buffer[227] <= realpart_in[227]; 
        working_real_buffer[228] <= realpart_in[228]; 
        working_real_buffer[229] <= realpart_in[229]; 
        working_real_buffer[230] <= realpart_in[230]; 
        working_real_buffer[231] <= realpart_in[231]; 
        working_real_buffer[232] <= realpart_in[232]; 
        working_real_buffer[233] <= realpart_in[233]; 
        working_real_buffer[234] <= realpart_in[234]; 
        working_real_buffer[235] <= realpart_in[235]; 
        working_real_buffer[236] <= realpart_in[236]; 
        working_real_buffer[237] <= realpart_in[237]; 
        working_real_buffer[238] <= realpart_in[238]; 
        working_real_buffer[239] <= realpart_in[239]; 
        working_real_buffer[240] <= realpart_in[240]; 
        working_real_buffer[241] <= realpart_in[241]; 
        working_real_buffer[242] <= realpart_in[242]; 
        working_real_buffer[243] <= realpart_in[243]; 
        working_real_buffer[244] <= realpart_in[244]; 
        working_real_buffer[245] <= realpart_in[245]; 
        working_real_buffer[246] <= realpart_in[246]; 
        working_real_buffer[247] <= realpart_in[247]; 
        working_real_buffer[248] <= realpart_in[248]; 
        working_real_buffer[249] <= realpart_in[249]; 
        working_real_buffer[250] <= realpart_in[250]; 
        working_real_buffer[251] <= realpart_in[251]; 
        working_real_buffer[252] <= realpart_in[252]; 
        working_real_buffer[253] <= realpart_in[253]; 
        working_real_buffer[254] <= realpart_in[254]; 
        working_real_buffer[255] <= realin_255_1;
//        working_real_buffer[254] <= {{8{realin_255_1[19]}},realin_255_1,2'b00};
    
        working_imag_buffer[0]   <= imagpart_in[0];  
        working_imag_buffer[1]   <= imagpart_in[1]; 
        working_imag_buffer[2]   <= imagpart_in[2]; 
        working_imag_buffer[3]   <= imagpart_in[3]; 
        working_imag_buffer[4]   <= imagpart_in[4]; 
        working_imag_buffer[5]   <= imagpart_in[5]; 
        working_imag_buffer[6]   <= imagpart_in[6]; 
        working_imag_buffer[7]   <= imagpart_in[7]; 
        working_imag_buffer[8]   <= imagpart_in[8]; 
        working_imag_buffer[9]   <= imagpart_in[9]; 
        working_imag_buffer[10]  <= imagpart_in[10]; 
        working_imag_buffer[11]  <= imagpart_in[11]; 
        working_imag_buffer[12]  <= imagpart_in[12]; 
        working_imag_buffer[13]  <= imagpart_in[13]; 
        working_imag_buffer[14]  <= imagpart_in[14]; 
        working_imag_buffer[15]  <= imagpart_in[15]; 
        working_imag_buffer[16]  <= imagpart_in[16]; 
        working_imag_buffer[17]  <= imagpart_in[17]; 
        working_imag_buffer[18]  <= imagpart_in[18]; 
        working_imag_buffer[19]  <= imagpart_in[19]; 
        working_imag_buffer[20]  <= imagpart_in[20]; 
        working_imag_buffer[21]  <= imagpart_in[21]; 
        working_imag_buffer[22]  <= imagpart_in[22]; 
        working_imag_buffer[23]  <= imagpart_in[23]; 
        working_imag_buffer[24]  <= imagpart_in[24]; 
        working_imag_buffer[25]  <= imagpart_in[25]; 
        working_imag_buffer[26]  <= imagpart_in[26]; 
        working_imag_buffer[27]  <= imagpart_in[27]; 
        working_imag_buffer[28]  <= imagpart_in[28]; 
        working_imag_buffer[29]  <= imagpart_in[29]; 
        working_imag_buffer[30]  <= imagpart_in[30]; 
        working_imag_buffer[31]  <= imagpart_in[31]; 
        working_imag_buffer[32]  <= imagpart_in[32]; 
        working_imag_buffer[33]  <= imagpart_in[33]; 
        working_imag_buffer[34]  <= imagpart_in[34]; 
        working_imag_buffer[35]  <= imagpart_in[35]; 
        working_imag_buffer[36]  <= imagpart_in[36]; 
        working_imag_buffer[37]  <= imagpart_in[37]; 
        working_imag_buffer[38]  <= imagpart_in[38]; 
        working_imag_buffer[39]  <= imagpart_in[39]; 
        working_imag_buffer[40]  <= imagpart_in[40]; 
        working_imag_buffer[41]  <= imagpart_in[41]; 
        working_imag_buffer[42]  <= imagpart_in[42]; 
        working_imag_buffer[43]  <= imagpart_in[43]; 
        working_imag_buffer[44]  <= imagpart_in[44]; 
        working_imag_buffer[45]  <= imagpart_in[45]; 
        working_imag_buffer[46]  <= imagpart_in[46]; 
        working_imag_buffer[47]  <= imagpart_in[47]; 
        working_imag_buffer[48]  <= imagpart_in[48]; 
        working_imag_buffer[49]  <= imagpart_in[49]; 
        working_imag_buffer[50]  <= imagpart_in[50]; 
        working_imag_buffer[51]  <= imagpart_in[51]; 
        working_imag_buffer[52]  <= imagpart_in[52]; 
        working_imag_buffer[53]  <= imagpart_in[53]; 
        working_imag_buffer[54]  <= imagpart_in[54]; 
        working_imag_buffer[55]  <= imagpart_in[55]; 
        working_imag_buffer[56]  <= imagpart_in[56]; 
        working_imag_buffer[57]  <= imagpart_in[57]; 
        working_imag_buffer[58]  <= imagpart_in[58]; 
        working_imag_buffer[59]  <= imagpart_in[59]; 
        working_imag_buffer[60]  <= imagpart_in[60]; 
        working_imag_buffer[61]  <= imagpart_in[61]; 
        working_imag_buffer[62]  <= imagpart_in[62]; 
        working_imag_buffer[63]  <= imagpart_in[63]; 
        working_imag_buffer[64]  <= imagpart_in[64]; 
        working_imag_buffer[65]  <= imagpart_in[65]; 
        working_imag_buffer[66]  <= imagpart_in[66]; 
        working_imag_buffer[67]  <= imagpart_in[67]; 
        working_imag_buffer[68]  <= imagpart_in[68]; 
        working_imag_buffer[69]  <= imagpart_in[69]; 
        working_imag_buffer[70]  <= imagpart_in[70]; 
        working_imag_buffer[71]  <= imagpart_in[71]; 
        working_imag_buffer[72]  <= imagpart_in[72]; 
        working_imag_buffer[73]  <= imagpart_in[73]; 
        working_imag_buffer[74]  <= imagpart_in[74]; 
        working_imag_buffer[75]  <= imagpart_in[75]; 
        working_imag_buffer[76]  <= imagpart_in[76]; 
        working_imag_buffer[77]  <= imagpart_in[77]; 
        working_imag_buffer[78]  <= imagpart_in[78]; 
        working_imag_buffer[79]  <= imagpart_in[79]; 
        working_imag_buffer[80]  <= imagpart_in[80]; 
        working_imag_buffer[81]  <= imagpart_in[81]; 
        working_imag_buffer[82]  <= imagpart_in[82]; 
        working_imag_buffer[83]  <= imagpart_in[83]; 
        working_imag_buffer[84]  <= imagpart_in[84]; 
        working_imag_buffer[85]  <= imagpart_in[85]; 
        working_imag_buffer[86]  <= imagpart_in[86]; 
        working_imag_buffer[87]  <= imagpart_in[87]; 
        working_imag_buffer[88]  <= imagpart_in[88]; 
        working_imag_buffer[89]  <= imagpart_in[89]; 
        working_imag_buffer[90]  <= imagpart_in[90]; 
        working_imag_buffer[91]  <= imagpart_in[91]; 
        working_imag_buffer[92]  <= imagpart_in[92]; 
        working_imag_buffer[93]  <= imagpart_in[93]; 
        working_imag_buffer[94]  <= imagpart_in[94]; 
        working_imag_buffer[95]  <= imagpart_in[95]; 
        working_imag_buffer[96]  <= imagpart_in[96]; 
        working_imag_buffer[97]  <= imagpart_in[97]; 
        working_imag_buffer[98]  <= imagpart_in[98]; 
        working_imag_buffer[99]  <= imagpart_in[99]; 
        working_imag_buffer[100] <= imagpart_in[100]; 
        working_imag_buffer[101] <= imagpart_in[101]; 
        working_imag_buffer[102] <= imagpart_in[102]; 
        working_imag_buffer[103] <= imagpart_in[103]; 
        working_imag_buffer[104] <= imagpart_in[104]; 
        working_imag_buffer[105] <= imagpart_in[105]; 
        working_imag_buffer[106] <= imagpart_in[106]; 
        working_imag_buffer[107] <= imagpart_in[107]; 
        working_imag_buffer[108] <= imagpart_in[108]; 
        working_imag_buffer[109] <= imagpart_in[109]; 
        working_imag_buffer[110] <= imagpart_in[110]; 
        working_imag_buffer[111] <= imagpart_in[111]; 
        working_imag_buffer[112] <= imagpart_in[112]; 
        working_imag_buffer[113] <= imagpart_in[113]; 
        working_imag_buffer[114] <= imagpart_in[114]; 
        working_imag_buffer[115] <= imagpart_in[115]; 
        working_imag_buffer[116] <= imagpart_in[116]; 
        working_imag_buffer[117] <= imagpart_in[117]; 
        working_imag_buffer[118] <= imagpart_in[118]; 
        working_imag_buffer[119] <= imagpart_in[119]; 
        working_imag_buffer[120] <= imagpart_in[120]; 
        working_imag_buffer[121] <= imagpart_in[121]; 
        working_imag_buffer[122] <= imagpart_in[122]; 
        working_imag_buffer[123] <= imagpart_in[123]; 
        working_imag_buffer[124] <= imagpart_in[124]; 
        working_imag_buffer[125] <= imagpart_in[125]; 
        working_imag_buffer[126] <= imagpart_in[126]; 
        working_imag_buffer[127] <= imagpart_in[127]; 
        working_imag_buffer[128] <= imagpart_in[128]; 
        working_imag_buffer[129] <= imagpart_in[129]; 
        working_imag_buffer[130] <= imagpart_in[130]; 
        working_imag_buffer[131] <= imagpart_in[131]; 
        working_imag_buffer[132] <= imagpart_in[132]; 
        working_imag_buffer[133] <= imagpart_in[133]; 
        working_imag_buffer[134] <= imagpart_in[134]; 
        working_imag_buffer[135] <= imagpart_in[135]; 
        working_imag_buffer[136] <= imagpart_in[136]; 
        working_imag_buffer[137] <= imagpart_in[137]; 
        working_imag_buffer[138] <= imagpart_in[138]; 
        working_imag_buffer[139] <= imagpart_in[139]; 
        working_imag_buffer[140] <= imagpart_in[140]; 
        working_imag_buffer[141] <= imagpart_in[141]; 
        working_imag_buffer[142] <= imagpart_in[142]; 
        working_imag_buffer[143] <= imagpart_in[143]; 
        working_imag_buffer[144] <= imagpart_in[144]; 
        working_imag_buffer[145] <= imagpart_in[145]; 
        working_imag_buffer[146] <= imagpart_in[146]; 
        working_imag_buffer[147] <= imagpart_in[147]; 
        working_imag_buffer[148] <= imagpart_in[148]; 
        working_imag_buffer[149] <= imagpart_in[149]; 
        working_imag_buffer[150] <= imagpart_in[150]; 
        working_imag_buffer[151] <= imagpart_in[151]; 
        working_imag_buffer[152] <= imagpart_in[152]; 
        working_imag_buffer[153] <= imagpart_in[153]; 
        working_imag_buffer[154] <= imagpart_in[154]; 
        working_imag_buffer[155] <= imagpart_in[155]; 
        working_imag_buffer[156] <= imagpart_in[156]; 
        working_imag_buffer[157] <= imagpart_in[157]; 
        working_imag_buffer[158] <= imagpart_in[158]; 
        working_imag_buffer[159] <= imagpart_in[159]; 
        working_imag_buffer[160] <= imagpart_in[160]; 
        working_imag_buffer[161] <= imagpart_in[161]; 
        working_imag_buffer[162] <= imagpart_in[162]; 
        working_imag_buffer[163] <= imagpart_in[163]; 
        working_imag_buffer[164] <= imagpart_in[164]; 
        working_imag_buffer[165] <= imagpart_in[165]; 
        working_imag_buffer[166] <= imagpart_in[166]; 
        working_imag_buffer[167] <= imagpart_in[167]; 
        working_imag_buffer[168] <= imagpart_in[168]; 
        working_imag_buffer[169] <= imagpart_in[169]; 
        working_imag_buffer[170] <= imagpart_in[170]; 
        working_imag_buffer[171] <= imagpart_in[171]; 
        working_imag_buffer[172] <= imagpart_in[172]; 
        working_imag_buffer[173] <= imagpart_in[173]; 
        working_imag_buffer[174] <= imagpart_in[174]; 
        working_imag_buffer[175] <= imagpart_in[175]; 
        working_imag_buffer[176] <= imagpart_in[176]; 
        working_imag_buffer[177] <= imagpart_in[177]; 
        working_imag_buffer[178] <= imagpart_in[178]; 
        working_imag_buffer[179] <= imagpart_in[179]; 
        working_imag_buffer[180] <= imagpart_in[180]; 
        working_imag_buffer[181] <= imagpart_in[181]; 
        working_imag_buffer[182] <= imagpart_in[182]; 
        working_imag_buffer[183] <= imagpart_in[183]; 
        working_imag_buffer[184] <= imagpart_in[184]; 
        working_imag_buffer[185] <= imagpart_in[185]; 
        working_imag_buffer[186] <= imagpart_in[186]; 
        working_imag_buffer[187] <= imagpart_in[187]; 
        working_imag_buffer[188] <= imagpart_in[188]; 
        working_imag_buffer[189] <= imagpart_in[189]; 
        working_imag_buffer[190] <= imagpart_in[190]; 
        working_imag_buffer[191] <= imagpart_in[191]; 
        working_imag_buffer[192] <= imagpart_in[192]; 
        working_imag_buffer[193] <= imagpart_in[193]; 
        working_imag_buffer[194] <= imagpart_in[194]; 
        working_imag_buffer[195] <= imagpart_in[195]; 
        working_imag_buffer[196] <= imagpart_in[196]; 
        working_imag_buffer[197] <= imagpart_in[197]; 
        working_imag_buffer[198] <= imagpart_in[198]; 
        working_imag_buffer[199] <= imagpart_in[199]; 
        working_imag_buffer[200] <= imagpart_in[200]; 
        working_imag_buffer[201] <= imagpart_in[201]; 
        working_imag_buffer[202] <= imagpart_in[202]; 
        working_imag_buffer[203] <= imagpart_in[203]; 
        working_imag_buffer[204] <= imagpart_in[204]; 
        working_imag_buffer[205] <= imagpart_in[205]; 
        working_imag_buffer[206] <= imagpart_in[206]; 
        working_imag_buffer[207] <= imagpart_in[207]; 
        working_imag_buffer[208] <= imagpart_in[208]; 
        working_imag_buffer[209] <= imagpart_in[209]; 
        working_imag_buffer[210] <= imagpart_in[210]; 
        working_imag_buffer[211] <= imagpart_in[211]; 
        working_imag_buffer[212] <= imagpart_in[212]; 
        working_imag_buffer[213] <= imagpart_in[213]; 
        working_imag_buffer[214] <= imagpart_in[214]; 
        working_imag_buffer[215] <= imagpart_in[215]; 
        working_imag_buffer[216] <= imagpart_in[216]; 
        working_imag_buffer[217] <= imagpart_in[217]; 
        working_imag_buffer[218] <= imagpart_in[218]; 
        working_imag_buffer[219] <= imagpart_in[219]; 
        working_imag_buffer[220] <= imagpart_in[220]; 
        working_imag_buffer[221] <= imagpart_in[221]; 
        working_imag_buffer[222] <= imagpart_in[222]; 
        working_imag_buffer[223] <= imagpart_in[223]; 
        working_imag_buffer[224] <= imagpart_in[224]; 
        working_imag_buffer[225] <= imagpart_in[225]; 
        working_imag_buffer[226] <= imagpart_in[226]; 
        working_imag_buffer[227] <= imagpart_in[227]; 
        working_imag_buffer[228] <= imagpart_in[228]; 
        working_imag_buffer[229] <= imagpart_in[229]; 
        working_imag_buffer[230] <= imagpart_in[230]; 
        working_imag_buffer[231] <= imagpart_in[231]; 
        working_imag_buffer[232] <= imagpart_in[232]; 
        working_imag_buffer[233] <= imagpart_in[233]; 
        working_imag_buffer[234] <= imagpart_in[234]; 
        working_imag_buffer[235] <= imagpart_in[235]; 
        working_imag_buffer[236] <= imagpart_in[236]; 
        working_imag_buffer[237] <= imagpart_in[237]; 
        working_imag_buffer[238] <= imagpart_in[238]; 
        working_imag_buffer[239] <= imagpart_in[239]; 
        working_imag_buffer[240] <= imagpart_in[240]; 
        working_imag_buffer[241] <= imagpart_in[241]; 
        working_imag_buffer[242] <= imagpart_in[242]; 
        working_imag_buffer[243] <= imagpart_in[243]; 
        working_imag_buffer[244] <= imagpart_in[244]; 
        working_imag_buffer[245] <= imagpart_in[245]; 
        working_imag_buffer[246] <= imagpart_in[246]; 
        working_imag_buffer[247] <= imagpart_in[247]; 
        working_imag_buffer[248] <= imagpart_in[248]; 
        working_imag_buffer[249] <= imagpart_in[249]; 
        working_imag_buffer[250] <= imagpart_in[250]; 
        working_imag_buffer[251] <= imagpart_in[251]; 
        working_imag_buffer[252] <= imagpart_in[252]; 
        working_imag_buffer[253] <= imagpart_in[253]; 
        working_imag_buffer[254] <= imagpart_in[254]; 
        working_imag_buffer[255] <= imagin_255_1;
//        working_imag_buffer[254] <= {{8{imagin_255_1[19]}},imagin_255_1,2'b00};
//        working_real_buffer <= realpart_in;
//        working_imag_buffer <= imagpart_in;
    end else if (butterfly_en_result || butterfly_en_result_t)
    begin
    //Take data from butterfly
        working_real_buffer[output_from_butterfly_ad_0_test] <= output_from_butterfly_real[0];
        working_real_buffer[output_from_butterfly_ad_1_test] <= output_from_butterfly_real[1];
        working_real_buffer[output_from_butterfly_ad_2_test] <= output_from_butterfly_real[2];
        working_real_buffer[output_from_butterfly_ad_3_test] <= output_from_butterfly_real[3];
        working_real_buffer[output_from_butterfly_ad_4_test] <= output_from_butterfly_real[4];
        working_real_buffer[output_from_butterfly_ad_5_test] <= output_from_butterfly_real[5];
        working_real_buffer[output_from_butterfly_ad_6_test] <= output_from_butterfly_real[6];
        working_real_buffer[output_from_butterfly_ad_7_test] <= output_from_butterfly_real[7];
        
        working_imag_buffer[output_from_butterfly_ad_0_test] <= output_from_butterfly_imag[0];
        working_imag_buffer[output_from_butterfly_ad_1_test] <= output_from_butterfly_imag[1];
        working_imag_buffer[output_from_butterfly_ad_2_test] <= output_from_butterfly_imag[2];
        working_imag_buffer[output_from_butterfly_ad_3_test] <= output_from_butterfly_imag[3];
        working_imag_buffer[output_from_butterfly_ad_4_test] <= output_from_butterfly_imag[4];
        working_imag_buffer[output_from_butterfly_ad_5_test] <= output_from_butterfly_imag[5];
        working_imag_buffer[output_from_butterfly_ad_6_test] <= output_from_butterfly_imag[6];
        working_imag_buffer[output_from_butterfly_ad_7_test] <= output_from_butterfly_imag[7];
    end


end
always@(posedge clk) begin
    if (butterfly_output_flush ||  butterfly_en_output) begin
//    if (butterfly_en_output) begin
    // Data and Address to Butterfly
        input_to_butterfly_real[0] <=  working_real_buffer[butterfly_add_0]; 
        input_to_butterfly_real[1] <=  working_real_buffer[butterfly_add_1]; 
        input_to_butterfly_real[2] <=  working_real_buffer[butterfly_add_2]; 
        input_to_butterfly_real[3] <=  working_real_buffer[butterfly_add_3]; 
        input_to_butterfly_real[4] <=  working_real_buffer[butterfly_add_4]; 
        input_to_butterfly_real[5] <=  working_real_buffer[butterfly_add_5]; 
        input_to_butterfly_real[6] <=  working_real_buffer[butterfly_add_6]; 
        input_to_butterfly_real[7] <=  working_real_buffer[butterfly_add_7];


        input_to_butterfly_imag[0] <=  working_imag_buffer[butterfly_add_0]; 
        input_to_butterfly_imag[1] <=  working_imag_buffer[butterfly_add_1]; 
        input_to_butterfly_imag[2] <=  working_imag_buffer[butterfly_add_2]; 
        input_to_butterfly_imag[3] <=  working_imag_buffer[butterfly_add_3]; 
        input_to_butterfly_imag[4] <=  working_imag_buffer[butterfly_add_4]; 
        input_to_butterfly_imag[5] <=  working_imag_buffer[butterfly_add_5]; 
        input_to_butterfly_imag[6] <=  working_imag_buffer[butterfly_add_6]; 
        input_to_butterfly_imag[7] <=  working_imag_buffer[butterfly_add_7];

        input_to_butterfly_ad [0] <=  butterfly_add_0; 
        input_to_butterfly_ad [1] <=  butterfly_add_1; 
        input_to_butterfly_ad [2] <=  butterfly_add_2; 
        input_to_butterfly_ad [3] <=  butterfly_add_3; 
        input_to_butterfly_ad [4] <=  butterfly_add_4; 
        input_to_butterfly_ad [5] <=  butterfly_add_5; 
        input_to_butterfly_ad [6] <=  butterfly_add_6; 
        input_to_butterfly_ad [7] <=  butterfly_add_7;
    end else begin
    // Data and Address to Butterfly
        input_to_butterfly_real[0] <= working_real_buffer[124]; 
        input_to_butterfly_real[1] <= working_real_buffer[252]; 
        input_to_butterfly_real[2] <= working_real_buffer[125]; 
        input_to_butterfly_real[3] <= working_real_buffer[253]; 
        input_to_butterfly_real[4] <= working_real_buffer[126]; 
        input_to_butterfly_real[5] <= working_real_buffer[254]; 
        input_to_butterfly_real[6] <= working_real_buffer[127]; 
        input_to_butterfly_real[7] <= working_real_buffer[255];

        input_to_butterfly_imag[0] <= working_imag_buffer[124]; 
        input_to_butterfly_imag[1] <= working_imag_buffer[252]; 
        input_to_butterfly_imag[2] <= working_imag_buffer[125]; 
        input_to_butterfly_imag[3] <= working_imag_buffer[253]; 
        input_to_butterfly_imag[4] <= working_imag_buffer[126]; 
        input_to_butterfly_imag[5] <= working_imag_buffer[254]; 
        input_to_butterfly_imag[6] <= working_imag_buffer[127]; 
        input_to_butterfly_imag[7] <= working_imag_buffer[255];

        input_to_butterfly_ad [0] <= 124; 
        input_to_butterfly_ad [1] <= 252; 
        input_to_butterfly_ad [2] <= 125; 
        input_to_butterfly_ad [3] <= 253; 
        input_to_butterfly_ad [4] <= 126; 
        input_to_butterfly_ad [5] <= 254; 
        input_to_butterfly_ad [6] <= 127; 
        input_to_butterfly_ad [7] <= 255;

    end


end

always@(posedge clk) begin
	
	if (reset) begin	output_startin<=0; output_startin2<=0;output_startin3<=0;output_startin4<=0; output_startin5<=0;   end
	else begin	output_startin<=output_startin5;output_startin5<=output_startin4; output_startin4<=output_startin3;output_startin3<=output_startin2; output_startin2<=output_startin1; end end


always @(posedge clk or posedge reset)
begin
    if (reset) begin
        en <= 0;
        count <= 0;
        level <= 0; //TO DO: SET to 0
        level_2 <= 0;
//rak        butterfly_output_flush <= 0;
        butterfly_en_output <= 0;
        butterfly_en_result_t <= 0; 
        output_startin1 <= 0;
    end else begin
    case (present_state)
        IDLE:
        begin
        en <= en;
        count <= count;
        level <= level;
        level_2 <= level_2;
//rak        butterfly_output_flush <= butterfly_output_flush;
        butterfly_en_output <= butterfly_en_output;
        butterfly_en_result_t <= butterfly_en_result_t; 
        output_startin1 <= output_startin1;
        //Eakta: Reset al values of working Buffer
        end
        START:
        begin
            if (start_flush)
            begin
                en <= 1;
                count <= 0;
                level <= 1;
                level_2 <= 0;
            end else begin
  //rak             if (en == 1 && count == 0) butterfly_output_flush <= 1; //Startin to Butterfly
  //rak              else butterfly_output_flush <= 0;
        
                count <= count +1;
//                if (count != 0 && count % 32 == 0) level_2 <= level_2+1;
                if (count == 31 || count == 63 || count == 95 || count == 127 || count == 159 || count == 191 || count ==  223 ) level <= level +1; //To generate Level
                if (count == 255) en <= 0;
            end 
      
            if (butterfly_output_flush) butterfly_en_output <= 1; // Signals to Butterfly for reading data from Data Buffer
            else if (count == 255) butterfly_en_output <= 0;
            else butterfly_en_output <= butterfly_en_output;

            if (butterfly_input_flush)
            begin
               butterfly_en_result_t <= 1; 
               output_startin1 <= 0;
            end
            else if (count == 223) 
            begin
                butterfly_en_result_t <= 0;
                output_startin1 <= 1;
            end
            else begin
                    butterfly_en_result_t <= butterfly_en_result_t;
                    output_startin1 <= 0;
            end

         
//            $display ("%d: %d %d %d %d %d %d %d %d",$time, butterfly_add_0, butterfly_add_1, butterfly_add_2, butterfly_add_3, butterfly_add_4, butterfly_add_5, butterfly_add_6, butterfly_add_7);

//            //Recirculating logic for Butterfly
//            case (level_state)
//                STAGE_0:
//                begin
//                    if (butterfly_level_counter == 0) 
//                    begin
//                        butterfly_add_0 <= 8'd0;
//                        butterfly_add_1 <= 8'd1;
//                        butterfly_add_2 <= 8'd2;
//                        butterfly_add_3 <= 8'd3;
//                        butterfly_add_4 <= 8'd4;
//                        butterfly_add_5 <= 8'd5;
//                        butterfly_add_6 <= 8'd6;
//                        butterfly_add_7 <= 8'd7;
//                    end else begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd8;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd8;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd8;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd8;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd8;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd8;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd8;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd8;
//                    end
//
//
//                end
//                STAGE_1:
//                 begin
//                    if (butterfly_level_counter == 0) 
//                    begin
//                        butterfly_add_0 <= 8'd0;
//                        butterfly_add_1 <= 8'd2;
//                        butterfly_add_2 <= 8'd1;
//                        butterfly_add_3 <= 8'd3;
//                        butterfly_add_4 <= 8'd4;
//                        butterfly_add_5 <= 8'd6;
//                        butterfly_add_6 <= 8'd5;
//                        butterfly_add_7 <= 8'd7;
//                    end else begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd8;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd8;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd8;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd8;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd8;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd8;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd8;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd8;
//                    end
//                end 
//                STAGE_2:
//                begin
//                    if (butterfly_level_counter == 0)
//                    begin
//                        butterfly_add_0 <= 8'd0;
//                        butterfly_add_1 <= 8'd4;
//                        butterfly_add_2 <= 8'd1;
//                        butterfly_add_3 <= 8'd5;
//                        butterfly_add_4 <= 8'd2;
//                        butterfly_add_5 <= 8'd6;
//                        butterfly_add_6 <= 8'd3;
//                        butterfly_add_7 <= 8'd7;
//                    end else 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd8;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd8;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd8;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd8;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd8;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd8;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd8;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd8;
//                    end 
//                end 
//                STAGE_3:
//                begin
//                    if (butterfly_level_counter == 0)
//                    begin
//                        butterfly_add_0 <= 8'd0;
//                        butterfly_add_1 <= 8'd8;
//                        butterfly_add_2 <= 8'd1;
//                        butterfly_add_3 <= 8'd9;
//                        butterfly_add_4 <= 8'd2;
//                        butterfly_add_5 <= 8'd10;
//                        butterfly_add_6 <= 8'd3;
//                        butterfly_add_7 <= 8'd11;
//                    end else if (butterfly_level_counter % 2 == 0) 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd12;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd12;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd12;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd12;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd12;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd12;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd12;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd12;
//                    end else 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd4;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd4;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd4;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd4;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd4;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd4;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd4;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd4;
//                    end 
//                end 
//                STAGE_4:
//                begin
//                    if (butterfly_level_counter == 0)
//                    begin
//                        butterfly_add_0 <= 8'd0;
//                        butterfly_add_1 <= 8'd16;
//                        butterfly_add_2 <= 8'd1;
//                        butterfly_add_3 <= 8'd17;
//                        butterfly_add_4 <= 8'd2;
//                        butterfly_add_5 <= 8'd18;
//                        butterfly_add_6 <= 8'd3;
//                        butterfly_add_7 <= 8'd19;
//                    end else if (butterfly_level_counter % 4 == 0) 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd20;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd20;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd20;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd20;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd20;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd20;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd20;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd20;
//                    end else 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd4;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd4;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd4;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd4;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd4;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd4;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd4;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd4;
//                    end 
//                end 
//                STAGE_5:
//                begin
//                    if (butterfly_level_counter == 0)
//                    begin
//                        butterfly_add_0 <= 8'd0;
//                        butterfly_add_1 <= 8'd32;
//                        butterfly_add_2 <= 8'd1;
//                        butterfly_add_3 <= 8'd33;
//                        butterfly_add_4 <= 8'd2;
//                        butterfly_add_5 <= 8'd34;
//                        butterfly_add_6 <= 8'd3;
//                        butterfly_add_7 <= 8'd35;
//                    end else if (butterfly_level_counter % 8 == 0) 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd36;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd36;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd36;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd36;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd36;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd36;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd36;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd36;
//                    end else 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd4;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd4;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd4;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd4;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd4;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd4;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd4;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd4;
//                    end 
//                end 
//                STAGE_6:
//                begin
//                    if (butterfly_level_counter == 0)
//                    begin
//                        butterfly_add_0 <= 8'd0;
//                        butterfly_add_1 <= 8'd64;
//                        butterfly_add_2 <= 8'd1;
//                        butterfly_add_3 <= 8'd65;
//                        butterfly_add_4 <= 8'd2;
//                        butterfly_add_5 <= 8'd66;
//                        butterfly_add_6 <= 8'd3;
//                        butterfly_add_7 <= 8'd67;
//                    end else if (butterfly_level_counter % 16 == 0) 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd68;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd68;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd68;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd68;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd68;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd68;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd68;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd68;
//                    end else 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd4;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd4;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd4;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd4;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd4;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd4;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd4;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd4;
//                    end 
//                end 
//                STAGE_7:
//
//                begin
//                    if (butterfly_level_counter == 0)
//                    begin
//                        butterfly_add_0 <= 8'd0;
//                        butterfly_add_1 <= 8'd128;
//                        butterfly_add_2 <= 8'd1;
//                        butterfly_add_3 <= 8'd129;
//                        butterfly_add_4 <= 8'd2;
//                        butterfly_add_5 <= 8'd130;
//                        butterfly_add_6 <= 8'd3;
//                        butterfly_add_7 <= 8'd131;
//                    end else 
//                    begin
//                        butterfly_add_0 <= butterfly_add_0 + 8'd4;
//                        butterfly_add_1 <= butterfly_add_1 + 8'd4;
//                        butterfly_add_2 <= butterfly_add_2 + 8'd4;
//                        butterfly_add_3 <= butterfly_add_3 + 8'd4;
//                        butterfly_add_4 <= butterfly_add_4 + 8'd4;
//                        butterfly_add_5 <= butterfly_add_5 + 8'd4;
//                        butterfly_add_6 <= butterfly_add_6 + 8'd4;
//                        butterfly_add_7 <= butterfly_add_7 + 8'd4;
//                    end 
//                end
//                B_IDLE:
//                begin
//                    butterfly_add_0 <= 8'd0;
//                    butterfly_add_1 <= 8'd0;
//                    butterfly_add_2 <= 8'd0;
//                    butterfly_add_3 <= 8'd0;
//                    butterfly_add_4 <= 8'd0;
//                    butterfly_add_5 <= 8'd0;
//                    butterfly_add_6 <= 8'd0;
//                    butterfly_add_7 <= 8'd0;
//
//                end
//    endcase
            
    end    
    default:
    begin
    end
        endcase
    end
end

////**Debug Logic**/
//
//always @(butterfly_level_counter)
//begin
//    $display ("%d: %d %d %d %d %d %d %d %d",level, butterfly_add_0, butterfly_add_1, butterfly_add_2, butterfly_add_3, butterfly_add_4, butterfly_add_5, butterfly_add_6, butterfly_add_7);
//
//end
//**

/***DEBUG Transfer of real_buffer ****/
always @(posedge start_flush)
begin
//    for (int i = 0; i<= 255 ; i = i+1)
//    begin
//        $display ("%d %h ",i, working_real_buffer[i]);
//    end
//#11
//        $display ("DE_2 %d: 0 %h %h %b",    $time, realpart_in[0], working_real_buffer[0], (realpart_in[0]^working_real_buffer[0]));
//        $display ("DE_2 %d: 128 %h %h %b",  $time, realpart_in[128], working_real_buffer[128],( realpart_in[128]^working_real_buffer[128]));
//        $display ("DE_2 %d: 64 %h %h %b",   $time, realpart_in[64], working_real_buffer[64], (realpart_in[64]^working_real_buffer[64]));
//        $display ("DE_2 %d: 92 %h %h %b",   $time, realpart_in[92], working_real_buffer[92], (realpart_in[92]^working_real_buffer[92]));
//        $display ("DE_2 %d: 32 %h %h %b",   $time, realpart_in[32], working_real_buffer[32], (realpart_in[32]^working_real_buffer[32]));
//        $display ("DE_2 %d: 255 %h %h %b",   $time, realin_255_1, working_real_buffer[255], (realin_255_1^working_real_buffer[255]));
end
always @(posedge clk or posedge reset) begin
	if (reset) butterfly_output_flush<=0;
	else if (start_flush) butterfly_output_flush<=1;
//	else if (count==255) butterfly_output_flush<=0;
        else butterfly_output_flush<=0;
end
always @(posedge clk or posedge reset) begin
	if (reset) begin butterfly_en_result<=0; butterfly_en_result1<=0; butterfly_en_result2<=0; butterfly_en_result3<=0; butterfly_en_result4<=0; butterfly_en_result5<=0;  end
	else begin  butterfly_en_result<= butterfly_en_result5; butterfly_en_result5<= butterfly_en_result4; butterfly_en_result4<= butterfly_en_result3;  butterfly_en_result3<= butterfly_en_result2; butterfly_en_result2<= butterfly_en_result1;butterfly_en_result1<= butterfly_en_result_t;  end
end

always @(*) begin
	if (count==0 || count==1) begin
output_from_butterfly_ad_0_test=8'd0;
output_from_butterfly_ad_1_test=8'd1;
output_from_butterfly_ad_2_test=8'd2;
output_from_butterfly_ad_3_test=8'd3;
output_from_butterfly_ad_4_test=8'd4;
output_from_butterfly_ad_5_test=8'd5;
output_from_butterfly_ad_6_test=8'd6;
output_from_butterfly_ad_7_test=8'd7; end
else begin
output_from_butterfly_ad_0_test=output_from_butterfly_ad_0;
output_from_butterfly_ad_1_test=output_from_butterfly_ad_1;
output_from_butterfly_ad_2_test=output_from_butterfly_ad_2;
output_from_butterfly_ad_3_test=output_from_butterfly_ad_3;
output_from_butterfly_ad_4_test=output_from_butterfly_ad_4;
output_from_butterfly_ad_5_test=output_from_butterfly_ad_5;
output_from_butterfly_ad_6_test=output_from_butterfly_ad_6;
output_from_butterfly_ad_7_test=output_from_butterfly_ad_7;
end
end

























endmodule
