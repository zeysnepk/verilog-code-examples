//  Two-way arbiter FSM/HLSM.  
//   Similar to the example in the HLSM chapter, but eliminates extra state ("Arbitrate") and uses meaningful signal names  
module Arbiter(
	input clk,rst,ra,rb, // ra = request from requestor a, rb = request from requestor b, which are level (not pulse) signals
	input [1:0] PA, PB,  // priority values for requestor a and requestor b, unsigned, higher number is higher priority
	output reg ga,gb     // ga = grant to a, gb = grant to b
);
	// insert code here
	localparam [1:0]
        	WaitReq = 2'b00,
        	GrantA = 2'b01,
       		GrantB = 2'b10;

	reg [1:0] State, next_state;
	
	always @(posedge clk or posedge rst) begin
		if( rst ) begin
			State <= WaitReq;
			ga = 1'b0;
			gb = 1'b0;
		end else begin
			State <= next_state;
		end
	end
	
	always @(*) begin
		case( State )
			WaitReq: begin
				if( ra && !rb ) begin
					next_state = GrantA;
				end else if( !ra && rb ) begin
					next_state = GrantB;
				end else if( ra && rb ) begin
					if( PB > PA ) begin
						next_state = GrantB;
					end else begin
						next_state = GrantA;
					end
				end
			end
		
			GrantA: begin
				ga = 1'b1;
				if ( !ra ) begin
				next_state = WaitReq;
				end
			end
			GrantB: begin
				gb = 1'b1;
				if ( !rb ) begin
					next_state = WaitReq;
				end
			end
			default: begin
				next_state = WaitReq;
			end
		endcase
	end	
endmodule