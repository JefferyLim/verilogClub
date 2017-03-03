// Assignment 3, SystemVerilog testbench for the
//                   traffic controller.
// Author: Dave Sluiter
// Date  : Feb 23, 2017

// To make protected file: > vencrypt file.sv -o file_p.sv 


`define CLK_HALF_PERIOD   5000000 // 1 Hz clock


`define NUM_TEST_CASES    500	// the number of cycles to run



// -------------------------------------------------------
// The testbench. This module provides inputs (stimulus) 
// to the Device Under Test (DUT), and checks for correct
// behavior. The testbench code and the DUT use unit delay
// modeling of flip-flops for clarity.
// -------------------------------------------------------
module a3_testbench ();


timeunit        1ns/1ns; // time unit with precision

// testbench variables 
integer	        errors;

logic       	clk;
logic           resetn;


logic           ns_green;
logic           ns_yellow;
logic           ns_red;

logic           ew_green;
logic           ew_yellow;
logic           ew_red;



// --------------------------------------------------------
// Instantiate the DUT (Device Under Test)
// --------------------------------------------------------
traffic_controller traffic_controller_inst (

    .clk     (clk),
    .resetn  (resetn),

    // outputs
    .ns_green  (ns_green),
    .ns_yellow (ns_yellow),
    .ns_red    (ns_red),

    .ew_green  (ew_green),
    .ew_yellow (ew_yellow),
    .ew_red    (ew_red)

); // traffic_controller_inst







// --------------------------------------------------------
// Instantiate the driver
// --------------------------------------------------------
driver driver_inst (

	// outputs ------------------------------------------
	.driver_clk          (clk),
	.driver_resetn       (resetn)
	
); // driver_inst


// --------------------------------------------------------
// Instantiate the scoreboard / checker
// --------------------------------------------------------
scoreboard scoreboard_inst (

	// inputs ------------------------------
	.clk              (clk),
	.resetn           (resetn),

    // inputs from the DUT to monitor
    .ns_green  (ns_green),
    .ns_yellow (ns_yellow),
    .ns_red    (ns_red),

    .ew_green  (ew_green),
    .ew_yellow (ew_yellow),
    .ew_red    (ew_red),

    // outputs
    // the scoreboards internally calculated signals,
    // you can look at these in the waveform viewer
    .sb_ns_green  (),
    .sb_ns_yellow (),
    .sb_ns_red    (),

    .sb_ew_green  (),
    .sb_ew_yellow (),
    .sb_ew_red    ()

); // scoreboard



endmodule // a3_testbench






// -------------------------------------------------------
// Stimulus generator
// -------------------------------------------------------
module driver (

	// outputs ----------------------------
	output logic		   driver_clk,
	output logic		   driver_resetn

	);
	
timeunit      1ns/1ns; // time unit with precision




// ------------------------------
// generate the clock signal
// ------------------------------
always begin
   driver_clk = 1; // time t=0
   forever begin
      #`CLK_HALF_PERIOD;
	  driver_clk = ~driver_clk;
   end //forever
end // always


// ------------------------------
// initialize DUT inputs
// ------------------------------
initial begin

	integer       seed;
	
	// at time t=0, init all DUT inputs
	driver_resetn = 0; // assert reset 

	seed = 25;
	seed = $random ( seed ); // seed the pseudo-random sequence generator 
	
end // initial

// ------------------------------
// generate the stimulus
// ------------------------------
always begin

	// burn a couple clocks & release reset 
	@ (posedge driver_clk);
	@ (posedge driver_clk);
	@ (posedge driver_clk);
	#1; driver_resetn = 1; // de-assert reset 
	


	
    // burn a whole bunch of sim time & let the checker check
    // for functional correctness
	repeat (`NUM_TEST_CASES)
        @ (posedge driver_clk);




	// simulation end 
	// burn a couple clocks to let the last stimulus filter through
    repeat (32)
        @ (posedge driver_clk);

	
	$display ("------------------------------------------------------------------------");
	$display ("Simulation ended with: %d errors", a3_testbench.errors);
	$display ("------------------------------------------------------------------------");
	
	$stop ();
	
	

end // always 






endmodule // driver









// -------------------------------------------------------
// Scoreboard - checker
// -------------------------------------------------------
module scoreboard (

	// inputs ------------------------------
	input  logic	clk,
	input  logic	resetn,

    // inputs
    input   logic   ns_green,
    input   logic   ns_yellow,
    input   logic   ns_red,

    input   logic   ew_green,
    input   logic   ew_yellow,
    input   logic   ew_red,

    // score boards calculated signals
    output logic    sb_ns_green,
    output logic    sb_ns_yellow,
    output logic    sb_ns_red,

    output logic    sb_ew_green,
    output logic    sb_ew_yellow,
    output logic    sb_ew_red

	);

timeunit      1ns/1ns; // time unit with precision


`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "10.4d"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect encoding = (enctype = "base64", line_length = 64, bytes = 128), key_block
frijTkZ4nZ7swSdyUslCTmcSGaBbSAdVmJtbTYT47L75PQ3mkGRjKQojinvRJY32
L4vl4Quv6KlfyHRGuHs7Ik2HnE5LtA1wEmhMQFWYHnYz3nbj7ilRga4wEN52UuM9
+hrNJ0iOrPh9ZQFPgZ3lYAyK8I6IkZ/ZtfLSKjSXoxw=
`pragma protect encoding = (enctype = "base64", line_length = 64, bytes = 9552), data_block
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
`pragma protect end_protected



