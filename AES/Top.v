`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 22:49:21
// Design Name: 
// Module Name: Top
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


module Top(
    input clk,
    input reset,
    input data_valid_in,
    input cipherkey_valid_in,
    input [127:0] cipher_key,
    input [127:0] plain_text,
    output [127:0] cipher_text_E,
    output [127:0] plain_text_D,
    output E_valid,
    output D_valid

    );
    
    wire valid_out_E;
    wire valid_out_D;
    wire cipher_text=cipher_text_E;
    assign E_valid=valid_out_E;
    assign D_valid=valid_out_D;
    Encryption E_AES(.clk(clk),.reset(reset),.data_valid_in(data_valid_in),.cipherkey_valid_in(cipherkey_valid_in),.cipher_key(cipher_key),.plain_text(plain_text),.valid_out(valid_out_E),.cipher_text(cipher_text_E));
    
    reg [127:0] cipher_text_D,valid_in_D;
    always@(posedge clk)
    begin
        if(valid_out_E)
        begin
        cipher_text_D<=cipher_text_E;
        valid_in_D<=1;
        end
        else
        valid_in_D<=0;
    end
    Decryption D_AES(.clk(clk),.reset(reset),.data_valid_in(valid_in_D),.cipherkey_valid_in(valid_in_D),.cipher_key(cipher_key),.plain_text(cipher_text_D),.valid_out(valid_out_D),.cipher_text(plain_text_D));
endmodule
