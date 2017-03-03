// Author		: Dave Sluiter
// Date  		: Jan 23, 2017
// Description	:
//	A unit delay RTL model for a simple state machine. This code illustrates
//	industry best coding practices.	

module sm (

	// inputs ---------------------------------------------
	input	logic	clk,
	input	logic	resetn, 	// active low reset 
	input	logic	a,
	input	logic	b,
	input	logic	c,
	
	// outputs --------------------------------------------
	output logic    control_1, // flop output 
	output logic    control_2  // flop output	
   
   );
   
	timeunit      1ns;	// this one defines "how" to interptret numbers encountered in the source
	timeprecision 1ns; 	// this specifies the minimum time-step resolution


	// typedef for state machine
	typedef enum logic [1:0] {
		WAIT  = 2'b00,
		START = 2'b01,
		DOIT  = 2'b10,
		DONE  = 2'b11
	} t_state;
	
	// flops
	t_state		state;
	
	// combinational logic
	t_state		next_state;
	logic		next_control_1, next_control_2;
	
   
	// ------------------------------------------------------
	// sequential logic section
	// ------------------------------------------------------
	always_ff @ (posedge clk or negedge resetn)
	
		if (resetn == 1'b0) begin
		
			state     <= #1 WAIT;
			control_1 <= #1 1'b0;
			control_2 <= #1 1'b0;
			
		end else begin
		
			state     <= #1 next_state;
			control_1 <= #1 next_control_1;
			control_2 <= #1 next_control_2;
			
		end // else
		
	// always 

	
	// ------------------------------------------------------
	// combinational logic section
	// ------------------------------------------------------
	always_comb begin
	
		// An alternate method to define case "default" behavior,
		// include code like this before the case statement 
		next_control_1 = control_1;
		next_control_2 = control_2;
		
		// --------------------------------------------
		// state machine next state logic 
		// --------------------------------------------
		case (state) inside
		
			// -----------------------------
			WAIT: begin
			
				if (a) begin
					next_state     = START; 	// advance
					next_control_1 = 1'b1;
					next_control_2 = 1'b0;
				end else begin
					next_state     = state; 	// hold
					//next_control_1 = control_1;
					//next_control_2 = control_2;
				end  
				
			end
			
			
			
			// -----------------------------
			START: begin 

				if (a & b) begin 
					next_state     = DOIT; 		// advance
					next_control_1 = 1'b0;
					next_control_2 = 1'b1;
				end else begin
					next_state     = state; 	// hold
					//next_control_1 = control_1;
					//next_control_2 = control_2;
				end
				
			end 
			
			
			
			// -----------------------------
			DOIT: begin 
			
				if (a & b & c) begin
					next_state     = DONE;	// advance
					next_control_1 = 1'b1;
					next_control_2 = 1'b1;
				end else begin
					next_state     = state; 	// hold
					//next_control_1 = control_1;
					//next_control_2 = control_2;
				end
				
			end 
			
			
			
			// -----------------------------
			DONE: begin 
			
				if (~a & b & ~c) begin
					next_state     = WAIT;	// advance, we're done
					next_control_1 = 1'b0; 
					next_control_2 = 1'b0;
				end else begin
					next_state     = state; 	// hold
					//next_control_1 = control_1;
					//next_control_2 = control_2;
				end
				
			end 
			
			
			// -----------------------------
			default: begin
			
				// next state
				next_state = state;	// hold
				
				// module output default condition handled before the case statement
				
			end
			
		endcase // state 
	
	end // always 
 
 
endmodule // sm 


