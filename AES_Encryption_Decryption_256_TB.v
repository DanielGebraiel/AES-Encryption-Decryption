module AES_Encryption_Decryption_256_TB();

reg [0:127] Text256;

wire [0:127] EncryptedText256;

wire [0:127] DecryptedText256;

reg [0:255] Key256Bits;

reg [7:0] SuccessCounter;
reg [7:0] FailureCounter;

reg clk;
reg reset;

AESEncryption #(.Nk(8), .Nr(14)) Encryption256Bits (.EncryptedText(EncryptedText256), .Text(Text256), .Key(Key256Bits), .clk(clk), .reset(reset));

AESDecryption #(.Nk(8), .Nr(14)) Decryption256Bits (.DecryptedText(DecryptedText256), .EncryptedText(EncryptedText256), .Key(Key256Bits), .clk(clk), .reset(reset));

always begin
#10 clk = ~clk;
end

initial begin
SuccessCounter = 0;
FailureCounter = 0;

Text256 = 128'h00112233445566778899aabbccddeeff;
Key256Bits = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
clk = 0;
reset = 1;
#10
reset = 0;
#1700
if (EncryptedText256 == 128'h8ea2b7ca516745bfeafc49904b496089 && DecryptedText256 == Text256) begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("First Testcase of 256 bits is correct!");
	$display("Input Text = %h", Text256);
	$display("Encrypted Text = %h", EncryptedText256);
	$display("DecryptedText = %h", DecryptedText256);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	SuccessCounter = SuccessCounter + 1;
end else begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("First Testcase of 256 bits is Incorrect!");
	$display("Input Text = %h", Text256);
	$display("Encrypted Text = %h", EncryptedText256);
	$display("DecryptedText = %h", DecryptedText256);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	FailureCounter = FailureCounter + 1;
end

Text256 = 128'h1234567890ABCDEF0123456789ABCDEF;
Key256Bits = 256'hA1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D60708090A0B0C0D0E0F10111213141516;
#1700
if (EncryptedText256 == 128'h1a457798d81ded2b7b079d51ac3b88d7 && DecryptedText256 == Text256) begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Second Testcase of 256 bits is correct!");
	$display("Input Text = %h", Text256);
	$display("Encrypted Text = %h", EncryptedText256);
	$display("DecryptedText = %h", DecryptedText256);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	SuccessCounter = SuccessCounter + 1;
end else begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Second Testcase of 256 bits is Incorrect!");
	$display("Input Text = %h", Text256);
	$display("Encrypted Text = %h", EncryptedText256);
	$display("DecryptedText = %h", DecryptedText256);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	FailureCounter = FailureCounter + 1;
end
Text256 = 128'h00000000000000000000000000000000;
Key256Bits = 256'h0000000000000000000000000000000000000000000000000000000000000000;
#2000
if (EncryptedText256 == 128'hdc95c078a2408989ad48a21492842087 && DecryptedText256 == Text256) begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Third Testcase of 256 bits is correct!");
	$display("Input Text = %h", Text256);
	$display("Encrypted Text = %h", EncryptedText256);
	$display("DecryptedText = %h", DecryptedText256);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	SuccessCounter = SuccessCounter + 1;
end else begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Third Testcase of 256 bits is Incorrect!");
	$display("Input Text = %h", Text256);
	$display("Encrypted Text = %h", EncryptedText256);
	$display("DecryptedText = %h", DecryptedText256);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	FailureCounter = FailureCounter + 1;
end
$display("////////////////////////////////////////////////////////////////////////////////////");
$display("Number of Successes = %d", SuccessCounter);
$display("Number of Failures = %d", FailureCounter);
$display("////////////////////////////////////////////////////////////////////////////////////");
$finish;
end

endmodule