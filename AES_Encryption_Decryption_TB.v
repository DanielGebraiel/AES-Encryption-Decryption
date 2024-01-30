module AES_Encryption_Decryption_TB();

reg [0:127] Text128;

wire [0:127] EncryptedText128;

wire [0:127] DecryptedText128;

reg [0:127] Key128Bits;

reg [7:0] SuccessCounter;
reg [7:0] FailureCounter;

reg clk;
reg reset;

AESEncryption #(.Nk(4), .Nr(10)) Encryption128Bits (.EncryptedText(EncryptedText128), .Text(Text128), .Key(Key128Bits), .clk(clk), .reset(reset));

AESDecryption #(.Nk(4), .Nr(10)) Decryption128Bits (.DecryptedText(DecryptedText128), .EncryptedText(EncryptedText128), .Key(Key128Bits), .clk(clk), .reset(reset));

always begin
#10 clk = ~clk;
end

initial begin
SuccessCounter = 0;
FailureCounter = 0;

Text128 = 128'h00112233445566778899aabbccddeeff;
Key128Bits = 128'h000102030405060708090a0b0c0d0e0f;
clk = 0;
reset = 1;
#10
reset = 0;
#1120
if (EncryptedText128 == 128'h69c4e0d86a7b0430d8cdb78070b4c55a && DecryptedText128 == Text128) begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("First Testcase of 128 bits is correct!");
	$display("Input Text = %h", Text128);
	$display("Encrypted Text = %h", EncryptedText128);
	$display("DecryptedText = %h", DecryptedText128);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	SuccessCounter = SuccessCounter + 1;
end else begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("First Testcase of 128 bits is Incorrect!");
	$display("Input Text = %h", Text128);
	$display("Encrypted Text = %h", EncryptedText128);
	$display("DecryptedText = %h", DecryptedText128);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	FailureCounter = FailureCounter + 1;
end

Text128 = 128'h3243F6A8885A308D313198A2E0370734;
Key128Bits = 128'h2B7E151628AED2A6ABF7158809CF4F3C;
#1300
if (EncryptedText128 == 128'h3925841D02DC09FBDC118597196A0B32 && DecryptedText128 == Text128) begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Second Testcase of 128 bits is correct!");
	$display("Input Text = %h", Text128);
	$display("Encrypted Text = %h", EncryptedText128);
	$display("DecryptedText = %h", DecryptedText128);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	SuccessCounter = SuccessCounter + 1;
end else begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Second Testcase of 128 bits is Incorrect!");
	$display("Input Text = %h", Text128);
	$display("Encrypted Text = %h", EncryptedText128);
	$display("DecryptedText = %h", DecryptedText128);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	FailureCounter = FailureCounter + 1;
end
Text128 = 128'h6BC1BEE22E409F96E93D7E117393172A;
Key128Bits = 128'h2B7E151628AED2A6ABF7158809CF4F3C;
#1500
if (EncryptedText128 == 128'h3AD77BB40D7A3660A89ECAF32466EF97 && DecryptedText128 == Text128) begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Third Testcase of 128 bits is correct!");
	$display("Input Text = %h", Text128);
	$display("Encrypted Text = %h", EncryptedText128);
	$display("DecryptedText = %h", DecryptedText128);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	SuccessCounter = SuccessCounter + 1;
end else begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Third Testcase of 128 bits is Incorrect!");
	$display("Input Text = %h", Text128);
	$display("Encrypted Text = %h", EncryptedText128);
	$display("DecryptedText = %h", DecryptedText128);
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