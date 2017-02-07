// Assignment 1, SystemVerilog testbench for the positive and negative edge detector
// Author: Dave Sluiter
// Date  : Jan 03, 2017

// To make protected file: > vencrypt file.sv -o file_p.sv 


`define CLK_HALF_PERIOD   5 	// 10ns period, 100 MHz clock

`define NUM_TEST_CASES    25	// the number of test cases to run 


// -------------------------------------------------------
// The testbench. This module provides inputs (stimulus) 
// to the Device Under Test (DUT), and checks for correct
// behavior. The testbench code and the DUT use unit delay
// modeling of flip-flops for clarity.
// -------------------------------------------------------
module a1_testbench ();

//timeunit      1ns;	// this one defines "how" to interptret numbers encountered in the source
//timeprecision 1ns; 	// this specifies the minimum time-step resultion
// aternative form:
timeunit      1ns/1ns; // time unit with precision

// testbench variables 
integer	        errors;

logic       	clk;
logic           resetn;
logic  			a;

logic     		pos_edge, neg_edge;


// Instantiate the DUT (Device Under Test) 
edge_detector edge_detector_inst (

	// inputs -------------------------------------------
	.clk       (clk),
	.resetn    (resetn), 
	.a         (a),
	
	// outputs ------------------------------------------
	.pos_edge  (pos_edge),
	.neg_edge  (neg_edge)
   
); // edge_detector_inst
   


// Instantiate the driver
driver driver_inst (

	// No inputs 
	
	// outputs ------------------------------------------
	.driver_clk      (clk),
	.driver_resetn   (resetn),
	
	.driver_a	     (a)
	
); // driver_inst



// Instantiate the scoreboard / checker 
scoreboard scoreboard_inst (

	// inputs ------------------------------
	.clk              (clk),
	.resetn           (resetn),
	
	.a                (a),
	
	.dut_pos_edge     (pos_edge),
	.dut_neg_edge     (neg_edge)
	
	// No outputs 
	
	); // scoreboard

	

endmodule // a1_testbench






// -------------------------------------------------------
// Stimulus generator
// -------------------------------------------------------
module driver (

	// outputs ----------------------------
	output logic		driver_clk,
	output logic		driver_resetn,
	
	output logic		driver_a		// drives test values for a
	
	);
	
timeunit      1ns/1ns; // time unit with precision

// ------------------------------
// generate the clock signal
// ------------------------------
always begin
   driver_clk = 1; // time t=0
   forever begin
      #5;
	  driver_clk = ~driver_clk;
   end //forever
end // always


initial begin

	integer       seed;
	
	// at time t=0, init all DUT inputs
	driver_resetn = 0; // assert reset 
	driver_a      = 0;
	
	seed = 25;
	seed = $random ( seed ); // seed the pseudo-random sequence generator 
	
end // initial


always begin

	
	// burn a couple clocks & release reset 
	@ (posedge driver_clk);
	@ (posedge driver_clk);
	@ (posedge driver_clk);
	#1; driver_resetn = 1; // de-assert reset 
	
	
	// start generating stimulus
	repeat (`NUM_TEST_CASES) begin
	
		// This is a primitive form of constrained random verification
		@ (posedge driver_clk);
		#1; driver_a = $random() & 32'h01;
		
	end // repeat
	

	
	
	// simulation end 
	// burn a couple clocks to let the last stimulus filter through to outputs 
	@ (posedge driver_clk);
	@ (posedge driver_clk);
	@ (posedge driver_clk);
	@ (posedge driver_clk);
	
	$display ("------------------------------------------------------------------------");
	$display ("Simulation ended with: %d errors", a1_testbench.errors);
	$display ("------------------------------------------------------------------------");
	
	$stop ();
	
	

end // always 

endmodule // driver



// -------------------------------------------------------
// Scoreboard - checker
// -------------------------------------------------------
module scoreboard (

	// inputs ------------------------------
	input  logic		clk,
	input  logic		resetn,
	
	input  logic		a, // from the driver
	
	input  logic        dut_pos_edge, // from the DUT
	input  logic        dut_neg_edge
	
	);
	
timeunit      1ns/1ns; // time unit with precision


logic         flop;
logic         sb_pos_edge, sb_neg_edge; // scoreboard predicted values

always begin
	
	a1_testbench.errors = 0;
	
	// wait for the rising edge of resetn 
	@ (posedge clk);  // get off time t=0 
	@ (posedge resetn);
	
	forever begin
	
		@ (posedge clk);
		
		if (dut_pos_edge !== sb_pos_edge) begin
			$display ("%m: Error dut_pos_edge: Expected=%d, Got=%d, at time=%t", sb_pos_edge, dut_pos_edge, $time);
			a1_testbench.errors += 1;
		end
		
		if (dut_neg_edge !== sb_neg_edge) begin
			$display ("%m: Error dut_neg_edge: Expected=%d, Got=%d, at time=%t", sb_neg_edge, dut_neg_edge, $time);
			a1_testbench.errors += 1;
		end
		
	end // forever
	
	
end // always


// ------------------------------------------------------------
// Prediction logic 
// ------------------------------------------------------------
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "10.4d"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect encoding = (enctype = "base64", line_length = 64, bytes = 128), key_block
lbzf8BJADzyeRoqXjXXmmsz0tAfikHFB8hE+OuoFZmzauxbH+a/kFHlEWqfu99fC
7O33RhoAq5UHdRL312cHBa67JLFGygwIvU67ysKh8UObeDWnkShdXUa8iEpc+ALn
ZB4mWZUkcaCpaE40KV5wte6KzHlrgjicS1aEzBnauvQ=
`pragma protect encoding = (enctype = "base64", line_length = 64, bytes = 416), data_block
K2uX+EdD7TqCD1qLLvcIg/9N0wNA9lE3j9GfJNdDR9ppCmOyJ1tDk1pSJZNsQtku
Klx1FC3spVlWe6dfmuJDq51DD4juGybeVmUGNUEohj8Lt6/JyYFNxqL4xkVywN1a
jgDVFzPCG1ovJCPF6zyIFJFON0azrWrkZw+gyfvIQMOOMG+oPCWWzW+mg5sRbLI3
2ERBsvYCp4tPpndHeZBwGwrubrK6NLtxh0KyqKhXchZx7i3g/q6vqDwApzx20dq6
6/an3zhpDt5oCahA8VMYusDIY6NHSS9ndlhoUYtn+41R1SwFEmiLOvuOxZuRC+96
SmiTANObxTL5hVKRGm40YTFiD3V4EerDpHdKjaUsbXQPUgZ0zdL3JfrnuAvVQ/nI
XArCJw7NYnr/7+yMpMoxDezXmMpWvhY/sk2HDK9Ov6nYoNPPEsu+DRRAoGkY7899
JgXvg8DM+iCZUYhNYTi06AKR1KMT1H4AH+Zc78MxBezn7m7va51RcM4z4GNKSaVA
iKipueshzK/oD39rC24pZhI/v8zOvSUN7RZ+G0avp+U=
`pragma protect end_protected



endmodule // scoreboard









