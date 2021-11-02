`define CLK_PERIOD 1

module network_tb();
	
	reg clk, rst;
	reg[31:0] clk_counter;
	reg[15:0] in, wih, who;
	wire[16:0] addr_in, addr_wih, addr_who;
	wire[15:0] out0;
	wire[15:0] out1;
	wire[15:0] out2;
	wire[15:0] out3;
	wire[15:0] out4;
	wire[15:0] out5;
	wire[15:0] out6;
	wire[15:0] out7;
	wire[15:0] out8;
	wire[15:0] out9;

	network_top nn(.clk(clk), .rst(rst), .in(in), .wih(wih), .who(who), .addr_in(addr_in), .addr_ho(addr_who), .addr_ih(addr_wih), 
					.out0(out0),.out1(out1),.out2(out2),.out3(out3),.out4(out4),.out5(out5),.out6(out6),.out7(out7),.out8(out8),.out9(out9));
//ReadOnlyMemory_I romi(.address(addr_in), .data_out(in));
//ReadOnlyMemory_WIH romih(.address(addr_wih), .data_out(wih));
//ReadOnlyMemory_WHO romho(.address(addr_who), .data_out(who));



initial begin
	forever #(`CLK_PERIOD) clk <= ~clk;

end

always@(posedge clk) clk_counter <= clk_counter + 32'h1;

always@(addr_in) begin
	in <= in+1;
end

always@(addr_who)begin
	who <= who + 1;
end	

always@(addr_wih)begin
	wih <= wih + 1;
end

initial begin

	$dumpfile("./vcd/network.vcd");
	$dumpvars(0, network_tb);

	clk = 0;
	rst = 1;
	clk_counter = 0;
	wih = 0;
	who = 0;
	in = 0;

	#(`CLK_PERIOD*1.5)
	rst = 0;

	#(223500*`CLK_PERIOD)
	$finish;

end


endmodule
