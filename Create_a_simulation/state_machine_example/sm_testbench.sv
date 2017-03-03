// SystemVerilog testbench for a state machine.
// Author: Dave Sluiter
// Date  : Jan 23, 2017

// To make protected file: > vencrypt file.sv -o file_p.sv 


`define CLK_HALF_PERIOD   5 	// 10ns period, 100 MHz clock

`define NUM_TEST_CASES    25	// the number of test cases to run 


// -------------------------------------------------------
// The testbench. This module provides inputs (stimulus) 
// to the Device Under Test (DUT), it does not check for correct
// behavior. The testbench code and the DUT use unit delay
// modeling of flip-flops for clarity.
// -------------------------------------------------------
module sm_testbench ();

//timeunit      1ns;	// this one defines "how" to interptret numbers encountered in the source
//timeprecision 1ns; 	// this specifies the minimum time-step resolution
// aternative form:
timeunit      1ns/1ns; // time unit with precision

// testbench variables 
logic       	clk;
logic           resetn;

logic			a, b, c;
logic			control_1, control_2;


// ------------------------------------
// process: generate the clock signal
// ------------------------------------
always begin
   clk = 1; // time t=0
   forever begin
      #5;
	  clk = ~clk;
   end //forever
end // always



// ------------------------------------
// process: run the test 
// ------------------------------------
initial begin

	integer       seed;
	
	// at time t=0, init all DUT inputs
	resetn = 0; // assert reset 

	a = 0;
	b = 0;
	c = 0;
	
	// set the random seed
	seed = 25;
	seed = $random ( seed ); // seed the pseudo-random sequence generator 
	
	// burn a couple clock cycles, then release reset 
	@ (posedge clk);
	@ (posedge clk);
	#1; resetn = 1; // deassert reset 
	@ (posedge clk);
	
	
	// ------------------------------------------
	// send the state machine through 1 cycle
	// ------------------------------------------
	@ (posedge clk);
	@ (posedge clk);
	#1; a = 1;
	
	@ (posedge clk);
	@ (posedge clk);
	#1; b = 1;
	
	// wait a couple clocks 
	@ (posedge clk); 
	@ (posedge clk);
	#1; c = 1;	
	
	// wait a couple clocks 
	@ (posedge clk);
	@ (posedge clk);	
	#1;
	a = 0; // condition that sends state machine back to WAIT
	b = 1;
	c = 0;
	
	// wait a couple clocks 
	@ (posedge clk);
	@ (posedge clk);	
	#1; b = 0;
	
	// stop the simulation
	@ (posedge clk);
	@ (posedge clk);
	$stop();
	
end // initial



// Instantiate the DUT (Device Under Test) 
sm sm_inst (

	// inputs ---------------------------------------------
	.clk        (clk),
	.resetn     (resetn),
	.a          (a),
	.b          (b),
	.c          (c),
	
	// outputs --------------------------------------------
	.control_1  (control_1), 
	.control_2  (control_2)
   
   );


endmodule // sm_testbench




