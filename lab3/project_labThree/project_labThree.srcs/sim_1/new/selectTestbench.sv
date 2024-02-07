module selectTestbench(); //even though the testbench doesn't create any hardware, it still needs to be a module

	timeunit 10ns;	// This is the amount of time represented by #1 
	timeprecision 1ns;

	// These signals are internal because the processor will be 
	// instantiated as a submodule in testbench.
	logic  [15:0] a; 
    logic  [15:0] b;
	logic         cin;
	
	logic  [15:0] s;
	logic         cout;
	logic clk;
			

	// To store expected results 
	//logic [15:0] ans_out;
	
	// Instantiating the DUT (Device Under Test)
	// Make sure the module and signal names match with those in your design
	// Note that if you called the 8-bit version something besides 'Processor'
	// You will need to change the module name
	select_adder test_select_adder(.*);	




	initial begin: CLOCK_INITIALIZATION
		clk = 1;
	end 


	// Toggle the clock
	// #1 means wait for a delay of 1 timeunit, so simulation clock is 50 MHz technically 
	// half of what it is on the FPGA board 

	// Note: Since we do mostly behavioral simulations, timing is not accounted for in simulation, however
	// this is important because we need to know what the time scale is for how long to run
	// the simulation
	always begin : CLOCK_GENERATION
		#1 clk = ~clk;
	end
	

	// Testing begins here
	// The initial block is not synthesizable on an FPGA
	// Everything happens sequentially inside an initial block
	// as in a software program

	// Note: Even though the testbench happens sequentially,
	// it is recommended to use non-blocking assignments for most assignments because
	// we do not want any dependencies to arise between different assignments in the 
	// same simulation timestep. The exception is for reset, which we want to make sure
	// happens first. 
	initial begin: TEST_VECTORS
	
	    a <= 16'b0000000000000000;
	    b <= 16'b0000000000000000;

		repeat (3) @(posedge clk); //each @(posedge Clk) here means to wait for 1 clock edge, so this waits for 3 clock edges
		
		a <= 16'b1111111111111111;
	    b <= 16'b0000000000000000;
	    cin = 1; 
	    
	    //assert (Aval == ans_1a) else $display("2nd cycle A ERROR: Aval is %h", Aval);
	    
	    repeat (3) @(posedge clk); //each @(posedge Clk) here means to wait for 1 clock edge, so this waits for 3 clock edges
	    
	    a <= 16'b0000000000000000;
	    b <= 16'b1111110000000111;
	    cin = 1;
	    
	    repeat (3) @(posedge clk); //each @(posedge Clk) here means to wait for 1 clock edge, so this waits for 3 clock edges
	    
	    a <= 16'b0001111111111011;
	    b <= 16'b0000000000000000;
	    cin = 1; 
	    
		//assert (Bval == ans_2b) else $display("2nd cycle B ERROR: Bval is %h", Bval);

		$finish(); //this task will end the simulation if the Vivado settings are properly configured


	end

endmodule
