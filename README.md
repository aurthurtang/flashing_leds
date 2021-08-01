# Flashing LEDs


> This is my first FPGA project on the NEXYS A7.  The purpose of this project is to get familiar with the FPGA and Vivado.
> This project will demonstrate the use of the FPGA board to turn on the LEDs on the board.  There are total of 16 LEDs and
> the code will trigger one LED to be on for a given time and then cycle to the next one and so forth.  Once it reaches the 
> last LED, it will cycle through again.

[![Watch the video](https://github.com/aurthurtang/flashing_leds/blob/main/flashing_LEDs.JPG)](https://youtu.be/X3RE84lb_Kk)


# Requirements

> - Vivado (I'm using Vivado 2020.2)  *Any version should do*
> - Nexys A7 board

# Before getting start

> 1. Download Vivado
> 2. Get the board file from [this link](https://github.com/Digilent/vivado-boards/archive/master.zip?_ga=2.208193810.1843468524.1627578007-919375833.1627165649) and copy over to  C:\Xilinx\Vivado\<VERSION>\data\boards\board_files

# Steps

> 1. Open Vivado and start a new project.  Please select the Nexys A7 board design
> 2. Upload the RTL file to the source
> 3. Update constraints to connect the pin to package pins
>     Please download the master XDC from [this link](https://reference.digilentinc.com/learn/programmable-logic/doc/github/digilent-xdc)
>
>     For this project, we will be using the LED pins and the clocks.  Copy the lines with the LED and the sys_clk ports.  Also you will need to create a clock at the clock port
> 4. Run Synthesis->Implementation->Generate Bit Stream   
> 5. Open **Hardware Manager** and click on **Open Target**.  Then you can just do Auto Connect
> 6. Program Device
  
# Takeaway

> 1. Learn to run Vivado and get familiar with the board.  
> 2. Understand the board file and master constraints for the board

# Lesson Learned

> 1.  The duration cannot be set to too small.  If so, you can't see the LEDs blinking.  I accidentally changed the value for simulation and forgot to change back. When I loaded the code to FPGA, all the lights are on.  It took me some time to realize that it was because of the duration parameter.

> 2.  Originally, I would think that I can simply use the following code to cycle through the LEDs:
> 
>             led[led_shift_cnt] <= 1'b1
>             led[led_shift_cnt-1] <= 1'b0
>             
>  You would think that when led_shift_cnt is 4'b0, led_shift_cnt-1 will be 4'b1111.  However, since the led_shift_cnt is **unsigned**, led_shift_cnt - 1 is not equal to 4'b1111 when count is 0.  Somehow, in the FPGA, the LED[15] will stay high after the first cycle.  Instead of using the if-else clause when led_shift_cnt, one alternative is to use *signed* number for the led_shift_cnt.  If doing so, led_shift_cnt needs to add one additional bit for signed extension.

# Challenges Ideas

> 1. Change the design to use signed number for the count?
> 2. Instead of doing rotation, change the code to make the LEDs blinks back and forth?


# Reference
> 1. [Nexys A7 Reference Page](https://reference.digilentinc.com/programmable-logic/nexys-a7/start)
 
