`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 11:13:49
// Design Name: 
// Module Name: Shift_Reg_1
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


module Shift_Reg_1(

    input clk,
    input ld,
    input en,
    input reset,
    input [7:0] A,
    output reg [7:0] D,
    output sd2  //data that has to be shifted out
    );
    
    
    always @(posedge clk)
    begin
    if(reset)
    D<=8'd0;
    else if(ld)
    D<=A;
    else if(en)
    begin
    D<={D[7],D[7:1]};
    //sd2=D[0];
    end
    else
    D<=D;
    end
    
    assign sd2=D[0];
endmodule
