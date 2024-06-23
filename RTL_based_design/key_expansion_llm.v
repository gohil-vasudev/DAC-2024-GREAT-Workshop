// Please generate a Verilog module for the key expansion of the SIMON cipher with a block size of 64 bits and a key size of 128 bits. Use z as the constant for the key expansion algorithm. 
//The code takes key and outputs a round key for a specified round i. Assume round incrementing is happening in the testbench. Thus, use if statement.

// if i<4
//    key_i = i-th 32 bit partitioning of the initial key
// else
      // tmp ← S−3 (leftmost 32 bits of key)
      // tmp ← tmp ^ key[63-:32];
      // tmp ← tmp ⊕ S−1 tmp
      // key_i ← ~key[31:0] ^ tmp ^ z[i-4] ^ 3
// end if
//where key_i is the resultant 32-bit round key for a specific round i.
//do NOT change localparam. It MUST be [0:61]



module key_expansion(
    input [127:0] key,
    input [5:0] i, // denotes current round
    output reg [31:0] key_i
);
    localparam [0:61] z = 62'b11011011101011000110010111100000010010001010011100110100001111;

    wire [31:0] k0, k1, k2, k3;
    reg [31:0] tmp;

    // Partition the 128-bit key into four 32-bit segments
    assign k0 = key[127:96];
    assign k1 = key[95:64];
    assign k2 = key[63:32];
    assign k3 = key[31:0];

    always @(*) begin
        if (i < 4) begin
            case (i)
                0: key_i = k0;
                1: key_i = k1;
                2: key_i = k2;
                3: key_i = k3;
                default: key_i = 32'b0;
            endcase
        end else begin
            // S−3 (leftmost 32 bits of key)
            tmp = {k0[2:0], k0[31:3]};
            // tmp ← tmp ^ key[63-:32];
            tmp = tmp ^ k2;
            // tmp ← tmp ⊕ S−1 tmp
            tmp = tmp ^ {tmp[0], tmp[31:1]};
            // key_i ← ~key[31:0] ^ tmp ^ z[i-4] ^ 3
            key_i = ~k3 ^ tmp ^ {31'b0, z[i-4]} ^ 32'h3;
        end
    end
endmodule
