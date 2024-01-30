module InvSubState(output [0:127] out, input [0:127] in);

InvSubBytes S1(out[0:7],in [0:7]);
InvSubBytes S2(out[8:15],in [8:15]);
InvSubBytes S3(out[16:23],in [16:23]);
InvSubBytes S4(out[24:31],in [24:31]);
InvSubBytes S5(out[32:39],in [32:39]);
InvSubBytes S6(out[40:47],in [40:47]);
InvSubBytes S7(out[48:55],in [48:55]);
InvSubBytes S8(out[56:63],in [56:63]);
InvSubBytes S9(out[64:71],in [64:71]);
InvSubBytes S10(out[72:79],in [72:79]);
InvSubBytes S11(out[80:87],in [80:87]);
InvSubBytes S12(out[88:95],in [88:95]);
InvSubBytes S13(out[96:103],in [96:103]);
InvSubBytes S14(out[104:111],in [104:111]);
InvSubBytes S15(out[112:119],in [112:119]);
InvSubBytes S16(out[120:127],in [120:127]);

endmodule 