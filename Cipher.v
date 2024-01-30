module Cipher #(parameter Nr = 10)
(output [0:127] Ciphered, input [0:127] Text, input [0:128*(Nr+1)-1] RoundKeys, input clk, input reset);

reg [0:127] states [Nr:0];
wire [0:127] firstState;
wire [0:127] SubBytesState;
wire [0:127] ShiftRowState;
wire [0:127] MixColumnState;
wire [0:127] outState;
reg [0:127] inState;
reg [0:127] inRoundKey;
reg [0:3] i;
reg outReady;

AddRoundKey A0(.outState(firstState), .inState(Text), .RoundKey(RoundKeys[0:127]));
EncryptionRound Er(outState, inState, inRoundKey);

always @ (posedge clk or posedge reset) begin
	if (reset) begin
		i = 0;
		states[0] = firstState;
		outReady = 0;
	end else if (i <= Nr-2) begin
		if (!outReady) begin
			inState = states[i];
			inRoundKey = RoundKeys[(i+1)*128 +: 128];
		end else begin
			states[i + 1] = outState;
			i = i+1;
		end
			outReady = !outReady;
	end else begin
		i=0;
		states[0] = firstState;
		outReady = 0;
	end
end

SubState Sf(SubBytesState, states[Nr-1]);
ShiftRows Rf(ShiftRowState, SubBytesState);
AddRoundKey Af(.outState(Ciphered), .inState(ShiftRowState), .RoundKey(RoundKeys[128*Nr +: 128]));

endmodule 