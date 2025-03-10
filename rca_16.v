`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2025 15:27:52
// Design Name: 
// Module Name: rca_16
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


module rca_16(x, y, cin, s, co);
input [15:0] x, y;
input cin;
output [15:0] s;
output co;
wire c1, c2, c3;
rca_4 g0 (x[3:0], y[3:0], cin, s[3:0], c1);
rca_4 g1 (x[7:4], y[7:4], c1, s[7:4], c2);
rca_4 g2 (x[11:8], y[11:8], c2, s[11:8], c3);
rca_4 g3 (x[15:12], y[15:12], c3, s[15:12], co);
endmodule

module rca_4(x, y, cin, s, co);
input [3:0] x, y;
input cin;
output [3:0] s;
output co;
wire w1, w2, w3;
fulladder u1(x[0], y[0], cin, s[0], w1);
fulladder u2(x[1], y[1], w1, s[1], w2);
fulladder u3(x[2], y[2], w2, s[2], w3);
fulladder u4(x[3], y[3], w3, s[3], co);
endmodule

module fulladder(x, y, ci, s, co);
input x, y, ci;
output s, co;
wire w1, w2, w3;  
xor l1(w1, x, y);
xor l2(s, w1, ci);
and l3(w2, w1, ci);
and l4(w3, x, y);
or l5(co, w2, w3);
endmodule
