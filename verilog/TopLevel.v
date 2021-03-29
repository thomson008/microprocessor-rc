`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2021 10:34:35
// Design Name: 
// Module Name: TopInterface
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


module TopLevel(
    input CLK,
    input RESET,
    input SWITCH,
    inout CLK_MOUSE,
    inout DATA_MOUSE,
    output [15:0] LED_OUT,
    output [7:0] HEX_OUT,
    output [3:0] SEG_SELECT,
    output HS,
    output VS,
    output [7:0] COLOUR_OUT,
    output IR_LED
    );
    
    wire [7:0] BusData;
    wire [7:0] BusAddr;
    wire BusWE;
    wire [7:0] RomAddress;
    wire [7:0] RomData;
    wire [1:0] BusInterruptsRaise;
    wire [1:0] BusInterruptsAck;

    Processor CPU (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_DATA(BusData),
        .BUS_ADDR(BusAddr),
        .BUS_WE(BusWE),
        .ROM_ADDRESS(RomAddress),
        .ROM_DATA(RomData),
        .BUS_INTERRUPTS_RAISE(BusInterruptsRaise),
        .BUS_INTERRUPTS_ACK(BusInterruptsAck)
    );

    ROM rom (
        .CLK(CLK),
        .ADDR(RomAddress),
        .DATA(RomData)
    );

    RAM ram (
        .CLK(CLK),
        .BUS_DATA(BusData),
        .BUS_ADDR(BusAddr),
        .BUS_WE(BusWE)
    );

    Timer timer (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_DATA(BusData),
        .BUS_ADDR(BusAddr),
        .BUS_WE(BusWE),
        .BUS_INTERRUPT_RAISE(BusInterruptsRaise[1]),
        .BUS_INTERRUPT_ACK(BusInterruptsAck[1])
    );
    
    MousePeripheral mp (
        .CLK(CLK),
        .RESET(RESET),
        .CLK_MOUSE(CLK_MOUSE),
        .DATA_MOUSE(DATA_MOUSE),
        .BUS_ADDR(BusAddr),
        .BUS_DATA(BusData),
        .BUS_WE(BusWE),
        .BUS_INTERRUPT_RAISE(BusInterruptsRaise[0]),
        .BUS_INTERRUPT_ACK(BusInterruptsAck[0])
    );
    
    LedPeripheral lp (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_ADDR(BusAddr),
        .BUS_DATA(BusData),
        .BUS_WE(BusWE),
        .LEDS(LED_OUT)
    );
    
    Seg7Peripheral seg7 (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_ADDR(BusAddr),
        .BUS_DATA(BusData),
        .BUS_WE(BusWE),
        .HEX_OUT(HEX_OUT),
        .SEG_SELECT(SEG_SELECT)
    );
    
    SwitchPeripheral switch (
        .CLK(CLK),
        .RESET(RESET),
        .SWITCH_IN(SWITCH),
        .BUS_DATA(BusData),
        .BUS_ADDR(BusAddr),
        .BUS_WE(BusWE)
    );
    
    VGA_Controller vga (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_DATA(BusData),
        .BUS_ADDR(BusAddr),
        .BUS_WE(BusWE),
        .COLOUR_OUT(COLOUR_OUT),
        .HS(HS),
        .VS(VS)
    );
    
    IRTransmitter ir (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_ADDR(BusAddr),
        .BUS_DATA(BusData),
        .BUS_WE(BusWE),
        .IR_LED(IR_LED)
    );

endmodule