module Debounce(
    input clk,
    input b,
    output reg s
);

    localparam [1:0] 
        WaitRise = 2'b00,
        SkipRise = 2'b01,
        WaitFall = 2'b10,
        SkipFall = 2'b11;

    reg [1:0] current_state, next_state;

    initial begin
        current_state = WaitRise;
        s = 0;
    end

    always @(posedge clk) begin
        current_state <= next_state;
    end
 always @(*) begin
        case (current_state)
            WaitRise: begin
                s = 0;  
                if (b)
                    next_state = SkipRise;
                else
                    next_state = WaitRise;
            end

            SkipRise: begin
                s = 1;  
                next_state = WaitFall;
            end

            WaitFall: begin
                s = 1;  
                if (~b)
                    next_state = SkipFall;
                else
                    next_state = WaitFall;
            end

            SkipFall: begin
                s = 0;  
                next_state = WaitRise;
            end

            default: begin
                s = 0; 
                next_state = WaitRise;
            end
        endcase
    end
endmodule
   
