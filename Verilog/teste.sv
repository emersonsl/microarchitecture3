`timescale 1ns/1ps
module teste;
	reg clock, resetn, read, write, chip_select;
 	reg [31:0] writedata;
	wire [31:0] readdata;
 	reg rx;
 	wire tx;
	wire [2:0] estado;
	reg clk_50m;
	wire rxclk_en;
        wire txclk_en;
	arbitrator teste(clock, resetn, writedata, readdata, read, write, chip_select, rx, tx, estado);
	baud_rate_gen teste1( clk_50m, rxclk_en, txclk_en);
	
	initial begin
	if(rxclk_en)begin rx=~rx; end
	end


	always # 1 clock = ~clock;
	
	always @(posedge clock) begin
		$display("Estado %b ", estado);
	end
endmodule