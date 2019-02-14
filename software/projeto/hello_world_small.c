#include "altera_up_avalon_character_lcd.h"
#include "system.h"
#include "sys/alt_stdio.h"
#include "io.h"
#include "altera_avalon_uart_regs.h"
#include "altera_avalon_jtag_uart_regs.h"
#include <string.h>


void delay(int a){ //bounce
	volatile int i = 0;
	while(i<a*10000){
		i++;
	}
}

/*Write Console*/

void write(char * v) {
	int i = 0;
	while (v[i] != '\0') {
		IOWR_ALTERA_AVALON_JTAG_UART_DATA(JTAG_BASE, v[i]);
		delay(2);
		i++;
	}
}

/************************************ESP**********************************/

/*Mensagens*/

/*Mensagem connect*/
char connectMessage[] = { 0x10 // Connect
		, 0x0C + 0x04 // Remaining Length
				, 0x00 // 0
		, 0x06 // 6
		, 0x4d // M
		, 0x51 // Q
		, 0x49 // I
		, 0x73 // S
		, 0x64 // D
		, 0x70 // P
		, 0x03 // Protocol version = 3
		, 0x02 // Clean session only
		, 0x00 // Keepalive MSB
		, 0x3c // Keepaliave LSB = 60
		, 0x00 // String length MSB
		, 0x02 // String length LSB = 2
		, 0x4d // M
		, 0x70 // P .. Let's say client ID = MP
		};
/*Mensagem disconnect*/
char disconnectMessage[] = {0xE0, 0x00};

char publishMessage []= { 0x30 // Publish with QOS 0
		, 0x05 + 0x05 // Remaining length
		, 0x00 // MSB
		, 0x03 // 3 bytes of topic
		, 0x61 // a
		, 0x2F ///
		, 0x62 // b (a/b) is the topic
		, 0x48, 0x45, 0x4c, 0x4c, 0x4f // HELLO is the message
};


char pb1 [] = { 0x30 // Publish with QOS 0
			, 0x05 + 0x0a // Remaining length
			, 0x00 // MSB
			, 0x03 // 3 bytes of topic
			, 0x61 // a
			, 0x2F ///
			, 0x62 // b (a/b) is the topic
			, 0x4d, 0x65, 0x6e, 0x73, 0x61, 0x67, 0x65, 0x6d, 0x20, 0x31 // Mensagem 1 is the message
	};

char pb2 [] = { 0x30 // Publish with QOS 0
			, 0x05 + 0x09 // Remaining length
			, 0x00 // MSB
			, 0x03 // 3 bytes of topic
			, 0x61 // a
			, 0x2F ///
			, 0x62 // b (a/b) is the topic
			, 0x4d, 0x65, 0x6e, 0x73, 0x61, 0x67, 0x65, 0x6d, 0x20 // Mensagem  is the message
	};

char pb3 [] = { 0x30 // Publish with QOS 0
			, 0x05 + 0x07 // Remaining length
			, 0x00 // MSB
			, 0x03 // 3 bytes of topic
			, 0x61 // a
			, 0x2F ///
			, 0x62 // b (a/b) is the topic
			, 0x4d, 0x65, 0x6e, 0x73, 0x61, 0x67, 0x65 // Mensage is the message
	};

char pb4 [] = { 0x30 // Publish with QOS 0
			, 0x05 + 0x06 // Remaining length
			, 0x00 // MSB
			, 0x03 // 3 bytes of topic
			, 0x61 // a
			, 0x2F ///
			, 0x62 // b (a/b) is the topic
			, 0x4d, 0x65, 0x6e, 0x73, 0x61, 0x67 // Mensag is the message
	};
char pb5 [] = { 0x30 // Publish with QOS 0
			, 0x05 + 0x05 // Remaining length
			, 0x00 // MSB
			, 0x03 // 3 bytes of topic
			, 0x61 // a
			, 0x2F ///
			, 0x62 // b (a/b) is the topic
			, 0x4d, 0x65, 0x6e, 0x73, 0x61 // Mensa is the message
	};

void sendCommand(char * cmd) {
	alt_putstr(cmd);
	char a;

	while (1) {
		if (IORD_ALTERA_AVALON_UART_STATUS(ESP_BASE) & (1 << 7)) {
			a = IORD_ALTERA_AVALON_UART_RXDATA(ESP_BASE);
			IOWR_ALTERA_AVALON_JTAG_UART_DATA(JTAG_BASE, a);
		}
		if(a=='K')
			break;
	}

}

void espTest() {
	sendCommand("AT\r\n");
}
void espMode() {
	sendCommand("AT+CWMODE=1\r\n");
}

void espConnect(char * ssid, char * pass) {
	char net[80] = "AT+CWJAP=\"";
	strcat(net, ssid);
	strcat(net, "\",\"");
	strcat(net, pass);
	strcat(net, "\"\r\n");
	sendCommand(net);
}

void espOpenTCPConnect(char * ip, char * port) {
	char net[80] = "AT+CIPSTART=\"TCP\",\"";
	strcat(net, ip);
	strcat(net, "\",");
	strcat(net, port);
	strcat(net, "\r\n");
	sendCommand(net);
}

void espTCPSend(char * message, int size) {
	char a;
	char net[] = "";
	sprintf(net, "AT+CIPSEND=%d\r\n", size);
	alt_putstr(net);

	while (1) {
		if (IORD_ALTERA_AVALON_UART_STATUS(ESP_BASE) & (1 << 7)) {
			a = IORD_ALTERA_AVALON_UART_RXDATA(ESP_BASE);
			IOWR_ALTERA_AVALON_JTAG_UART_DATA(JTAG_BASE, a);
		}
		if(a=='>')
			break;
	}

	//enviando messagem
	int i;
	for (i = 0; i < size; i++) {
		while(!(IORD_ALTERA_AVALON_UART_STATUS(ESP_BASE)&(1<<6)));
		alt_putchar(message[i]);
		delay(3);
	}

}

void espTCPSendP(char * message, int size) {
	char a;
	char net[] = "";
	sprintf(net, "AT+CIPSEND=%d\r\n", size);
	alt_putstr(net);

	while (1) {
		if (IORD_ALTERA_AVALON_UART_STATUS(ESP_BASE) & (1 << 7)) {
			a = IORD_ALTERA_AVALON_UART_RXDATA(ESP_BASE);
			IOWR_ALTERA_AVALON_JTAG_UART_DATA(JTAG_BASE, a);
		}
		if(a=='>')
			break;
	}

	//enviando messagem
	int i;
	for (i = 0; i < size; i++) {
		while(!(IORD_ALTERA_AVALON_UART_STATUS(ESP_BASE)&(1<<6)));
		alt_putchar(message[i]);
		delay(3);
	}
	delay(50);
}



void espSendMessage(int i){
	switch (i){
		case 1: espTCPSendP(pb1, sizeof(pb1)); break;
		case 2: espTCPSendP(pb2, sizeof(pb2)); break;
		case 3: espTCPSendP(pb3, sizeof(pb3)); break;
		case 4: espTCPSendP(pb4, sizeof(pb4)); break;
		case 5: espTCPSendP(pb5, sizeof(pb5)); break;
	}
	write("aqui");
}

/************************************LCD**********************************/

void writeLCD(alt_up_character_lcd_dev * char_lcd_dev, char word []){

	//limpando
	alt_up_character_lcd_set_cursor_pos(char_lcd_dev, 0, 0);
	int j;
	for(j=0; j<16; j++){
		alt_up_character_lcd_string(char_lcd_dev, " ");
	}

	//escrevendo
	alt_up_character_lcd_set_cursor_pos(char_lcd_dev, 0, 0);
	alt_up_character_lcd_string(char_lcd_dev, word);
}

void initConf(){
	espTest();
	espMode();
	espConnect("UNIX", "santoslima");
	espOpenTCPConnect("192.168.137.1", "1883");
	delay(100);
	espTCPSend(connectMessage, sizeof(connectMessage));
	delay(10);
}


int main(void)
{

	initConf();

	unsigned int read;

	while(1){
		read = IORD(ARBITRATOR_0_BASE, 0);
		char valor [100];
		strcat(valor, read);
		write(valor);
	}

	espTCPSendP(pb1, sizeof(pb1));
	espTCPSendP(pb2, sizeof(pb2));
	espTCPSendP(pb3, sizeof(pb3));
	espTCPSendP(pb4, sizeof(pb4));
	espTCPSendP(pb5, sizeof(pb5));

	espTCPSend(disconnectMessage, sizeof(disconnectMessage));
	return 0;
}
