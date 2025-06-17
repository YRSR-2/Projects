module nDiv_tb#(parameter n=8)();

reg [n-1:0] divisor,dividend;
wire [n-1:0] quotient,remainder;
reg start,clk,reset;
wire done;

nDiv #(.n(n)) dut(.reset(reset),.clk(clk),.divisor(divisor),.dividend(dividend),.start(start),.remainder(remainder),.quotient(quotient),.done(done));

initial
begin
clk=0;
reset=0;
divisor=0;
dividend=0;
start=0;
end

always
begin
#5 clk=~clk;
end

initial
begin
   // #3 divisor=3; dividend=5;
    #3 divisor=8'b00000011; dividend=8'b00010111;
    #10 start=1;
    #5 start=0;
    #363 reset=1;
    #5 reset=0;
    #30 $finish;
end

endmodule
