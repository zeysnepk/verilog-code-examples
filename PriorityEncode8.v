module PriorityEncode8(in, code,z);  
	input [7:0] in;         
	output reg [2:0] code;
	output reg z;           
 
	always @( * ) begin
		if ( in[7] ) begin
			code = 3'b111;
		end
		else if ( in[6] ) begin
			code = 3'b110;
		end
		else if ( in[5] ) begin
			code = 3'b101;
		end
		else if ( in[4] ) begin
			code = 3'b100;
		end
		else if ( in[3] ) begin
			code = 3'b011;
		end
		else if ( in[2] ) begin
			code = 3'b010;
		end
		else if ( in[1] ) begin
			code = 3'b001;
		end
		else if ( in[0] ) begin
			code = 3'b000;
		end
		else begin	
			code = 3'b000;
		end

		if ( in == 8'b00000000 ) begin
			z = 1;
		end
		else begin   
			z = 0;
		end
	end
endmodule