`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2021 16:29:49
// Design Name: 
// Module Name: IR_SM
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


module IRTransmitterSM(
    input CLK,
    input [3:0] COMMAND,
    input SEND_PACKET,
    input RESET,
    output IR_LED,
    output PHASE_FINISHED,
    output [3:0] CURR_STATE,
    output [3:0] NEXT_STATE,
    output CAR_CLK,
    
    output SEND_PACKET_REC,
    output [3:0] CURR_COMMAND,
    output [3:0] COMMAND_COUNT,
    output NOT_CAR_CLK,
    output [24:0] CLK_COUNT,
    output [24:0] CLK_COUNT_TARGET,
    output CLK_COUNT_FINISHED,
    output [15:0] CLK_COUNTER
    );
    
    reg ir_led;
    reg [3:0] curr_state;
    reg [3:0] next_state;
    reg [3:0] curr_command;
    reg [3:0] command_count;
    reg [7:0] pulse_count;
    reg [7:0] pulse_count_target;
    reg phase_finished;   
    reg out;
    reg send_packet_rec;
    reg [15:0] clk_counter;
    reg [24:0] clk_count;
    reg [24:0] clk_count_target;
    reg clk_count_finished;
    
    reg car_clk;
    reg not_car_clk;
    
    assign CURR_COMMAND = curr_command;
    assign COMMAND_COUNT = command_count;
    assign IR_LED = ir_led;
    assign CURR_STATE = curr_state;
    assign NEXT_STATE = next_state;
    assign CAR_CLK = car_clk;
    assign SEND_PACKET_REC = send_packet_rec;
    assign NOT_CAR_CLK = not_car_clk;
    assign CLK_COUNT = clk_count;
    assign CLK_COUNT_TARGET = clk_count_target;
    assign CLK_COUNT_FINISHED = clk_count_finished;
    assign CLK_COUNTER = clk_counter;
    
    parameter StartBurstSize = 192;
    parameter CarSelectBurstSize = 24;
    parameter GapSize = 24;
    parameter AssertBurstSize = 48;
    parameter DeAssertBurstSize = 24;
    
    //set initial command
    initial begin  
        clk_count_target = 0;  
        clk_count = 0;
        send_packet_rec = 0;
    
        // start in wait state
        curr_state = 4'd3;
        next_state = 4'd3;
        
        clk_counter = 0;
        car_clk=0;
       
        command_count = 3'd0;
        pulse_count = 8'b00000000;
        phase_finished = 0;
        pulse_count_target = 0;
        out = 0;
        
        curr_command = 4'd0000;
    end
    
  
    //----- 36KHz clock ------
    
    always@(posedge CLK)begin
        if(curr_state == 3 || curr_state == 1)begin
            clk_counter <=0;
            car_clk <=0;
        end
        else begin
            if(clk_counter == 1388)begin
                car_clk = ~car_clk;
                clk_counter<=0;
            end
            else
                clk_counter <= clk_counter +1;
        end
    end
    
    always@(car_clk)
        not_car_clk <= ~car_clk;
    //----- State Machine ------
    
    //Sequential Logic
    always@(posedge CLK) begin
       curr_state <= next_state;
        
    end
 
    //CLK counter
    always@(posedge CLK)begin
        if(clk_count_finished)
            clk_count<=0;
        else begin
            if(curr_state != 3)
                clk_count <= clk_count + 1;
        end
    end
    always@(*)begin
        if(clk_count == clk_count_target)begin
            clk_count_finished <=1;
        end
        else
            clk_count_finished <=0;
    end
    
    //increment command count
    always@(posedge clk_count_finished)begin
        if(curr_state == 0)begin
            command_count <= 0;
            curr_command <= COMMAND;
        end
        else if(curr_state == 2)begin
            command_count <= command_count +1;
            curr_command <= curr_command;
        end
        else if(curr_state == 5 || curr_state == 4)begin
            command_count <= command_count+1;
            curr_command <= curr_command << 1;
        end  
        else begin
            command_count <= command_count;
            curr_command <= curr_command;
        end
            
    end 
    
    
    //manage the send packet signal
    always@(posedge CLK)begin
        if(SEND_PACKET)
            send_packet_rec <=1;
        else if(send_packet_rec == 1 && curr_state == 3)
            send_packet_rec <=1;
        else
            send_packet_rec <=0;
    end
    
    // handle command count (right left forward or back
    /*always@(curr_state)begin
        
    end*/
   
   
    //handle pulse count target
    always@(*)begin 
        case(curr_state)
            //start
            4'd0    :begin
                pulse_count_target <= StartBurstSize;
                clk_count_target <= (StartBurstSize * 2) * 1389 - 1;
            end
            //gap
            4'd1    :begin
                pulse_count_target <= 0;
                clk_count_target <= GapSize * 2 * 1389 - 1;
            end
            //select
            4'd2    :begin
                pulse_count_target <= CarSelectBurstSize;
                clk_count_target <= (CarSelectBurstSize * 2 ) * 1389 - 1;
            end
            //wait
            4'd3    :begin
                pulse_count_target <= 1;
                clk_count_target <= 0;
            end
            //assert
            4'd4    :begin
                pulse_count_target <= AssertBurstSize;
                clk_count_target <= (AssertBurstSize* 2 ) * 1389 - 1;
            end
            //de assert
            4'd5    :begin
                pulse_count_target <= DeAssertBurstSize;
                clk_count_target <= (DeAssertBurstSize* 2 ) * 1389 - 1;
            end
            default :begin
                pulse_count_target <= 0;
                clk_count_target <= 0;
            end
        endcase
    end
    //combinatorial logic
    always@(phase_finished or send_packet_rec or curr_state or pulse_count or clk_count_finished)begin
        
        case (curr_state)
            //START:    0
            //GAP:      1
            //SELECT:   2
            //WAIT:     3
            //ASSERT:   4
            //DE-ASSERT:5
            
            //START
            4'd0    :begin
                if(clk_count_finished)begin
                    next_state <= 4'd1;
                end
                
                else begin
                    next_state <= curr_state;         
                end
            end
            
            //GAP
            4'd1    :begin

                if(clk_count_finished)begin

                    if(command_count == 0)begin
                    //go to select
                        next_state<=4'd2;

                    end
                    else begin
                        if(command_count < 5) begin
                            if((curr_command & 4'b1000) == 4'b1000)begin
                                //go to ASSERT
                                next_state<=4'd4;
                            end
                            else begin
                                //go to DE ASSERT
                                next_state<=4'd5;
                            end
                        end
                        else begin
                            //go to wait
                            next_state <= 4'd3;
                        end
                    end
                end
                else begin
                    next_state <= curr_state;
                end
            end
            
            //SELECT
            4'd2    :begin

                if(clk_count_finished)begin
                    //go to GAP
                    next_state <= 4'd1;
                end
                else begin
                    next_state <= curr_state;
                end
            end
            
            //WAIT - wait for next SEND_PACKET 
            4'd3    :begin
                if(send_packet_rec)begin
                    next_state <= 4'd0;               
                end
                else begin 
                    next_state <= curr_state;
                end
            end
            
            //ASSERT
            4'd4    :begin
                if(clk_count_finished)begin
                    //go to GAP
                    next_state <= 4'd1;
                end
                else begin
                    next_state <= curr_state;
                end
            end
            
            //de assert
            4'd5    :begin
                if(clk_count_finished)begin
                    next_state <= 4'd1;
                    //go to GAP
                end 
                else begin
                    next_state <= curr_state;
                end
            end
            default:    begin
                next_state<= 0;
            end
        endcase
      end      
      
      
      //-----Tie clock to state machine output
    
      
    always@(car_clk or curr_state)begin
        if(curr_state == 1||curr_state == 3)
            ir_led<=0;
        else begin
            /*if(alternate)
                ir_led <= ~car_clk;
                
            else*/
                ir_led<=car_clk;
        end
    end
        
endmodule
