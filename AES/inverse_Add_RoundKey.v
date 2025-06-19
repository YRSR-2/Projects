`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 22:21:55
// Design Name: 
// Module Name: inverse_Add_RoundKey
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


module inverse_Add_RoundKey#(parameter DATA_W = 128)  //data width          
(
    input clk,                        //system clock
    input reset,                      //asynch active low reset
    input data_valid_in,              //data valid signal
    //input key_valid_in,               //key valid signal  
    input [DATA_W-1:0] data_in,       //input data
    input [DATA_W-1:0] round_key,     //input round key
    output reg valid_out,             //output valid signal
    output reg [DATA_W-1:0] data_out  //output data
);

always@(posedge clk or negedge reset)
    begin
    
        if(!reset)
        begin
            data_out <= 'b0;
            valid_out <= 1'b0;
        end
        else 
        begin
            if(data_valid_in /*&& key_valid_in*/)
            begin
                data_out <=  data_in ^ round_key;      //xoring data and round key       
            end
            valid_out <=  data_valid_in;// & key_valid_in;
        end
    end
endmodule
