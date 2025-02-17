`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 17:14:59
// Design Name: 
// Module Name: BM_tb
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


module BM_tb();

reg clk,start;
wire done;
wire [15:0] out;//out2;
reg [7:0] A;
//wire [3:0] state,prev_state;
//wire [7:0]Q_out,M_out,count;

initial
begin
clk=0;
start=0;
A=8'd0;
end

BM dut(

    .clk(clk),
    .A(A),
    .start(start),
    .done(done),
    .out(out)//,.state(state),.count(count),.Q_out(Q_out),.M_out(M_out),.prev_state(prev_state)
    );
    
    
    always
    begin
        #5 clk=~clk;
    end 
    
    initial
    begin
        #12 start=1;
        #10 start=0;
        
        #3 A=8'd4;
        #12 start=1;
       // #3 A=4'd3;//loading multiplicand
        #10 start=0;
        
       // #3 A=4'd3;//loading multiplicand
       
        #10 A=8'd2;//loading multiplier
        #12 start=1;
        //#3 A=4'd2;//loading multiplier
        #10 start=0;
        
        //#3 A=4'd2;//loading multiplier
        
        #10 A=8'd8;//loading count
        #12 start=1;
        //#3 A=4'd4;//loading count
        #10 start=0;
        
        //#3 A=4'd4;//loading count 
        //#10 A=4'd0;
        #300 $finish; 
       /* #12 start=1;
                #10 start=0;
                
                #3 A=4'd15;
                #12 start=1;
               // #3 A=4'd3;//loading multiplicand
                #10 start=0;
                
               // #3 A=4'd3;//loading multiplicand
               
                #10 A=4'd8;//loading multiplier
                #12 start=1;
                //#3 A=4'd2;//loading multiplier
                #10 start=0;
                
                //#3 A=4'd2;//loading multiplier
                
                #10 A=4'd4;//loading count
                #12 start=1;
                //#3 A=4'd4;//loading count
                #10 start=0;
        #150 $finish;*/
       /*
        #10 start=1;
        #10 start=0; 
        #10 A=4'd4;
        #10 A=4'd4;
        #10 A=4'd4;
        #10 A=4'd0;
        #150$finish; */
       
    end
    
endmodule 
