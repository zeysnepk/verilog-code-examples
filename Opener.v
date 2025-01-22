// Garage door opener FSM  
module Opener(            
   input clk, b, c, o, r, s,  // b: button, c: closed limit switch, o: open limit switch, r = reset, s = sensor
   output reg d, u,          // d: run the motor downwards to close the door, u: run the motor upwards to open the door
   output reg [1:0] State    // an output for troubleshooting and simulation verification
);

localparam [1:0]
    Closed  = 2'b00,
    Opening = 2'b01,
    Open    = 2'b10,
    Closing = 2'b11;


initial begin
    u = 0;
    d = 0;
    State = Closed;
end


always @(posedge clk or posedge r) begin
    if (r) begin
        if (c) begin
            State <= Closed;
        end else if (o) begin
            State <= Open;
        end else begin
            State <= Opening;
        end
    end else begin
        case (State)
            Closed: begin
                if (b) begin
                    State <= Opening;
                end
            end
            Opening: begin
                if (o) begin
                    State <= Open;
                end
            end
            Open: begin
                if (b && !s) begin
                    State <= Closing;
                end
            end
            Closing: begin
                if (b || s) begin
                    State <= Opening;
                end else if (c && !b && !s) begin
                    State <= Closed;
                end else begin
                    State <= Closing;
                end
                u = 0;
                d = 1;
            end
        endcase
    end
end

always @(*) begin
    case (State)
        Closed: begin
            u = 0;
            d = 0;
        end
        Opening: begin
            u = 1;
            d = 0;
        end
        Open: begin
            u = 0;
            d = 0;
        end
        Closing: begin
            if (b && s) begin
                State <= Opening;
            end else if (c && !b && !s) begin
                State <= Closed;
            end
            u = 0;
            d = 1;
        end
        default: begin
            u = 0;
            d = 0;
        end
    endcase
end

endmodule
