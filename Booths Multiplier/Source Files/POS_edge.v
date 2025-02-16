`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.01.2025 22:27:42
// Design Name: 
// Module Name: POS_edge
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


module POS_edge(
    
    input sig,
    input clk,
    output pe
);

    reg sig_dly;
    always @ (posedge clk) begin
            sig_dly <= sig;
    end
    
    assign pe = sig & ~sig_dly;
endmodule

