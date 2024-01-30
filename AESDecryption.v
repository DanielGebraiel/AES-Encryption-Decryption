module AESDecryption #(parameter Nk = 4, Nr = 10)
(output [0:127] DecryptedText, input [0:127] EncryptedText, input [0:32*Nk-1] Key, input clk, input reset);

wire [0:128*(Nr+1)-1] RoundKeys;

KeyExpansion #(Nk,Nr) K (.RoundKeys(RoundKeys), .Key(Key));
InvCipher #(Nr) C (.Unciphered(DecryptedText), .Text(EncryptedText), .RoundKeys(RoundKeys), .clk(clk), .reset(reset));

endmodule 