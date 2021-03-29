`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2021 22:04:37
// Design Name: 
// Module Name: HelloWorld
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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TenHz_cnt(
    input CLK,
    output SEND_PACKET,
    input RESET
    );
    
    parameter COUNTER_MAX = 10000000;
    
    reg [24:0] count_value;
    reg Trigger_out;
    
    
    always@(posedge CLK) begin
        
            if(count_value == COUNTER_MAX)
                count_value <= 0;
            else
                count_value <= count_value+1;
    end
    
    always@(posedge CLK)begin
        
            if(count_value == COUNTER_MAX)
                Trigger_out <= 1;
            else
                Trigger_out <= 0;
           
        
    end
    
    assign SEND_PACKET = Trigger_out;
    
    initial begin
        count_value = 0;
    end
    
endmodule
