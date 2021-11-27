`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 11:55:23 AM
// Design Name: 
// Module Name: multiplier
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


module multiplier(
    output [47:0] s,
    input [47:0] a,
    input [47:0] b
    );
    wire [95:0] tmp;
    wire [95:0] a_extended;
    wire sign;
    assign sign = a[47];
    assign a_extended = { {24{sign}}, a, 24'd0 };
    assign tmp = a_extended * b;
    assign s = tmp[95:48];
endmodule
