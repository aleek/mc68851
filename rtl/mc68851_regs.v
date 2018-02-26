module mc68851_regs (
    input clk_i,
    input rst_n,

    input [4:0] addr_i,
    input [31:0] data_i,
    output [31:0] data_o,
    input we,
    input cs,
    output valid,
);

`define CONTROL           5'h00; // wo
`define RESPONSE          5'h02; // ro
`define RESTORE           5'h04; // rw
`define SAVE              5'h06; // ro
`define COMMAND           5'h08; // wo
`define OPERATION         5'b0a; // wo
`define CONDITION         5'h0c; //wo
/* 0x0e reserved */
`define OPERAND           5'b10; // rw
/* 0x14 reserved */
`define REG_SELECT        5'b16; // ro
`define F_LINE_INSTR_ADDR 5'b18; // rw
`define OP_ADDR           5'b1c; // rw

reg [15:0] ctrl;
reg [15:0] resp;
reg [15:0] rest;
reg [15:0] save;
reg [15:0] cmd;
reg [15:0] oper;
reg [15:0] cond;
reg [31:0] operand;
reg [15:0] reg_sel;
reg [31:0] fl_instr;
reg [31:0] op_addr;


always @(posedge clk_i)
    if(rst_n == 1'b0) begin
    end
    else
        if(cs) begin
            if(we_i) begin
            end
                case (addr_i)
                    if(we_i) begin
                        `CONTROL:           begin ctrl     <= data_i[15:0] end
                        `RESTORE:           begin rest     <= data_i[15:0] end
                        `COMMAND:           begin cmd      <= data_i[15:0] end
                        `OPERATION:         begin oper     <= data_i[31:16] end
                        `CONDITION:         begin cond     <= data_i[15:0] end
                        `OPERAND:           begin operand  <= data_i end
                        `F_LINE_INSTR_ADDR: begin fl_instr <= data_i end
                        `OP_ADDR:           begin op_addr  <= data_i end
                    end
                    `RESPONSE:          begin data_o[31:16] <= resp end
                    `RESTORE:           begin data_o[15:0]  <= rest end
                    `SAVE:              begin data_o[31:16] <= save end
                    `OPERAND:           begin data_o        <= operand end
                    `REG_SELECT:        begin data_o[31:16] <= reg_sel end
                    `F_LINE_INSTR_ADDR: begin data_o        <= fl_instr end
                    `OP_ADDR:           begin data_o        <= op_addr end
                endcase
            end
        end
    end
end



end
