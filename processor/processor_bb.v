
module processor (
	arbitrator_0_rx_beginbursttransfer,
	arbitrator_0_tx_writeresponsevalid_n,
	clk_clk,
	esp_rxd,
	esp_txd,
	lcd_DATA,
	lcd_ON,
	lcd_BLON,
	lcd_EN,
	lcd_RS,
	lcd_RW,
	input_export,
	output_export);	

	input		arbitrator_0_rx_beginbursttransfer;
	output		arbitrator_0_tx_writeresponsevalid_n;
	input		clk_clk;
	input		esp_rxd;
	output		esp_txd;
	inout	[7:0]	lcd_DATA;
	output		lcd_ON;
	output		lcd_BLON;
	output		lcd_EN;
	output		lcd_RS;
	output		lcd_RW;
	input	[3:0]	input_export;
	output	[3:0]	output_export;
endmodule
