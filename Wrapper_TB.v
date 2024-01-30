module Wrapper_TB();
wire led1;
wire led2;
reg clk;
reg reset;

Wrapper_256 W(.led1(led1),.led2(led2),.clk(clk),.reset(reset));

always begin
#2 clk = ~clk;
end

initial begin
	clk=0;
	reset=1;
	#50
	reset=0;
	#4800
	$finish;
end
endmodule