
module KeyExpansion
#(parameter Nk = 4, Nr = 10)
(output [0:128*(Nr+1)-1] RoundKeys , input [0:32*Nk-1] Key);

reg [0:128*(Nr+1)-1] tempRoundKeys;
reg [31:0] temp;
reg [7:0] Rcon;

integer i;

always @(*) begin

	Rcon = 8'd1;
	for (i=0; i<Nk; i=i+1) begin
		tempRoundKeys[32*i+:32] = Key[32*i+:32];
	end
	
	for (i=Nk; i<4*(Nr+1); i=i+1) begin
		temp = tempRoundKeys[32*(i-1)+:32];
		if (i % Nk == 0) begin
			temp = SubWord(RotWord(temp)) ^ {Rcon, 24'd0};
			Rcon = Mult2(Rcon);
		end
		else if(Nk > 6 && i % Nk == 4) begin
			temp = SubWord(temp);
		end
		tempRoundKeys[32*i+:32] = (tempRoundKeys[(32*(i-Nk))+:32])^temp;
	end
end


assign RoundKeys = tempRoundKeys;

function [7:0] Mult2 (input [7:0] a);
begin
	Mult2 = {a[6:0],1'b0};
	Mult2 = (a[7] == 1)? Mult2^8'h1b: Mult2;
end
endfunction

function [31:0] SubWord(input [31:0] in);
begin
SubWord[7:0] = SubBytes(in[7:0]);
SubWord[15:8] = SubBytes(in[15:8]);
SubWord[23:16] = SubBytes(in[23:16]);
SubWord[31:24] = SubBytes(in[31:24]);
end
endfunction 

function [31:0] RotWord(input [31:0] in);
begin
RotWord[7:0] = in [31:24];
RotWord[15:8] = in [7:0];
RotWord[23:16] = in [15:8];
RotWord[31:24] = in [23:16];
end
endfunction

function [7:0] SubBytes(input [7:0] in);
begin
case (in)
      8'h00: SubBytes=8'h63;
	   8'h01: SubBytes=8'h7c;
	   8'h02: SubBytes=8'h77;
	   8'h03: SubBytes=8'h7b;
	   8'h04: SubBytes=8'hf2;
	   8'h05: SubBytes=8'h6b;
	   8'h06: SubBytes=8'h6f;
	   8'h07: SubBytes=8'hc5;
	   8'h08: SubBytes=8'h30;
	   8'h09: SubBytes=8'h01;
	   8'h0a: SubBytes=8'h67;
	   8'h0b: SubBytes=8'h2b;
	   8'h0c: SubBytes=8'hfe;
	   8'h0d: SubBytes=8'hd7;
	   8'h0e: SubBytes=8'hab;
	   8'h0f: SubBytes=8'h76;
	   8'h10: SubBytes=8'hca;
	   8'h11: SubBytes=8'h82;
	   8'h12: SubBytes=8'hc9;
	   8'h13: SubBytes=8'h7d;
	   8'h14: SubBytes=8'hfa;
	   8'h15: SubBytes=8'h59;
	   8'h16: SubBytes=8'h47;
	   8'h17: SubBytes=8'hf0;
	   8'h18: SubBytes=8'had;
	   8'h19: SubBytes=8'hd4;
	   8'h1a: SubBytes=8'ha2;
	   8'h1b: SubBytes=8'haf;
	   8'h1c: SubBytes=8'h9c;
	   8'h1d: SubBytes=8'ha4;
	   8'h1e: SubBytes=8'h72;
	   8'h1f: SubBytes=8'hc0;
	   8'h20: SubBytes=8'hb7;
	   8'h21: SubBytes=8'hfd;
	   8'h22: SubBytes=8'h93;
	   8'h23: SubBytes=8'h26;
	   8'h24: SubBytes=8'h36;
	   8'h25: SubBytes=8'h3f;
	   8'h26: SubBytes=8'hf7;
	   8'h27: SubBytes=8'hcc;
	   8'h28: SubBytes=8'h34;
	   8'h29: SubBytes=8'ha5;
	   8'h2a: SubBytes=8'he5;
	   8'h2b: SubBytes=8'hf1;
	   8'h2c: SubBytes=8'h71;
	   8'h2d: SubBytes=8'hd8;
	   8'h2e: SubBytes=8'h31;
	   8'h2f: SubBytes=8'h15;
	   8'h30: SubBytes=8'h04;
	   8'h31: SubBytes=8'hc7;
	   8'h32: SubBytes=8'h23;
	   8'h33: SubBytes=8'hc3;
	   8'h34: SubBytes=8'h18;
	   8'h35: SubBytes=8'h96;
	   8'h36: SubBytes=8'h05;
	   8'h37: SubBytes=8'h9a;
	   8'h38: SubBytes=8'h07;
	   8'h39: SubBytes=8'h12;
	   8'h3a: SubBytes=8'h80;
	   8'h3b: SubBytes=8'he2;
	   8'h3c: SubBytes=8'heb;
	   8'h3d: SubBytes=8'h27;
	   8'h3e: SubBytes=8'hb2;
	   8'h3f: SubBytes=8'h75;
	   8'h40: SubBytes=8'h09;
	   8'h41: SubBytes=8'h83;
	   8'h42: SubBytes=8'h2c;
	   8'h43: SubBytes=8'h1a;
	   8'h44: SubBytes=8'h1b;
	   8'h45: SubBytes=8'h6e;
	   8'h46: SubBytes=8'h5a;
	   8'h47: SubBytes=8'ha0;
	   8'h48: SubBytes=8'h52;
	   8'h49: SubBytes=8'h3b;
	   8'h4a: SubBytes=8'hd6;
	   8'h4b: SubBytes=8'hb3;
	   8'h4c: SubBytes=8'h29;
	   8'h4d: SubBytes=8'he3;
	   8'h4e: SubBytes=8'h2f;
	   8'h4f: SubBytes=8'h84;
	   8'h50: SubBytes=8'h53;
	   8'h51: SubBytes=8'hd1;
	   8'h52: SubBytes=8'h00;
	   8'h53: SubBytes=8'hed;
	   8'h54: SubBytes=8'h20;
	   8'h55: SubBytes=8'hfc;
	   8'h56: SubBytes=8'hb1;
	   8'h57: SubBytes=8'h5b;
	   8'h58: SubBytes=8'h6a;
	   8'h59: SubBytes=8'hcb;
	   8'h5a: SubBytes=8'hbe;
	   8'h5b: SubBytes=8'h39;
	   8'h5c: SubBytes=8'h4a;
	   8'h5d: SubBytes=8'h4c;
	   8'h5e: SubBytes=8'h58;
	   8'h5f: SubBytes=8'hcf;
	   8'h60: SubBytes=8'hd0;
	   8'h61: SubBytes=8'hef;
	   8'h62: SubBytes=8'haa;
	   8'h63: SubBytes=8'hfb;
	   8'h64: SubBytes=8'h43;
	   8'h65: SubBytes=8'h4d;
	   8'h66: SubBytes=8'h33;
	   8'h67: SubBytes=8'h85;
	   8'h68: SubBytes=8'h45;
	   8'h69: SubBytes=8'hf9;
	   8'h6a: SubBytes=8'h02;
	   8'h6b: SubBytes=8'h7f;
	   8'h6c: SubBytes=8'h50;
	   8'h6d: SubBytes=8'h3c;
	   8'h6e: SubBytes=8'h9f;
	   8'h6f: SubBytes=8'ha8;
	   8'h70: SubBytes=8'h51;
	   8'h71: SubBytes=8'ha3;
	   8'h72: SubBytes=8'h40;
	   8'h73: SubBytes=8'h8f;
	   8'h74: SubBytes=8'h92;
	   8'h75: SubBytes=8'h9d;
	   8'h76: SubBytes=8'h38;
	   8'h77: SubBytes=8'hf5;
	   8'h78: SubBytes=8'hbc;
	   8'h79: SubBytes=8'hb6;
	   8'h7a: SubBytes=8'hda;
	   8'h7b: SubBytes=8'h21;
	   8'h7c: SubBytes=8'h10;
	   8'h7d: SubBytes=8'hff;
	   8'h7e: SubBytes=8'hf3;
	   8'h7f: SubBytes=8'hd2;
	   8'h80: SubBytes=8'hcd;
	   8'h81: SubBytes=8'h0c;
	   8'h82: SubBytes=8'h13;
	   8'h83: SubBytes=8'hec;
	   8'h84: SubBytes=8'h5f;
	   8'h85: SubBytes=8'h97;
	   8'h86: SubBytes=8'h44;
	   8'h87: SubBytes=8'h17;
	   8'h88: SubBytes=8'hc4;
	   8'h89: SubBytes=8'ha7;
	   8'h8a: SubBytes=8'h7e;
	   8'h8b: SubBytes=8'h3d;
	   8'h8c: SubBytes=8'h64;
	   8'h8d: SubBytes=8'h5d;
	   8'h8e: SubBytes=8'h19;
	   8'h8f: SubBytes=8'h73;
	   8'h90: SubBytes=8'h60;
	   8'h91: SubBytes=8'h81;
	   8'h92: SubBytes=8'h4f;
	   8'h93: SubBytes=8'hdc;
	   8'h94: SubBytes=8'h22;
	   8'h95: SubBytes=8'h2a;
	   8'h96: SubBytes=8'h90;
	   8'h97: SubBytes=8'h88;
	   8'h98: SubBytes=8'h46;
	   8'h99: SubBytes=8'hee;
	   8'h9a: SubBytes=8'hb8;
	   8'h9b: SubBytes=8'h14;
	   8'h9c: SubBytes=8'hde;
	   8'h9d: SubBytes=8'h5e;
	   8'h9e: SubBytes=8'h0b;
	   8'h9f: SubBytes=8'hdb;
	   8'ha0: SubBytes=8'he0;
	   8'ha1: SubBytes=8'h32;
	   8'ha2: SubBytes=8'h3a;
	   8'ha3: SubBytes=8'h0a;
	   8'ha4: SubBytes=8'h49;
	   8'ha5: SubBytes=8'h06;
	   8'ha6: SubBytes=8'h24;
	   8'ha7: SubBytes=8'h5c;
	   8'ha8: SubBytes=8'hc2;
	   8'ha9: SubBytes=8'hd3;
	   8'haa: SubBytes=8'hac;
	   8'hab: SubBytes=8'h62;
	   8'hac: SubBytes=8'h91;
	   8'had: SubBytes=8'h95;
	   8'hae: SubBytes=8'he4;
	   8'haf: SubBytes=8'h79;
	   8'hb0: SubBytes=8'he7;
	   8'hb1: SubBytes=8'hc8;
	   8'hb2: SubBytes=8'h37;
	   8'hb3: SubBytes=8'h6d;
	   8'hb4: SubBytes=8'h8d;
	   8'hb5: SubBytes=8'hd5;
	   8'hb6: SubBytes=8'h4e;
	   8'hb7: SubBytes=8'ha9;
	   8'hb8: SubBytes=8'h6c;
	   8'hb9: SubBytes=8'h56;
	   8'hba: SubBytes=8'hf4;
	   8'hbb: SubBytes=8'hea;
	   8'hbc: SubBytes=8'h65;
	   8'hbd: SubBytes=8'h7a;
	   8'hbe: SubBytes=8'hae;
	   8'hbf: SubBytes=8'h08;
	   8'hc0: SubBytes=8'hba;
	   8'hc1: SubBytes=8'h78;
	   8'hc2: SubBytes=8'h25;
	   8'hc3: SubBytes=8'h2e;
	   8'hc4: SubBytes=8'h1c;
	   8'hc5: SubBytes=8'ha6;
	   8'hc6: SubBytes=8'hb4;
	   8'hc7: SubBytes=8'hc6;
	   8'hc8: SubBytes=8'he8;
	   8'hc9: SubBytes=8'hdd;
	   8'hca: SubBytes=8'h74;
	   8'hcb: SubBytes=8'h1f;
	   8'hcc: SubBytes=8'h4b;
	   8'hcd: SubBytes=8'hbd;
	   8'hce: SubBytes=8'h8b;
	   8'hcf: SubBytes=8'h8a;
	   8'hd0: SubBytes=8'h70;
	   8'hd1: SubBytes=8'h3e;
	   8'hd2: SubBytes=8'hb5;
	   8'hd3: SubBytes=8'h66;
	   8'hd4: SubBytes=8'h48;
	   8'hd5: SubBytes=8'h03;
	   8'hd6: SubBytes=8'hf6;
	   8'hd7: SubBytes=8'h0e;
	   8'hd8: SubBytes=8'h61;
	   8'hd9: SubBytes=8'h35;
	   8'hda: SubBytes=8'h57;
	   8'hdb: SubBytes=8'hb9;
	   8'hdc: SubBytes=8'h86;
	   8'hdd: SubBytes=8'hc1;
	   8'hde: SubBytes=8'h1d;
	   8'hdf: SubBytes=8'h9e;
	   8'he0: SubBytes=8'he1;
	   8'he1: SubBytes=8'hf8;
	   8'he2: SubBytes=8'h98;
	   8'he3: SubBytes=8'h11;
	   8'he4: SubBytes=8'h69;
	   8'he5: SubBytes=8'hd9;
	   8'he6: SubBytes=8'h8e;
	   8'he7: SubBytes=8'h94;
	   8'he8: SubBytes=8'h9b;
	   8'he9: SubBytes=8'h1e;
	   8'hea: SubBytes=8'h87;
	   8'heb: SubBytes=8'he9;
	   8'hec: SubBytes=8'hce;
	   8'hed: SubBytes=8'h55;
	   8'hee: SubBytes=8'h28;
	   8'hef: SubBytes=8'hdf;
	   8'hf0: SubBytes=8'h8c;
	   8'hf1: SubBytes=8'ha1;
	   8'hf2: SubBytes=8'h89;
	   8'hf3: SubBytes=8'h0d;
	   8'hf4: SubBytes=8'hbf;
	   8'hf5: SubBytes=8'he6;
	   8'hf6: SubBytes=8'h42;
	   8'hf7: SubBytes=8'h68;
	   8'hf8: SubBytes=8'h41;
	   8'hf9: SubBytes=8'h99;
	   8'hfa: SubBytes=8'h2d;
	   8'hfb: SubBytes=8'h0f;
	   8'hfc: SubBytes=8'hb0;
	   8'hfd: SubBytes=8'h54;
	   8'hfe: SubBytes=8'hbb;
	   8'hff: SubBytes=8'h16;
	endcase
end
endfunction
endmodule 