// 4-bit up/down counter
module Count4(clk,rst,enable,upDown, count);
   input clk, rst, enable, upDown;
   output reg [3:0] count;

   // insert code here 
	always @(posedge clk or posedge rst) begin
		if( rst ) begin
			count <= 4'b000;
		end
		else if( enable ) begin
			if( upDown ) begin
				count <= (count == 4'b1111) ? 4'b0000 : count + 1;
			end else begin
				count <= (count == 4'b0000) ? 4'b1111 : count - 1;
			end
		end
	end 

endmodule  // Count4