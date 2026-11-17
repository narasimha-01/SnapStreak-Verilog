
module snap_streak #(
    parameter TIMEOUT_CYCLES = 5
)(
    input wire clk,
    input wire rst,
    input wire snap_event,

    output reg [7:0] streak_count,
    output reg [31:0] timer_count,
    output reg expired,
    output wire active
);

    localparam IDLE = 1'b0;
    localparam ACTIVE = 1'b1;

    reg state;

    assign active = (state == ACTIVE);

    always @(posedge clk) begin

        if (rst) begin
            state <= IDLE;
            streak_count <= 0;
            timer_count <= 0;
            expired <= 0;
        end

        else begin

            expired <= 0;

            case (state)

                IDLE: begin

                    timer_count <= 0;

                    if (snap_event) begin
                        streak_count <= 1;
                        state <= ACTIVE;
                    end

                end

                ACTIVE: begin

                    if (snap_event) begin

                        if (streak_count < 255)
                            streak_count <= streak_count + 1'b1;

                        timer_count <= 0;

                    end

                    else if (timer_count >= TIMEOUT_CYCLES - 1) begin

                        streak_count <= 0;
                        timer_count <= 0;
                        expired <= 1;
                        state <= IDLE;

                    end

                    else begin
                        timer_count <= timer_count + 1'b1;
                    end

                end

                default: begin
                    state <= IDLE;
                    streak_count <= 0;
                    timer_count <= 0;
                    expired <= 0;
                end

            endcase

        end

    end

endmodule
