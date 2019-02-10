module arbitrator( clock, resetn, writedata, readdata, read, write, chip_select, rx, tx);
 input clock, resetn, read, write, chip_select;
 input [31:0] writedata;
 output [31:0] readdata;
 input rx;
 output tx;

 parameter SEND_STATE	= 3'b000;
 parameter RECEIVE_DATA_STATE	= 3'b001;
 parameter RECEIVE_CRC_STATE	= 3'b010;
 parameter CHECK_CRC_STATE	= 3'b011;
 parameter RECOVERY_STATE	= 3'b100;

 reg [15:0] temp;
 reg [2:0] state = SEND_STATE;
 reg [2:0] select_sensor = 3'b1;
 reg [7:0] receive_reg, send_reg;
 wire rdy_clr = 0;
 wire rdy;
 wire wr_en;
 wire ck_crc, ck_alarme;
 wire tx_busy;

 uart uart_instance(.din(send_reg), .wr_en(wr_en), .clk_50m(clk), .tx(tx), .tx_busy(tx_busy), .rx(rx), .rdy(rdy), .rdy_clr(rdy_clr), .dout(receive_reg));

 assign wr_en = (state == SEND_STATE);

always@(posedge clock or negedge resetn)
 if (~resetn)
  state <= SEND_STATE;
 else
 begin
 	case (state)
		SEND_STATE: begin
			state <= RECEIVE_DATA_STATE;
			send_reg[2:0] <= select_sensor[2:0];	
			select_sensor <= select_sensor + 3'b1;
			if (select_sensor == 6) begin
				select_sensor <= 3'b1;
			end
		end
		RECEIVE_DATA_STATE: bengin
			if(rdy) begin
				temp[7:0] <= receive_reg[7:0];
				rdy_clr <= 1'b1;
				state <= RECEIVE_CRC_STATE;
			end
			else bengin
				//time out
			end
		end
		RECEIVE_CRC_STATE: begin
			rdy_clr <= 0;
			if(rdy) begin
				temp[15:8] <= receive_reg[7:0];
				rdy_clr <= 1'b1;
				state <= CHECK_CRC_STATE;
			end
			else begin
				//time out
			end
		end
		CHECK_CRC_STATE: begin
			rdy_clr <= 0;
			if(ck_alarme) begin
				state <= RECOVERY_STATE;
			end
			else begin
				if(ck_crc) begin
					readdata[15:0] <= temp[15:0];
					readdata[23:16] <= send_data[7:0];
					state <= SEND_STATE; 
				end
				else begin
					state <= RECEIVE_DATA_STATE;
				end
			end
		end
		RECOVERY_STATE: begin
			select_sensor <= 3'b0;
			state <= SEND_STATE;
		end
	endcase
 end
endmodule
