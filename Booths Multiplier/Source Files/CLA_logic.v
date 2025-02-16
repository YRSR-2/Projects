`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 11:23:06
// Design Name: 
// Module Name: CLA_logic
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


module CLA_logic(

    input [7:0]P,
    input [7:0]G,
    input cin,
    output [8:0]carry
    );
    
    assign carry[0]=cin;
    assign carry[1]=G[0]|(P[0]&cin);
    assign carry[2]=G[1]|(P[1]&G[0])|(P[1]&P[0]&cin);
    assign carry[3]=G[2]|(P[2]&G[1])|(P[2]&P[1]&G[0])|(P[2]&P[1]&P[0]&cin);
    assign carry[4]=G[3]|(P[3]&G[2])|(P[3]&P[2]&G[1])|(P[3]&P[2]&P[1]&G[0])|(P[3]&P[2]&P[1]&P[0]&cin);
    assign carry[5]=G[4]|(P[4]&G[3])|(P[4]&P[3]&G[2])|(P[4]&P[3]&P[2]&G[1])|(P[4]&P[3]&P[2]&P[1]&G[0])|(P[4]&P[3]&P[2]&P[1]&P[0]&cin);
    assign carry[6]=G[5]|(P[5]&G[4])|(P[5]&P[4]&G[3])|(P[5]&P[4]&P[3]&G[2])|(P[5]&P[4]&P[3]&P[2]&G[1])|(P[5]&P[4]&P[3]&P[2]&P[1]&G[0])|(P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&cin);
    assign carry[7]=G[6]|(P[6]&G[5])|(P[6]&P[5]&G[4])|(P[6]&P[5]&P[4]&G[3])|(P[6]&P[5]&P[4]&P[3]&G[2])|(P[6]&P[5]&P[4]&P[3]&P[2]&G[1])|(P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0])|(P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&cin);
    assign carry[8]=G[7]|(P[7]&G[6])|(P[7]&P[6]&G[5])|(P[7]&P[6]&P[5]&G[4])|(P[7]&P[6]&P[5]&P[4]&G[3])|(P[7]&P[6]&P[5]&P[4]&P[3]&G[2])|(P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&G[1])|(P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0])|(P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&cin);
endmodule
