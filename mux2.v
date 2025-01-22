`timescale 1ns / 1ns

module mux2(a, b, s, y);       
   input a, b, s;   
   output reg y; //  y = s'a + sb  (not really a register)
    
// add code here to implement the multiplexer y = s'a + sb
   always @(a, b, s) begin
	y = (~s & a) | (s & b);
   end
endmodule

module Testbench();
	reg a_tb, b_tb, s_tb;
	wire y_tb;
	mux2 mux2_tb(a_tb, b_tb, s_tb, y_tb);
	initial begin
	a_tb = 0;
	b_tb = 0;
	s_tb = 0;
	#5 
	b_tb = 1;
	#5
	a_tb = 1;
	b_tb = 0;
	#5
	b_tb = 1;
	#5
	a_tb = 0;
	b_tb = 0;
	s_tb = 1;
	#5
	b_tb = 1;
	#5
	a_tb = 1;
	b_tb = 0;
	#5
	b_tb = 1;
	end

endmodule