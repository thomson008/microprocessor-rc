# microprocessor-rc
Verilog project of a simple microprocessor with peripherals such as mouse, VGA display and IR transmitter. Can be run on Xilinx Basys 3 FPGA board with an additional IR module in order to control a RC car. The system was developed for [Digital Systems Laboratory](http://www.drps.ed.ac.uk/20-21/dpt/cxelee10023.htm) course at The University of Edinburgh. 

## ISA
The processor has its own ISA, containing 13 instructions and 2 registers. Software has been developed such that a 3x3 grid is displayed on the screen through VGA and the RC command is determined by mouse position on the screen (each grid square corresponds to a different command, see diagram in next section for more detail).

## System diagram
Full system diagram can be seen in the figure below:

![image info](./images/system.jpg)

## Processor architecture
In order to understand the architecture of the microprocessor itself, please consult the following schematic:

![image info](./images/cpu.jpg)

## Application demo
A full video demonstration of the working system can be found [here](https://youtu.be/zi9BBTluCMY) on YouTube.

## Contributors
This project is a joint effort of the following students:
* [Tomek Horszczaruk](https://github.com/thomson008)
* [Benjamin Young](https://github.com/benjamin-young)
* [Zheyu You](https://github.com/ZheyuYou)
