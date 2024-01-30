module AESDecryptionSlave #(parameter Nk = 4, Nr = 10)
(output miso, input cs, input mosi, input clk, input reset);

reg [8:0] i;
reg [8:0] j;
reg transmitReady;
reg[0:32*Nk-1] data;
wire [0:128*(Nr+1)-1] RoundKeys;
reg [0:32*Nk-1] Key;
reg [0:127] Text;
wire [0:127] DecryptedText;
reg [0:127] EncryptedText;
reg tempmiso;

always @ (posedge clk) begin
	if (reset) begin
		i=0;
		transmitReady = 0;
	end else if (!cs) begin
		if (i <= 32*Nk-1) begin
			data[i] = mosi;
			i=i+1;
			if (i == 32*Nk) begin
				EncryptedText = data[0:127];
				$display("recieved Text = %h",data);
			end
		end else if (i>=32*Nk && i <32*Nk + 128) begin
			data[i-32*Nk] = mosi;
			i=i+1;
			if (i==32*Nk + 128) begin
				$display("recieved Key = %h",data);
				Key = data;
			end
		end else if(i>=32*Nk + 128 && i< 32*Nk + 182) begin
			i=i+1;
			if (i == 32*Nk + 182) begin
				transmitReady = 1;
				data[0:127] = DecryptedText;
				$display("Decrypted Message = %h",data);
			end
		end
	end else begin
		i=0;
		transmitReady = 0;
	end
end

always @ (negedge clk) begin
	if (reset) begin
		j=0;
	end
	if (transmitReady && j<128 && !cs) begin
		tempmiso = data[j];
		j=j+1;
	end else begin
		j=0;
	end
end

assign miso = tempmiso;

KeyExpansion #(Nk,Nr) K (.RoundKeys(RoundKeys), .Key(Key));
InvCipher #(Nr) C (.Unciphered(DecryptedText), .Text(EncryptedText), .RoundKeys(RoundKeys), .clk(clk), .reset(reset));

endmodule 