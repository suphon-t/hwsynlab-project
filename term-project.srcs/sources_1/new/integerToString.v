`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 09:21:09 PM
// Design Name: 
// Module Name: integerToString
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


module upperToString(
    output [3:0] s6,
    output [3:0] s5,
    output [3:0] s4,
    output [3:0] s3,
    output [3:0] s2,
    output [3:0] s1,
    input [23:0] a
    );
    wire [23:0] tmp[6:0];
    wire [3:0] s[5:0];
    assign tmp[6] = a;
    genvar c;
    generate for (c = 5; c >= 0; c = c - 1)
    begin
        wire [3:0] digit_val;
        wire [23:0] prev_val;
        wire [23:0] exp;
        assign prev_val = tmp[c + 1];
        assign digit_val = (prev_val >= 24'd9 * (10**c)) ? 4'd9 : (
            prev_val >= 24'd8 * (10**c) ? 4'd8 : (
            prev_val >= 24'd7 * (10**c) ? 4'd7 : (
            prev_val >= 24'd6 * (10**c) ? 4'd6 : (
            prev_val >= 24'd5 * (10**c) ? 4'd5 : (
            prev_val >= 24'd4 * (10**c) ? 4'd4 : (
            prev_val >= 24'd3 * (10**c) ? 4'd3 : (
            prev_val >= 24'd2 * (10**c) ? 4'd2 : (
            prev_val >= 24'd1 * (10**c) ? 4'd1 : 4'd0
        ))))))));
        assign tmp[c] = prev_val - (digit_val * (10**c));
        assign s[c] = digit_val;
    end
    endgenerate
    assign s6 = s[5];
    assign s5 = s[4];
    assign s4 = s[3];
    assign s3 = s[2];
    assign s2 = s[1];
    assign s1 = s[0];
endmodule


module lowerToString(
    output [3:0] s6,
    output [3:0] s5,
    output [3:0] s4,
    output [3:0] s3,
    output [3:0] s2,
    output [3:0] s1,
    input [23:0] a
    );
    wire [27:0] tmp[6:0];
    wire [3:0] s[5:0];
    assign tmp[6] = a;
    genvar c;
    generate for (c = 5; c >= 0; c = c - 1)
    begin
        assign tmp[c] = tmp[c + 1][23:0] * 28'd10;
        assign s[c] = tmp[c][27:24];
    end
    endgenerate
    assign s6 = s[5];
    assign s5 = s[4];
    assign s4 = s[3];
    assign s3 = s[2];
    assign s2 = s[1];
    assign s1 = s[0];
endmodule
