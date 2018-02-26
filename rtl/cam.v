module cam #
(
    parameter WIDTH = 32;
    parameter DEPTH = 32;
)
(
    input                           clk_i,
    input [WIDTH-1:0]               pattern,
    input                           we,
    input [$clog2(WIDTH)-1:0]       wraddr,

    output reg [$clog2(WIDTH)-1:0]  match,
    output reg                      found
);

reg [WIDTH-1:0] ram [0:DEPTH-1];
wire [DEPTH-1:0] match_lines;

integer i;
initial begin
    for (i=0;i<DEPTH;i++)
        ram[i] = 0;
end

always @(posedge clk_i) begin
    if (we) begin
        ram[wraddr] = pattern;
    end
end


wire [DEPTH-1:0] match_line;

genvar i;
generate
    for (i=0; i<DEPTH; i++) begin
        assign match_lines = ram[i] == pattern;
    end
endgenerate


priority_encoder #(
    .WIDTH(DEPTH),
    .LSB_PRIORITY("HIGH")
)
pe_inst (
    .input_unencoded(match_lines),
    .output_valid(found),
    .output_encoded(match),
    .output_unencoded()
);

endmodule
