module check_CRC(output ck_crc, output ck_alarme, input wire [7:0] d, input wire [7:0] crc);
    wire [7:0] c;
    wire [5:0] newcrc;

    assign c = 8'b00110111;

    assign newcrc[0] = d[5] ^ d[2] ^ d[1] ^ d[0] ^ c[0] ^ c[3];
    assign newcrc[1] = d[6] ^ d[5] ^ d[3] ^ d[0] ^ c[1] ^ c[3] ^ c[4];
    assign newcrc[2] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[2] ^ d[0] ^ c[0] ^ c[2] ^ c[3] ^ c[4] ^ c[5];
    assign newcrc[3] = d[7] ^ d[6] ^ d[3] ^ d[2] ^ d[0] ^ c[0] ^ c[1] ^ c[4] ^ c[5];
    assign newcrc[4] = d[7] ^ d[4] ^ d[3] ^ d[1] ^ c[1] ^ c[2] ^ c[5];
    assign newcrc[5] = d[4] ^ d[1] ^ d[0] ^ c[2];
    
    assign ck_crc = newcrc & crc;
 	//verificação do alarme

endmodule
