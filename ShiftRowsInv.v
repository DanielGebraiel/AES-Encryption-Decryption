module ShiftRowsInv(output [0:127] outState, input [0:127] inState );

assign outState[0:31] = {inState[0:7], inState[104:111], inState[80:87], inState[56:63]};		//1st Column
assign outState[32:63] = {inState[32:39], inState[8:15], inState[112:119], inState[88:95]};	//2nd column
assign outState[64:95] = {inState[64:71], inState[40:47], inState[16:23], inState[120:127]};	//3rd column
assign outState[96:127] = {inState[96:103], inState[72:79], inState[48:55], inState[24:31]};	//4th column

endmodule 