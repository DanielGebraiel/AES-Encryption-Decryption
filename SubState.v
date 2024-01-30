module SubState(output [0:127] out, input [0:127] in);

SubBytes S1(out[0:7],in [0:7]);
SubBytes S2(out[8:15],in [8:15]);
SubBytes S3(out[16:23],in [16:23]);
SubBytes S4(out[24:31],in [24:31]);
SubBytes S5(out[32:39],in [32:39]);
SubBytes S6(out[40:47],in [40:47]);
SubBytes S7(out[48:55],in [48:55]);
SubBytes S8(out[56:63],in [56:63]);
SubBytes S9(out[64:71],in [64:71]);
SubBytes S10(out[72:79],in [72:79]);
SubBytes S11(out[80:87],in [80:87]);
SubBytes S12(out[88:95],in [88:95]);
SubBytes S13(out[96:103],in [96:103]);
SubBytes S14(out[104:111],in [104:111]);
SubBytes S15(out[112:119],in [112:119]);
SubBytes S16(out[120:127],in [120:127]);

endmodule 