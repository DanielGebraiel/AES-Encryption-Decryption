module GF_Mult(output [7:0] product, input [7:0] numIn, input [7:0] mixColNum);

reg [7:0] temp;
always @ (numIn or mixColNum) begin
	case (mixColNum)
	8'h01: temp = numIn;
	8'h02: temp = Mult2(numIn);
	8'h03: temp = Mult3(numIn);
	8'h0e: temp = MultE(numIn);
	8'h0b: temp = MultB(numIn);
	8'h0d: temp = MultD(numIn);
	endcase
end

assign product = temp;

//////////////////////////////////////////////////////////////////////////////

function [8:0] Mult2 (input [7:0] a);
begin
	Mult2 = {a[6:0],1'b0};
	Mult2 = (a[7] == 1)? Mult2^8'h1b: Mult2;
end
endfunction


function [8:0] Mult3 (input [7:0] a);
begin
	 Mult3 = Mult2(a) ^ a;
end
endfunction 

function [8:0] MultE (input [7:0] a);
begin
	 MultE = Mult2(a)^Mult2(a)^Mult2(a)^Mult2(a)^Mult2(a)^Mult2(a)^Mult2(a);
end
endfunction

function [8:0] MultB (input [7:0] a);
begin
	 MultB = Mult2(a)^Mult2(a)^Mult2(a)^Mult2(a)^Mult2(a)^a;
end
endfunction 

function [8:0] MultD (input [7:0] a);
begin
	 MultD = Mult2(a)^Mult2(a)^Mult2(a)^Mult2(a)^Mult2(a)^Mult2(a)^a;
end
endfunction  
endmodule