`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 11:00:49
// Design Name: 
// Module Name: PIPO_1b
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


module PIPO_1b(

    input clk,
    input reset,
    input A,
    input ld,
    output reg D
    );
    
    always @(posedge clk)
    begin
        if(reset)
        D<=1'b0;
        else if(ld)
        D<=A;
        else
        D<=D;
    end
endmodule
