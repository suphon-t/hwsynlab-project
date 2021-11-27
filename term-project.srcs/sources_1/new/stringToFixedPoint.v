`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 07:45:35 PM
// Design Name: 
// Module Name: stringToFixedPoint
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


module stringToFixedPoint(
    output [47:0] s,
    input [3:0] u6,
    input [3:0] u5,
    input [3:0] u4,
    input [3:0] u3,
    input [3:0] u2,
    input [3:0] u1,
    input [3:0] l6,
    input [3:0] l5,
    input [3:0] l4,
    input [3:0] l3,
    input [3:0] l2,
    input [3:0] l1
    );
    wire [23:0] u, l;
    stringToInt s2i_u(u, u6, u5, u4, u3, u2, u1);
    stringToInt s2i_l(l, l6, l5, l4, l3, l2, l1);
    wire [23:0] tmp;
    upperToLower u2l(tmp, l);
    assign s = { u, tmp };
endmodule
