`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 22:36:17
// Design Name: 
// Module Name: Decryption
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


module Decryption#(
   parameter DATA_W = 128,      //data width
   parameter KEY_L = 128,       //key length
   parameter NO_ROUNDS = 10     //number of rounds
   )
   (
   input clk,                       //system clock
   input reset,                     //asynch reset
   input data_valid_in,             //data valid signal
   input cipherkey_valid_in,        //cipher key valid signal
   input [KEY_L-1:0] cipher_key,    //cipher key
   input [DATA_W-1:0] plain_text,   //plain text
   output valid_out,               //output valid signal
   output [DATA_W-1:0] cipher_text //cipher text 
   );

   wire [NO_ROUNDS-1:0] valid_round_key;            //all round keys valid signals KeyExpantion output
   wire [NO_ROUNDS-1:0] valid_round_data;           //all rounds ouput data valid signals
   wire [DATA_W-1:0] data_round [0:NO_ROUNDS-1];    //all rounds data
   //assign text=data_round[0];
   wire valid_shift2sub;    //-..-..-.-.-.-.--l-.-.-.                        //for final round connection
   wire valid_sub2key;                            // 
   wire [DATA_W-1:0]data_shift2sub;
   wire [DATA_W-1:0]data_sub2key;
                    //
                   //
                    //
   wire [(NO_ROUNDS*DATA_W)-1:0] W;                 //all round keys

   reg[DATA_W-1:0] data_sub2key_delayed;           //for delay register
   reg valid_sub2key_delayed;
   

   //instantiate Key Expantion which will feed every round with round key
   Key_Generation_D #(DATA_W,KEY_L,NO_ROUNDS) U_KEYEXP(clk,reset,cipherkey_valid_in,cipher_key,W,valid_round_key);

   //due to algorithm,first cipher key will be xored witht plain text
   inverse_Add_RoundKey #(DATA_W)U0_ARK(clk,reset,valid_round_key[9]/*data_valid_in*//*valid_round_key[9]*//*cipherkey_valid_in*/,plain_text,W[DATA_W-1:0]/*cipher_key*/,valid_round_data[0],data_round[0]);

   //instantiate all rounds , connect them with key expantion
   genvar i;
   generate
   for(i=0;i<NO_ROUNDS-1;i=i+1) begin : ROUND
    Round_D #(DATA_W)U_ROUND(clk,reset,valid_round_data[i],/*1'b1*/data_round[i],W[(i+2)*(DATA_W)-1:(i+1)*DATA_W],valid_round_data[i+1],data_round[i+1]);
   end
   endgenerate

   inverse_Shift_Rows #(DATA_W) U_SH (clk,reset,valid_round_data[NO_ROUNDS-1],data_round[NO_ROUNDS-1],valid_shift2sub,data_shift2sub);
   inverse_Sub_Bytes #(DATA_W) U_SUB (clk,reset,valid_shift2sub,data_shift2sub,valid_sub2key,data_sub2key);
   inverse_Add_RoundKey #(DATA_W) U_KEY (clk,reset,valid_sub2key,/*valid_round_key[NO_ROUNDS-1],*/data_sub2key,cipher_key/*W[DATA_W-1:0]*/,valid_out,cipher_text);
  

   endmodule