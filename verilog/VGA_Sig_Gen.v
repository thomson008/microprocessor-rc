`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ZheyuYou s1997544
// 
// Create Date: 2021/03/15 12:26:32
// Design Name: 
// Module Name: VGA_Sig_Gen
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


module VGA_Sig_Gen(
    input CLK,
    input RESET,
    // Colour Configuration Interface
    input [15:0] CONFIG_COLOURS,
    // Frame Buffer (Dual Port memory) Interface
    output DPR_CLK,
    output [14:0] VGA_ADDR,
    input VGA_DATA,
    // VGA Port Interface
    output reg VGA_HS,
    output reg VGA_VS,
    output reg [7:0] VGA_COLOUR
    );
    
    //Halve the clock to 25 MHz to drive the VGA display
    reg VGA_CLK_1;
    always@(posedge CLK) begin
        if (RESET)
            VGA_CLK_1 <= 0;
        else 
            VGA_CLK_1 <= ~VGA_CLK_1;
    end
    
    reg VGA_CLK;
    initial begin 
    VGA_CLK =0;
    VGA_CLK_1 =0;
    end
    
    always@(posedge VGA_CLK_1) begin
        if (RESET)
            VGA_CLK <= 0;
        else 
            VGA_CLK <= ~VGA_CLK;
    end
    
    /*
    Define VGA signal parameters eg. Horizontal and Vertical display time, pulse width, front and back porch widths, etc.
    */
    
    // Use the following signal parameters
    parameter HTs       = 800;  // Total Horizontal Sync Pulse Time
    parameter HTpw      = 96;   // Horizontal Pulse Width Time
    parameter HTDisp    = 640;  // Horizontal Display Time
    parameter Hbp       = 48;   // Horizontal Back Porch Time
    parameter Hfp       = 16;   // Horizontal Front Porch Time 
    
    parameter VTs       = 521;  // Total Vertical Sync Pulse Time
    parameter VTpw      = 2;    // Vertical Pulse Width Time
    parameter VTDisp    = 480;  // Vertical Display Time
    parameter Vbp       = 29;   // Vertical Back Porch Time
    parameter Vfp       = 10;   // Vertical Front Porch Time    
    
     //Vertical Lines Timeline
    parameter VertTimeToPulseWidthEnd  = 10'd2;
    parameter VertTimeToBackPorchEnd   = 10'd31;
    parameter VertTimeToDisplayTimeEnd = 10'd511;
    parameter VertTimeToFrontPorchEnd  = 10'd521;
    
    //Horizental Lines Timeline
    parameter HorzTimeToPulseWidthEnd  = 10'd96;
    parameter HorzTimeToBackPorchEnd   = 10'd144;
    parameter HorzTimeToDisplayTimeEnd = 10'd784;
    parameter HorzTimeToFrontPorchEnd  = 10'd800;
    
    // Define Horizontal and Vertical Counter to generate the VGA signal
    reg [9:0]   ADDRH;
    reg [9:0]   ADDRV;
    
    reg [9:0]   HCounter;
    reg [9:0]   VCounter;
    initial begin
    HCounter <= 1;
    VCounter <= 1;
    end
    
    /*
    Create a process that assigns the proper horizontal and vertical counter values for raster scan of the display
    */
    
    always@(posedge VGA_CLK) begin
        if (RESET)
            HCounter <= 1;
        else begin
            if (HCounter == 800)
                HCounter <= 1;
            else
                HCounter <= HCounter + 1;
        end
    end
    
    always@(posedge VGA_CLK) begin
        if (RESET)
            VCounter <= 1;
        else begin
        if (HCounter == 800) begin
            if(VCounter == 521)
                VCounter <= 1;
            else 
                VCounter <= VCounter + 1;
        end
        end
    end
    
    /*
    Need to create the address of the next pixel. Concatenate and tie the look ahead address to the frame buffer address
    */
    
    assign DPR_CLK  = VGA_CLK;
    assign VGA_ADDR = {ADDRV[8:2], ADDRH[9:2]};
    
    /*
    Create a process that generates the Horizontal and Vertical synchronisation signals, as well as the pixel colour information,
    use HCounter and VCounter. Do not forget to use CONFIG_COLOURS input to display the right foreground and background colours
    */
    
    //Decide when the Horizontal Sync set high or low                     
    always@(posedge VGA_CLK) begin     
        if (HCounter <= HorzTimeToPulseWidthEnd)
            VGA_HS <= 0;
        else
            VGA_HS <= 1;
    
    
    //Decide when the Vertical Sync set high or low 
    
        if (VCounter <= VertTimeToPulseWidthEnd)
            VGA_VS <= 0;
        else
            VGA_VS <= 1;
    
    
    
     //Make the Vertical address increase at the same speed as the two counters
    
        if((VertTimeToBackPorchEnd < VCounter) && (VCounter <= VertTimeToDisplayTimeEnd))
           ADDRV <= VCounter- VertTimeToBackPorchEnd;
        else
           ADDRV <= 0;
    
    
     //Make the Horizontal address increase at the same speed as the two counters         
    
        if ((HorzTimeToBackPorchEnd < HCounter) && (HCounter <= HorzTimeToDisplayTimeEnd))
            ADDRH <= HCounter-HorzTimeToBackPorchEnd;            
       else 
            ADDRH <= 0;
    
    
    /*
    Finally, tie the output of the frame buffer to the colour ouput VGA_COLOUR
    */
        if ((VertTimeToBackPorchEnd < VCounter) && (VCounter <= VertTimeToDisplayTimeEnd) && (HorzTimeToBackPorchEnd < HCounter) &&(HCounter <= HorzTimeToDisplayTimeEnd)) begin
            if(VGA_DATA)begin
                VGA_COLOUR <= CONFIG_COLOURS[15:8]; 
            end
            else begin
            VGA_COLOUR <= CONFIG_COLOURS[7:0];
            end
        end
        else
        VGA_COLOUR <=16'b0000000000000000;   
    
       
end


endmodule