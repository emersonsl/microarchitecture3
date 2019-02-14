`timescale 1ns/1ps
module teste_arbitrator;
	reg clock, resetn, read, write, chip_select;
 	reg [31:0] writedata;
	wire [31:0] readdata;
 	reg rx;
 	wire tx;
	wire [2:0] state;
	reg clk_50m;
	wire rxclk_en;
        wire txclk_en;
	arbitrator arbitrator(clock, resetn, writedata, readdata, read, write, chip_select, rx, tx, state);
	//baud_rate_gen teste1( clk_50m, rxclk_en, txclk_en);
	
	initial begin
		clock = 0;
		resetn = 1;
		$display("init");
	end

	
	always @(posedge clock) begin
		$display("Estado %b ", state);
	end
endmodule
