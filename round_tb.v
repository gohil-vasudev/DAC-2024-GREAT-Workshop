`timescale 1ns / 1ps

//`include "utility.vh"

module round_tb();

    reg [(2*32)-1:0] x;
    reg [31:0] k;
    wire [(2*32)-1:0] y;

    round_llm  UUT (
        .x(x),
        .k(k),
        .y(y)
    );

    integer mismatch_count;
    reg [(2*32)-1:0] expected_y [0:4]; // Array to hold expected outputs

    initial begin
        // Dumping waveform data
        $dumpfile("waveform.vcd");
        $dumpvars(0, round_tb);

        mismatch_count = 0;

        // Define expected outputs
        expected_y[0] = 64'h71be60eb01234567;
        expected_y[1] = 64'hccaa440000112233;
        expected_y[2] = 64'h529dcb4089abcdef;
        expected_y[3] = 64'h50bd8d24fedcba98;
        expected_y[4] = 64'h910eb29fcafebabe;

        // Test Case 1
        x = 64'h0123456789ABCDEF;
        k = 32'hFEDCBA98;
        #10;
        if (y !== expected_y[0]) begin
            $display("Mismatch in Test Case 1 - Input x: %h, Input k: %h, Expected y: %h, Got y: %h", x, k, expected_y[0], y);
            mismatch_count = mismatch_count + 1;
        end else begin
            $display("Test 1 passed!");
        end

        // Test Case 2
        x = 64'h0011223344556677;
        k = 32'h8899AABB;
        #10;
        if (y !== expected_y[1]) begin
            $display("Mismatch in Test Case 2 - Input x: %h, Input k: %h, Expected y: %h, Got y: %h", x, k, expected_y[1], y);
            mismatch_count = mismatch_count + 1;
        end else begin
            $display("Test 2 passed!");
        end

        // Test Case 3
        x = 64'h89ABCDEF01234567;
        k = 32'h76543210;
        #10;
        if (y !== expected_y[2]) begin
            $display("Mismatch in Test Case 3 - Input x: %h, Input k: %h, Expected y: %h, Got y: %h", x, k, expected_y[2], y);
            mismatch_count = mismatch_count + 1;
        end else begin
            $display("Test 3 passed!");
        end

        // Test Case 4
        x = 64'hFEDCBA9876543210;
        k = 32'h01234567;
        #10;
        if (y !== expected_y[3]) begin
            $display("Mismatch in Test Case 4 - Input x: %h, Input k: %h, Expected y: %h, Got y: %h", x, k, expected_y[3], y);
            mismatch_count = mismatch_count + 1;
        end else begin
            $display("Test 4 passed!");
        end

        // Test Case 5
        x = 64'hCAFEBABEDEADBEEF;
        k = 32'hF0E1D2C3;
        #10;
        if (y !== expected_y[4]) begin
            $display("Mismatch in Test Case 5 - Input x: %h, Input k: %h, Expected y: %h, Got y: %h", x, k, expected_y[4], y);
            mismatch_count = mismatch_count + 1;
        end else begin
            $display("Test 5 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches found.", mismatch_count);
        
        $finish;
    end

endmodule
