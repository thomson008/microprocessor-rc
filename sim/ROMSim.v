`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2021 13:13:17
// Design Name: 
// Module Name: ROMSim
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


module ROMSim(

    );
    
    reg CLK;
    reg [7:0] BUS_ADDR;
    wire [7:0] BUS_DATA;
    
    ROM uut (
        .CLK(CLK),
        .DATA(BUS_DATA),
        .ADDR(BUS_ADDR)
    );
    
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    initial begin
        BUS_ADDR = 0;
        forever #10 BUS_ADDR = BUS_ADDR + 1;
    end

endmodule
