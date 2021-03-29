`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2021 11:06:01
// Design Name: 
// Module Name: DisplayInterface
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


module DisplayInterface(
        input CLK,
        input [15:0] VALUE_IN,
        output [7:0] HEX_OUT,
        output [3:0] SEG_SELECT
    );
  
    wire [1:0] StrobeCount;
    wire [4:0] MuxOut;
    wire Bit17TriggOut;
    
    // Clock counter
    Generic_counter # (.COUNTER_WIDTH(17), .COUNTER_MAX(99999))
        Bit17Counter (
            .RESET(1'b0),
            .CLK(CLK),
            .ENABLE(1'b1),
            .TRIGGER_OUT(Bit17TriggOut)
    );
    
    // Strobe counter
    Generic_counter # (.COUNTER_WIDTH(2), .COUNTER_MAX(3))
        Bit2Counter (
            .RESET(1'b0),
            .CLK(CLK),
            .ENABLE(Bit17TriggOut),
            .COUNT(StrobeCount)
    ); 
    
    // Multiplexer to choose segment on 7-seg display
    Multiplexer_4way strobe_mult (
        .CONTROL(StrobeCount),
        .IN0({1'b0, VALUE_IN[3:0]}),
        .IN1({1'b0, VALUE_IN[7:4]}),
        .IN2({1'b1, VALUE_IN[11:8]}),
        .IN3({1'b0, VALUE_IN[15:12]}),
        .OUT(MuxOut)
    );
    
    Decimal_decoder dd (
        .SEG_SELECT_IN(StrobeCount),
        .BIN_IN(MuxOut[3:0]),
        .DOT_IN(MuxOut[4]),
        .SEG_SELECT_OUT(SEG_SELECT),
        .HEX_OUT(HEX_OUT)
    );
    
endmodule
