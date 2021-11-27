`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 09:13:18 AM
// Design Name: 
// Module Name: test_calculator
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


module test_calculator(

    );
    
    reg clock = 0;
    always
    #2 clock = ~clock;
    
    wire [151:0] tx_data;
    wire [7:0] tx_len;
    
    reg [7:0] rx_data = 0;
    reg rx_received = 0;
    
    wire [3:0] debug_state, debug_input_stage;
    
    calculator calculator(
        .tx_data(tx_data),
        .tx_len(tx_len),
        .tx_ena(tx_ena),
        .tx_sending(tx_sending),
        .tx_sent(tx_sent),
        
        .rx_data(rx_data),
        .rx_received(rx_received),
        
        .clock(clock),
        
        .state(debug_state),
        .input_stage(debug_input_stage)
    );
    
    sim_uart_tx #(.LEN(19)) tx(clock, tx_data, tx_len, tx_ena, tx_sending, tx_sent);
    
    initial
    begin
        #14
        rx_data = `ASCII_MINUS;
        rx_received = 1;
        #2
        rx_received = 0;
        
        #10
        $finish;
    end
endmodule
