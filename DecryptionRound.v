module DecryptionRound(output [0:127] outState, input [0:127] inState, input [0:127] roundKey);

wire [0:127] InvSubBytesState;
wire [0:127] InvShiftRowState;
wire [0:127] InvAddRoundKeyState;

ShiftRowsInv Ri(InvShiftRowState, inState);
InvSubState Si(InvSubBytesState, InvShiftRowState);
AddRoundKey Ai(InvAddRoundKeyState, InvSubBytesState, roundKey);
MixColumnsInv Ci(outState, InvAddRoundKeyState);

	
endmodule 