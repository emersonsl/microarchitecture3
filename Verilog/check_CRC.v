module check_CRC( ck_crc, ck_alarme, dado, crc, newcrc);
    output wire ck_alarme;
    output wire ck_crc;
    input wire [7:0] dado;
    input wire [7:0] crc;
    wire [7:0] chave;
    output wire [7:0] newcrc;
    assign chave = 8'b00110111;
    assign newcrc = dado ^ chave;
    assign ck_crc = (newcrc == crc);
    assign ck_alarme = (crc == chave);
    
    
    
endmodule
