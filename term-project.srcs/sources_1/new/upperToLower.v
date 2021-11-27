`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 08:17:23 PM
// Design Name: 
// Module Name: upperToLower
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


module upperToLower(
    output [23:0] s,
    input [23:0] a
    );
    parameter PRECISION = 24;
    wire [23:0] tmp [PRECISION-1:0]; 
    assign tmp[23] = a;
    wire [23:0] oneMil;
    assign oneMil = 24'd1000000;
    genvar c;
    generate for (c = PRECISION-1; c > 0; c = c - 1)
    begin
        wire [23:0] tmp2 = tmp[c] << 1'd1;
        assign s[c] = tmp2 >= oneMil;
        assign tmp[c - 1] = s[c] ? tmp2 - oneMil : tmp2;
    end
    endgenerate
    assign s[0] = (tmp[0] + tmp[0]) >= oneMil;
endmodule
