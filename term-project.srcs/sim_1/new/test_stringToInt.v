`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 08:23:00 PM
// Design Name: 
// Module Name: test_stringToInt
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


module test_stringToInt(

    );
    
//    wire [23:0] u, l, l2;
//    stringToInt s2i_u(u, 4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6);
//    stringToInt s2i_l(l, 4'd5, 4'd4, 4'd3, 4'd2, 4'd1, 4'd0);
//    upperToLower u2l(l2, l);
    
    wire [47:0] all;
    stringToFixedPoint s2fp(all, 4'd0, 4'd0, 4'd0, 4'd5, 4'd3, 4'd9, 4'd0, 4'd6, 4'd2, 4'd5, 4'd0, 4'd0);
    
    wire [47:0] all2;
    stringToFixedPoint s2fp2(all2, 4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd5, 4'd4, 4'd3, 4'd2, 4'd1, 4'd0);
    
    wire [3:0] u6, u5, u4, u3, u2, u1;
    wire [3:0] l6, l5, l4, l3, l2, l1;
    upperToString u2s(u6, u5, u4, u3, u2, u1, all[47:24]);
    lowerToString l2s(l6, l5, l4, l3, l2, l1, all[23:0]);
//    upperToString u2s(u6, u5, u4, u3, u2, u1, all2[47:24]);
//    lowerToString l2s(l6, l5, l4, l3, l2, l1, all2[23:0]);
    
    initial
    begin
        #100 $finish;
    end
endmodule
