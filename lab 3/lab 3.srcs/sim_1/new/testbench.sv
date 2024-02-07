//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2024 03:05:02 PM
// Design Name: 
// Module Name: testbench
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


module testbench();

timeunit 10ns;
timeprecision 1ns;

logic 		clk; 
logic		reset; 
logic 		run_i; // _i stands for input
logic [15:0] sw_i;

logic 		sign_led;
logic [7:0]  hex_seg_a;
logic [3:0]  hex_grid_a;
logic [7:0]  hex_seg_b;
logic [3:0]  hex_grid_b;

always begin: CLOCK_GENERATION 
    #1 clk = ~clk; //change this line look at testbench 2
end

initial begin: 
    clk = 0;
    
end



adder_toplevel test_adder_toplevel(.*);

endmodule
