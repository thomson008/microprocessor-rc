`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2021 01:30:35
// Design Name: 
// Module Name: IRTransmitter
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


module IRTransmitter(
    input CLK,
    input RESET,
    input [7:0] BUS_ADDR,
    input [7:0] BUS_DATA,
    input BUS_WE,
    output IR_LED
);
    
    wire SEND_PACKET;

    reg [3:0] command;
    
    parameter [7:0] IRBaseAddress = 8'h90;
    
    IRTransmitterSM ir(
        .CLK(CLK),
        .RESET(RESET),
        .IR_LED(IR_LED),
        .COMMAND(command),
        .SEND_PACKET(SEND_PACKET)
    );
    
    TenHz_cnt ten_hz(
        .CLK(CLK),
        .SEND_PACKET(SEND_PACKET),
        .RESET(RESET)
    );
    
    always@(posedge CLK)begin
        if (RESET)
            command <= 4'h0;
        else if (BUS_WE & (BUS_ADDR == IRBaseAddress))
            command <= BUS_DATA[3:0];
    end
    
endmodule
