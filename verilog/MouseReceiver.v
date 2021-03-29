`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2021 11:56:02
// Design Name: 
// Module Name: MouseReceiver
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


module MouseReceiver(
         //Standard Inputs
        input RESET,
        input CLK,
        //Mouse IO - CLK
        input CLK_MOUSE_IN,
        //Mouse IO - DATA
        input DATA_MOUSE_IN,
        //Control
        input READ_ENABLE,
        output [7:0] BYTE_READ,
        output [1:0] BYTE_ERROR_CODE,
        output BYTE_READY
    );
    
    //////////////////////////////////////////////////////////
    // Clk Mouse delayed to detect clock edges
    reg ClkMouseInDly;
    always@(posedge CLK)
        ClkMouseInDly <= CLK_MOUSE_IN;
    
    //////////////////////////////////////////////////////////
    //A simple state machine to handle the incoming 11-bit codewords
    reg [2:0] Curr_State, Next_State;
    reg [7:0] Curr_MSCodeShiftReg, Next_MSCodeShiftReg;
    reg [3:0] Curr_BitCounter, Next_BitCounter;
    reg Curr_ByteReceived, Next_ByteReceived;
    reg [1:0] Curr_MSCodeStatus, Next_MSCodeStatus;
    reg [15:0] Curr_TimeoutCounter, Next_TimeoutCounter;
    
    //Sequential
    always@(posedge CLK) begin
        if(RESET) begin
            Curr_State <= 3'b000;
            Curr_MSCodeShiftReg <= 8'h00;
            Curr_BitCounter <= 0;
            Curr_ByteReceived <= 1'b0;
            Curr_MSCodeStatus <= 2'b00;
            Curr_TimeoutCounter <= 0;
        end 
        else begin
            Curr_State <= Next_State;
            Curr_MSCodeShiftReg <= Next_MSCodeShiftReg;
            Curr_BitCounter <= Next_BitCounter;
            Curr_ByteReceived <= Next_ByteReceived;
            Curr_MSCodeStatus <= Next_MSCodeStatus;
            Curr_TimeoutCounter <= Next_TimeoutCounter;
        end
    end
    
    //Combinatorial
    always@* begin
        //defaults to make the State Machine more readable
        Next_State = Curr_State;
        Next_MSCodeShiftReg = Curr_MSCodeShiftReg;
        Next_BitCounter = Curr_BitCounter;
        Next_ByteReceived = 1'b0;
        Next_MSCodeStatus = Curr_MSCodeStatus;
        Next_TimeoutCounter = Curr_TimeoutCounter + 1'b1;
        
        //The states
        case (Curr_State)
            3'b000: begin
                //Falling edge of Mouse clock and MouseData is low i.e. start bit
                if(READ_ENABLE & ClkMouseInDly & ~CLK_MOUSE_IN & ~DATA_MOUSE_IN) begin
                    Next_State = 3'b001;
                    Next_MSCodeStatus = 2'b00;
                end
                Next_BitCounter = 0;
             end
             
            // Read successive byte bits from the mouse here
            3'b001: begin
                if(Curr_TimeoutCounter == 100000) // 1ms timeout
                    Next_State = 3'b000;
                else if(Curr_BitCounter == 8) begin // if last bit go to parity bit check
                    Next_State = 3'b010;
                    Next_BitCounter = 0;
                end 
                else if(ClkMouseInDly & ~CLK_MOUSE_IN) begin //Shift Byte bits in
                    Next_MSCodeShiftReg[6:0] = Curr_MSCodeShiftReg[7:1];
                    Next_MSCodeShiftReg[7] = DATA_MOUSE_IN;
                    Next_BitCounter = Curr_BitCounter + 1;
                    Next_TimeoutCounter = 0;
                end
            end
            
            //Check Parity Bit
            3'b010: begin
                //Falling edge of Mouse clock and MouseData is odd parity
                if(Curr_TimeoutCounter == 100000)
                    Next_State = 3'b000;
                else if(ClkMouseInDly & ~CLK_MOUSE_IN) begin
                    if (DATA_MOUSE_IN != ~^Curr_MSCodeShiftReg[7:0]) // Parity bit error
                        Next_MSCodeStatus[0] = 1'b1;
                    Next_BitCounter = 0;
                    Next_State = 3'b011;
                    Next_TimeoutCounter = 0;
                end
            end
            
            //Check Stop Bit
            3'b011: begin
                if(Curr_TimeoutCounter == 100000) // 1ms timeout
                    Next_State = 3'b000;
                else if(ClkMouseInDly & ~CLK_MOUSE_IN) begin
                    if (~DATA_MOUSE_IN)
                        Next_MSCodeStatus[1] = 1'b1;
                    Next_BitCounter = 0;
                    Next_State = 3'b100;
                    Next_TimeoutCounter = 0;
                end
            end
            
            // Set ByteReceived flag
            3'b100: begin
                Next_State = 3'b000;
                Next_ByteReceived = 1'b1;
            end

            default: begin
                Next_State = 3'b000;
                Next_MSCodeShiftReg = 8'hFF;
                Next_BitCounter = 4'h0;
                Next_ByteReceived = 1'b0;
                Next_MSCodeStatus = 2'b00;
                Next_TimeoutCounter = 0;
            end
             
        endcase
    end
    
    assign BYTE_READY = Curr_ByteReceived;
    assign BYTE_READ = Curr_MSCodeShiftReg;
    assign BYTE_ERROR_CODE = Curr_MSCodeStatus;
    
endmodule
