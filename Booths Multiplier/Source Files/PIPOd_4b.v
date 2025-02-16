`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 23:22:36
// Design Name: 
// Module Name: PIPOd_4b
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


module PIPOd_4b(

    input clk,
    input [7:0] A,
    input reset,
    input ld,
    input dec,
    output reg [7:0] D
    );
    
    always @(posedge clk)
    begin
        if(reset)
        D<=8'd0;
        else if(ld)
        D<=A;
        else if(dec)
        D<=D-8'd1;
        else
        D<=D;
        
    end
endmodule
