module MixColumns(output [0:127] outState, input [0:127] inState);

integer i;
reg [0:127] tempstate;
reg[7:0] mul02,mul03,mul12,mul13,mul22,mul23,mul32,mul33;

always @(inState) begin

	for (i=0;i<=96;i=i+32) begin
		mul02 = Mult2 (inState[0+i+:8]);
		mul03 = Mult3 (inState[0+i+:8]);
		mul12 = Mult2 (inState[8+i+:8]);
		mul13 = Mult3 (inState[8+i+:8]);
		mul22 = Mult2 (inState[16+i+:8]);
		mul23 = Mult3 (inState[16+i+:8]);
		mul32 = Mult2 (inState[24+i+:8]);
		mul33 = Mult3 (inState[24+i+:8]);

		tempstate[0+i+:8] = mul02 ^ mul13 ^ inState[16+i+:8] ^ inState[24+i+:8];
		tempstate[8+i+:8] = inState[0+i+:8] ^ mul12 ^ mul23 ^ inState[24+i+:8];
		tempstate[16+i+:8] = inState[0+i+:8] ^ inState[8+i+:8] ^ mul22 ^ mul33;
		tempstate[24+i+:8] = mul03 ^ inState[8+i+:8] ^ inState[16+i+:8] ^ mul32;
	end
	
end
assign outState = tempstate;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

function [7:0] Mult2 (input [7:0] a);
begin
	Mult2 = {a[6:0],1'b0};
	Mult2 = (a[7] == 1)? Mult2^8'h1b: Mult2;
end
endfunction


function [7:0] Mult3 (input [7:0] a);
begin
	 Mult3 = Mult2(a) ^ a;
end
endfunction 
 
endmodule
 


