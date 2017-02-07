// Author		: 
// Date  		: 
// Description	:
//    A unit delay RTL model for positive and negative edge detector
//

module edge_detector (

	// inputs ---------------------------------------------
	input  logic  	clk,
	input  logic  	resetn, 	// active low reset 
	input  logic	a,
	
	// outputs --------------------------------------------
	output logic    pos_edge,	// 1 cycle pulse on +edge 
	output logic    neg_edge	// 1 cycle pulse on -edge 
   
   );
   
	timeunit      1ns;	// this defines "how" to interptret numbers
                        //   encountered in the source.
	timeprecision 1ns; 	// this specifies the minimum time-step resolution.







   
	// ------------------------------------------------------
	// sequential logic section
	// ------------------------------------------------------


	
	// ------------------------------------------------------
	// combinational logic section
	// ------------------------------------------------------

 
 
endmodule // edge_detector
