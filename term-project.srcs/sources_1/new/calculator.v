`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 08:56:29 AM
// Design Name: 
// Module Name: calculator
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

`define STATE_INIT 4'h0
`define STATE_SEND_PROMPT 4'h1
`define STATE_WAIT_SEND_PROMPT 4'h2
`define STATE_SEND_ECHO 4'h3
`define STATE_WAIT_SEND_ECHO 4'h4
`define STATE_INPUT 4'h5
`define STATE_SHIFT_UPPER 4'h6
`define STATE_COMMIT 4'h7

`define INPUT_SPECIAL 4'h0
`define INPUT_SIGN 4'h1
`define INPUT_UPPER 4'h2
`define INPUT_DOT 4'h3
`define INPUT_LOWER 4'h4
`define INPUT_ENTER 4'h5

`define OP_ADD 4'h0
`define OP_SUB 4'h1
`define OP_MUL 4'h2
`define OP_DIV 4'h3
`define OP_SQR 4'h4
`define OP_CLR 4'h5

`define ASCII_LF 8'h0a
`define ASCII_CR 8'h0d
`define ASCII_SPACE 8'h20
`define ASCII_STAR 8'h2a
`define ASCII_PLUS 8'h2b
`define ASCII_MINUS 8'h2d
`define ASCII_DOT 8'h2e
`define ASCII_SLASH 8'h2f
`define ASCII_0 8'h30
`define ASCII_9 8'h39
`define ASCII_GT 8'h3e
`define ASCII_c 8'h63
`define ASCII_s 8'h73

module calculator(
    // output
    output wire [151:0] tx_data,
    output wire [7:0] tx_len,
    output tx_ena,
    input tx_sending,
    input tx_sent,
    // input
    input wire [7:0] rx_data,
    input rx_received,
    // clock
    input clock,
    // debug
    output state,
    output input_stage
    );
    
    reg last_received = 0;
    wire just_received;
    assign just_received = ~last_received & rx_received;
    
    reg [3:0] state = `STATE_INIT;
    reg [3:0] resume_state = `STATE_INIT;
    reg [3:0] input_stage = `INPUT_SPECIAL;
    reg [47:0] acc = 0;
    wire [47:0] b;
    reg [3:0] op = `OP_ADD;
    
    wire [47:0] a_mul_b;
    multiplier multiplier(a_mul_b, acc, b);
    
    stringToFixedPoint s2fp(b, u6, u5, u4, u3, u2, u1, l6, l5, l4, l3, l2, l1);
    
    reg [3:0] u6, u5, u4, u3, u2, u1;
    reg [3:0] l6, l5, l4, l3, l2, l1;
    reg [3:0] u_cnt;
    reg [3:0] l_cnt;
    
    wire [151:0] prompt_buf;
    prompt prompt(prompt_buf, acc);
    wire [151:0] echo_buf;
    assign echo_buf = { rx_data, 144'd0 };
    assign tx_data = (state == `STATE_SEND_PROMPT | state == `STATE_WAIT_SEND_PROMPT) ? prompt_buf : echo_buf;
    assign tx_len = (state == `STATE_SEND_PROMPT | state == `STATE_WAIT_SEND_PROMPT) ? 8'd19 : 8'd1;
    assign tx_ena = state == `STATE_SEND_PROMPT | state == `STATE_SEND_ECHO;
    
    wire is_special, is_sign, is_digit, is_dot, is_enter;
    assign is_special = rx_data == `ASCII_c | rx_data == `ASCII_s;
    assign is_sign = rx_data == `ASCII_STAR | rx_data == `ASCII_PLUS | rx_data == `ASCII_MINUS | rx_data == `ASCII_SLASH;
    assign is_digit = rx_data >= `ASCII_0 & rx_data <= `ASCII_9;
    assign is_dot = rx_data == `ASCII_DOT;
    assign is_enter = rx_data == `ASCII_CR;
    
    wire [3:0] digit_input;
    assign digit_input = rx_data - `ASCII_0;
    
    always @(posedge clock)
    begin
        if (state == `STATE_INIT) begin
            state <= `STATE_SEND_PROMPT;
            input_stage <= `INPUT_SPECIAL;
            op <= `OP_ADD;
            u6 <= 0; u5 <= 0; u4 <= 0; u3 <= 0; u2 <= 0; u1 <= 0; u_cnt <= 6;
            l6 <= 0; l5 <= 0; l4 <= 0; l3 <= 0; l2 <= 0; l1 <= 0; l_cnt <= 6;
        end
        if (state == `STATE_SEND_PROMPT)
            state <= `STATE_WAIT_SEND_PROMPT;
        if (state == `STATE_WAIT_SEND_PROMPT & tx_sent)
            state <= `STATE_INPUT;
            
        if (state == `STATE_SEND_ECHO)
            state <= `STATE_WAIT_SEND_ECHO;
        if (state == `STATE_WAIT_SEND_ECHO & tx_sent)
            state <= resume_state;
        
        if (state == `STATE_INPUT & just_received) begin
            if (input_stage <= `INPUT_SPECIAL & is_special) begin
                if (rx_data == `ASCII_c) begin
                    acc <= 0;
                    state <= `STATE_INIT;
                end
                else begin
                    state <= `STATE_INIT;
                end
            end
            if (input_stage <= `INPUT_SIGN & is_sign) begin
                case (rx_data)
                    `ASCII_PLUS: op = `OP_ADD;
                    `ASCII_MINUS: op = `OP_SUB;
                    `ASCII_STAR: op = `OP_MUL;
                    `ASCII_SLASH: op = `OP_DIV;
                endcase
                input_stage <= `INPUT_UPPER;
                resume_state <= `STATE_INPUT;
                state <= `STATE_SEND_ECHO;
            end
            if (input_stage <= `INPUT_UPPER & is_digit) begin
                case (u_cnt)
                    4'd1: u1 <= digit_input;
                    4'd2: u2 <= digit_input;
                    4'd3: u3 <= digit_input;
                    4'd4: u4 <= digit_input;
                    4'd5: u5 <= digit_input;
                    4'd6: u6 <= digit_input;
                endcase
                
                if (u_cnt != 1)
                    input_stage <= `INPUT_UPPER;
                else
                    input_stage <= `INPUT_DOT;
                
                u_cnt <= u_cnt - 1;
                resume_state <= `STATE_INPUT;
                state <= `STATE_SEND_ECHO;
            end
            if (input_stage <= `INPUT_DOT & is_dot) begin
                input_stage <= `INPUT_LOWER;
                resume_state <= `STATE_INPUT;
                state <= `STATE_SEND_ECHO;
            end
            if (input_stage == `INPUT_LOWER & is_digit) begin
                case (l_cnt)
                    4'd1: l1 <= digit_input;
                    4'd2: l2 <= digit_input;
                    4'd3: l3 <= digit_input;
                    4'd4: l4 <= digit_input;
                    4'd5: l5 <= digit_input;
                    4'd6: l6 <= digit_input;
                endcase
                
                if (l_cnt != 1)
                    input_stage <= `INPUT_LOWER;
                else
                    input_stage <= `INPUT_ENTER;
                
                l_cnt <= l_cnt - 1;
                resume_state <= `STATE_INPUT;
                state <= `STATE_SEND_ECHO;
            end
            if (input_stage <= `INPUT_ENTER & is_enter) begin
                state <= `STATE_SHIFT_UPPER;
            end
        end
        
        if (state == `STATE_SHIFT_UPPER) begin
            if (u_cnt != 0) begin
                u_cnt <= u_cnt - 1;
                u6 <= 0;
                u5 <= u6;
                u4 <= u5;
                u3 <= u4;
                u2 <= u3;
                u1 <= u2;
            end
            else
                state <= `STATE_COMMIT;
        end
        
        if (state == `STATE_COMMIT) begin
            case (op)
                `OP_ADD: acc <= acc + b;
                `OP_SUB: acc <= acc - b;
                `OP_MUL: acc <= a_mul_b;
            endcase
            state <= `STATE_INIT;
        end
        
        last_received <= rx_received;
    end
endmodule

module prompt(
    output wire [151:0] out, 
    input wire [47:0] acc
    );
    
    wire [3:0] u6, u5, u4, u3, u2, u1;
    wire [3:0] l6, l5, l4, l3, l2, l1;
    fixedPointToString fp2s(is_neg, u6, u5, u4, u3, u2, u1, l6, l5, l4, l3, l2, l1, acc);
    
    assign out = {
        `ASCII_CR, `ASCII_LF, is_neg ? `ASCII_MINUS : `ASCII_SPACE, 
        u6 + 8'h30, u5 + 8'h30, u4 + 8'h30, u3 + 8'h30, u2 + 8'h30, u1 + 8'h30,
        `ASCII_DOT,
        l6 + 8'h30, l5 + 8'h30, l4 + 8'h30, l3 + 8'h30, l2 + 8'h30, l1 + 8'h30,
        `ASCII_SPACE, `ASCII_GT, `ASCII_SPACE
    };
endmodule
