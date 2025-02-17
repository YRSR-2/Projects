`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2024 21:34:03
// Design Name: 
// Module Name: CLA
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


module CLA(

    input [3:0] A,
    input [3:0] B,
    input cin,
    output [3:0] sum,
    output carry
    );
  
    wire [3:0] p,g; 
    wire [4:0] c;
   
    Half_Adder p_g0(
    
        .a(A[0]),
        .b(B[0]),
        .carry(g[0]),
        .sum(p[0])
        );
        
        Half_Adder p_g1(
    
        .a(A[1]),
        .b(B[1]),
        .carry(g[1]),
        .sum(p[1])
        );
        
        Half_Adder p_g2(
    
        .a(A[2]),
        .b(B[2]),
        .carry(g[2]),
        .sum(p[2])
        );
        
        Half_Adder p_g3(
    
        .a(A[3]),
        .b(B[3]),
        .carry(g[3]),
        .sum(p[3])
        );
    
    CLA_Logic CL(
        
            .g(g),
            .p(p),
            .cin(cin),
            .carry(c)
            );
            
    assign sum[0]=p[0]^c[0];
    assign sum[1]=p[1]^c[1];
    assign sum[2]=p[2]^c[2];
    assign sum[3]=p[3]^c[3];
    
    assign carry=c[4];
    
endmodule
