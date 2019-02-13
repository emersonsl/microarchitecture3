module arbitrator( clock, resetn, writedata, readdata, read, write, chip_select, rx, tx, state);
 input clock, resetn, read, write, chip_select;
 input [31:0] writedata;
 output [31:0] readdata;
 input rx;
 output tx;

/*estados*/
 parameter SEND_STATE	= 3'b000;
 parameter RECEIVE_DATA_STATE	= 3'b001;
 parameter RECEIVE_CRC_STATE	= 3'b010;
 parameter CHECK_CRC_STATE	= 3'b011;
 parameter RECOVERY_STATE	= 3'b100;

 reg [15:0] temp; //guarda o que foi recebido antes de verificar o CRC
 output reg [2:0] state = SEND_STATE;
 reg [2:0] select_sensor = 3'b1; //contador que seleciona o sensor
 reg [7:0] send_reg; //registradores para envio e recebimento da uart
 wire [7:0] receive_reg;
 reg [31:0] readd;
 reg rdy_clr; 
 wire rdy; //controle de leitura na uart
 wire wr_en; // controle da escrita na uart
 wire ck_crc, ck_alarme; //controle crc
 wire tx_busy;

 uart uart_instance(.din(send_reg), .wr_en(wr_en), .clk_50m(clock), .tx(tx), .tx_busy(tx_busy), .rx(rx), .rdy(rdy), .rdy_clr(rdy_clr), .dout(receive_reg));

 check_CRC check_CRC_instance(.ck_crc(ck_crc), .ck_alarme(ck_alarme), .dado(temp[7:0]), .crc(temp[15:8]));


 assign wr_en = (state == SEND_STATE);

always@(posedge clock or negedge resetn) begin
 if (~resetn) //reset da maquina
  state <= SEND_STATE; 
 else
 begin
 	case (state)
		SEND_STATE: begin
			state <= RECEIVE_DATA_STATE;
			send_reg[2:0] <= select_sensor[2:0];	
			select_sensor <= select_sensor + 3'b1;
			if (select_sensor == 6) begin //contagem exceda 5
				select_sensor <= 3'b1;
			end
		end
		RECEIVE_DATA_STATE: begin
			if(rdy) begin //leitura concluida
				temp[7:0] <= receive_reg[7:0];
				rdy_clr <= 1'b1;
				state <= RECEIVE_CRC_STATE;
			end
			else begin 
				//time out
			end
		end
		RECEIVE_CRC_STATE: begin
			rdy_clr <= 0;
			if(rdy) begin //leitura concluida
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
			if(ck_alarme) begin //verifica ser foi o alarme
				state <= RECOVERY_STATE;
			end
			else begin
				if(ck_crc) begin //crc está correto
					readd[15:0] <= temp[15:0];
					readd[23:16] <= send_reg[7:0];
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
 end
endmodule
