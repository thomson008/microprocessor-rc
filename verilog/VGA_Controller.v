`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2021 14:29:59
// Design Name: 
// Module Name: VGAPeripheral
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


module VGA_Controller(
        input CLK,
        input RESET,
        input [7:0] BUS_ADDR,
        inout [7:0] BUS_DATA,
        input  BUS_WE,
        output [7:0] COLOUR_OUT,
        output HS,
        output VS
    );
    
    parameter [7:0] VGABaseAddress = 8'hB0;
    parameter [7:0] MouseLimitY = 120;
    
    wire [15:0] Config_colour = {8'hFF, 8'h00};
    wire [14:0] address_connect;
    wire Data_FB_VGA;
    wire Data_FB;   
    wire DPR_CLK;
    
    reg FrameBuffer_WE;
    reg [14:0] ADDR_FB;
    reg Pixel_data;
    
    
    Frame_Buffer fb (
        .A_CLK(CLK),
        .A_ADDR(ADDR_FB),     // 8+7 bits = 15 bits hence [14:0]
        .A_DATA_IN(Pixel_data),         // Pixel Data in
        .A_DATA_OUT(Data_FB),
        .A_WE(FrameBuffer_WE),              // Write Enable                  
        .B_CLK(DPR_CLK),
        .B_ADDR(address_connect),     // Pixel Data Out
        .B_DATA(Data_FB_VGA)
    );   
   
    VGA_Sig_Gen sg ( 
        .CLK(CLK),
        .RESET(RESET),
        .CONFIG_COLOURS(Config_colour),
        .DPR_CLK(DPR_CLK),
        .VGA_ADDR(address_connect),
        .VGA_DATA(Data_FB_VGA),
        .VGA_HS(HS),
        .VGA_VS(VS),
        .VGA_COLOUR(COLOUR_OUT)
    );
    
    reg VGABusWE;
    reg [7:0] Out;
    
    // Tristate
    assign BUS_DATA = (VGABusWE) ? Out : 8'hZZ;

    always@(posedge CLK) begin
        if (BUS_WE) begin
            VGABusWE <= 1'b0;
            
            // X coordinate
            if (BUS_ADDR == VGABaseAddress) begin
                FrameBuffer_WE <= 1'b0;
                ADDR_FB[7:0] <= BUS_DATA;
            end
            // Y coordinate
            else if (BUS_ADDR == VGABaseAddress + 1) begin
                FrameBuffer_WE <= 1'b0;
                ADDR_FB[14:8] <= MouseLimitY - BUS_DATA - 1;
            end
            // Pixel value to write
            else if (BUS_ADDR == VGABaseAddress + 2) begin
                FrameBuffer_WE <= 1'b1;
                Pixel_data <= BUS_DATA[0];
            end
            else
                FrameBuffer_WE <= 1'b0;
        end
        else begin
            // Enable the VGA module to write to bus (if the address is right)
            if (BUS_ADDR >= VGABaseAddress & BUS_ADDR < VGABaseAddress + 3)
                VGABusWE <= 1'b1;
            else
                VGABusWE <= 1'b0;
                
            // Processor is not writing, so disable writing to frame buffer
            FrameBuffer_WE <= 1'b0;
        end
            
        Out <= Data_FB;
    end
    
    
endmodule
