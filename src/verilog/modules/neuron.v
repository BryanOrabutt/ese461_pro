module neuron(in, weight, clk, start, rst, ready, out);

	parameter counter_size = $clog2(128);

	input[15:0] in, weight;
	input clk, rst, start;
	output ready;
	output reg[15:0] out;
	wire[15:0] sum, mult_out;
	reg[counter_size-1:0] counter;
	reg[6:0] counter2;
	wire[15:0] act_out;
	reg[15:0] psum;
	reg en;	

	wire act_start;

	mult m(.clk(clk), .rst(rst), .A(weight), .B(in), .start_mac(start), .out(mult_out));
	adder16 a(mult_out, psum, sum);
	activation act(.in(psum), .clk(clk), .en(en), .ready(ready), .rst(rst), .out(act_out));
	
	always@(posedge clk or rst) begin

		if(rst) begin
			counter <= 0;
			out <= 0;
			psum <= 0;
			en <= 0;
			counter2 <= 0;
		end
		else if(start) begin
			counter <= counter + 1;
			psum <= sum;
			if(counter == counter_size-1) begin
				counter <= 0;
				en <= 1;
				counter2 <= counter2 + 1;
			end
		end
		if(ready) begin
			out <= act_out;
		end
		if(counter2 == 127) begin
			en <= 0;
		end

	end

endmodule

module adder16(a, b, out);

	input[15:0] a, b;
	output[15:0] out;
	wire sign;
	assign sign = a[15] ^ b[15];

	assign out = {sign, a[14:0] + b[14:0]};

endmodule

