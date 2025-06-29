`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 20:35:53
// Design Name: 
// Module Name: Key_Generation
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


module Key_Generation#(parameter DATA_W = 128,parameter KEY_L = 128,parameter NO_ROUNDS = 10)
 (
 input clk,                            
 input reset,                          //async reset               
 input valid_in,                       //input valid in
 input [KEY_L-1:0] cipher_key,         //cipher key
 output [(NO_ROUNDS*DATA_W)-1:0] W,    //contains all generated round keys
 output [NO_ROUNDS-1:0] valid_out      //output valid signal
 );

 wire [31:0] RCON [0:9];                       //round constant array of words
 wire [NO_ROUNDS-1:0] keygen_valid_out;        //every bit represens output valid signal for every RoundKeyGen module 
 wire [DATA_W-1:0] W_array  [0:NO_ROUNDS-1];   //array of round keys to form W output 

 //round connstant values
 assign RCON[0] = 32'h01000000;
 assign RCON[1] = 32'h02000000;
 assign RCON[2] = 32'h04000000;
 assign RCON[3] = 32'h08000000;
 assign RCON[4] = 32'h10000000;
 assign RCON[5] = 32'h20000000;
 assign RCON[6] = 32'h40000000;
 assign RCON[7] = 32'h80000000;
 assign RCON[8] = 32'h1b000000;
 assign RCON[9] = 32'h36000000;

 //instantiate number RounkeyGen modules = number of rounds to get number of roundkeys = number of  rounds
 Round_Key_Generation #(KEY_L)RKGEN_U0(clk,reset,RCON[0],valid_in,cipher_key,W_array[0],keygen_valid_out[0]);

 genvar i;
 generate
 for (i=1 ;i<NO_ROUNDS;i=i+1) begin : ROUND_KEY_GEN
 Round_Key_Generation #(KEY_L)RKGEN_U(clk,reset,RCON[i],keygen_valid_out[i-1],W_array[i-1],W_array[i],keygen_valid_out[i]);
 end
 endgenerate

                          //assigning all the round keys to one output
 assign W = {  W_array[0],
               W_array[1],
               W_array[2],
               W_array[3],
               W_array[4],
               W_array[5],
               W_array[6],
               W_array[7],
               W_array[8],
               W_array[9] };

 assign valid_out = keygen_valid_out;


 endmodule