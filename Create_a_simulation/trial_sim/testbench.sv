
// SystemVerilog test file for mentor modelsim from Altera Quartus Lite 16.0
// Author: Dave Sluiter
// Date  : Jan 02, 2016

// Steps
//   compile all
//   simulate / restart...
//      > restart -f
//   simulate / run -all
//      > run -all 

// `timescale 1 ns / 1 ns // pre SystemVerilog way


`define CLK_HALF_PERIOD   5 	// 10ns period, 100 MHz clock




// -------------------------------------------------------
// The testbench. This module provides inputs (stimulus) 
// to the Device Under Test (DUT), and checks for correct
// behavior. The testbacnh code and the DUT use unit delay
// modeling of flip-flops for clarity.
// -------------------------------------------------------
module testbench ();

//timeunit      1ns;	// this one defines "how" to interptret numbers encountered in the source
//timeprecision 1ns; 	// this specifies the minimum time-step resultion
// aternative form:
timeunit      1ns/1ps; // time unit with precision

// testbench variables 
logic       	clk;
logic           resetn;

logic			a, b, c; // inputs and outputs to the DUT
logic           z;

logic			a_tb, b_tb, c_tb; // inputs and outputs to the DUT for the testbench to use 
logic           z_tb;

logic [1:0]		temp1, temp2;

// ------------------------------
// generate the clock signal
// ------------------------------
always begin
   clk = 1;
   forever begin
      #5;
	  clk = ~clk;
   end //forever
end // always
 

// Instatniate the DUT
majority dut (

   .clk     (clk),
   .resetn  (resetn),
   .a       (a),
   .b       (b),
   .c       (c),
   .z       (z)
   
   ); // dut 


// This initial block is the stimulus generator 
initial begin

	// reset all inputs (drive inputs to their inactive states)
	resetn = 0; // resetn is the exception to the inactive state, we want this active from time 0
	a      = 0;
    b      = 0;
	c      = 0;
	
	@ (posedge clk);
	resetn <= #1 1; // de-assert reset
 	@ (posedge clk);
 
 
 
	// --------------------------
	// test case 1
	// --------------------------
	@ (posedge clk);
	a <= #1 1;	
	b <= #1 1;
	c <= #1 0;
	
	
	// --------------------------
	// test case 2
	// --------------------------
	@ (posedge clk);
	a <= #1 0;	
	b <= #1 1;
	c <= #1 1;
 
 
	// --------------------------
	// test case 3
	// --------------------------
	@ (posedge clk);
	a <= #1 1;	
	b <= #1 0;
	c <= #1 1;
	
	
	// --------------------------
	// test case 4
	// --------------------------
	@ (posedge clk);
	a <= #1 0;	
	b <= #1 0;
	c <= #1 0;	

	
	// --------------------------
	// test case 5
	// --------------------------
	@ (posedge clk);
	a <= #1 1;	
	b <= #1 0;
	c <= #1 0;	
	

	// --------------------------
	// test case 6
	// --------------------------
	@ (posedge clk);
	a <= #1 0;	
	b <= #1 1;
	c <= #1 0;	
	
	
	// --------------------------
	// test case 7
	// --------------------------
	@ (posedge clk);
	a <= #1 0;	
	b <= #1 0;
	c <= #1 1;	
	
	temp1[1:0] = 2'b01;
	temp2[1:0] = myfunction1 (temp1[1:0]);
	
   // its always a good idea to burn a little extra time
   // at the end of a simulation so you can see the effects 
   // of the last stimulus 
   #20
   // for Mentor we call $stop() as we want the intercative sim to not quit/exit.
   // With nc-verilog (Cadence) and VCS (Synopsys) we generally run these in batch scripts
   // so we'd call $finish(); instead.
   $stop(); 


end // initial stimulus 


// the checker
always begin

	// sample DUT inputs
	@ (posedge clk); // driving clock edge
	a_tb <= a; // notice 0-delay for TB "flop-flops"!
	b_tb <= b;
	c_tb <= c;
	
	// tb_z is the expected output, mimicing the flop in the majority module 
	@ (posedge clk); // DUT computation cycle
	z_tb <= (a_tb & b_tb) |
            (b_tb & c_tb) |
	        (a_tb & c_tb) ;
			   
	// sample & compare clock edge 
	@ (posedge clk);
	if (z !== z_tb)
		$display ("Error: Expected %d, got %d", z_tb, z, "at time: ", $time);
	
end // always


function logic [1:0] myfunction1
	(
	input logic [1:0]   a
	);
	
	myfunction1[0] = a[1] & a[0];
	myfunction1[1] = a[1] ^ a[0];
	
endfunction // myfunction1


endmodule // testbench

