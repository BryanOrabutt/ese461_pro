`define CLK_PERIOD 10

module divide_tb();

	reg[15:0] num, den, clk_counter;
	reg clk, rst;

	wire ready;
	wire[15:0] out;

	nr_div d(.numerator(num), .denominator(den), .clk(clk), .rst(rst), .ready(ready), .quotient(out));

	initial begin
		$dumpfile("./vcd/divide.vcd");
		$dumpvars(0, divide_tb);
		clk = 0;
		rst = 1;
		clk_counter = 0;
		num = 16'h0180;
		den = 16'h8080;
		#(1.5*`CLK_PERIOD)
		rst = 0;		
	end

	always #(`CLK_PERIOD) clk <= ~clk;

	always@(posedge clk) clk_counter <= clk_counter + 16'h1;

	initial #(68*`CLK_PERIOD) $finish;

endmodule
