`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2024 10:53:30
// Design Name: 
// Module Name: CLA_tb
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


module CLA_tb();

reg [3:0] a,b;
reg cin;
wire [3:0] sum;
wire carry;

CLA dut(

    .A(a),
    .B(b),
    .cin(cin),
    .sum(sum),
    .carry(carry)
    );
    
    initial
    begin
        cin=0;
        a=0;
        b=0;
        #5 a=4'b1001; b=4'b0110;
        #5 a=4'b1011;
        #5;
        $finish;
    end
endmodule
