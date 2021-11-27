`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 12:24:16 PM
// Design Name: 
// Module Name: test_divider
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


module test_divider(

    );
    
    reg clk = 0;
    always #1 clk = ~clk;
    
    reg [47:0] a = { 24'd1, 24'd0 };
    reg [47:0] b = { 24'd0, 1'd1, 23'd0 };
    wire [47:0] s;
    
    divider divider(busy, done, s, clk, 1, a, b);
    
    initial
    #200 $finish;
endmodule
