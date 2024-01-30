module RotWord(output [31:0] out, input [31:0] in);

assign out[7:0] = in [15:8];
assign out[15:8] = in [23:16];
assign out[23:16] = in [31:24];
assign out[31:24] = in [7:0];

endmodule 