module Top(clk, rst, enable, upDown, count, seg7);
// count[3:0] output included for convenience in debug and testbenches
	input clk, rst, enable, upDown;
	output [3:0] count;
	output [6:0] seg7;
	
   wire clkCounter;  // divided clock for Counter module
	
	// Add code here to instantiate and connect the three modules together structurally
	ClkDiv #(4) clk_div_inst (
      		.clk(clk),
      		.clkOut(clkCounter)
   	);

   Count4 count4_inst (
      .clk(clkCounter),
      .rst(rst),
      .enable(enable),
      .upDown(upDown),
      .count(count)
   );

   Seg7Decode seg7decode_inst (
      .bin(count),
      .seg7(seg7)
   );
endmodule
