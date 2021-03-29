`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2021 15:59:00
// Design Name: 
// Module Name: ROM
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


module ROM(
    //standard signals
    input CLK,
    //BUS signals
    output reg [7:0] DATA,
    input [7:0] ADDR
    );
    
    parameter RAMAddrWidth = 8;
    
    //Memory
    reg [7:0] rom [2**RAMAddrWidth-1:0];
    
    // Load program
    initial $readmemh("Complete_Demo_ROM.txt", rom);
    
    //single port ram
    always@(posedge CLK)
        DATA <= rom[ADDR];
    
endmodule
