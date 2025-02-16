`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 11:14:23
// Design Name: 
// Module Name: Shift_Reg_2
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



module Shift_Reg_2(

    input clk,
    input [7:0] A,
    input ld,
    input en,
    input sd1,  //data that has to be shifted in
    input reset,
    output reg [7:0] D,
    output sd2  //data that has to be shifted out
    );
    
    always @(posedge clk)
    begin
    if(reset)
    D<=8'b0;
    else if(ld)
    D<=A;
    else if(en)
    begin
    D<={sd1,D[7:1]};   //shifting when shift enabled
    //sd2=D[0];
    end
    else
    D<=D;
    end
    
    assign sd2=D[0];
endmodule
