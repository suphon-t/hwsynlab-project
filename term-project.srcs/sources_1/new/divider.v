`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 12:20:59 PM
// Design Name: 
// Module Name: divider
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


module divider(
    output busy,
    output done,
    output [47:0] s,
    input clk,
    input start,
    input [47:0] a,
    input [47:0] b
    );
    
    wire isNeg = a[47];
    wire [47:0] a_pos, s;
    assign a_pos = isNeg ? -a : a;
    assign s = isNeg ? -s_pos : s_pos;
    
    reg busy = 0;
    assign done = count == 8'd72;
    
    reg [95:0] tmp_a, tmp_b;
    wire [95:0] next_a;
    wire outputOne;
    assign outputOne = tmp_a >= tmp_b;
    assign next_a = outputOne ? tmp_a - tmp_b : tmp_a;
    
    reg [7:0] count;
    reg [47:0] s_pos;
    
    always @(posedge clk)
    begin
        if (~busy & start) begin
            busy <= 1;
            count <= 0;
            tmp_a <= { 47'd0, a_pos, 1'd0 };
            tmp_b <= { b, 48'd0 };
        end
        if (busy & ~done) begin
            tmp_a <= { next_a[94:0], 1'd0 };
            s_pos <= { s_pos[46:0], outputOne };
//            $display("--- count: %d\n%b\n%b\n%b\n", count, tmp_a, tmp_b, s);
            count <= count + 1;
        end
        if (busy & done) busy <= 0;
    end
endmodule
