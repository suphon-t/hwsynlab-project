`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 02:36:40 PM
// Design Name: 
// Module Name: test_sqrt
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


module test_sqrt(

    );
    
    reg clk = 0;
    always #1 clk = ~clk;
    
    reg [47:0] d = { 24'd140, 24'd0 };
    wire [47:0] s;
    
    sqrt sqrt(busy, done, s, clk, 1, d);
    
    initial
    #200 $finish;
endmodule
