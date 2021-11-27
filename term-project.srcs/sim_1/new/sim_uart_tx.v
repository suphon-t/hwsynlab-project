`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 09:19:52 AM
// Design Name: 
// Module Name: sim_uart_tx
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


module sim_uart_tx(
    input clk,
    input [LEN*8-1:0] data_transmit,
    input [7:0] transmit_len,
    input ena,
    output sending,
    output sent
    );
    
    parameter LEN = 16;
    
    wire [(LEN+1)*8-1:0] send_buf;
    assign send_buf = { data_transmit, 8'd0 };
    
    reg prev_ena = 0;
    always @(posedge clk)
    begin
        if (~prev_ena & ena) begin
            $display("transmit: %s", send_buf);
        end
        prev_ena <= ena;
    end
    
    assign sent = prev_ena & ~ena;
endmodule
