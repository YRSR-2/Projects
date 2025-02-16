`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 11:20:39
// Design Name: 
// Module Name: Full_Adder
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



module Full_adder(

    input A,
    input B,
    input cin,
    output sum,
    output carry
    );
    
    assign sum=A^B^cin;
    assign carry=(A&B)|(B&cin)|(A&cin);
    
    
endmodule
