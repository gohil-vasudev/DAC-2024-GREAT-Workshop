module round(
    input [(2*32)-1:0] x,
    input [(32-1):0] k,
    output [(2*32)-1:0] y
);
    
    wire [31:0] x_0 = x[31:0];
    wire [31:0] x_1 = x[63:32];
    
    wire [31:0] rol_1 = {x_1[30:0], x_1[31]};
    wire [31:0] rol_2 = {x_1[29:0], x_1[31:30]};
    wire [31:0] rol_8 = {x_1[23:0], x_1[31:24]};
    
    wire [31:0] y_1 = (x_0 ^ (rol_1 & rol_8)) ^ rol_2 ^ k;
    wire [31:0] y_0 = x_1;
    
    assign y = {y_1, y_0};

endmodule
