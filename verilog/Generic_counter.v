`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2021 10:22:32
// Design Name: 
// Module Name: Generic_counter
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


module Generic_counter(
        CLK,
        RESET,
        ENABLE,
        TRIGGER_OUT,
        COUNT
    );
    
    parameter COUNTER_WIDTH = 4;
    parameter COUNTER_MAX = 9;
    
    input CLK;
    input RESET;
    input ENABLE;
    output TRIGGER_OUT;
    output [COUNTER_WIDTH-1:0] COUNT;
    
    reg [COUNTER_WIDTH-1:0] count_value = 0;
    reg Trigger_out;
    
    always@(posedge CLK) begin
        if (RESET)
            count_value <= 0;
        else begin
            if (ENABLE) begin
                if (count_value == COUNTER_MAX)
                    count_value <= 0;
                else
                    count_value <= count_value + 1;
            end
        end
    end
    
    always@(posedge CLK) begin
        if (RESET)
            Trigger_out <= 0;
        else begin
            if (ENABLE && (count_value == COUNTER_MAX))
                Trigger_out <= 1;
            else 
                Trigger_out <= 0;
        end
    end
    
    assign TRIGGER_OUT = Trigger_out;
    assign COUNT = count_value;
    
endmodule