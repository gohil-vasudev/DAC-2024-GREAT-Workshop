module round_llm(
    input [(2*32)-1:0] x,
    input [(32-1):0] k,
    output [(2*32)-1:0] y
);
    
    // Split the input x into two parts
    wire [31:0] x_0 = x[31:0];
    wire [31:0] x_1 = x[63:32];

    // Perform circular left rotations
    wire [31:0] rol_1 = {x_1[30:0], x_1[31]};
    wire [31:0] rol_2 = {x_1[29:0], x_1[31:30]};
    wire [31:0] rol_8 = {x_1[23:0], x_1[31:24]};
    
    // Compute upper n bits of y
    wire [31:0] y_upper = (rol_1 & rol_8) ^ x_0 ^ rol_2 ^ k;
    
    // Assign the results to output y
    assign y[31:0] = x_1;
    assign y[63:32] = y_upper;

endmodule
