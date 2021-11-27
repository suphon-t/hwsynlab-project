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
    
    assign done = count == 8'd48;
    reg busy = 0;
    
    reg [7:0] count;
    reg [47:0] q;
    reg [48:0] r;
    reg [95:0] tmp_d;
    
    assign s = q;
    
    always @(posedge clk)
    begin
        if (~busy & start) begin
            busy <= 1;
            count <= 0;
            q <= 0;
            r <= 0;
            tmp_d <= { 24'd0, d, 24'd0 }; 
        end
        if (busy & ~done) begin
            if (~r[48]) begin
                r = { r[46:0], tmp_d[95:94] };
                r = r - { q[45:0], 2'd1 };
            end
            else begin
                r = { r[46:0], tmp_d[95:94] };
                r = r + { q[45:0], 2'd3 };
            end
            if (~r[48]) begin
                q = { q[46:0], 1'd1 };
            end
            else begin
                q = { q[46:0], 1'd0 };
            end
            tmp_d = { tmp_d[93:0], 2'd0 };
            count = count + 1;
        end
        if (busy & done) busy <= 0;
    end
endmodule
