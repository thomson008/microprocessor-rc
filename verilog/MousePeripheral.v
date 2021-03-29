`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2021 12:14:05
// Design Name: 
// Module Name: MousePeripheral
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


module MousePeripheral(
    input CLK,
    input RESET,
    // mouse signals
    inout DATA_MOUSE,
    inout CLK_MOUSE,
    // bus signals
    output [7:0] BUS_DATA,
    input [7:0] BUS_ADDR,
    input BUS_WE,
    // interrupt signals
    output BUS_INTERRUPT_RAISE,
    input BUS_INTERRUPT_ACK
    );
    
    wire [7:0] MouseStatus;
    wire [7:0] MouseX;
    wire [7:0] MouseY;
    wire [7:0] MouseDx;
    wire [7:0] MouseDy;
    wire SendInterrupt;
    
    MouseTransceiver mt (
        .RESET(RESET),
        .CLK(CLK),
        .CLK_MOUSE(CLK_MOUSE),
        .DATA_MOUSE(DATA_MOUSE),
        .MouseStatus(MouseStatus),
        .MouseX(MouseX),
        .MouseY(MouseY),
        .INTERRUPT(SendInterrupt),
        .MouseDX(MouseDx),
        .MouseDY(MouseDy)
    );
    
    // Raise interrupt signal if mouse sends an interrupt
    reg Interrupt;
    always@(posedge CLK) begin
        if(RESET)
            Interrupt <= 1'b0;
        else if(SendInterrupt)
            Interrupt <= 1'b1;
        else if(BUS_INTERRUPT_ACK)
            Interrupt <= 1'b0;
    end
    
    assign BUS_INTERRUPT_RAISE = Interrupt;
    
    parameter [7:0] MouseBaseAddr = 8'hA0;
    
    //Tristate
    reg [7:0] Out;
    reg MouseBusWE;
    
    //Only place data on the bus if the processor is NOT writing, and it is addressing the correct address
    assign BUS_DATA = (MouseBusWE) ? Out : 8'hZZ;
     
    // 2D array for holding mouse bytes
    wire [7:0] MouseBytes [4:0];
    assign MouseBytes[0] = MouseStatus;
    assign MouseBytes[1] = MouseX;
    assign MouseBytes[2] = MouseY;
    assign MouseBytes[3] = MouseDx;
    assign MouseBytes[4] = MouseDy;
    
    // Write to bus
    always@(posedge CLK) begin
        if((BUS_ADDR >= MouseBaseAddr) & (BUS_ADDR < MouseBaseAddr + 5)) begin
            // Processor is writing, so do NOT write mouse bytes to bus
            if (BUS_WE)
                MouseBusWE <= 1'b0;
            // Now we can write
            else
                MouseBusWE <= 1'b1;
        end 
        else
            MouseBusWE <= 1'b0;
            
        Out <= MouseBytes[BUS_ADDR[3:0]];
    end
    
endmodule