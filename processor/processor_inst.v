	processor u0 (
		.arbitrator_0_rx_beginbursttransfer   (<connected-to-arbitrator_0_rx_beginbursttransfer>),   // arbitrator_0_rx.beginbursttransfer
		.arbitrator_0_tx_writeresponsevalid_n (<connected-to-arbitrator_0_tx_writeresponsevalid_n>), // arbitrator_0_tx.writeresponsevalid_n
		.clk_clk                              (<connected-to-clk_clk>),                              //             clk.clk
		.esp_rxd                              (<connected-to-esp_rxd>),                              //             esp.rxd
		.esp_txd                              (<connected-to-esp_txd>),                              //                .txd
		.lcd_DATA                             (<connected-to-lcd_DATA>),                             //             lcd.DATA
		.lcd_ON                               (<connected-to-lcd_ON>),                               //                .ON
		.lcd_BLON                             (<connected-to-lcd_BLON>),                             //                .BLON
		.lcd_EN                               (<connected-to-lcd_EN>),                               //                .EN
		.lcd_RS                               (<connected-to-lcd_RS>),                               //                .RS
		.lcd_RW                               (<connected-to-lcd_RW>),                               //                .RW
		.input_export                         (<connected-to-input_export>),                         //           input.export
		.output_export                        (<connected-to-output_export>)                         //          output.export
	);

