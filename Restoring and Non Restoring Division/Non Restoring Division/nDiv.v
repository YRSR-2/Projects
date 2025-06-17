module nDiv #(parameter n=8) (

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
    reg restore;
    reg ctrl1,ctrl2,ctrl3;
    
    assign remainder=(done==1)?A:0;
    assign quotient=(done==1)?Q:0;
    
    always@(posedge clk)
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
        end
        else if(start)
        begin
            A<=0;
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
            if(m!=n)
            begin
                if(restore)
                    A<=A+M;
                else
                    A<=A-M;
                ctrl3<=1;
                ctrl2<=0;
            end
            else
            begin
                if(restore)
                    A<=A+M;
            ctrl2<=0;
            end              
        end
        else if(ctrl3==1)
        begin
            if(A[n-1]==0)
            begin
                Q[0]=1;
                restore<=0;
            end
            else
            begin
                Q[0]=0;
                restore<=1;
            end
            ctrl3<=0;
            m=m+1;
            if(m==n)
            begin
                ctrl2<=1;
            end
            else
                ctrl1<=1;
        end
    end
endmodule
