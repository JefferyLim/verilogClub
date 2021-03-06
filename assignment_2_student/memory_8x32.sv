// Author		: Dave Sluiter
// Date  		: Feb 09, 2017
// Description	:
//    A unit delay RTL model of an 8 location, 32-bit wide
//    synchronous static RAM (SRAM) modeled with flip-flops.
//    Note: A memory with a single address input (referred to
//          as a "single-ported" memory), can only perform either
//          a) a write, or
//          b) a read
//          each clock cycle.
//          "Dual-ported" memories can perform simultaneous
//          read and writes in 1 clock cycle.


// General industry convention is to use MxN notation,
// where M = number of locations and N = width in bits.
module memory_8x32 (

    // memories generally do not have resets

	// inputs ---------------------------------------------
	input  logic  	    clk,
    input  logic [2:0]  address,
    input  logic        write_enable, // 1=write, 0=read
    input  logic [31:0] write_data,

	// outputs --------------------------------------------
    output logic [31:0] read_data
   
   );
   
	timeunit      	1ns;	// this one defines "how" to interptret numbers
							//   encountered in the source.
	timeprecision 	1ns; 	// this specifies the minimum time-step resultion


					
	// ------------------------------------------------------
	// internal declarations
	// ------------------------------------------------------

	logic [31:0] mem[2:0];
	logic [2:0] old_address;


	// ------------------------------------------------------
	// sequential logic section
	// ------------------------------------------------------
	
	always_ff@(posedge clk)
	begin
		if(write_enable==1)
			mem[address] <=#1 write_data;
		if(write_enable==0)
			old_address <=#1 address;
	end


	// ------------------------------------------------------
	// combinational logic section
	// ------------------------------------------------------
	
	always_comb
	begin
		read_data = mem[old_address];
	end

endmodule // memory_8x32


