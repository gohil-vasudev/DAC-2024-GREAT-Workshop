module key_expansion(
    input [127:0] key,
    input [5:0] i, // denotes current round
    output reg [31:0] key_i
);
  localparam [0:61] z = 62'b11011011101011000110010111100000010010001010011100110100001111;
  
  // Split key into 4 parts
  wire [31:0] key_parts [3:0];
  

  reg [31:0] tmp1, tmp2, tmp3;

  always @(*) begin
    if (i < 4) begin
      //key_i = key_parts[i];
      key_i = key[32*(i+1)-1-: 32];
    end else begin
      // Rotate right by 3 bits
      tmp1 = {key[96+:3], key[127-:29]};
      // XOR with key[63-:32]
      tmp1 = tmp1 ^ key[63-:32];//key_parts[2];
      // Rotate right by 1 bit and XOR with tmp1 again
      tmp2 = {tmp1[0], tmp1[31:1]};
      tmp3 = tmp1 ^ tmp2;
      // Final computation for key_i

      key_i = ~key[31:0] ^ tmp3  ^ z[i-4] ^ 2'b11;
    end
  end
endmodule
