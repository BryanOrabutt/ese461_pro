`define CLK_PERIOD 10

module activation_tb();

	reg[15:0] mac_out, clk_counter;
	reg clk, rst;

	wire[15:0] out;
	wire ready;

	activation act(.clk(clk), .rst(rst), .in(mac_out), .ready(ready), .out(out));

	initial begin
		$dumpfile("./vcd/activation.vcd");
		$dumpvars(0, activation_tb);
		clk = 0;
		rst = 1;
		clk_counter = 0;
		mac_out = 16'h0280;
		#(1.5*`CLK_PERIOD)
		rst = 0;		
	end

	always #(`CLK_PERIOD) clk <= ~clk;

	always@(posedge clk) clk_counter <= clk_counter + 16'h1;

	initial #(68*`CLK_PERIOD) $finish;

endmodule
