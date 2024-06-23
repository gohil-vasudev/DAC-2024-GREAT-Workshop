`timescale 1ns / 1ps

module tb_key_expansion();

    reg clk;
    reg [5:0] i;
    reg [32-1:0] key_schedule[T(32,4)-1:0];
    reg [32*4-1:0] key_input;
    wire [32-1:0] key_output;

    key_expansion ks(key_input, i, key_output);

    integer mismatch_count;

    reg [31:0] expected_keys [0:43]; // Extend the array to hold all expected keys

    initial begin
        // Dumping waveform data
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_key_expansion);

        clk = 0;
        mismatch_count = 0;
    end

    always begin
        #5 clk = ~clk;
    end

    initial begin
   
        // Test Case 5
        expected_keys[0] = 32'h3de916c5;
        expected_keys[1] = 32'hc4bb9749;
        expected_keys[2] = 32'h2a0f6d6f;
        expected_keys[3] = 32'h81fdc39f;
        expected_keys[4] = 32'hecd0d19f;
        expected_keys[5] = 32'h871ba447;
        expected_keys[6] = 32'h1c617e0e;
        expected_keys[7] = 32'h46f0bd13;
        expected_keys[8] = 32'h0b084475;
        expected_keys[9] = 32'h9b64167b;
        expected_keys[10] = 32'hcccca1c1;
        expected_keys[11] = 32'h12d67a84;
        expected_keys[12] = 32'h61560e36;
        expected_keys[13] = 32'he40eb982;
        expected_keys[14] = 32'h5a4f2553;
        expected_keys[15] = 32'he2399aaa;
        expected_keys[16] = 32'hfac4be76;
        expected_keys[17] = 32'h5c6d2dac;
        expected_keys[18] = 32'h78defa3e;
        expected_keys[19] = 32'hb2f6b4ff;
        expected_keys[20] = 32'h7a114720;
        expected_keys[21] = 32'hefc069e6;
        expected_keys[22] = 32'h5fa8e0e0;
        expected_keys[23] = 32'h041f3da0;
        expected_keys[24] = 32'h1d0cf1a6;
        expected_keys[25] = 32'hc23257a5;
        expected_keys[26] = 32'h4222d3e3;
        expected_keys[27] = 32'hb40c3c6b;
        expected_keys[28] = 32'h0c193666;
        expected_keys[29] = 32'h7fbca7e1;
        expected_keys[30] = 32'hebdb50c3;
        expected_keys[31] = 32'h0220b1d6;
        expected_keys[32] = 32'h93e220ac;
        expected_keys[33] = 32'hc537c6a1;
        expected_keys[34] = 32'h33e1c2bc;
        expected_keys[35] = 32'h628e5aac;
        expected_keys[36] = 32'h01c8d45f;
        expected_keys[37] = 32'h00fc8d71;
        expected_keys[38] = 32'hafc713c3;
        expected_keys[39] = 32'h53598864;
        expected_keys[40] = 32'hb1eb49e1;
        run_test(128'hCAFEBABEDEADBEEFFEDCBA9876543210);
// Test Case 1
        // expected_keys[0] = 32'he1d16456;
        // expected_keys[1] = 32'h594cd5a2;
        // expected_keys[2] = 32'h8ddeb08a;
        // expected_keys[3] = 32'h8eb80589;
        // expected_keys[4] = 32'hc2f8a430;
        // expected_keys[5] = 32'h79f25c54;
        // run_test(128'h19181110090801001918111009080100);
 
        // // Test Case 2
        // expected_keys[0] = 32'h6bb01cc5;
        // expected_keys[1] = 32'he25c0ad6;
        // expected_keys[2] = 32'h89dd6b56;
        // expected_keys[3] = 32'h9820b4b6;
        // expected_keys[4] = 32'hbdbbf158;
        // expected_keys[5] = 32'h4cfceae9;
     
        // run_test(128'h00112233445566770011223344556677);

        // // Test Case 3
        // expected_keys[0] = 32'hba0d54e1;
        // expected_keys[1] = 32'hdb07aa14;
        // expected_keys[2] = 32'h65721e60;
        // expected_keys[3] = 32'h1ba6aea9;
        // expected_keys[4] = 32'h41b86b3d;
        // expected_keys[5] = 32'h0f1fcf6c;
    
        // run_test(128'h89ABCDEF0123456789ABCDEF01234567);

        // // Test Case 4
        // expected_keys[0] = 32'h982f76c3;
        // expected_keys[1] = 32'h06da77c9;
        // expected_keys[2] = 32'hb8afc3bd;
        // expected_keys[3] = 32'h39848c8b;
        // expected_keys[4] = 32'h36cf1c4a;
        // expected_keys[5] = 32'h7868b81b;
     
        // run_test(128'hFEDCBA9876543210FEDCBA9876543210);
        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches found.", mismatch_count);
        
        $finish;
    end

    task run_test(input [127:0] initial_key);
    integer j;
    begin
        // Initialize the key schedule with the initial key
        for (j = 0; j < 4; j = j + 1) begin
            key_schedule[j] = initial_key[((j+1)*32)-1-:32];
        end

        i = 4;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        while (i < 45) begin
            key_input = {key_schedule[i-1], key_schedule[i-2], key_schedule[i-3], key_schedule[i-4]};
            @(posedge clk);
            key_schedule[i] = key_output;
            if (key_output !== expected_keys[i-4]) begin
                $display("Mismatch in Round %0d: Expected Key = %h, Got = %h",  i, expected_keys[i-4], key_output);
                mismatch_count = mismatch_count + 1;
            end else begin
                $display("Test %d passed!", i);
            end
            i = i + 1;
        end
    end
    endtask

    function integer T;
        input integer n;
        input integer m;
        case (n)
            16: T = 32;
            24: T = 36;
            32: T = (m == 3) ? 42 : (m == 4) ? 44 : -1;
            48: T = (m == 2) ? 52 : (m == 3) ? 54 : -1;
            64: T = (m == 2) ? 68 : (m == 3) ? 69 : (m == 4) ? 72 : -1;
            128: T = (m == 4) ? 44 : -1; // Assuming 44 rounds for 128-bit key with 4 words
            default: T = -1;
        endcase        
    endfunction
endmodule

