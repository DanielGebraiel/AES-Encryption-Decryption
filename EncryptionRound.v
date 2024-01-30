module EncryptionRound(output [0:127] outState, input [0:127] inState, input [0:127] roundKey);

wire [0:127] SubBytesState;
wire [0:127] ShiftRowState;
wire [0:127] MixColumnState;

SubState Si(SubBytesState, inState);
ShiftRows Ri(ShiftRowState, SubBytesState);
MixColumns Ci(MixColumnState, ShiftRowState);
AddRoundKey Ai(outState, MixColumnState, roundKey);
	
endmodule 