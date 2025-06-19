`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2025 18:18:59
// Design Name: 
// Module Name: Top_tb
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


module Top_tb();


reg clk,reset,data_valid_in,cipherkey_valid_in;
reg [127:0] cipher_key,plain_text;
wire E_valid,D_valid;
wire [127:0] cipher_text;
wire [127:0] plain_text_D;
 Top dut(.clk(clk),.reset(reset),.data_valid_in(data_valid_in),.cipherkey_valid_in(cipherkey_valid_in),.cipher_key(cipher_key),
    .plain_text(plain_text),
    .cipher_text_E(cipher_text),
    .plain_text_D(plain_text_D),
    .E_valid(E_valid),
    .D_valid(D_valid)
    );


   
   initial
   begin
        clk=0;
        reset=1;
        data_valid_in=0;
        cipherkey_valid_in=0;
        cipher_key='b0;
        plain_text='b0;
   end
   
    always
    begin
        #3 clk=~clk;
    end 
    
    
    initial
    begin
    
        #3 reset=0;
        #5 reset=1;
        #10 cipher_key=128'h 00000000000000000000000000000000; plain_text=128'h 00000101030307070f0f1f1f3f3f7f7f;
        
        #7 data_valid_in=1;  cipherkey_valid_in=1;
        #5 data_valid_in=0;  cipherkey_valid_in=0;
        
        #3000 $finish;
        
    
    end
endmodule
