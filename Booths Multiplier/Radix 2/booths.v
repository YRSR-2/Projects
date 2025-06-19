//module for the accumulator
module accumulator(lda,clk,shfta,clra,z,a);
parameter N=8;
parameter alpha=3;
input lda,clk,shfta,clra;
input [N-1:0] z;
output reg [N-1:0]a;
always @(posedge clk)
if(clra) a[N-1:0]<=0;
else if(lda) a[N-1:0]<=z[N-1:0];
else if(shfta) a[N-1:0]<={a[N-1],a[N-1:1]};
endmodule

// module for multiplier
module multiplier(clk,ldq,data_inQ,shftq,clrq,prev,q);
parameter N=8;
parameter alpha=3;
input clk,ldq,shftq,clrq,prev;
input [N-1:0] data_inQ;
output reg [N-1:0] q;
always @(posedge clk)
if(clrq==1'b1) q[N-1:0]<=0;
else if(ldq==1'b1) q[N-1:0]<=data_inQ;
else if(shftq==1'b1) q[N-1:0]<={prev,q[N-1:1]};
endmodule

// module for qm1
module store(shftff,clk,clrff,prev,qm1);
input shftff,clk,clrff,prev;
output reg qm1;
always@(posedge clk)
if(clrff==1'b1) qm1<=1'b0;
else if(shftff==1'b1) qm1<=prev;
endmodule

// module for alu
module ALU(a,m,addsub,clk,z);
parameter N=8;
parameter alpha=3;
input [N-1:0] a,m;
input addsub,clk;
output reg [N-1:0] z;
always@(posedge clk)
if(addsub==1'b1) z[N-1:0]<= a[N-1:0]+m[N-1:0];
else if(addsub==1'b0) z[N-1:0]<=a[N-1:0]-m[N-1:0];
endmodule

// module for multiplicand
module multiplicand(ldm,clrm,clk,data_inM,m);
parameter N=8;
parameter alpha=3;
input ldm,clk,clrm;
input [N-1:0] data_inM;
output reg [N-1:0] m;
always@(posedge clk)
if(clrm==1'b1) m[N-1:0]<=0;
else if(ldm==1'b1) m[N-1:0]<=data_inM;
endmodule

// module for counter
module counter(clk,decr,ldcount,count);
parameter N=8;
parameter alpha=3;
input clk,decr,ldcount;
output reg[alpha:0]count;
always @(ldcount,decr)
if(ldcount==1'b1) count<=N;
else if(decr==1'b1) count <= count-1;
endmodule

//module for comparator
module comparator(clk,q0,qm1,comp,value);
input clk,q0,qm1,comp;
output reg[1:0] value;
always@(comp)
if(comp==1'b1) value<={q0,qm1};
endmodule 

// module for ans
module finalans(clk,a,q,ans);
parameter N=8;
parameter alpha=3;
input clk;
input [N-1:0] a,q;
output reg [(N+N)-1:0] ans;
always @(posedge clk)
ans[(N+N)-1:0]<={a,q};
endmodule

// mdoule for datapath

module datapath(clk,clra,lda,shfta,ldq,data_inQ,shftq,clrq,shftff,clrff,addsub,data_inM,ldm,clrm,ldcount,decr,comp,ans,count,value,a,q,qm1);
parameter N=8;
parameter alpha=3;
input clk,clra,lda,shfta,ldq,shftq,clrq,shftff,clrff,addsub,ldm,clrm,ldcount,decr,comp;
input [N-1:0] data_inQ,data_inM;
output wire [(N+N)-1:0] ans;
output wire[1:0] value;
output wire[alpha:0] count;
wire [N-1:0] z,m;
output [N-1:0] a,q;
output qm1;
finalans result(clk,a,q,ans);
comparator co(clk,q[0],qm1,comp,value);
counter cnt(clk,decr,ldcount,count);
multiplicand mut(ldm,clrm,clk,data_inM,m);
ALU alu(a,m,addsub,clk,z);
store str(shftff,clk,clrff,q[0],qm1);
multiplier mult(clk,ldq,data_inQ,shftq,clrq,a[0],q);
accumulator acc(lda,clk,shfta,clra,z,a);
endmodule

// module for controlpath

module controlpath(clk,clra,lda,shfta,ldq,data_inQ,shftq,clrq,shftff,clrff,addsub,data_inM,ldm,clrm,ldcount,decr,comp,count,value,start,state);
parameter N=8;
parameter alpha=3;
input [alpha:0] count;
input [1:0] value;
input start;
input clk;
output  reg clra,lda,shfta,ldq,shftq,clrq,shftff,clrff,addsub,ldm,clrm,ldcount,decr,comp;
input [N-1:0] data_inQ,data_inM;
parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100,s5=3'b101,s6=3'b110,s7=3'b111;
output reg [2:0] state;

always @(posedge clk)
case(state)
    s0: if(start) state<=s1;
    s1: state<=s2;
    s2: if(value==2'b01) state<=s3;
        else if(value==2'b10) state<=s4;
        else state<=s5;
    s3: state<=s7;
    s4: state<=s7;
    s5: if(count==0) state<=s6;
        else state<=s2;
    s6: state<=s6;
    s7: state<=s5;
    default : state <= s0;
   endcase

always @(state)
case(state)
 s0 : begin
      clrm<=1'b1;
      clrq<=1'b1;
      clra<=1'b1;
      clrff<=1'b1;
      lda<=1'b0;
      shfta<=1'b0;
      ldq<=1'b0;
      shftq<=1'b0;
      shftff<=1'b0;
      addsub<=1'b0;
      ldm<=1'b0;
      ldcount<=1'b0;
      decr<=1'b0;
      comp<=1'b0;
      end
      
 s1: begin
     clrm<=1'b0;
     clrq<=1'b0;
     clra<=1'b0;
     clrff<=1'b0;
     ldq<=1'b1;
     ldm<=1'b1;
     ldcount<=1'b1;
     end

 s2: begin
     ldm<=1'b0;
     ldcount<=1'b0;
     ldq<=1'b0;
     shfta<=1'b0;
     shftq<=1'b0;
     shftff<=1'b0;
     comp<=1'b1;
     decr<=1'b0;
     end
 s3: begin
        comp<=1'b0;
        addsub<=1'b1;
     end
 s4: begin
        comp=1'b0;
        addsub=1'b0;
     end
 s5: begin
        comp<=1'b0;
        shfta<=1'b1;
        shftq<=1'b1;
        shftff<=1'b1;
        decr<=1'b1;
        lda<=1'b0;
     end
  s6: begin
        clrm<=1'b1;
        clrq<=1'b0;
        clra<=1'b0;
        clrff<=1'b0;
        lda<=1'b0;
        shfta<=1'b0;
        ldq<=1'b0;
        shftq<=1'b0;
        shftff<=1'b0;
        addsub<=1'b0;
        ldm<=1'b0;
        ldcount<=1'b0;
        decr<=1'b0;
        comp<=1'b0;
      end
  s7:  begin
       lda<=1'b1;
          end
  default: begin
            clrm<=1'b1;
        clrq<=1'b1;
        clra<=1'b1;
        clrff<=1'b1;
        lda<=1'b0;
        shfta<=1'b0;
        ldq<=1'b0;
        shftq<=1'b0;
        shftff<=1'b0;
        addsub<=1'b0;
        ldm<=1'b0;
        ldcount<=1'b0;
        decr<=1'b0;
        comp<=1'b0;
           end
endcase
endmodule


module booth(start,clk,data_inM,data_inQ,ans);
input start,clk;
parameter N= 8;
parameter alpha = 3;
input [N-1:0] data_inM,data_inQ;
output [N+N-1:0] ans;

wire clra,lda,shfta,ldq,shftq,clrq,shftff,clrff,addsub,ldm,clrm,ldcount,decr,qm1;
wire [1:0] comp,value;
wire [alpha:0] count;
wire [N-1:0] a,q;
wire [2:0] state;
wire reset;
assign reset =1'b0;

datapath dp1(clk,clra,lda,shfta,ldq,data_inQ,shftq,clrq,shftff,clrff,addsub,data_inM,ldm,clrm,ldcount,decr,comp,ans,count,value,a,q,qm1);
controlpath cp1(clk,clra,lda,shfta,ldq,data_inQ,shftq,clrq,shftff,clrff,addsub,data_inM,ldm,clrm,ldcount,decr,comp,count,value,start,state);

endmodule
