	component processor is
		port (
			arbitrator_0_rx_beginbursttransfer   : in    std_logic                    := 'X';             -- beginbursttransfer
			arbitrator_0_tx_writeresponsevalid_n : out   std_logic;                                       -- writeresponsevalid_n
			clk_clk                              : in    std_logic                    := 'X';             -- clk
			esp_rxd                              : in    std_logic                    := 'X';             -- rxd
			esp_txd                              : out   std_logic;                                       -- txd
			lcd_DATA                             : inout std_logic_vector(7 downto 0) := (others => 'X'); -- DATA
			lcd_ON                               : out   std_logic;                                       -- ON
			lcd_BLON                             : out   std_logic;                                       -- BLON
			lcd_EN                               : out   std_logic;                                       -- EN
			lcd_RS                               : out   std_logic;                                       -- RS
			lcd_RW                               : out   std_logic;                                       -- RW
			input_export                         : in    std_logic_vector(3 downto 0) := (others => 'X'); -- export
			output_export                        : out   std_logic_vector(3 downto 0)                     -- export
		);
	end component processor;

	u0 : component processor
		port map (
			arbitrator_0_rx_beginbursttransfer   => CONNECTED_TO_arbitrator_0_rx_beginbursttransfer,   -- arbitrator_0_rx.beginbursttransfer
			arbitrator_0_tx_writeresponsevalid_n => CONNECTED_TO_arbitrator_0_tx_writeresponsevalid_n, -- arbitrator_0_tx.writeresponsevalid_n
			clk_clk                              => CONNECTED_TO_clk_clk,                              --             clk.clk
			esp_rxd                              => CONNECTED_TO_esp_rxd,                              --             esp.rxd
			esp_txd                              => CONNECTED_TO_esp_txd,                              --                .txd
			lcd_DATA                             => CONNECTED_TO_lcd_DATA,                             --             lcd.DATA
			lcd_ON                               => CONNECTED_TO_lcd_ON,                               --                .ON
			lcd_BLON                             => CONNECTED_TO_lcd_BLON,                             --                .BLON
			lcd_EN                               => CONNECTED_TO_lcd_EN,                               --                .EN
			lcd_RS                               => CONNECTED_TO_lcd_RS,                               --                .RS
			lcd_RW                               => CONNECTED_TO_lcd_RW,                               --                .RW
			input_export                         => CONNECTED_TO_input_export,                         --           input.export
			output_export                        => CONNECTED_TO_output_export                         --          output.export
		);

