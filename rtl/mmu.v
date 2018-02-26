module mmu (
    input clk_i,
    input rst_n,
    /* cpu side */

    input      [31:0] cpu_addr_i,
    input      [31:0] cpu_dat_i,
    output reg [31:0] cpu_dat_o,
    input cyc_i,
    input sel_i,
    input stb_i,
    input we_i,
    output ack_o,

    /* tag type tgc_o */
    input fc_i[2:0],
);

wire cpid[2:0] = cpu_addr_i[15:13];

`define S_IDLE 3'b000;
`define S_REG_OP 3'b001;
/* bus control */
always @(posedge clk_i)
begin
  if(rst_n == 1'b0) begin
  end
  else
    if(cs) begin

end

/* register definition */
reg [15:0] response

wire cs = &fc_i & cpid == 3'b000 & cpu_addr_i[19:16] == 4b'0010 & cyc_i & stb_i & ~ack_o;
/* register control */
always @(posedge clk_i)
  if(rst_n == 1'b0) begin
  end
  else
    if(cs) begin
        if(we_i)


end

endmodule