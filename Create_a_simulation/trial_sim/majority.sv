
module majority (

   input  logic  	clk,
   input  logic  	resetn,
   input  logic     a,
   input  logic     b,
   input  logic     c,
   output logic     z
   
   );
   
   timeunit      1ns;	// this one defines "how" to interptret numbers encountered in the source
   timeprecision 1ns; 	// this specifies the minimum time-step resultion

   logic   z_next;
   
   // --------------------------------------
   // combinational logic
   // --------------------------------------
   
 /*
   // old-school way
   assign z_next = (a & b) |
                   (b & c) |
			       (a & c) ;
*/

   // SystemVerilog construct
   always_comb begin
      z_next = (a & b) |
               (b & c) |
	           (a & c) ;
   end 

   // --------------------------------------
   // sequential logic
   // --------------------------------------	
	always_ff @ (posedge clk or negedge resetn)
		if (resetn == 1'b0)
			z <= #1 1'b0;
		else
			z <= #1 z_next;
			
	
 
endmodule // majority
