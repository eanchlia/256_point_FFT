module input_buffer( realpart, imagpart, flush, realin, imagin, clk, reset, startin);
parameter totalbits = 30;
parameter total_in_bits = 20;
output reg signed [totalbits-1:0] realpart [254:0];
output reg signed [totalbits-1:0] imagpart [254:0];
reg flush_data;
input signed [total_in_bits-1:0] realin,  imagin;
input clk, reset, startin;
output flush;

reg [7:0] count, data_input_pos;
reg [1:0] present_state;

parameter IDLE  = 2'b00,
          RESET = 2'b01,
          START = 2'b10;
reg en;

bit_reversal BIT_REV (
    .bit_reversed_out (data_input_pos),
    .in_position(count)
);


always@(posedge clk or posedge reset) begin
if (reset) en<=0;
else if (startin==1) en<=1;
else if (count==255) en<=0;
else en<=en;
end

assign flush = (count == 8'd255) ? 1 : 0;
//always @(posedge clk or posedge reset)
always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
//        en <= 0;
        count <= 0;
        flush_data <= 0;
    end else if (startin == 1)
    begin
//        en <= 1;
        count <= count + 1;
    end
    else if (en) begin
        count <= count + 1;
    end
end

always @(*)
begin
    if (reset)
    begin
        present_state = RESET;
    end else if (startin == 1 | en == 1)
    begin
        present_state = START;
    end
    else
        present_state = IDLE;
end

//always @(posedge clk )// Fluch comes after 255 data, ie first data of new set 
always @(posedge clk or posedge reset)
begin
    if (reset) begin
        //do something 
    end
    else if (count == 255) 
        begin
 //           en <=0;
            flush_data <=1; 
        end
    else flush_data <= 0;
end

//always @(posedge clk or posedge reset) 
always @(posedge clk or posedge reset ) 
begin
    if (reset)
    begin
        //DO Something
    end
    else 
    begin
    case (present_state)
        START:
        begin
            realpart[data_input_pos] <= {{8{realin[19]}},realin,2'b00};
            imagpart[data_input_pos] <= {{8{imagin[19]}},imagin,2'b00};
        end
        RESET:
        begin
            realpart[0] <= 0;   imagpart[0] <= 0;   
            realpart[1] <= 0;   imagpart[1] <= 0;
            realpart[2] <= 0;   imagpart[2] <= 0;
            realpart[3] <= 0;   imagpart[3] <= 0;
            realpart[4] <= 0;   imagpart[4] <= 0;
            realpart[5] <= 0;   imagpart[5] <= 0;
            realpart[6] <= 0;   imagpart[6] <= 0;
            realpart[7] <= 0;   imagpart[7] <= 0;
            realpart[8] <= 0;   imagpart[8] <= 0;
            realpart[9] <= 0;   imagpart[9] <= 0;
            realpart[10] <= 0;  imagpart[10] <= 0;
            realpart[11] <= 0;  imagpart[11] <= 0;
            realpart[12] <= 0;  imagpart[12] <= 0;
            realpart[13] <= 0;  imagpart[13] <= 0;
            realpart[14] <= 0;  imagpart[14] <= 0;
            realpart[15] <= 0;  imagpart[15] <= 0;
            realpart[16] <= 0;  imagpart[16] <= 0;
            realpart[17] <= 0;  imagpart[17] <= 0;
            realpart[18] <= 0;  imagpart[18] <= 0;
            realpart[19] <= 0;  imagpart[19] <= 0;
            realpart[20] <= 0;  imagpart[20] <= 0;
            realpart[21] <= 0;  imagpart[21] <= 0;
            realpart[22] <= 0;  imagpart[22] <= 0;
            realpart[23] <= 0;  imagpart[23] <= 0;
            realpart[24] <= 0;  imagpart[24] <= 0;
            realpart[25] <= 0;  imagpart[25] <= 0;
            realpart[26] <= 0;  imagpart[26] <= 0;
            realpart[27] <= 0;  imagpart[27] <= 0;
            realpart[28] <= 0;  imagpart[28] <= 0;
            realpart[29] <= 0;  imagpart[29] <= 0;
            realpart[30] <= 0;  imagpart[30] <= 0;
            realpart[31] <= 0;  imagpart[31] <= 0;
            realpart[32] <= 0;  imagpart[32] <= 0;
            realpart[33] <= 0;  imagpart[33] <= 0;
            realpart[34] <= 0;  imagpart[34] <= 0;
            realpart[35] <= 0;  imagpart[35] <= 0;
            realpart[36] <= 0;  imagpart[36] <= 0;
            realpart[37] <= 0;  imagpart[37] <= 0;
            realpart[38] <= 0;  imagpart[38] <= 0;
            realpart[39] <= 0;  imagpart[39] <= 0;
            realpart[40] <= 0;  imagpart[40] <= 0;
            realpart[41] <= 0;  imagpart[41] <= 0;
            realpart[42] <= 0;  imagpart[42] <= 0;
            realpart[43] <= 0;  imagpart[43] <= 0;
            realpart[44] <= 0;  imagpart[44] <= 0;
            realpart[45] <= 0;  imagpart[45] <= 0;
            realpart[46] <= 0;  imagpart[46] <= 0;
            realpart[47] <= 0;  imagpart[47] <= 0;
            realpart[48] <= 0;  imagpart[48] <= 0;
            realpart[49] <= 0;  imagpart[49] <= 0;
            realpart[50] <= 0;  imagpart[50] <= 0;
            realpart[51] <= 0;  imagpart[51] <= 0;
            realpart[52] <= 0;  imagpart[52] <= 0;
            realpart[53] <= 0;  imagpart[53] <= 0;
            realpart[54] <= 0;  imagpart[54] <= 0;
            realpart[55] <= 0;  imagpart[55] <= 0;
            realpart[56] <= 0;  imagpart[56] <= 0;
            realpart[57] <= 0;  imagpart[57] <= 0;
            realpart[58] <= 0;  imagpart[58] <= 0;
            realpart[59] <= 0;  imagpart[59] <= 0;
            realpart[60] <= 0;  imagpart[60] <= 0;
            realpart[61] <= 0;  imagpart[61] <= 0;
            realpart[62] <= 0;  imagpart[62] <= 0;
            realpart[63] <= 0;  imagpart[63] <= 0;
            realpart[64] <= 0;  imagpart[64] <= 0;
            realpart[65] <= 0;  imagpart[65] <= 0;
            realpart[66] <= 0;  imagpart[66] <= 0;
            realpart[67] <= 0;  imagpart[67] <= 0;
            realpart[68] <= 0;  imagpart[68] <= 0;
            realpart[69] <= 0;  imagpart[69] <= 0;
            realpart[70] <= 0;  imagpart[70] <= 0;
            realpart[71] <= 0;  imagpart[71] <= 0;
            realpart[72] <= 0;  imagpart[72] <= 0;
            realpart[73] <= 0;  imagpart[73] <= 0;
            realpart[74] <= 0;  imagpart[74] <= 0;
            realpart[75] <= 0;  imagpart[75] <= 0;
            realpart[76] <= 0;  imagpart[76] <= 0;
            realpart[77] <= 0;  imagpart[77] <= 0;
            realpart[78] <= 0;  imagpart[78] <= 0;
            realpart[79] <= 0;  imagpart[79] <= 0;
            realpart[80] <= 0;  imagpart[80] <= 0;
            realpart[81] <= 0;  imagpart[81] <= 0;
            realpart[82] <= 0;  imagpart[82] <= 0;
            realpart[83] <= 0;  imagpart[83] <= 0;
            realpart[84] <= 0;  imagpart[84] <= 0;
            realpart[85] <= 0;  imagpart[85] <= 0;
            realpart[86] <= 0;  imagpart[86] <= 0;
            realpart[87] <= 0;  imagpart[87] <= 0;
            realpart[88] <= 0;  imagpart[88] <= 0;
            realpart[89] <= 0;  imagpart[89] <= 0;
            realpart[90] <= 0;  imagpart[90] <= 0;
            realpart[91] <= 0;  imagpart[91] <= 0;
            realpart[92] <= 0;  imagpart[92] <= 0;
            realpart[93] <= 0;  imagpart[93] <= 0;
            realpart[94] <= 0;  imagpart[94] <= 0;
            realpart[95] <= 0;  imagpart[95] <= 0;
            realpart[96] <= 0;  imagpart[96] <= 0;
            realpart[97] <= 0;  imagpart[97] <= 0;
            realpart[98] <= 0;  imagpart[98] <= 0;
            realpart[99] <= 0;  imagpart[99] <= 0;
            realpart[100] <= 0; imagpart[100] <= 0;
            realpart[101] <= 0; imagpart[101] <= 0;
            realpart[102] <= 0; imagpart[102] <= 0;
            realpart[103] <= 0; imagpart[103] <= 0;
            realpart[104] <= 0; imagpart[104] <= 0;
            realpart[105] <= 0; imagpart[105] <= 0;
            realpart[106] <= 0; imagpart[106] <= 0;
            realpart[107] <= 0; imagpart[107] <= 0;
            realpart[108] <= 0; imagpart[108] <= 0;
            realpart[109] <= 0; imagpart[109] <= 0;
            realpart[110] <= 0; imagpart[110] <= 0;
            realpart[111] <= 0; imagpart[111] <= 0;
            realpart[112] <= 0; imagpart[112] <= 0;
            realpart[113] <= 0; imagpart[113] <= 0;
            realpart[114] <= 0; imagpart[114] <= 0;
            realpart[115] <= 0; imagpart[115] <= 0;
            realpart[116] <= 0; imagpart[116] <= 0;
            realpart[117] <= 0; imagpart[117] <= 0;
            realpart[118] <= 0; imagpart[118] <= 0;
            realpart[119] <= 0; imagpart[119] <= 0;
            realpart[120] <= 0; imagpart[120] <= 0;
            realpart[121] <= 0; imagpart[121] <= 0;
            realpart[122] <= 0; imagpart[122] <= 0;
            realpart[123] <= 0; imagpart[123] <= 0;
            realpart[124] <= 0; imagpart[124] <= 0;
            realpart[125] <= 0; imagpart[125] <= 0;
            realpart[126] <= 0; imagpart[126] <= 0;
            realpart[127] <= 0; imagpart[127] <= 0;
            realpart[128] <= 0; imagpart[128] <= 0;
            realpart[129] <= 0; imagpart[129] <= 0;
            realpart[130] <= 0; imagpart[130] <= 0;
            realpart[131] <= 0; imagpart[131] <= 0;
            realpart[132] <= 0; imagpart[132] <= 0;
            realpart[133] <= 0; imagpart[133] <= 0;
            realpart[134] <= 0; imagpart[134] <= 0;
            realpart[135] <= 0; imagpart[135] <= 0;
            realpart[136] <= 0; imagpart[136] <= 0;
            realpart[137] <= 0; imagpart[137] <= 0;
            realpart[138] <= 0; imagpart[138] <= 0;
            realpart[139] <= 0; imagpart[139] <= 0;
            realpart[140] <= 0; imagpart[140] <= 0;
            realpart[141] <= 0; imagpart[141] <= 0;
            realpart[142] <= 0; imagpart[142] <= 0;
            realpart[143] <= 0; imagpart[143] <= 0;
            realpart[144] <= 0; imagpart[144] <= 0;
            realpart[145] <= 0; imagpart[145] <= 0;
            realpart[146] <= 0; imagpart[146] <= 0;
            realpart[147] <= 0; imagpart[147] <= 0;
            realpart[148] <= 0; imagpart[148] <= 0;
            realpart[149] <= 0; imagpart[149] <= 0;
            realpart[150] <= 0; imagpart[150] <= 0;
            realpart[151] <= 0; imagpart[151] <= 0;
            realpart[152] <= 0; imagpart[152] <= 0;
            realpart[153] <= 0; imagpart[153] <= 0;
            realpart[154] <= 0; imagpart[154] <= 0;
            realpart[155] <= 0; imagpart[155] <= 0;
            realpart[156] <= 0; imagpart[156] <= 0;
            realpart[157] <= 0; imagpart[157] <= 0;
            realpart[158] <= 0; imagpart[158] <= 0;
            realpart[159] <= 0; imagpart[159] <= 0;
            realpart[160] <= 0; imagpart[160] <= 0;
            realpart[161] <= 0; imagpart[161] <= 0;
            realpart[162] <= 0; imagpart[162] <= 0;
            realpart[163] <= 0; imagpart[163] <= 0;
            realpart[164] <= 0; imagpart[164] <= 0;
            realpart[165] <= 0; imagpart[165] <= 0;
            realpart[166] <= 0; imagpart[166] <= 0;
            realpart[167] <= 0; imagpart[167] <= 0;
            realpart[168] <= 0; imagpart[168] <= 0;
            realpart[169] <= 0; imagpart[169] <= 0;
            realpart[170] <= 0; imagpart[170] <= 0;
            realpart[171] <= 0; imagpart[171] <= 0;
            realpart[172] <= 0; imagpart[172] <= 0;
            realpart[173] <= 0; imagpart[173] <= 0;
            realpart[174] <= 0; imagpart[174] <= 0;
            realpart[175] <= 0; imagpart[175] <= 0;
            realpart[176] <= 0; imagpart[176] <= 0;
            realpart[177] <= 0; imagpart[177] <= 0;
            realpart[178] <= 0; imagpart[178] <= 0;
            realpart[179] <= 0; imagpart[179] <= 0;
            realpart[180] <= 0; imagpart[180] <= 0;
            realpart[181] <= 0; imagpart[181] <= 0;
            realpart[182] <= 0; imagpart[182] <= 0;
            realpart[183] <= 0; imagpart[183] <= 0;
            realpart[184] <= 0; imagpart[184] <= 0;
            realpart[185] <= 0; imagpart[185] <= 0;
            realpart[186] <= 0; imagpart[186] <= 0;
            realpart[187] <= 0; imagpart[187] <= 0;
            realpart[188] <= 0; imagpart[188] <= 0;
            realpart[189] <= 0; imagpart[189] <= 0;
            realpart[190] <= 0; imagpart[190] <= 0;
            realpart[191] <= 0; imagpart[191] <= 0;
            realpart[192] <= 0; imagpart[192] <= 0;
            realpart[193] <= 0; imagpart[193] <= 0;
            realpart[194] <= 0; imagpart[194] <= 0;
            realpart[195] <= 0; imagpart[195] <= 0;
            realpart[196] <= 0; imagpart[196] <= 0;
            realpart[197] <= 0; imagpart[197] <= 0;
            realpart[198] <= 0; imagpart[198] <= 0;
            realpart[199] <= 0; imagpart[199] <= 0;
            realpart[200] <= 0; imagpart[200] <= 0;
            realpart[201] <= 0; imagpart[201] <= 0;
            realpart[202] <= 0; imagpart[202] <= 0;
            realpart[203] <= 0; imagpart[203] <= 0;
            realpart[204] <= 0; imagpart[204] <= 0;
            realpart[205] <= 0; imagpart[205] <= 0;
            realpart[206] <= 0; imagpart[206] <= 0;
            realpart[207] <= 0; imagpart[207] <= 0;
            realpart[208] <= 0; imagpart[208] <= 0;
            realpart[209] <= 0; imagpart[209] <= 0;
            realpart[210] <= 0; imagpart[210] <= 0;
            realpart[211] <= 0; imagpart[211] <= 0;
            realpart[212] <= 0; imagpart[212] <= 0;
            realpart[213] <= 0; imagpart[213] <= 0;
            realpart[214] <= 0; imagpart[214] <= 0;
            realpart[215] <= 0; imagpart[215] <= 0;
            realpart[216] <= 0; imagpart[216] <= 0;
            realpart[217] <= 0; imagpart[217] <= 0;
            realpart[218] <= 0; imagpart[218] <= 0;
            realpart[219] <= 0; imagpart[219] <= 0;
            realpart[220] <= 0; imagpart[220] <= 0;
            realpart[221] <= 0; imagpart[221] <= 0;
            realpart[222] <= 0; imagpart[222] <= 0;
            realpart[223] <= 0; imagpart[223] <= 0;
            realpart[224] <= 0; imagpart[224] <= 0;
            realpart[225] <= 0; imagpart[225] <= 0;
            realpart[226] <= 0; imagpart[226] <= 0;
            realpart[227] <= 0; imagpart[227] <= 0;
            realpart[228] <= 0; imagpart[228] <= 0;
            realpart[229] <= 0; imagpart[229] <= 0;
            realpart[230] <= 0; imagpart[230] <= 0;
            realpart[231] <= 0; imagpart[231] <= 0;
            realpart[232] <= 0; imagpart[232] <= 0;
            realpart[233] <= 0; imagpart[233] <= 0;
            realpart[234] <= 0; imagpart[234] <= 0;
            realpart[235] <= 0; imagpart[235] <= 0;
            realpart[236] <= 0; imagpart[236] <= 0;
            realpart[237] <= 0; imagpart[237] <= 0;
            realpart[238] <= 0; imagpart[238] <= 0;
            realpart[239] <= 0; imagpart[239] <= 0;
            realpart[240] <= 0; imagpart[240] <= 0;
            realpart[241] <= 0; imagpart[241] <= 0;
            realpart[242] <= 0; imagpart[242] <= 0;
            realpart[243] <= 0; imagpart[243] <= 0;
            realpart[244] <= 0; imagpart[244] <= 0;
            realpart[245] <= 0; imagpart[245] <= 0;
            realpart[246] <= 0; imagpart[246] <= 0;
            realpart[247] <= 0; imagpart[247] <= 0;
            realpart[248] <= 0; imagpart[248] <= 0;
            realpart[249] <= 0; imagpart[249] <= 0;
            realpart[250] <= 0; imagpart[250] <= 0;
            realpart[251] <= 0; imagpart[251] <= 0;
            realpart[252] <= 0; imagpart[252] <= 0;
            realpart[253] <= 0; imagpart[253] <= 0;
            realpart[254] <= 0; imagpart[254] <= 0;
 //           realpart[255] <= 0; imagpart[255] <= 0;
        end
    endcase
end
end
endmodule

module bit_reversal (
    output reg [7:0] bit_reversed_out,
    input [7:0] in_position
);
assign bit_reversed_out[0] = in_position[7];
assign bit_reversed_out[1] = in_position[6];
assign bit_reversed_out[2] = in_position[5];
assign bit_reversed_out[3] = in_position[4];
assign bit_reversed_out[4] = in_position[3];
assign bit_reversed_out[5] = in_position[2];
assign bit_reversed_out[6] = in_position[1];
assign bit_reversed_out[7] = in_position[0];
endmodule

