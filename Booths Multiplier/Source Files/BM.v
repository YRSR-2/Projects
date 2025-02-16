`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 16:47:47
// Design Name: 
// Module Name: BM
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


module BM(

    input clk,
    input [7:0] A,
    input start,
    output done,
    //output [3:0] data,
   
    output [15:0] out
    
    //new wire
   // output [3:0] state,
   // output [7:0] count,
   // output [7:0] Q_out,
   // output [7:0] M_out,
   // output [3:0] prev_state
    //output [7:0] out2
    //output [3:0] bus
    );
    
    wire [7:0] data;//bus;//,count;
    wire [7:0] count;
    wire [15:0] out1;
    //assign out2=out1;
    wire Q0,done1,LdM,resetM,LdA,resetA,resetQ,LdQ,Ld_Count,reset_Count,Ldq,resetq,shift,ctrl,dec;
    wire q0;
   
   // wire count;
  BM_DP dp(.LdM(LdM),.resetM(resetM),.LdA(LdA),.resetA(resetA),.LdQ(LdQ),.resetQ(resetQ),.Ld_Count(Ld_Count),
        .reset_Count(reset_Count),
        .Ldq1(Ldq),
        .resetq1(resetq),
        .shift(shift),
        .ctrl(ctrl),
        .dec(dec),
        .clk(clk),
        .data(data),
        .Q0(Q0),
        .q10(q0),
        .done(done),
        .out(out1),.count(count)
        );
    
    
    BM_CP cp(
        
            .clk(clk),
            .in_data(A),
            .data(out1),
            .start(start),
            .count(count),
            .q0(q0),
            .Q0(Q0),
            .out_data(data),
            
            .resetA(resetA),
            .LdA(LdA),
            
            .resetM(resetM),
            .LdM(LdM),
            
            .resetQ(resetQ),
            .LdQ(LdQ),
            
            .reset_Count(reset_Count),
            .Ld_Count(Ld_Count),
            
            .resetq(resetq),
            .Ldq(Ldq),
            
            .done(done),
            .out(out),
             
            .shift(shift),
            .ctrl(ctrl),
            .dec(dec)
            
           );
    
endmodule
