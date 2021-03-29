`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2021 13:53:11
// Design Name: 
// Module Name: ProcessorSim
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


module ProcessorSim(

    );
    
    reg CLK;
    reg RESET;
    wire [7:0] BUS_DATA;
    wire [7:0] BUS_ADDR;
    wire BUS_WE;
    wire [7:0] ROM_ADDRESS;
    wire [7:0] ROM_DATA;
    reg [1:0] BUS_INTERRUPTS_RAISE;
    wire [1:0] BUS_INTERRUPTS_ACK;
    wire [7:0] STATE;
    
    RAM uut1 (
        .CLK(CLK),
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE)
    );
        
    ROM uut2 (
        .CLK(CLK),
        .DATA(ROM_DATA),
        .ADDR(ROM_ADDRESS)
    );
    
    Processor uut3 (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE),
        .ROM_ADDRESS(ROM_ADDRESS),
        .ROM_DATA(ROM_DATA),
        .BUS_INTERRUPTS_RAISE(BUS_INTERRUPTS_RAISE),
        .BUS_INTERRUPTS_ACK(BUS_INTERRUPTS_ACK),
        .STATE(STATE)
    );
    
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    initial begin
        RESET = 1'b0;
        #10 RESET = 1'b1;
        #10 RESET = 1'b0;
    end
        
    initial begin
        BUS_INTERRUPTS_RAISE = 2'b00;
        #300 RESET = 1'b1;
        #10 RESET = 1'b0;
        #300 BUS_INTERRUPTS_RAISE = 2'b01;
        #10 BUS_INTERRUPTS_RAISE = 2'b00; 
    end
    
endmodule
