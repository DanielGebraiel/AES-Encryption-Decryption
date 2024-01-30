module InvCipher #(parameter Nr = 10)
(output [0:127] Unciphered, input [0:127] Text, input [0:128*(Nr+1)-1] RoundKeys, input clk, input reset);

reg [0:127] states [Nr:0];
wire [0:127] firstState;
wire [0:127] InvSubBytesState;
wire [0:127] InvShiftRowState;
wire [0:127] InvMixColumnState;
wire [0:127] outState;
reg [0:127] inState;
reg [0:127] inRoundKey;
reg [0:127] previousInput;
reg [0:3] i;
reg outReady;

AddRoundKey A0(.outState(firstState), .inState(Text), .RoundKey(RoundKeys[128*Nr +: 128]));
DecryptionRound Dr (outState, inState, inRoundKey);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		i=Nr-1;
		states[Nr] = firstState;
		outReady = 0;
	end else if (i>0) begin
		if (!outReady) begin
			inState = states[i+1];
			inRoundKey = RoundKeys[(i)*128 +:128];
		end else begin
			states[i] = outState;
			i = i - 1;
		end
			outReady = !outReady;
	end else begin
		i=Nr-1;
		states[Nr] = firstState;
		outReady = 0;
	end
end

ShiftRowsInv Rf(InvShiftRowState, states[1]);
InvSubState Sf(InvSubBytesState, InvShiftRowState);
AddRoundKey Af(.outState(Unciphered), .inState(InvSubBytesState), .RoundKey(RoundKeys[0:127]));

endmodule 