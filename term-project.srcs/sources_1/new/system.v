`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 11:13:19 PM
// Design Name: 
// Module Name: system
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


module system(
    output wire [1:0] led,
    output wire RsTx,
    input wire RsRx,
    input clock
    );
    
    wire [151:0] tx_data;
    wire [7:0] tx_len;
    
    wire [7:0] rx_data;
    wire rx_received;
    
    assign led[0] = ~RsRx;
    assign led[1] = rx_received;
    
    baudrate_gen baudrate_gen(clock, baud);
    uart_rx receiver(baud, RsRx, rx_received, rx_data);
    uart_tx_buffer #(.LEN(19)) transmitter(baud, tx_data, tx_len, tx_ena, tx_sending, tx_sent, RsTx);
    
    calculator calculator(
        .tx_data(tx_data),
        .tx_len(tx_len),
        .tx_ena(tx_ena),
        .tx_sending(tx_sending),
        .tx_sent(tx_sent),
        
        .rx_data(rx_data),
        .rx_received(rx_received),
        
        .clock(baud)
    );
    
//    reg ena = 0;
    
//    wire [47:0] all;
//    stringToFixedPoint s2fp(all, 4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd5, 4'd4, 4'd3, 4'd2, 4'd1, 4'd0);
    
//    wire [3:0] u6, u5, u4, u3, u2, u1;
//    wire [3:0] l6, l5, l4, l3, l2, l1;
//    fixedPointToString fp2s(u6, u5, u4, u3, u2, u1, l6, l5, l4, l3, l2, l1, all);
    
//    wire [151:0] data_in;
//    assign data_in = {
//    //  \r     \n     space
//        8'h0d, 8'h0a, 8'h20, 
//        u6 + 8'h30, u5 + 8'h30, u4 + 8'h30, u3 + 8'h30, u2 + 8'h30, u1 + 8'h30, 
//        8'h2e,
//        l6 + 8'h30, l5 + 8'h30, l4 + 8'h30, l3 + 8'h30, l2 + 8'h30, l1 + 8'h30, 
//        8'h20, 8'h3e, 8'h20
//    };
//    baudrate_gen baudrate_gen(clock, baud);
//    uart_tx_buffer #(.LEN(19)) transmitter(baud, data_in, 8'd19, ena, sending, sent, RsTx);
    
//    always @(posedge baud)
//    ena = ~ena;
endmodule
