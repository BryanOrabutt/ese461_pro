module network_top(clk, rst, in, wih, who, addr_in, addr_ih, addr_ho, out0,out1,out2,out3,out4,out5,out6,out7,out8,out9);
	input clk, rst;
	input[15:0] in, wih, who;
	output[16:0] addr_in, addr_ih, addr_ho;

	wire[127:0] ready_ih, start_ih;
	wire[9:0] ready_ho, start_ho;
	output[15:0] out0;
	output[15:0] out1;
	output[15:0] out2;
	output[15:0] out3;
	output[15:0] out4;
	output[15:0] out5;
	output[15:0] out6;
	output[15:0] out7;
	output[15:0] out8;
	output[15:0] out9;
	reg[31:0] cycle_counter;
	reg[3:0] who_counter;
	reg who_clk;
	reg[15:0] layer2_in;
	reg[6:0] ihptr;

	assign out0 = olayer[0].nout;
	assign out1 = olayer[1].nout;
	assign out2 = olayer[2].nout;
	assign out3 = olayer[3].nout;
	assign out4 = olayer[4].nout;
	assign out5 = olayer[5].nout;
	assign out6 = olayer[6].nout;
	assign out7 = olayer[7].nout;
	assign out8 = olayer[8].nout;
	assign out9 = olayer[9].nout;


	genvar j;

	//layer1
	generate
		for(j = 0; j < 128; j = j + 1) begin:layer1
			wire[15:0] nout;
			neuron #(.counter_size($clog2(784*128))) n(.in(in), .weight(bank_ih[j].weight_ih), .start(start_ih[j]), .clk(clk), .rst(rst), 
					.ready(ready_ih[j]), .out(nout));
		end
		for(j = 0; j < 10; j = j + 1) begin:olayer
			wire[15:0] nout;
			neuron #(.counter_size($clog2(128*10))) n(.in(layer2_in), .weight(bank_ho[j].weight_ho), .start(start_ho[j]), .clk(clk), .rst(rst), 
					.ready(ready_ho[j]), .out(nout));
		end
	endgenerate

	always@(posedge clk or rst) begin
		if(rst) begin
			cycle_counter <= 0;
			who_counter <= 0;
			layer2_in <= 0;
			who_clk <= 0;
			ihptr <= 0;
		end
		else begin
			cycle_counter <= cycle_counter + 1;
			if(~ready_ih == 0) begin
				who_counter <= who_counter + 1;
				if(who_counter == 4'h9) begin
					who_counter <= 0;
					who_clk <= 1;
				end
				else begin
					who_clk <= 0;
				end
			end
			if(cycle_counter == 32'd100352) begin
				if(ihptr == 0) begin
					layer2_in <= olayer[0].nout;
				end
				else if(ihptr == 1) begin
					layer2_in <= olayer[1].nout;
				end
				else if(ihptr == 2)begin
					layer2_in <= olayer[2].nout;
				end
				else if(ihptr == 3) begin
					layer2_in <= olayer[3].nout;
				end
				else if(ihptr == 4) begin
					layer2_in <= olayer[4].nout;
				end
				else if(ihptr == 5)begin
					layer2_in <= olayer[5].nout;
				end
				else if(ihptr == 6) begin
					layer2_in <= olayer[6].nout;
				end
				else if(ihptr == 7)begin
					layer2_in <= olayer[7].nout;
				end
				else if(ihptr == 8) begin
					layer2_in <= olayer[8].nout;
				end
				else if(ihptr == 9) begin
					layer2_in <= olayer[9].nout;
				end
				ihptr <= ihptr + 1;
				cycle_counter <= 0;
			end
		end
	end

	generate
		for(j = 0; j < 128; j = j + 1)begin:bank_ih
			reg[15:0] weight_ih;
		end
		for(j = 0; j < 10; j = j + 1)begin:bank_ho
			reg[15:0] weight_ho;
		end

	endgenerate


	generate
		for(j = 0; j < 128; j = j + 1) begin:assign_bank_ih
			always@(posedge clk or rst) begin
				if(rst) begin
					bank_ih[j].weight_ih <= 0;
				end
				else begin
					bank_ih[j].weight_ih <= wih;
				end
			end
		end
		for(j = 0; j < 10; j = j + 1) begin:assign_bank_ho
			always@(posedge clk or rst) begin
				if(rst) begin
					bank_ho[j].weight_ho <= 0;
				end
				else begin
					bank_ho[j].weight_ho <= who;
				end
			end
		end
	endgenerate

	network_ctrl con(.clk(clk), .who_clk(who_clk), .rst(rst), .addr_ih(addr_ih), .addr_in(addr_in), .addr_ho(addr_ho),
					 .start_ih(start_ih), .start_ho(start_ho), .ready_ih(ready_ih), .ready_ho(ready_ho));
	//network nn(.in(in), .weight_ih(weight_ih), .weight_ho(weight_ho), .start_ih(start_ih), .start_ho(start_ho)
		//	  , .clk(clk), .rst(rst), .out(out), ready_ih(ready_ih), ready_ho(ready_ho));
endmodule;
