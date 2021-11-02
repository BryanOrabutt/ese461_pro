
module nr_div(numerator, denominator, en, clk, rst, ready, quotient);

	input[15:0] numerator, denominator;
	input clk, rst, en;
	output[15:0] quotient;
	output ready;

	reg[29:0] a, m, q;
	reg[4:0] n;

	wire sign;
	assign sign = numerator[15] ^ denominator[15];
	
	assign quotient = {sign,q[14:0]};
	assign ready = (n == 0);

	always@(posedge clk or rst) begin
		if(rst) begin
			n = 5'h1e;
			a = 0;
			m = {15'h0,denominator[14:0]};
			q = {15'h0, numerator[14:0]};
			q = q << 8; 
		end
		else begin 
			if(en) begin
				if(n != 0) begin

					a = a << 1;
					a[0] = q[29];
					q = q << 1;

					if(a[29]) begin
						a = a+m;				
					end
					else begin
						a = a - m;
					end
					
					q[0] = (a[29]) ? 0:1;
					n = n-1;
				end
				else begin
					n = 4'he;
					if(a[29]) begin
						a = a + m;
					end
				end
			end
		end
	end
	
endmodule


