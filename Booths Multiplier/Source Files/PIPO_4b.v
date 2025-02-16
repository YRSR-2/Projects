`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 10:53:53
// Design Name: 
// Module Name: PIPO_4b
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


module PIPO_4b(

    input clk,
    input [7:0] A,
    input reset,
    input ld,
    output reg [7:0] D
    );
    
    always @(posedge clk)
    begin
        if(reset)
        D<=8'd0;
        else if(ld)
        D<=A;
        else
        D<=D;
        
    end
endmodule
