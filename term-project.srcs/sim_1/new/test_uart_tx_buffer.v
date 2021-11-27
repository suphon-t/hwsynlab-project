`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 11:59:02 PM
// Design Name: 
// Module Name: test_uart_tx_buffer
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


module test_uart_tx_buffer(

    );
    
    reg clk = 0;
    always #1 clk = ~clk;
    
    reg ena, sent;
    initial
    begin
    ena = 0;
    end
    
    always
    #2 ena = ~ena;
    
    reg [15:0] data_transmit = { 8'd10, 8'd97 };
    
    parameter LEN = 2;
    
    reg last_ena;
    reg last_tx_sent;
    reg tx_ena;
    reg sending = 0;
    reg [7:0] count;
    reg [(LEN+1)*8-1:0] send_buf;
    
    uart_tx transmitter(clk, send_buf[(LEN+1)*8-1:LEN*8], tx_ena, tx_sent, bit_out);
    
    always @(posedge clk)
    begin
        if (~sending & ~last_ena & ena) begin
            send_buf <= { 8'd0, data_transmit };
            sending <= 1;
            sent <= 0;
            tx_ena <= 0;
            count <= 8'd255; 
        end
        
        if (sending & ~tx_ena & count != LEN-1) begin
            count <= count + 1;
            send_buf <= { send_buf[LEN*8-1:0], 8'd0 };
            tx_ena <= 1;
        end
        
        if (tx_sent & ~last_tx_sent) begin
            tx_ena <= 0;
            if (count == LEN-1) begin
                sent <= 1;
                sending <= 0;
            end
        end
        
        last_tx_sent <= tx_sent;
        last_ena <= ena;
    end
endmodule
