module Div #(parameter n=4) (

    input clk,
    input reset,
    input [n-1:0] divisor,
    input [n-1:0] dividend,
    input start,
    output [n-1:0] remainder,
    output [n-1:0] quotient,
    output reg done

);

    reg [n-1:0] A,Q,M;
    reg [3:0] m;
    reg sign,restore;
    reg ctrl1,ctrl2,ctrl3,ctrl4;
    
    assign remainder=(m==n)?A:0;
    assign quotient=(m==n)?Q:0;
       
    always @(posedge clk)
    begin
        if(m==n)
            done<=1;
        else
            done<=0;
    end
    
    always @(posedge clk)
    begin
        if(reset)
        begin
            A<=0; 
            Q<=0;
            M<=0;
            m<=0;
            restore<=0; 
            ctrl1<=0;
            ctrl2<=0;
            ctrl3<=0;
            ctrl4<=0;
            sign<=0;
        end
        else if(start)
        begin
            A<={n{dividend[n-1]}}; 
            Q<=dividend;
            M<=divisor;
            m<=0;
            restore<=0; 
            ctrl1<=1;
        end
        else if(ctrl1==1)
        begin
            A<={A[n-2:0],Q[n-1]};
            Q<=Q<<1;
            ctrl1<=0;
            ctrl2<=1;
        end
        else if(ctrl2==1)
        begin
            if(A[n-1]==M[n-1])
            begin
                A<=A-M;
                restore<=1;
            end
            else
            begin
                A<=A+M;
                restore<=0;
            end
            sign<=A[n-1];
            ctrl2<=0;
            ctrl3<=1;  
        end
        else if(ctrl3==1)
        begin
            if(A[n-1]==sign || (({A,Q} & {(2*n){1'b1}} << m)==0))
            begin
                Q[0]<=1;
                ctrl4<=0;
                m=m+1;
                if(m==n)
                begin
                    ctrl1<=0;
                end
                else
                ctrl1<=1;
            end
            else
            begin
                Q[0]<=0;
                ctrl4<=1;
            end
            ctrl3<=0;
        end
        else if(ctrl4==1)
        begin
           if(restore==0)
                A<=A-M;
           else
                A<=A+M;
           ctrl4<=0;
           m=m+1;
           if(m==n)
           begin
                ctrl1<=0;
           end
           else
                ctrl1<=1;
           end
    end    
endmodule
