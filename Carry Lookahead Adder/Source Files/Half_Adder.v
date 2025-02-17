`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2024 21:06:30
// Design Name: 
// Module Name: p_g_gen
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


module Half_Adder(

    input a,
    input b,
    output carry,
    output sum
    );
    
    assign carry=a&b;
    assign sum=a^b;
endmodule
