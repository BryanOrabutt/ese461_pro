module network_ctrl(clk, rst, addr_in, addr_ih, addr_ho, who_clk, start_ih, start_ho, ready_ih, ready_ho);

	input clk, rst;
	input[127:0] ready_ih;
	input[9:0] ready_ho;
	output reg[16:0] addr_in, addr_ih, addr_ho;
	output reg[127:0] start_ih;
	output reg[9:0] start_ho;
	input who_clk;

	always@(posedge clk or rst) begin
		if(rst) begin
			addr_in <= 0;
			addr_ih <= 0;
			addr_ho <= 0;
			start_ih <= 0;
			start_ho <= 0;
		end
		else begin
			if(~ready_ih == 128'h0) begin
				addr_in <= addr_in + 1;
				addr_ih <= 0;
				start_ih <= 0;
			end
			if(~ready_ho == 10'h0) begin
				addr_ho <= 0;
				start_ho <= 0;
			end
			else begin
				if(start_ih == 128'h0) begin
					start_ih <= 1;
				end
				else begin
					start_ih <= start_ih << 1;
				end
			end
			if(~start_ho != 10'h0) begin
				if(start_ho == 0) begin
					start_ho <= 1;
				end
				else begin
					start_ho <= start_ho << 1;
				end
			end
			addr_ih <= addr_ih + 1;
			if(who_clk) begin
				addr_ho <= addr_ho + 1;
			end
		end
	end

endmodule
