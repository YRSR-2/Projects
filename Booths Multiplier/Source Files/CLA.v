`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 11:24:13
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

    input [7:0] A,
    input [7:0] B,
    input cin,
    output carry,
    output [7:0] sum
    );
    
    wire [7:0] P,G;
    wire [8:0] c;
    assign carry=c[8];
    
    Full_adder FA0(
    
        .A(A[0]),
        .B(B[0]),
        .cin(1'b0),
        .sum(P[0]),
        .carry(G[0])
        );
    Full_adder FA1(
    
        .A(A[1]),
        .B(B[1]),
        .cin(1'b0),
        .sum(P[1]),
        .carry(G[1])
        );    
    Full_adder FA2(
    
        .A(A[2]),
        .B(B[2]),
        .cin(1'b0),
        .sum(P[2]),
        .carry(G[2])
        );    
    Full_adder FA3(
    
        .A(A[3]),
        .B(B[3]),
        .cin(1'b0),
        .sum(P[3]),
        .carry(G[3])
        );
        
     Full_adder FA4(
            
                .A(A[4]),
                .B(B[4]),
                .cin(1'b0),
                .sum(P[4]),
                .carry(G[4])
                );
Full_adder FA5(
                    
                        .A(A[5]),
                        .B(B[5]),
                        .cin(1'b0),
                        .sum(P[5]),
                        .carry(G[5])
                        );
Full_adder FA6(
                            
                                .A(A[6]),
                                .B(B[6]),
                                .cin(1'b0),
                                .sum(P[6]),
                                .carry(G[6])
                                ); 

Full_adder FA7(
    
        .A(A[7]),
        .B(B[7]),
        .cin(1'b0),
        .sum(P[7]),
        .carry(G[7])
        ); 
        
    CLA_logic CLA_l(
        
            .P(P),
            .G(G),
            .cin(cin),
            .carry(c)
            );
            
       assign sum[0]=P[0]^c[0];
       assign sum[1]=P[1]^c[1];
       assign sum[2]=P[2]^c[2];
       assign sum[3]=P[3]^c[3];
       assign sum[4]=P[4]^c[4];
       assign sum[5]=P[5]^c[5];
       assign sum[6]=P[6]^c[6];
       assign sum[7]=P[7]^c[7];
        
endmodule
