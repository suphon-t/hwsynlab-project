`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 12:04:21 PM
// Design Name: 
// Module Name: test_multiplier
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


module test_multiplier(

    );
    
    reg [47:0] a = { 24'd3, 24'd0 };
    reg [47:0] b = { 24'd2, 24'd0 };
    wire [47:0] s;
    
    multiplier multiplier(s, a, b);
endmodule
