  
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2021 10:32:36
// Design Name: 
// Module Name: Decimal_decoder
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


module Decimal_decoder(
        input [1:0] SEG_SELECT_IN,
        input [3:0] BIN_IN,
        input DOT_IN,
        output reg [3:0] SEG_SELECT_OUT,
        output reg [7:0] HEX_OUT
    );
  
  always@(SEG_SELECT_IN) begin
      case(SEG_SELECT_IN) 
          0: SEG_SELECT_OUT <= 4'b1110;
          1: SEG_SELECT_OUT <= 4'b1101;
          2: SEG_SELECT_OUT <= 4'b1011;
          3: SEG_SELECT_OUT <= 4'b0111;
      endcase
  end
  
  always@(BIN_IN or DOT_IN) begin
      case(BIN_IN)
          0: HEX_OUT[6:0] <= 7'b1000000;
          1: HEX_OUT[6:0] <= 7'b1111001;
          2: HEX_OUT[6:0] <= 7'b0100100;
          3: HEX_OUT[6:0] <= 7'b0110000;
          
          4: HEX_OUT[6:0] <= 7'b0011001;
          5: HEX_OUT[6:0] <= 7'b0010010;
          6: HEX_OUT[6:0] <= 7'b0000010;
          7: HEX_OUT[6:0] <= 7'b1111000;
          
          8: HEX_OUT[6:0] <= 7'b0000000;
          9: HEX_OUT[6:0] <= 7'b0010000;
          10: HEX_OUT[6:0] <= 7'b0001000;
          11: HEX_OUT[6:0] <= 7'b0000011;
          
          12: HEX_OUT[6:0] <= 7'b1000110;
          13: HEX_OUT[6:0] <= 7'b0100001;
          14: HEX_OUT[6:0] <= 7'b0000110;
          15: HEX_OUT[6:0] <= 7'b0001110;
          
          default: HEX_OUT[6:0] <= 7'b1111111;
      endcase
      
      HEX_OUT[7] <= ~DOT_IN;
  end
          
endmodule