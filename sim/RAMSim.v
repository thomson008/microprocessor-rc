`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2021 13:11:20
// Design Name: 
// Module Name: RAMSim
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


module RAMSim(

    );
    
    reg CLK;
    reg [7:0] BUS_ADDR;
    wire [7:0] BUS_DATA;
    reg BUS_WE;
    
    RAM uut (
        .CLK(CLK),
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE)
    );
    
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    initial begin
        BUS_ADDR = 0;
        forever #10 BUS_ADDR = BUS_ADDR + 1;
    end
    
    initial begin
        BUS_WE = 1'b0;
        #50
        forever #10 BUS_WE = ~BUS_WE;
    end
 

    
endmodule
