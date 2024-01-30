module AddRoundKey(output [0:127] outState, input [0:127] inState, input [0:127] RoundKey);

assign outState[0:7] = inState[0:7] ^ RoundKey[0:7];
assign outState[8:15] = inState[8:15] ^ RoundKey[8:15];
assign outState[16:23] = inState[16:23] ^ RoundKey[16:23];
assign outState[24:31] = inState[24:31] ^ RoundKey[24:31];
assign outState[32:39] = inState[32:39] ^ RoundKey[32:39];
assign outState[40:47] = inState[40:47] ^ RoundKey[40:47];
assign outState[48:55] = inState[48:55] ^ RoundKey[48:55];
assign outState[56:63] = inState[56:63] ^ RoundKey[56:63];
assign outState[64:71] = inState[64:71] ^ RoundKey[64:71];
assign outState[72:79] = inState[72:79] ^ RoundKey[72:79];
assign outState[80:87] = inState[80:87] ^ RoundKey[80:87];
assign outState[88:95] = inState[88:95] ^ RoundKey[88:95];
assign outState[96:103] = inState[96:103] ^ RoundKey[96:103];
assign outState[104:111] = inState[104:111] ^ RoundKey[104:111];
assign outState[112:119] = inState[112:119] ^ RoundKey[112:119];
assign outState[120:127] = inState[120:127] ^ RoundKey[120:127];

endmodule 