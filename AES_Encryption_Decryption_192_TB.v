module AES_Encryption_Decryption_192_TB();

reg [0:127] Text192;

wire [0:127] EncryptedText192;

wire [0:127] DecryptedText192;

reg [0:191] Key192Bits;

reg [7:0] SuccessCounter;
reg [7:0] FailureCounter;

reg clk;
reg reset;

AESEncryption #(.Nk(6), .Nr(12)) Encryption192Bits (.EncryptedText(EncryptedText192), .Text(Text192), .Key(Key192Bits), .clk(clk), .reset(reset));

AESDecryption #(.Nk(6), .Nr(12)) Decryption192Bits (.DecryptedText(DecryptedText192), .EncryptedText(EncryptedText192), .Key(Key192Bits), .clk(clk), .reset(reset));

always begin
#10 clk = ~clk;
end

initial begin
SuccessCounter = 0;
FailureCounter = 0;

Text192 = 128'h00112233445566778899aabbccddeeff;
Key192Bits = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
clk = 0;
reset = 1;
#10
reset = 0;
#1500
if (EncryptedText192 == 192'hdda97ca4864cdfe06eaf70a0ec0d7191 && DecryptedText192 == Text192) begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("First Testcase of 192 bits is correct!");
	$display("Input Text = %h", Text192);
	$display("Encrypted Text = %h", EncryptedText192);
	$display("DecryptedText = %h", DecryptedText192);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	SuccessCounter = SuccessCounter + 1;
end else begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("First Testcase of 192 bits is Incorrect!");
	$display("Input Text = %h", Text192);
	$display("Encrypted Text = %h", EncryptedText192);
	$display("DecryptedText = %h", DecryptedText192);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	FailureCounter = FailureCounter + 1;
end

Text192 = 192'h1234567890ABCDEF0123456789ABCDEF;
Key192Bits = 192'hA1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D60708090A0B0C0D0E;
#1700
if (EncryptedText192 == 192'h9b6ddbe459b77e1084ed48df8a89d9c7 && DecryptedText192 == Text192) begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Second Testcase of 192 bits is correct!");
	$display("Input Text = %h", Text192);
	$display("Encrypted Text = %h", EncryptedText192);
	$display("DecryptedText = %h", DecryptedText192);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	SuccessCounter = SuccessCounter + 1;
end else begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Second Testcase of 192 bits is Incorrect!");
	$display("Input Text = %h", Text192);
	$display("Encrypted Text = %h", EncryptedText192);
	$display("DecryptedText = %h", DecryptedText192);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	FailureCounter = FailureCounter + 1;
end
Text192 = 192'h00000000000000000000000000000000;
Key192Bits = 192'hFEDCBA9876543210FEDCBA9876543210FEDCBA987654321;
#2000
if (EncryptedText192 == 192'h401274ba322be5cc93bcd449154dd97c && DecryptedText192 == Text192) begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Third Testcase of 192 bits is correct!");
	$display("Input Text = %h", Text192);
	$display("Encrypted Text = %h", EncryptedText192);
	$display("DecryptedText = %h", DecryptedText192);
	$display("////////////////////////////////////////////////////////////////////////////////////");
	SuccessCounter = SuccessCounter + 1;
end else begin
	$display("////////////////////////////////////////////////////////////////////////////////////");
	$display("Third Testcase of 192 bits is Incorrect!");
	$display("Input Text = %h", Text192);
	$display("Encrypted Text = %h", EncryptedText192);
	$display("DecryptedText = %h", DecryptedText192);
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