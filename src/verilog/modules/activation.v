module activation(in, clk, rst, en, out, ready);
	
	input clk, rst, en;
	input[15:0] in;
	output ready;
	output[15:0] out;

	wire[15:0] abs_in_inc;
	wire[15:0] div_out;
	assign abs_in_inc = {1'b0, in[14:0]} + 16'h1;

	nr_div div(.numerator({in[15],1'b0,in[13:0]}), .en(en),
			 .denominator(abs_in_inc), .clk(clk), .rst(rst), .ready(ready), .quotient(div_out));

	assign out = div_out + 16'h0080;

endmodule
