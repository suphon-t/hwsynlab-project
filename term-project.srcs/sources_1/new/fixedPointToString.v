`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 09:16:05 PM
// Design Name: 
// Module Name: fixedPointToString
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


module fixedPointToString(
    output is_neg, 
    output [3:0] u6,
    output [3:0] u5,
    output [3:0] u4,
    output [3:0] u3,
    output [3:0] u2,
    output [3:0] u1,
    output [3:0] l6,
    output [3:0] l5,
    output [3:0] l4,
    output [3:0] l3,
    output [3:0] l2,
    output [3:0] l1,
    input [47:0] a
    );
    assign is_neg = a[47];
    wire [47:0] to_parse;
    assign to_parse = is_neg ? -a : a;
    upperToString u2s(u6, u5, u4, u3, u2, u1, to_parse[47:24]);
    lowerToString l2s(l6, l5, l4, l3, l2, l1, to_parse[23:0]);
endmodule
