
`timescale 1ns/1ps

module snap_streak_tb;

    reg clk;
    reg rst;
    reg snap_event;

    wire [7:0] streak_count;
    wire [31:0] timer_count;
    wire expired;
    wire active;

    integer pass_count = 0;
    integer fail_count = 0;
    integer i;

    snap_streak #(
        .TIMEOUT_CYCLES(5)
    ) DUT (
        .clk(clk),
        .rst(rst),
        .snap_event(snap_event),
        .streak_count(streak_count),
        .timer_count(timer_count),
        .expired(expired),
        .active(active)
    );

    always #5 clk = ~clk;

    task check;
        input condition;
        input [8*60:1] test_name;
        begin
            if (condition) begin
                $display("[PASS] %0s", test_name);
                pass_count = pass_count + 1;
            end
            else begin
                $display("[FAIL] %0s", test_name);
                fail_count = fail_count + 1;
            end
        end
    endtask

    task send_snap;
        begin
            @(negedge clk);
            snap_event = 1;

            @(negedge clk);
            snap_event = 0;
        end
    endtask

    initial begin

        $dumpfile("snap_streak.vcd");
        $dumpvars(0, snap_streak_tb);

        clk = 0;
        rst = 1;
        snap_event = 0;

        $display("SNAPSTREAK VERIFICATION START");

        repeat(2) @(negedge clk);
        rst = 0;

        @(posedge clk);
        #1;

        check(streak_count == 0, "Reset initialization");

        send_snap();
        #1;

        check(streak_count == 1 && active,
              "First snap starts streak");

        repeat(3) @(negedge clk);

        send_snap();
        #1;

        check(streak_count == 2 && timer_count == 0,
              "Second snap increments streak");

        for(i=1; i<=4; i=i+1) begin
            @(posedge clk);
            #1;
            check(timer_count == i,
                  "Timer increments correctly");
        end

        @(posedge clk);
        #1;

        check(streak_count == 0 && expired && !active,
              "Timeout clears streak");

        @(posedge clk);
        #1;

        check(!expired, "Expired pulse lasts one clock");

        send_snap();
        #1;

        check(streak_count == 1 && active,
              "New streak after expiration");

        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        check(streak_count == 0 && !active,
              "Reset during active streak");

        @(negedge clk);
        rst = 0;

        $display("------------------------------");
        $display("PASSED : %0d", pass_count);
        $display("FAILED : %0d", fail_count);
        $display("------------------------------");

        if(fail_count == 0)
            $display("RESULT: ALL TESTS PASSED");
        else
            $display("RESULT: VERIFICATION FAILED");

        $finish;

    end

endmodule
