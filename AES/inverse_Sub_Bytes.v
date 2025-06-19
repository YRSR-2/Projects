`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 22:17:55
// Design Name: 
// Module Name: inverse_Sub_Bytes
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


module inverse_Sub_Bytes
   #
   (
    parameter DATA_W = 128,       //data width
    parameter NO_BYTES = DATA_W >> 3  //no of bytes = data width / 8
   )
   (
   input clk,                     //system clock
   input reset,                   //asynch active low reset
   input valid_in,                //input valid signal  
   input [DATA_W-1:0] data_in,    //input data
   output reg valid_out,          //output valid signal
   output [DATA_W-1:0] data_out   //output data
   );

   genvar i;
   generate                      //generating sbox roms 
   for (i=0; i< NO_BYTES ; i=i+1) begin : Cell
     inverse_SBox Cell(clk,reset,valid_in,data_in[(i*8)+7:(i*8)],data_out[(i*8)+7:(i*8)]);
   end
   endgenerate

   always@(posedge clk or negedge reset)   //valid out register
   if(!reset)begin
       valid_out <= 1'b0;
   end else begin
       valid_out <= valid_in;
     end
   endmodule
