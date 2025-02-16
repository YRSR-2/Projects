`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 12:48:41
// Design Name: 
// Module Name: BM_CP
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

module BM_CP(

    input clk,
    input [7:0] in_data,
    input [15:0] data,
    input start,
    input [7:0]count,
    input q0,
    input Q0,
    output reg [7:0] out_data,
    
    output reg resetA,
    output reg LdA,
    
    output reg resetM,
    output reg LdM,
    
    output reg resetQ,
    output reg LdQ,
    
    output reg reset_Count,
    output reg Ld_Count,
    
    output reg resetq,
    output reg Ldq,
    
    output reg done,
    output  [15:0] out,
     
    output reg shift,
    output reg ctrl,
    output reg dec
    
   );
   
   //assign out_data=in_data;
   reg [3:0]state,prev_state;
   parameter S0=4'd0,S1=4'd1,S2=4'd2,S3=4'd3,S4=4'd4,S5=4'd5,S6=4'd6,S7=4'd7,S8=4'd8,S9=4'd9,S10=4'd10,S11=4'd11;
   wire pe;
   
   always @(posedge pe)
   out_data<=in_data;
   /*
   S0=start
   S1=reset all
   S2:load M
   S3:load Q
   S4:load count
   S5:decide which path to go 00,01,10,00
   S6: 01  A+M
   S7: 10  A-M
   S8: 00,11    shift and counter decrement
   S9: decision after decrement
   S10: final done state
   S11: delay state
   */
   
   POS_edge pos(.sig(start),.clk(clk),.pe(pe));
   
   
   
   always @(posedge clk)
   begin
   case(state)
   S0: begin prev_state<=S0; if(pe) state<=S1; end
   S1: begin prev_state<=S1; state<=S11; end
   S2: begin prev_state<=S2; state<=S11; end
   S3: begin prev_state<=S3; state<=S11; end  //loading Q register
   S4: begin prev_state<=S4; state<=S5; end //loading counter register
   S5:
    begin
        prev_state<=S5;
        if(Q0==1'b0 && q0==1'b1)
        state<=S6;
        else if(Q0==1'b1 && q0==1'b0)
        state<=S7;
        else
        state<=S8; 
    end
   S6:begin prev_state<=S6; state<=S8; end
   S7:begin prev_state<=S7; state<=S8; end
   S8:begin prev_state<=S8; state<=S9; end
   S9:begin prev_state<=S9; if(count!=4'b0) state<=S5; else state<=S10; end
   S10:begin prev_state<=S10; if(start) state<=S1; end  // this state is active till start signal is received
   S11:
    begin
        if(prev_state==S1 && pe)
        state<=S2;
        else if(prev_state==S2 && pe)
        state<=S3;
        else if(prev_state==S3 && pe)
        state<=S4;
        else
        state<=S11;
    end
   default: state<=S0;
   endcase
   end
   
   
   always @(state)
   begin
    case(state)
    S0: 
        begin
        LdA=0; resetA=0;
        LdM=0; resetM=0;
        LdQ=0; resetQ=0;
        Ldq=0; resetq=0;
        Ld_Count=0; reset_Count=0;
        shift=0; ctrl=0; dec=0;
        done=0;   
        end
    S1:
    begin
        LdA=0; resetA=1;
        LdM=0; resetM=1;
        LdQ=0; resetQ=1;
        Ldq=0; resetq=1;
        Ld_Count=0; reset_Count=1;
        shift=0; ctrl=0; dec=0; done=0;
    end
    S2:
    begin
        LdA=0; resetA=0;
        LdM=1; resetM=0;
        LdQ=0; resetQ=0;
        Ldq=0; resetq=0;
        Ld_Count=0; reset_Count=0;
        shift=0; ctrl=0; dec=0;
    end
    S3:
        begin
        LdA=0; resetA=0;
        LdM=0; resetM=0;
        LdQ=1; resetQ=0;
        Ldq=0; resetq=0;
        Ld_Count=0; reset_Count=0;
        shift=0; ctrl=0; dec=0;
        end
    S4:
        begin
        LdA=0; resetA=0;
        LdM=0; resetM=0;
        LdQ=0; resetQ=0;
        Ldq=0; resetq=0;
        Ld_Count=1; reset_Count=0;
        shift=0; ctrl=0; dec=0;
        end
    S5:
        begin
        LdA=0; resetA=0;
        LdM=0; resetM=0;
        LdQ=0; resetQ=0;
        Ldq=0; resetq=0;
        Ld_Count=0; reset_Count=0;
        shift=0; ctrl=0; dec=0; 
        end
    
    S6:
    begin
        LdA=1; resetA=0;
        LdM=0; resetM=0;
        LdQ=0; resetQ=0;
        Ldq=0; resetq=0;
        Ld_Count=0; reset_Count=0;
        shift=0; ctrl=0; dec=0;
    end
    
    
    S7:
    begin
        LdA=1; resetA=0;
        LdM=0; resetM=0;
        LdQ=0; resetQ=0;
        Ldq=0; resetq=0;
        Ld_Count=0; reset_Count=0;
        shift=0; ctrl=1; dec=0;
    end
    S8:
    begin
        LdA=0; resetA=0;
        LdM=0; resetM=0;
        LdQ=0; resetQ=0;
        Ldq=1; resetq=0;
        Ld_Count=0; reset_Count=0;
        shift=1; ctrl=0; dec=1;
    end
    S9:
    begin
        LdA=0; resetA=0;
        LdM=0; resetM=0;
        LdQ=0; resetQ=0;
        Ldq=0; resetq=0;
        Ld_Count=0; reset_Count=0;
        shift=0; ctrl=0; dec=0;
    end
    S10: done=1;
    S11:
    begin
            LdA=0; resetA=0;
            LdM=0; resetM=0;
            LdQ=0; resetQ=0;
            Ldq=0; resetq=0;
            Ld_Count=0; reset_Count=0;
            shift=0; ctrl=0; dec=0;
            done=0; 
    end
    endcase
   end
   
   assign out=data;
   
endmodule
