`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 22:31:05
// Design Name: 
// Module Name: Key_Generation_D
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


module Key_Generation_D
 #
 (
 parameter DATA_W = 128,               //data width
 parameter KEY_L = 128,                //key length
 parameter NO_ROUNDS = 10              //number of rounds
 )
 (
 input clk,                            //system clock
 input reset,                          //async reset               
 input valid_in,                       //input valid in
 input [KEY_L-1:0] cipher_key,         //cipher key
 output [(NO_ROUNDS*DATA_W)-1:0] W,    //contains all generated round keys
 output [NO_ROUNDS-1:0] valid_out      //output valid signal
 );

 wire [31:0] RCON [0:9];                       //round constant array of words
 wire [NO_ROUNDS-1:0] keygen_valid_out;        //every bit represens output valid signal for every RoundKeyGen module 
 reg [NO_ROUNDS-1:0] delayed_keygen_valid_out;        //every bit represens output valid signal for every RoundKeyGen module 
 wire [DATA_W-1:0] W_array  [0:NO_ROUNDS-1];   //array of round keys to form W output 

    reg [31:0] delayed_RCON [0:9];
    
    
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
wire y1,y2,y3;
wire [DATA_W-1:0] y4,y5;
 //instantiate number RounkeyGen modules = number of rounds to get number of roundkeys = number of  rounds
 Round_Key_Generation_D #(KEY_L)RKGEN_U0(clk,reset,RCON[0],valid_in,cipher_key,W_array[0],keygen_valid_out[0]);//keygen_valid_out[0]);
 //delay D(.clk(clk),.reset(reset),.x(y),.y(keygen_valid_out[0]));

 genvar i;
 generate
 for (i=1 ;i<NO_ROUNDS;i=i+1) begin : ROUND_KEY_GEN
 
//delay D(.x(keygen_valid_out[i-1]),.reset(reset),.clk(clk),.y(y));
//delay D(.clk(clk),.reset(reset),.x1(RCON[i]),.x2(keygen_valid_out[i-1]),.x4(W_array[i-1]),.x5(W_array[i]),.x3(keygen_valid_out[i]),.y1(y1),.y2(y2),.y3(y3),.y4(y4),.y5(y5));
 //RoundKeyGen #(KEY_L)RKGEN_U(clk,reset,y1,y2,y4,y5,y3);
 //RoundKeyGen #(KEY_L)RKGEN_U(clk,reset,RCON[i],keygen_valid_out[i-1],W_array[i-1],W_array[i],keygen_valid_out[i]);
 Round_Key_Generation_D #(KEY_L)RKGEN_U(clk,reset,RCON[i],keygen_valid_out[i-1],W_array[i-1],W_array[i],keygen_valid_out[i]);
 end
 endgenerate

                          //assigning all the round keys to one output
 assign W = {W_array[0],W_array[1],W_array[2],W_array[3],W_array[4],W_array[5],W_array[6],W_array[7],W_array[8],W_array[9]};

 assign valid_out = keygen_valid_out;



 endmodule
 
