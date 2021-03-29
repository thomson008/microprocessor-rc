`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2021 14:12:15
// Design Name: 
// Module Name: LedPeripheral
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


module LedPeripheral(
    input CLK,
    input RESET,
    // bus signals
    input [7:0] BUS_ADDR,
    input [7:0] BUS_DATA,
    input BUS_WE,
    // LED output
    output reg [15:0] LEDS
    );
    
    parameter [7:0] LedBaseAddress = 8'hC0;
    
    always@(posedge CLK) begin
        if (RESET)
            LEDS <= 0;
        else if (BUS_WE) begin
            if (BUS_ADDR == LedBaseAddress)
                LEDS[7:0] <= BUS_DATA;
            else if (BUS_ADDR == LedBaseAddress + 1)
                LEDS[15:8] <= BUS_DATA << 4;
        end
    end
    
endmodule
