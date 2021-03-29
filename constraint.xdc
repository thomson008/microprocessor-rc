#clock
set_property PACKAGE_PIN W5 [get_ports CLK]
    set_property IOSTANDARD LVCMOS33 [get_ports CLK]
    
#RESET
set_property PACKAGE_PIN U18 [get_ports RESET]
    set_property IOSTANDARD LVCMOS33 [get_ports RESET]

#Switch   
set_property PACKAGE_PIN V17 [get_ports SWITCH]
    set_property IOSTANDARD LVCMOS33 [get_ports SWITCH]
    
    
# Mouse
set_property PACKAGE_PIN C17 [get_ports CLK_MOUSE]                        
     set_property IOSTANDARD LVCMOS33 [get_ports CLK_MOUSE]
     set_property PULLUP true [get_ports CLK_MOUSE]
         
set_property PACKAGE_PIN B17 [get_ports DATA_MOUSE]                    
     set_property IOSTANDARD LVCMOS33 [get_ports DATA_MOUSE]    
     set_property PULLUP true [get_ports DATA_MOUSE]


#7-segments
set_property PACKAGE_PIN V7 [get_ports {HEX_OUT[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[7]}]

set_property PACKAGE_PIN U7 [get_ports {HEX_OUT[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[6]}]

set_property PACKAGE_PIN V5 [get_ports {HEX_OUT[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[5]}]
    
set_property PACKAGE_PIN U5 [get_ports {HEX_OUT[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[4]}]

set_property PACKAGE_PIN V8 [get_ports {HEX_OUT[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[3]}]
    
set_property PACKAGE_PIN U8 [get_ports {HEX_OUT[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[2]}]
        
set_property PACKAGE_PIN W6 [get_ports {HEX_OUT[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[1]}]

set_property PACKAGE_PIN W7 [get_ports {HEX_OUT[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[0]}]



#choose one of 4 displays   
set_property PACKAGE_PIN U2 [get_ports {SEG_SELECT[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[0]}]
        
set_property PACKAGE_PIN U4 [get_ports {SEG_SELECT[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[1]}]
            
set_property PACKAGE_PIN V4 [get_ports {SEG_SELECT[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[2]}]
                
set_property PACKAGE_PIN W4 [get_ports {SEG_SELECT[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[3]}]
    
    
#LED_OUTputs
set_property PACKAGE_PIN U16 [get_ports {LED_OUT[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[0]}]

set_property PACKAGE_PIN E19 [get_ports {LED_OUT[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[1]}]

set_property PACKAGE_PIN U19 [get_ports {LED_OUT[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[2]}]

set_property PACKAGE_PIN V19 [get_ports {LED_OUT[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[3]}]

set_property PACKAGE_PIN W18 [get_ports {LED_OUT[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[4]}]

set_property PACKAGE_PIN U15 [get_ports {LED_OUT[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[5]}]

set_property PACKAGE_PIN U14 [get_ports {LED_OUT[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[6]}]

set_property PACKAGE_PIN V14 [get_ports {LED_OUT[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[7]}]
    
set_property PACKAGE_PIN V13 [get_ports {LED_OUT[8]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[8]}]
    
set_property PACKAGE_PIN V3 [get_ports {LED_OUT[9]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[9]}]

set_property PACKAGE_PIN W3 [get_ports {LED_OUT[10]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[10]}]

set_property PACKAGE_PIN U3 [get_ports {LED_OUT[11]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[11]}]

set_property PACKAGE_PIN P3 [get_ports {LED_OUT[12]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[12]}]

set_property PACKAGE_PIN N3 [get_ports {LED_OUT[13]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[13]}]

set_property PACKAGE_PIN P1 [get_ports {LED_OUT[14]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[14]}]

set_property PACKAGE_PIN L1 [get_ports {LED_OUT[15]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[15]}]
    
    
#VGA
set_property PACKAGE_PIN G19 [get_ports {COLOUR_OUT[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[0]}]

set_property PACKAGE_PIN H19 [get_ports {COLOUR_OUT[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[1]}]

set_property PACKAGE_PIN J19 [get_ports {COLOUR_OUT[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[2]}]

set_property PACKAGE_PIN J17 [get_ports {COLOUR_OUT[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[3]}]

set_property PACKAGE_PIN H17 [get_ports {COLOUR_OUT[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[4]}]

set_property PACKAGE_PIN G17 [get_ports {COLOUR_OUT[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[5]}]

set_property PACKAGE_PIN N18 [get_ports {COLOUR_OUT[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[6]}]

set_property PACKAGE_PIN L18 [get_ports {COLOUR_OUT[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[7]}]

set_property PACKAGE_PIN P19 [get_ports HS]
    set_property IOSTANDARD LVCMOS33 [get_ports HS]

set_property PACKAGE_PIN R19 [get_ports VS]
    set_property IOSTANDARD LVCMOS33 [get_ports VS]
    
    
#IR_LED
set_property PACKAGE_PIN P18 [get_ports IR_LED]
    set_property IOSTANDARD LVCMOS33 [get_ports IR_LED]