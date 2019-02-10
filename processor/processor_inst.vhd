	component processor is
		port (
			clk_clk                                            : in  std_logic                     := 'X'; -- clk
			my_register_slave_interface_0_conduit_end_readdata : out std_logic_vector(31 downto 0);        -- readdata
			uart_0_rxd                                         : in  std_logic                     := 'X'; -- rxd
			uart_0_txd                                         : out std_logic                             -- txd
		);
	end component processor;

	u0 : component processor
		port map (
			clk_clk                                            => CONNECTED_TO_clk_clk,                                            --                                       clk.clk
			my_register_slave_interface_0_conduit_end_readdata => CONNECTED_TO_my_register_slave_interface_0_conduit_end_readdata, -- my_register_slave_interface_0_conduit_end.readdata
			uart_0_rxd                                         => CONNECTED_TO_uart_0_rxd,                                         --                                    uart_0.rxd
			uart_0_txd                                         => CONNECTED_TO_uart_0_txd                                          --                                          .txd
		);

