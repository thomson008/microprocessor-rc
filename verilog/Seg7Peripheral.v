`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2021 14:55:39
// Design Name: 
// Module Name: Seg7Peripheral
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


module Seg7Peripheral(
    input CLK,
    input RESET,
    // bus signals
    input [7:0] BUS_ADDR,
    input [7:0] BUS_DATA,
    input BUS_WE,
    // 7 seg display outputs
    output [7:0] HEX_OUT,
    output [3:0] SEG_SELECT
    );
    
    parameter [7:0] Seg7BaseAddress = 8'hD0;
    
    reg [15:0] ValueIn;
    
    DisplayInterface di (
        .CLK(CLK),
        .VALUE_IN(ValueIn),
        .HEX_OUT(HEX_OUT),
        .SEG_SELECT(SEG_SELECT)
    );
    
    always@(posedge CLK) begin
        if (RESET)
            ValueIn <= 0; 
        else if (BUS_WE) begin
            if (BUS_ADDR == Seg7BaseAddress)
                ValueIn[15:8] <= BUS_DATA; 
            else if (BUS_ADDR == Seg7BaseAddress + 1)
                ValueIn[7:0] <= BUS_DATA;
        end
    end
    
endmodule