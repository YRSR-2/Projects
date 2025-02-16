`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 11:35:30
// Design Name: 
// Module Name: BM_DP
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


module BM_DP(

    input LdM,
    input resetM,
    input LdA,
    input resetA,
    input LdQ,
    input resetQ,
    input Ld_Count,
    input reset_Count,
    input Ldq1,
    input resetq1,
    input shift,
    input ctrl,
    input dec,
    input clk,
    input [7:0] data,
    output Q0,
    output q10,
    input done,
    output [15:0]out,
    output [7:0] count
    
    );


    wire [7:0] A_out,C_out,adderA; //count;
    wire [7:0] dc,da,bus;
    wire sd2,sd1,c,q1_out;
    wire [7:0] Q_out,M_out;
    assign Q0=Q_out[0];
    assign q10=q1_out;
    assign bus=data;
    assign adderA=M_out^{8{ctrl}};  /*this statement heklps to give the 1's complement form of M in case we need to do subtraction
                                       and the 1 needed to be added to find 2's complement is given to 4 bit adder in form of 
                                       carry*/
                                       
                                       /* ctrl signal helps to know whether we need to find 2's complement or not*/
    assign count=C_out;
    
    
    
    
    PIPOd_4b Count(.clk(clk),.A(bus),.reset(reset_Count),.ld(Ld_Count),.D(C_out),.dec(dec));  //Count register
    
    PIPO_4b M(.clk(clk),.A(bus),.reset(resetM),.ld(LdM),.D(M_out));  //M register to store Multiplicand
        
    PIPO_1b q(.clk(clk),.reset(resetq1),.A(sd2),.ld(Ldq1),.D(q1_out));  // q register to store q-1
    
    Shift_Reg_2 Q(.clk(clk),.A(bus),.ld(LdQ),.en(shift),.sd1(sd1),.reset(resetQ),.D(Q_out),.sd2(sd2));  //Q register to store multiplier
    
    Shift_Reg_1 A(.clk(clk),.ld(LdA),.en(shift),.reset(resetA),.A(da),.D(A_out),.sd2(sd1)); //A register acts as accumulator
     
    CLA adder(.A(adderA),.B(A_out),.cin(ctrl),.carry(c),.sum(da));  //4 bit CLA adder
    
    
  
    assign out=(done==1)?{A_out,Q_out}:16'd0;  //correct output is shown till done signal is active 
    
endmodule
