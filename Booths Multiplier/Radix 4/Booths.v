// Modified Booth Multiplier (Radix-4) 

// Module for accumulator
module accumulator #(parameter N=8) (
    input lda, clk, shfta, clra,
    input [N-1:0] z,
    output reg [N-1:0] a
);
always @(posedge clk)
begin
    if(clra) a <= 0;
    else if(lda) a <= z;
    else if(shfta) a <= { {2{a[N-1]}}, a[N-1:2] }; // Proper 2-bit arithmetic right shift
end
endmodule

// Module for multiplier
module multiplier #(parameter N=8) (
    input clk, ldq, shftq, clrq,
    input [1:0] prev,
    input [N-1:0] data_inQ,
    output reg [N-1:0] q
);
always @(posedge clk)
begin
    if(clrq) q <= 0;
    else if(ldq) q <= data_inQ;
    else if(shftq) q <= {prev, q[N-1:2]}; // Shift right by 2
end
endmodule

// Module for storing previous 2 bits (qm1 and qm2)
module store #(parameter N=8) (
    input clk, shftff, clrff,
    input [1:0] prev,
    output reg [1:0] qm
);
always @(posedge clk)
begin
    if(clrff) qm <= 2'b00;
    else if(shftff) qm <= prev;
end
endmodule

// ALU for Radix-4 Booth
module ALU #(parameter N=8) (
    input [N-1:0] a, m,
    input [2:0] booth_bits, // Full Booth encoding
    //input clk,
    output reg [N-1:0] z
);
always @(*)//posedge clk)
begin
    case(booth_bits)
        3'b000, 3'b111: z = a;                // No operation
        3'b001, 3'b010: z = a + m;            // +M
        3'b101, 3'b110: z = a - m;            // -M
        3'b011:         z = a + (m << 1);     // +2M
        3'b100:         z = a - (m << 1);     // -2M
        default:        z = a;
    endcase
end
endmodule

// Module for multiplicand
module multiplicand #(parameter N=8) (
    input ldm, clrm, clk,
    input [N-1:0] data_inM,
    output reg [N-1:0] m
);
always @(posedge clk)
begin
    if(clrm) m <= 0;
    else if(ldm) m <= data_inM;
end
endmodule

// Counter for Radix-4 (needs N/2 counts)
module counter #(parameter alpha=3, parameter N=8) (
    input clk, decr, ldcount,
    output reg [alpha:0] count
);
always @(posedge clk)
begin
    if(ldcount) count <= N >> 1; // divide by 2
    else if(decr) count <= count - 1;
end
endmodule

// Result combining module
module finalans #(parameter N=8) (
    input clk,
    input [N-1:0] a, q,
    output reg [(2*N)-1:0] ans
);
always @(posedge clk)
    ans <= {a, q};
endmodule

// Datapath
module datapath #(parameter N=8, parameter alpha=3) (
    input clk, clra, lda, shfta,
    input ldq, shftq, clrq, shftff, clrff,
    input [N-1:0] data_inQ, data_inM,
    input ldm, clrm, ldcount, decr,
    output [(2*N)-1:0] ans,
    output [alpha:0] count,
    output [2:0] booth_bits,
    output [N-1:0] a, q,m
);
wire [N-1:0]  z;
wire [1:0] qm;
assign ans={a,q};
assign booth_bits = {q[1:0], qm[1]};

//finalans fa(clk, a, q, ans);
counter cnt(clk, decr, ldcount, count);
multiplicand mul(ldm, clrm, clk, data_inM, m);
ALU alu(a, m, booth_bits, z);
store storebits(clk, shftff, clrff, q[1:0], qm);
multiplier mult(clk, ldq, shftq, clrq, a[1:0], data_inQ, q);
accumulator acc(lda, clk, shfta, clra, z, a);
endmodule

// Controlpath
module controlpath #(parameter N=8, parameter alpha=3) (
    input clk,
    input [alpha:0] count,
    input start,
    output reg clra, lda, shfta, ldq, shftq, clrq,
    output reg shftff, clrff, ldm, clrm,
    output reg ldcount, decr,
    output reg [2:0] state
);
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011,
          s4=3'b100, s5=3'b101, s6=3'b110, s7=3'b111;

always @(posedge clk)
begin
    case(state)
        s0: if(start) state <= s1;
        s1: state <= s2;
        s2: state <= s3;
        s3: state <= s4;
        s4: state <= (count == 0) ? s5 : s2;
        s5: state <= s5;
        default: state <= s0;
    endcase
end

always @(state)
begin
    
    case(state)
        s0: begin
                shftff<=1'b0;
                clrm<=1'b1;
                clrq<=1'b1;
                clra<=1'b1;
                clrff<=1'b1;
                lda<=1'b0;
                shfta<=1'b0;
                ldq<=1'b0;
                shftq<=1'b0;
                ldm<=1'b0;
                ldcount<=1'b0;
                decr<=1'b0; 
            end
        s1: begin
                 ldm<=1; ldq<=1; ldcount<=1;
                 clrm<=0;
                 clrq<=0;
                 clra<=0;
                 clrff<=0; 
            end
        s2: begin
                ldm<=0;
                ldq<=0;
                ldcount<=0;
                lda<=1; 
            end
        s3: begin
                 lda<=0;
                 shftq<=1;
                 shfta<=1;
                 shftff<=1;
                 decr<=1;
            end
        s4: begin
                shfta<=0; shftq<=0; shftff<=0; decr<=0;
                
            end
        s5: begin
                shftff<=1'b0;
                clrm<=1'b1;
                clrq<=1'b0;
                clra<=1'b0;
                clrff<=1'b0;
                lda<=1'b0;
                shfta<=1'b0;
                ldq<=1'b0;
                shftq<=1'b0;
                ldm<=1'b0;
                ldcount<=1'b0;
                decr<=1'b0; 
            end 
    endcase
end
endmodule

// Top module
module booth #(parameter N=8, parameter alpha=3) (
    input start, clk,
    input [N-1:0] data_inM, data_inQ,
    output [2*N-1:0] ans
);
wire clra,  shfta,  shftq, clrq, shftff, clrff;
wire  clrm, ldcount, decr,ldq,ldm,lda;
wire [2:0] state;
wire [alpha:0] count;
wire [2:0] booth_bits;
wire [N-1:0] m,a, q;

datapath #(N, alpha) dp(clk, clra, lda, shfta, ldq, shftq, clrq, shftff, clrff,data_inQ, data_inM, ldm, clrm, ldcount, decr,ans, count, booth_bits, a, q,m);

controlpath #(N, alpha) cp(clk, count, start,clra, lda, shfta, ldq, shftq, clrq,shftff, clrff, ldm, clrm,ldcount, decr, state);
endmodule
