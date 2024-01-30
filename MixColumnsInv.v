module MixColumnsInv(output [0:127] outState, input [0:127] inState);

integer i;
reg [0:127] tempstate;
reg[0:7] mul0e,mul0b,mul0d,mul09,mul1e,mul1b,mul1d,mul19,mul2e,mul2b,mul2d,mul29,mul3e,mul3b,mul3d,mul39;

always @(inState) begin

	for (i=0;i<=96;i=i+32) begin
		mul0e = MultE (inState[0+i+:8]);
		mul0b = MultB (inState[0+i+:8]);
		mul0d = MultD (inState[0+i+:8]);
		mul09 = Mult9 (inState[0+i+:8]);
		
		mul1e = MultE (inState[8+i+:8]);
		mul1b = MultB (inState[8+i+:8]);
		mul1d = MultD (inState[8+i+:8]);
		mul19 = Mult9 (inState[8+i+:8]);
		
		mul2e = MultE (inState[16+i+:8]);
		mul2b = MultB (inState[16+i+:8]);
		mul2d = MultD (inState[16+i+:8]);
		mul29 = Mult9 (inState[16+i+:8]);
		
		mul3e = MultE (inState[24+i+:8]);
		mul3b = MultB (inState[24+i+:8]);
		mul3d = MultD (inState[24+i+:8]);
		mul39 = Mult9 (inState[24+i+:8]);

		tempstate[0+i+:8] = mul0e ^ mul1b ^ mul2d ^ mul39;
		tempstate[8+i+:8] = mul09 ^ mul1e ^ mul2b ^ mul3d;
		tempstate[16+i+:8] = mul0d ^ mul19 ^ mul2e ^ mul3b;
		tempstate[24+i+:8] = mul0b ^ mul1d ^ mul29 ^ mul3e;
	end
	
end
assign outState = tempstate;

////////////////////////////////////////////////////////////////
function [7:0] Mult2 (input [7:0] a);
begin
	Mult2 = {a[6:0],1'b0};
	Mult2 = (a[7] == 1)? Mult2^8'h1b: Mult2;
end
endfunction

function [7:0] MultE (input [7:0] a);
begin
	 MultE = Mult2(Mult2(Mult2(a)))^Mult2(Mult2(a))^Mult2(a);
end
endfunction

function [7:0] MultB (input [7:0] a);
begin
	 MultB = Mult2(Mult2(Mult2(a)))^Mult2(a)^a;
end
endfunction 

function [7:0] MultD (input [7:0] a);
begin
	 MultD = Mult2(Mult2(Mult2(a)))^Mult2(Mult2(a))^a;
end
endfunction 

function [7:0] Mult9 (input [7:0] a);
begin
	 Mult9 = Mult2(Mult2(Mult2(a)))^a;
end
endfunction 

endmodule 