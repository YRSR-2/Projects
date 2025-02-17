`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2024 21:14:22
// Design Name: 
// Module Name: CLA_Logic
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


module CLA_Logic(

    input [3:0] g,  //a-->generator
    input [3:0] p,  //b-->propogator
    input cin,
    output [4:0] carry
    );
    
    
    
    assign carry[0]=cin;
    assign carry[1]= g[0] | ((p[0])&cin);
    assign carry[2]= g[1] | (p[1] &(g[0] | ((p[0])&cin)));
    assign carry[3]= g[2] | (p[2] & (g[1] | (p[1] &(g[0] | ((p[0])&cin)))));
    assign carry[4]= g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] &(g[0] | ((p[0])&cin)))))));
    
endmodule
