`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 22:23:50
// Design Name: 
// Module Name: Round_D
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Round_D
 #
 (
 parameter DATA_W = 128            //data width
 )
 (
 input clk,                        //system clock
 input reset,                      //asynch active low reset
 input data_valid_in,              //data valid signal
 //input key_valid_in,               //key valid signal
 input [DATA_W-1:0] data_in,       //input data
 input [DATA_W-1:0] round_key,     //round  key
 output  valid_out,                //output valid signal
 output  [DATA_W-1:0] data_out     //output data
 );
                                  //wires for connection 
 wire [DATA_W-1:0] data_shift2sub;
 wire [DATA_W-1:0] data_sub2key;
 wire [DATA_W-1:0] data_key2mix;
 
 wire [DATA_W-1:0] data_sub2shift;
 wire [DATA_W-1:0] data_shift2max;
 wire [DATA_W-1:0] data_mix2key;

 wire valid_shift2sub;
 wire valid_sub2key;
 wire valid_key2mix;
    
 /*   
 ///////////////////////////////SubBytes///////////////////////////////////////////////////
 iSubBytes #(DATA_W) U_SUB (clk,reset,data_valid_in,data_in,valid_sub2shift,data_sub2shift);

 //////////////////////////////ShiftRows///////////////////////////////////////////////////////////
 ShiftRows #(DATA_W) U_SH (clk,reset,valid_sub2shift,data_sub2shift,valid_shift2mix,data_shift2mix);

 //////////////////////////////MixColumns//////////////////////////////////////////////////////////
 MixColumns #(DATA_W) U_MIX (clk,reset,valid_shift2mix,data_shift2mix,valid_mix2key,data_mix2key);

 /////////////////////////////AddRoundKey/////////////////////////////////////////////////////////////////////
 AddRoundKey #(DATA_W) U_KEY (clk,reset,valid_mix2key,key_valid_in,data_mix2key,round_key,valid_out,data_out);
 */
 //issue of key_valid_in synchronization while decrypting
 
 
 inverse_Shift_Rows #(DATA_W) U_SH (clk,reset,data_valid_in,data_in,valid_shift2sub,data_shift2sub);
 
 inverse_Sub_Bytes #(DATA_W) U_SUB (clk,reset,valid_shift2sub,data_shift2sub,valid_sub2key,data_sub2key);
 
 inverse_Add_RoundKey #(DATA_W) U_KEY (clk,reset,valid_sub2key,/*key_valid_in,*/data_sub2key,round_key,valid_key2mix,data_key2mix);
 
 inverse_Mix_Columns #(DATA_W) U_MIX (clk,reset,valid_key2mix,data_key2mix,valid_out,data_out);

 endmodule
