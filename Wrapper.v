module Wrapper(output led1, output led2, input clk, input reset);

reg mosi;
wire miso;
wire miso1;
wire miso2;
reg cs1;
reg cs2;
integer i;
integer j;
reg [0:127] data;
reg [0:127] Text;
reg [0:127] Key;
reg [0:127] ExpectedText;
reg encryptCheck;
reg decryptCheck;
reg receive;
reg send;

AESEncryptionSlave #(4,10) Slave1 (.miso(miso1), .cs(cs1), .mosi(mosi), .clk(clk), .reset(reset));
AESDecryptionSlave #(4,10) Slave2 (.miso(miso2), .cs(cs2), .mosi(mosi), .clk(clk), .reset(reset));
assign miso=(cs1==0)?miso1:(cs2==0)?miso2:0;

initial begin
	
	Text = 128'h00112233445566778899aabbccddeeff;
	Key = 128'h000102030405060708090a0b0c0d0e0f;
	ExpectedText = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
	i=0;
	encryptCheck = 0;
	decryptCheck = 0;
end

always @ (negedge clk) begin
	cs1 = !cs2;
	if (reset) begin
		i=0;
		data = Key;
		send =1;
		cs1 = 0;
	end
	if (j == 32*4) begin
		if(!cs1) begin
			data = Text;
		end else if (!cs2) begin
			data = Key;
		end
	end else if (!cs1 && i<=127 && receive) begin
		data[i] = miso;
		i=i+1;
		send = 0;
		if (i == 128) begin
			send=1;
			cs1 = 1;
			i=0;
			if (data == ExpectedText) begin
				$display("correct = %h",data);
				encryptCheck = 1;
			end else begin
				encryptCheck=0;
			end
		end
	end else if (!cs2 && i<=127 && receive) begin
	$display("Here we go!");
		data[i] = miso;
		i=i+1;
		send = 0;
		if (i == 128) begin
			send=1;
			cs1 = 1;
			i=0;
			$display(data);
			if (data == Text) begin
				decryptCheck = 1;
			end else begin
				decryptCheck=0;
			end
		end
	end
end


always @ (posedge clk) begin
	cs2 = !cs1;
	if (reset) begin
		j=0;
		cs2 = 1;
	end if (!cs1 && send) begin
		if (j <= 127) begin
			receive=0;
			mosi = data[j];
			j=j+1;
		end else if (j>=32*4 && j <32*4 + 128) begin
			mosi = data[j-32*4];
			j=j+1;
		end else if(j>=32*4 + 128 && j< 32*4 + 184) begin
			j=j+1;
			if (j == 32*4 + 184) begin
				j=0;
				receive=1;
			end
		end
	end else if (!cs2 && send) begin
		if (j <= 127) begin
			receive=0;
			mosi = data[j];
			j=j+1;
			$display("%h",data);
		end else if (j>=32*4 && j <32*4 + 128) begin
			mosi = data[j-32*4];
			j=j+1;
			$display(j);
		end else if(j>=32*4 + 128 && j< 32*4 + 184) begin
			j=j+1;
			$display("what zis");
			if (j == 32*4 + 184) begin
				j=0;
				receive=1;
			end
		end
	end
end

assign led1 = encryptCheck;
assign led2 = decryptCheck;

endmodule
