`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 07:48:56 PM
// Design Name: 
// Module Name: stringToInt
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


module stringToInt(
    output [23:0] s,
    input [3:0] a6,
    input [3:0] a5,
    input [3:0] a4,
    input [3:0] a3,
    input [3:0] a2,
    input [3:0] a1
    );
    wire [23:0] a6v = a6 * 24'd100000;
    wire [23:0] a5v = a5 * 24'd10000;
    wire [23:0] tmp1 = a6v + a5v;
    wire [23:0] a4v = a4 * 24'd1000;
    wire [23:0] a3v = a3 * 24'd100;
    wire [23:0] tmp2 = a4v + a3v;
    wire [23:0] a2v = a2 * 24'd10;
    wire [23:0] a1v = a1;
    wire [23:0] tmp3 = a2v + a1v;
    assign s = tmp1 + tmp2 + tmp3;
endmodule
