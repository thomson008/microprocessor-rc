`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2021 11:57:05
// Design Name: 
// Module Name: IR_TB
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


module IR_TB(

    );
    
    reg CLK;
    reg RESET;
    wire IR_LED;
    wire SEND_PACKET;
    reg [3:0] COMMAND;
    
    IRTransmitterSM ir(
        .CLK(CLK),
        .RESET(RESET),
        .IR_LED(IR_LED),
        .SEND_PACKET(SEND_PACKET),
        .COMMAND(COMMAND)
    );
    
    TenHz_cnt ten_hz(
        .CLK(CLK),
        .SEND_PACKET(SEND_PACKET),
        .RESET(RESET)
    );
    
    initial begin 
        CLK=0;
        forever begin
            #5
            CLK = ~CLK;
        end
    end
    
    initial begin
        COMMAND = 4'b0000;
        #10    
        COMMAND = 4'b0100;
        
    end
    
    initial begin
        RESET = 0;
        #10
        RESET = 1;
        #10
        RESET = 0;

    end
    
endmodule
