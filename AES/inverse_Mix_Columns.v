`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 22:19:43
// Design Name: 
// Module Name: inverse_Mix_Columns
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


module inverse_Mix_Columns
   #
   (
   parameter DATA_W = 128             //data width
   )
   (
   input clk,                         //system clock
   input reset,                       //asynch active low reset
   input valid_in,                    //input valid signal   
   input [DATA_W-1:0] data_in,        //input data
   output reg valid_out,              //output valid signal
   output reg [DATA_W-1:0] data_out   //output data
   )
   ;

  /*
   wire [7:0] State [0:15];        //array of wires to form state array
   wire [7:0] State_Mulx2 [0:15];  //array of wires to perform multiplication by 02
   wire [7:0] State_Mulx7 [0:15];  //array of wires to perform multiplication by 07
   wire [7:0] State_Mulx9 [0:15];  //array of wires to perform multiplication by 09
   wire [7:0] State_Mulx11 [0:15];  //array of wires to perform multiplication by 011
   wire [7:0] State_Mulx13 [0:15];  //array of wires to perform multiplication by 013
   wire [7:0] State_Mulx14 [0:15];  //array of wires to perform multiplication by 014

   genvar i ;
   generate
   for(i=0;i<=15;i=i+1) begin :MUL
    assign State[i]= data_in[(((15-i)*8)+7):((15-i)*8)];   // filling state array as each row represents one byte ex: state[0] means first byte and so on
    assign State_Mulx2[i]= (State[i][7])?((State[i]<<1) ^ 8'h1b):(State[i]<<1);  //Multiplication by {02} in finite field is done shifting 1 bit lift                                                                               //and xoring with 1b if the most bit =1
    assign State_Mulx7[i]=(State_Mulx2[i])^(State_Mulx2[i])^(State_Mulx2[i])^State[i];
    assign State_Mulx9[i]=(State_Mulx7[i])^(State_Mulx2[i]);
    assign State_Mulx11[i]=(State_Mulx9[i])^(State_Mulx2[i]);
    assign State_Mulx13[i]=(State_Mulx11[i])^(State_Mulx2[i]);
    assign State_Mulx14[i]=(State_Mulx13[i])^(State[i]);
    */
    /*assign State_Mulx3[i]= (State_Mulx2[i])^State[i];  // Multiply by {03} in finite field can be done as multiplication by {02 xor 01}*/
    
  /* end
   endgenerate*/

    wire [7:0] State [0:15];        //array of wires to form state array
   wire [7:0] State_x [0:15];  //array of wires to perform multiplication by 02
   wire [7:0] State_x2 [0:15];  //array of wires to perform multiplication by 07
   wire [7:0] State_x3 [0:15];  //array of wires to perform multiplication by 09
   wire [7:0] State_Mulx9 [0:15];  //array of wires to perform multiplication by 09
   wire [7:0] State_Mulx11 [0:15];  //array of wires to perform multiplication by 011
   wire [7:0] State_Mulx13 [0:15];  //array of wires to perform multiplication by 013
   wire [7:0] State_Mulx14 [0:15];  //array of wires to perform multiplication by 014

   genvar i ;
   generate
   for(i=0;i<=15;i=i+1) begin :MUL
    assign State[i]= data_in[(((15-i)*8)+7):((15-i)*8)];   // filling state array as each row represents one byte ex: state[0] means first byte and so on
    //assign State_Mulx2[i]= (State[i][7])?((State[i]<<1) ^ 8'h1b):(State[i]<<1);  //Multiplication by {02} in finite field is done shifting 1 bit lift                                                                               //and xoring with 1b if the most bit =1
    //assign State_Mulx7[i]=(State_Mulx2[i])^(State_Mulx2[i])^(State_Mulx2[i])^State[i];
    assign State_x[i]= (State[i][7])?((State[i]<<1) ^ 8'h1b):(State[i]<<1);
    assign State_x2[i]= (State_x[i][7])?((State_x[i]<<1) ^ 8'h1b):(State_x[i]<<1);
    assign State_x3[i]= (State_x2[i][7])?((State_x2[i]<<1) ^ 8'h1b):(State_x2[i]<<1);
    assign State_Mulx9[i]=(State_x3[i])^State[i];
    assign State_Mulx11[i]=(State_x3[i])^State[i]^(State_x[i]);
    assign State_Mulx13[i]=(State_x3[i])^State[i]^(State_x2[i]);
    assign State_Mulx14[i]=(State_x3[i])^(State_x2[i])^(State_x[i]);
    
    
    
    
    
    /*assign State_Mulx3[i]= (State_Mulx2[i])^State[i];  // Multiply by {03} in finite field can be done as multiplication by {02 xor 01}*/
    
   end
   endgenerate

   always@(posedge clk or negedge reset)
   if(!reset)begin
       valid_out <= 1'b0;
       data_out <= 'b0;
   end else begin
      if(valid_in) begin               //mul by 2 and mul by 3 are used to perform matrix multiplication  for each column
       data_out[(15*8)+7:(15*8)]<=  State_Mulx14[0] ^ State_Mulx11[1] ^ State_Mulx13[2] ^ State_Mulx9[3];   //first column
       data_out[(14*8)+7:(14*8)]<= State_Mulx9[0] ^ State_Mulx14[1] ^ State_Mulx11[2] ^ State_Mulx13[3];
       data_out[(13*8)+7:(13*8)]<= State_Mulx13[0] ^ State_Mulx9[1] ^ State_Mulx14[2] ^ State_Mulx11[3];
       data_out[(12*8)+7:(12*8)]<= State_Mulx11[0] ^ State_Mulx13[1] ^ State_Mulx9[2] ^ State_Mulx14[3];
       /*********************************************************************************/
       data_out[(11*8)+7:(11*8)]<= State_Mulx14[4] ^ State_Mulx11[5] ^ State_Mulx13[6] ^ State_Mulx9[7];   //second column
       data_out[(10*8)+7:(10*8)]<= State_Mulx9[4] ^ State_Mulx14[5] ^ State_Mulx11[6] ^ State_Mulx13[7];
       data_out[(9*8)+7:(9*8)] <=  State_Mulx13[4] ^ State_Mulx9[5] ^ State_Mulx14[6] ^ State_Mulx11[7];
       data_out[(8*8)+7:(8*8)]<= State_Mulx11[4] ^ State_Mulx13[5] ^ State_Mulx9[6] ^ State_Mulx14[7];
       /**********************************************************************************/
       data_out[(7*8)+7:(7*8)]<= State_Mulx14[8] ^ State_Mulx11[9] ^ State_Mulx13[10] ^ State_Mulx9[11];   //third column
       data_out[(6*8)+7:(6*8)]<= State_Mulx9[8] ^ State_Mulx14[9] ^ State_Mulx11[10] ^ State_Mulx13[11];
       data_out[(5*8)+7:(5*8)]<= State_Mulx13[8] ^ State_Mulx9[9] ^ State_Mulx14[10] ^ State_Mulx11[11];
       data_out[(4*8)+7:(4*8)]<= State_Mulx11[8] ^ State_Mulx13[9] ^ State_Mulx9[10] ^ State_Mulx14[11];
       /***********************************************************************************/
       data_out[(3*8)+7:(3*8)]<= State_Mulx14[12] ^ State_Mulx11[13] ^ State_Mulx13[14] ^ State_Mulx9[15];  //fourth column
       data_out[(2*8)+7:(2*8)]<= State_Mulx9[12] ^ State_Mulx14[13] ^ State_Mulx11[14] ^ State_Mulx13[15];
       data_out[(1*8)+7:(1*8)]<= State_Mulx13[12] ^ State_Mulx9[13] ^ State_Mulx14[14] ^ State_Mulx11[15];
       data_out[(0*8)+7:(0*8)]<= State_Mulx11[12] ^ State_Mulx13[13] ^ State_Mulx9[14] ^ State_Mulx14[15];
      end
      valid_out <= valid_in;
   end
   endmodule