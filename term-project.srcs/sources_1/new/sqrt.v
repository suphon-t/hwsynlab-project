`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 02:36:59 PM
// Design Name: 
// Module Name: sqrt
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


module sqrt(
    output busy,
    output done,
    output [47:0] s,
    input clk,
    input start,
    input [47:0] d
    );
    
    assign done = count == 8'd24;
    reg busy = 0;
    
    reg [7:0] count;
    reg [23:0] q;
    reg [24:0] r;
    reg [47:0] tmp_d;
    
    assign s = { 12'd0, q, 12'd0 };
    
    always @(posedge clk)
    begin
        if (~busy & start) begin
            busy <= 1;
            count <= 0;
            q <= 0;
            r <= 0;
            tmp_d <= d; 
        end
        if (busy & ~done) begin
            if (~r[24]) begin
                r = { r[22:0], tmp_d[47:46] };
                r = r - { q[21:0], 2'd1 };
            end
            else begin
                r = { r[22:0], tmp_d[47:46] };
                r = r + { q[21:0], 2'd3 };
            end
            if (~r[24]) begin
                q = { q[22:0], 1'd1 };
            end
            else begin
                q = { q[22:0], 1'd0 };
            end
            tmp_d = { tmp_d[45:0], 2'd0 };
            count = count + 1;
        end
        if (busy & done) busy <= 0;
    end
endmodule
