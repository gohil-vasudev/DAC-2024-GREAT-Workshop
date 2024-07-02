module simon(
    input clk,
    input rst,
    input en,
    input [63:0] plaintext,
    input [127:0] key,
    output reg [63:0] ciphertext,
    output reg done
);
    // Internal signals and registers
    wire [31:0] key_i;
    wire [63:0] round_output;
    reg [63:0] round_input;
    reg [63:0] next_round_input;
    reg [5:0] round_counter, _next_round_counter;
    reg [1:0] state, next_state;

    // Key schedule array
    reg [31:0] key_schedule [0:43];

    // Array to store intermediate ciphertexts
    reg [63:0] intermediate_ciphertexts [0:43];

    // State encoding
    localparam S_IDLE = 2'd0,
               S_ENABLE = 2'd1,
               S_RUN  = 2'd2,
               S_DONE = 2'd3;

    // Conditional key_in logic
    wire [127:0] key_in = (round_counter < 4) ? key : 
                          {key_schedule[round_counter - 1], key_schedule[round_counter - 2], key_schedule[round_counter - 3], key_schedule[round_counter - 4]};

    // Instantiate key expansion and round modules
    key_expansion key_ex(.key(key_in), .i(round_counter), .key_i(key_i));
    round r (.x(round_input), .y(round_output), .k(key_i));

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S_IDLE;
            round_counter <= 6'd0;
            round_input <= 64'd0;
            next_round_input <= 64'd0;
            _next_round_counter <= 6'd0;
            ciphertext <= 64'd0;
            done <= 1'b0;
            // Initialize key_schedule
            key_schedule[0] <= key[31:0];
            key_schedule[1] <= key[63:32];
            key_schedule[2] <= key[95:64];
            key_schedule[3] <= key[127:96];
        end else begin
            state <= next_state;
            round_counter <= _next_round_counter; // Update round_counter
            if (state != S_IDLE) begin
                round_input <= next_round_input;
            end else if (en || next_state == S_ENABLE) begin
                round_input <= next_round_input; // Set the output based on conditions
            end else begin
                round_input <= 64'd0;
            end

            if (state == S_ENABLE || state == S_RUN) begin
                // Update key_schedule for the next round
                if (round_counter >= 4) begin
                    key_schedule[round_counter] <= key_i; // Update with the expanded key
                end
            end
        end
    end

    always @(*) begin
        next_state = state;
        _next_round_counter = round_counter; // Default assignment

        case (state)
            S_IDLE: begin
                if (en) begin
                    done = 1'b0;
                    next_state = S_ENABLE;
                end
                next_round_input = round_output;
            end
            S_ENABLE: begin
                next_round_input = plaintext;
                _next_round_counter = 6'd0;
                next_state = S_RUN;
            end
            S_RUN: begin
                next_round_input = round_output;
                _next_round_counter = round_counter + 1;
                if (round_counter == 6'd42) begin // Change 43 to 42 for exactly 44 rounds
                    next_state = S_DONE;
                end else begin
                    next_state = S_RUN;
                end
            end
            S_DONE: begin
                ciphertext = round_output;
                done = 1'b1;
                next_round_input = 64'd0;
                if (!en) begin
                    next_state = S_IDLE;
                end
            end
        endcase
    end
endmodule
