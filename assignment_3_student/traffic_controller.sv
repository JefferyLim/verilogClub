// Author		: 
// Date  		: 
// Description	:
//    A unit delay RTL model of a traffic controller system.
//    It only handles north-south and east-west lights, no
//    left turns, no traffic presence sensors etc. ie a dumb light
//    system.

module traffic_controller (

	// inputs ---------------------------------------------
	input  logic  	    clk,        // A 1 Hz clock (1 cycle/second)
    input  logic        resetn,

    // Light control outputs.
    // Flip-flop outputs to the power drivers to light up individual
    // light elements
    output logic        ns_green,   // the north-south outputs
    output logic        ns_yellow,
    output logic        ns_red,

    output logic        ew_green,   // the east-west outputs
    output logic        ew_yellow,
    output logic        ew_red

   );
   
	timeunit      	1ns;	// this one defines "how" to interptret numbers
							//   encountered in the source.
	timeprecision 	1ns; 	// this specifies the minimum time-step resultion




    // typedef for state mchine
    typedef enum logic [2:0] {
        SAFE      = 3'h0,
        NS_GREEN  = 3'h1,
        NS_YELLOW = 3'h2,
        NS_RED    = 3'h3,
        EW_GREEN  = 3'h4,
        EW_YELLOW = 3'h5,
        EW_RED    = 3'h6
    } t_cpu_state;



	// ------------------------------------------------------
	// internal declarations
	// ------------------------------------------------------

    	// flops
    	t_cpu_state     state, next_state, old_state, prev_state;
	int unsigned counter = 15;


	// ------------------------------------------------------
	// sequential logic section
	// ------------------------------------------------------

	always_ff @(posedge clk or negedge resetn)
		if(resetn == 1'b0) begin
			state 		<=#1 SAFE;
			prev_state	<=#1 SAFE;
			counter 	<=#1 15;
		
		end else begin
			state 		<=#1  next_state;
			prev_state	<=#1  old_state;
			counter 	<=#1  counter - 1;

			case (state) inside
			SAFE: begin
				if(counter == 1) begin
					counter <= #1 60;
				end
			end 
			NS_GREEN: begin
				if(counter == 1) begin
					counter <= #1 4;
				end
			end 
			NS_YELLOW: begin
				if(counter == 1) begin
					counter <= #1 3;
				end
			end 
			NS_RED: begin
				if(counter == 1) begin
					counter <= #1 4;
				end
			end  
			EW_GREEN: begin
				if(counter == 1) begin
					counter <= #1 4;
				end
			end 
			EW_YELLOW: begin
				if(counter == 1) begin
					counter <= #1 3;
				end
			
			end 
			EW_RED: begin
				if(counter == 1) begin
					counter <= #1 4;
				end
			end 
			default: begin
			
			end 	
		endcase
		end
	


	// ------------------------------------------------------
	// combinational logic section
	// ------------------------------------------------------


	always_comb begin
		case (state) inside
			SAFE: begin
				ns_green 	= 0;
				ns_yellow 	= 0;
				ns_red 		= 1;
				ew_green 	= 0;
				ew_yellow 	= 0;
				ew_red 		= 1;
				if(counter == 1) begin
					case(old_state) inside
						SAFE: begin
							next_state = NS_GREEN;
						end				
						NS_RED: begin
							next_state = EW_GREEN;
						end
						EW_RED: begin
							next_state = NS_GREEN;
						end

						default: begin
						end
					endcase;
				end else begin
					next_state = state;
					old_state = prev_state;
				end
			
			end 
			NS_GREEN: begin
				ns_green 	= 1;
				ns_yellow 	= 0;
				ns_red 		= 0;
				ew_green 	= 0;
				ew_yellow 	= 0;
				ew_red 		= 1;
				if(counter == 1) begin
					next_state = NS_YELLOW;
				end else begin
					next_state = state;
					old_state = prev_state;
				end
			end 
			NS_YELLOW: begin
				ns_green 	= 0;
				ns_yellow 	= 1;
				ns_red 		= 0;
				ew_green 	= 0;
				ew_yellow 	= 0;
				ew_red 		= 1;
				if(counter == 1) begin
					next_state = NS_RED;
					old_state = NS_RED;
				end else begin
					next_state = state;
					old_state = prev_state;
				end
			
			end 
			NS_RED: begin
				ns_green 	= 0;
				ns_yellow 	= 0;
				ns_red 		= 1;
				ew_green 	= 0;
				ew_yellow 	= 0;
				ew_red 		= 1;
				if(counter == 1) begin
					next_state = SAFE;
				end else begin
					next_state = state;
					old_state = prev_state;
				end
			end  
			EW_GREEN: begin
				ns_green 	= 0;
				ns_yellow 	= 0;
				ns_red 		= 1;
				ew_green 	= 1;
				ew_yellow 	= 0;
				ew_red 		= 0;
				if(counter == 1) begin
					next_state = EW_YELLOW;
				end else begin
					next_state = state;
					old_state = prev_state;
				end
			end 
			EW_YELLOW: begin
				ns_green 	= 0;
				ns_yellow 	= 0;
				ns_red 		= 1;
				ew_green 	= 0;
				ew_yellow 	= 1;
				ew_red 		= 0;
				if(counter == 1) begin
					next_state = EW_RED;
					old_state = EW_RED;
				end else begin
					next_state = state;
					old_state = prev_state;
				end
			end 
			EW_RED: begin
				ns_green 	= 0;
				ns_yellow 	= 0;
				ns_red 		= 1;
				ew_green 	= 0;
				ew_yellow 	= 0;
				ew_red 		= 1;
				if(counter == 1) begin
					next_state = SAFE;
				end else begin
					next_state = state;
					old_state = prev_state;
				end
			end 
			default: begin
				ns_green 	= 0;
				ns_yellow 	= 0;
				ns_red 		= 0;
				ew_green 	= 0;
				ew_yellow 	= 0;
				ew_red 		= 0;
			
			end 	
		endcase

	end
 


endmodule // traffic_controller


