module booth_tb();
parameter N = 8;
reg [N-1:0] data_inM,data_inQ;
reg start,clk_100MHz;
wire [N+N-1:0] ans;

booth #(.N(N),.alpha(3)) bt(start,clk_100MHz,data_inM,data_inQ,ans);
initial 
begin
start = 0;
clk_100MHz = 1'b0;
end
always #5 clk_100MHz=~clk_100MHz;
initial 
begin
//#15 data_inM=8'b00011111;data_inQ=8'b00100111;

#15 data_inM=8'b00000111;data_inQ=8'b11111010;
#3 start=1;
#10 start=0;

 $display($time,"data_inM=%b,data_inQ=%b,ans=%b",data_inM,data_inQ,ans);
#300 $finish;
end
endmodule
