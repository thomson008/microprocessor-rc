`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2021 13:22:10
// Design Name: 
// Module Name: SwitchPeripheral
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


module SwitchPeripheral(
    input CLK,
    input RESET,
    inout [7:0] BUS_DATA,
    input [7:0] BUS_ADDR,
    input BUS_WE,
    input SWITCH_IN
    );
    
    parameter [7:0] SwitchBaseAddress = 8'hA8;
    
    //Tristate
    reg [7:0] Out;
    reg SwitchBusWE;
    
    //Only place data on the bus if the processor is NOT writing, and it is addressing the correct address
    assign BUS_DATA = (SwitchBusWE) ? Out : 8'hZZ;
    
    // Write to bus
    always@(posedge CLK) begin
        if(BUS_ADDR == SwitchBaseAddress) begin
            if (BUS_WE)
                SwitchBusWE <= 1'b0;
            else
                SwitchBusWE <= 1'b1;
        end 
        else
            SwitchBusWE <= 1'b0;
            
        Out <= SWITCH_IN ? 8'h01 : 8'h00;
    end
    
endmodule
