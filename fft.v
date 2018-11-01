`include "input_buffer.v"
`include "data_buffer.v"
`include "twiddle_handle.v"
`include "butterfly_dw02/butterfly_4.v"
`include "butterfly_dw02/butterfly.v"
`include "butterfly_dw02/complex_mul.v"
`include "butterfly_dw02/mul.v"
//`include "butterfly_dw02/DW02_mult_3_stage.v"
`include "butterfly_dw02/roundoff.v"
`include "butterfly_dw02/3stagepipe_data.v"
`include "butterfly_dw02/2stagepipe_data.v"
`include "butterfly_dw02/3stagepipe_address.v"
`include "butterfly_dw02/3stagepipe.v"

`include "output_buffer.v"
module fft (
    input clk,reset,
    input [19:0] realin,imagin,
    input startin,
    output reg [19:0] realout,imagout,
    output reg startout);

parameter totalbits=30;
reg signed [totalbits-1:0] realbuffer [254:0];
reg signed [totalbits-1:0] imagbuffer [254:0];
reg signed [totalbits-1:0] butterfly_result_realpart [7:0]; 
reg signed [totalbits-1:0] butterfly_result_imagpart [7:0];
reg [7:0] butterfly_result_ad_0, butterfly_result_ad_1, butterfly_result_ad_2, butterfly_result_ad_3, butterfly_result_ad_4, butterfly_result_ad_5, butterfly_result_ad_6, butterfly_result_ad_7;
reg signed [7:0] butterfly_result_ad [7:0];
reg signed [totalbits-1:0] butterfly_input_realpart [7:0]; 
reg signed [totalbits-1:0] butterfly_input_imagpart [7:0];
reg [7:0] butterfly_input_ad [7:0];
reg signed butterfly_start_signal;
reg [7:0] level;
wire flush_data_from_in_buf;
reg output_startin;
reg butterfly_startin, butterfly_ready;
reg signed [totalbits-1:0]twiddle_real3,twiddle_real2,twiddle_real1,twiddle_real0,twiddle_imag3,twiddle_imag2,twiddle_imag1,twiddle_imag0;

input_buffer IN_BUF ( realbuffer, imagbuffer,flush_data_from_in_buf, realin, imagin, clk, reset, startin) ;

data_buffer DAT_BUF (
    .input_to_butterfly_real    (butterfly_input_realpart),
    .input_to_butterfly_imag    (butterfly_input_imagpart),
    .input_to_butterfly_ad      (butterfly_input_ad),
    .butterfly_output_flush     (butterfly_startin),
    .output_startin             (output_startin),
    .realpart_in                (realbuffer),
    .imagpart_in                (imagbuffer),
    .realin_255                 (realin),
    .imagin_255                 (imagin),
    .output_from_butterfly_real (butterfly_result_realpart),
    .output_from_butterfly_imag (butterfly_result_imagpart),
    .output_from_butterfly_ad_0 (butterfly_result_ad_0),
    .output_from_butterfly_ad_1 (butterfly_result_ad_1),
    .output_from_butterfly_ad_2 (butterfly_result_ad_2),
    .output_from_butterfly_ad_3 (butterfly_result_ad_3),
    .output_from_butterfly_ad_4 (butterfly_result_ad_4),
    .output_from_butterfly_ad_5 (butterfly_result_ad_5),
    .output_from_butterfly_ad_6 (butterfly_result_ad_6),
    .output_from_butterfly_ad_7 (butterfly_result_ad_7),
    .butterfly_input_flush      (butterfly_ready),
    .clk                        (clk),
    .reset                      (reset),
    .start_flush                (flush_data_from_in_buf)
);

//data_buffer DATA_BUF (butterfly_input_realpart, butterfly_input_imagpart, butterfly_input_ad, butterfly_startin, output_startin, realbuffer, imagbuffer, realin, imagin, butterfly_result_realpart, butterfly_result_imagpart, butterfly_result_ad_0, butterfly_result_ad_1, butterfly_result_ad_2, butterfly_result_ad_3, butterfly_result_ad_4, butterfly_result_ad_5, butterfly_result_ad_6, butterfly_result_ad_7, butterfly_ready, clk, reset, flush_data_from_in_buf);

twiddle_engine TWIDDLE (twiddle_real3, twiddle_real2, twiddle_real1, twiddle_real0, twiddle_imag3, twiddle_imag2, twiddle_imag1, twiddle_imag0, clk, reset, flush_data_from_in_buf);
   // butterfly_startin);

butterfly_4 BFLY_4 (
    .startout (butterfly_ready),
    .addr_out_7 (butterfly_result_ad_7),
    .addr_out_6 (butterfly_result_ad_6),
    .addr_out_5 (butterfly_result_ad_5),
    .addr_out_4 (butterfly_result_ad_4),
    .addr_out_3 (butterfly_result_ad_3),
    .addr_out_2 (butterfly_result_ad_2),
    .addr_out_1 (butterfly_result_ad_1),
    .addr_out_0 (butterfly_result_ad_0),
    .realout_7 (butterfly_result_realpart[7]),
    .realout_6 (butterfly_result_realpart[6]),
    .realout_5 (butterfly_result_realpart[5]),
    .realout_4 (butterfly_result_realpart[4]),
    .realout_3 (butterfly_result_realpart[3]),
    .realout_2 (butterfly_result_realpart[2]),
    .realout_1 (butterfly_result_realpart[1]),
    .realout_0 (butterfly_result_realpart[0]),
    .imagout_7 (butterfly_result_imagpart[7]),
    .imagout_6 (butterfly_result_imagpart[6]),
    .imagout_5 (butterfly_result_imagpart[5]),
    .imagout_4 (butterfly_result_imagpart[4]),
    .imagout_3 (butterfly_result_imagpart[3]),
    .imagout_2 (butterfly_result_imagpart[2]),
    .imagout_1 (butterfly_result_imagpart[1]),
    .imagout_0 (butterfly_result_imagpart[0]),
    .realin_7 (butterfly_input_realpart[7]),
    .realin_6 (butterfly_input_realpart[6]),
    .realin_5 (butterfly_input_realpart[5]),
    .realin_4 (butterfly_input_realpart[4]),
    .realin_3 (butterfly_input_realpart[3]),
    .realin_2 (butterfly_input_realpart[2]),
    .realin_1 (butterfly_input_realpart[1]),
    .realin_0 (butterfly_input_realpart[0]),
    .imagin_7 (butterfly_input_imagpart[7]),
    .imagin_6 (butterfly_input_imagpart[6]),
    .imagin_5 (butterfly_input_imagpart[5]),
    .imagin_4 (butterfly_input_imagpart[4]),
    .imagin_3 (butterfly_input_imagpart[3]),
    .imagin_2 (butterfly_input_imagpart[2]),
    .imagin_1 (butterfly_input_imagpart[1]),
    .imagin_0 (butterfly_input_imagpart[0]),
    .twiddle_real_3 (twiddle_real0 ),
    .twiddle_real_2 (twiddle_real1 ),
    .twiddle_real_1 (twiddle_real2 ),
    .twiddle_real_0 (twiddle_real3 ),
    .twiddle_imag_3 (twiddle_imag0 ),
    .twiddle_imag_2 (twiddle_imag1 ),
    .twiddle_imag_1 (twiddle_imag2 ),
    .twiddle_imag_0 (twiddle_imag3 ),
    .addr_7 (butterfly_input_ad[7]),
    .addr_6 (butterfly_input_ad[6]),
    .addr_5 (butterfly_input_ad[5]),
    .addr_4 (butterfly_input_ad[4]),
    .addr_3 (butterfly_input_ad[3]),
    .addr_2 (butterfly_input_ad[2]),
    .addr_1 (butterfly_input_ad[1]),
    .addr_0 (butterfly_input_ad[0]),
    .startin(butterfly_startin),
    .clk (clk)
);

output_buffer OUT_BUF(
    .realout (realout),
    .imagout (imagout),
    .startout (startout),
    .real_in_7 (butterfly_result_realpart[7]),
    .real_in_6 (butterfly_result_realpart[6]),
    .real_in_5 (butterfly_result_realpart[5]),
    .real_in_4 (butterfly_result_realpart[4]),
    .real_in_3 (butterfly_result_realpart[3]),
    .real_in_2 (butterfly_result_realpart[2]),
    .real_in_1 (butterfly_result_realpart[1]),
    .real_in_0 (butterfly_result_realpart[0]),
    .imag_in_7 (butterfly_result_imagpart[7]),
    .imag_in_6 (butterfly_result_imagpart[6]),
    .imag_in_5 (butterfly_result_imagpart[5]),
    .imag_in_4 (butterfly_result_imagpart[4]),
    .imag_in_3 (butterfly_result_imagpart[3]),
    .imag_in_2 (butterfly_result_imagpart[2]),
    .imag_in_1 (butterfly_result_imagpart[1]),
    .imag_in_0 (butterfly_result_imagpart[0]),
    .clk (clk),
    .reset (reset),
   .startin (output_startin)
);
//dummy_m DUMMY ();
//always @(posedge flush_data_from_in_buf)
//begin
//        $display ("DE_1 %d: 0  %h",$time, realbuffer[0]);
//        $display ("DE_1 %d: 128  %h",$time, realbuffer[128]);
//        $display ("DE_1 %d: 64  %h",$time, realbuffer[64]);
//        $display ("DE_1 %d: 92  %h",$time, realbuffer[92]);
//        $display ("DE_1 %d: 32  %h",$time, realbuffer[32]);
//        $display ("DE_1 %d: 249  %h",$time, realbuffer[249]);
//end
//data_buffer DATA_BUF (butterfly_result_realpart, butterfly_result_imagpart, level, flush_output, realbuffer, imagbuffer, butterfly_input_realpart, butterfly_input_imagpart, clk, reset, flush_data_from_in_buf);

endmodule


