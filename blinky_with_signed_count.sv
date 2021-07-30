`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/29/2021 08:14:56 PM
// Design Name: 
// Module Name: blinky
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


module blinky(
    input clk,
    output [15:0] LED
    );

localparam real CLK_FREQ  = 100.0;  // In Mhz
localparam integer DURATION  = 1000;    // In ms 1000000 ns = 1 ms
localparam MAXCOUNT = int'((DURATION * 1000000) / ((1/CLK_FREQ) * 1000));

localparam COUNT_SIZE = $clog2(MAXCOUNT);

logic [COUNT_SIZE-1:0] counter;
logic signed [4:0] led_shift_cnt;
logic [15:0] led;
    
    always_ff @(posedge clk) begin
       
      if (counter >= MAXCOUNT) begin
        counter <= 'b0;
        
        led[led_shift_cnt] <= 1'b1;
        led[led_shift_cnt-1] <= 1'b0;
        
        if (&led_shift_cnt[3:0]) led_shift_cnt <= 4'b0;
        else led_shift_cnt <= led_shift_cnt + 1; 
         
      end else counter <= counter + 1;
    end

assign LED = led;
     
endmodule
