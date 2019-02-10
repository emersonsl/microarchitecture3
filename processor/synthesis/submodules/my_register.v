module my_register(clock, resetn, data, byte_enable, q);
input clock, resetn;
input [3:0] byte_enable;
input [31:0] data;
output reg [31:0] q;

always@(posedge clock or negedge resetn)
 if (~resetn)
 q <= 32'd0;
 else
 begin
 // Enable writing to each byte separately.
 if (byte_enable[0]) q[7:0] <= data[7:0];
 if (byte_enable[1]) q[15:8] <= data[15:8];
 if (byte_enable[2]) q[23:16] <= data[23:16];
 if (byte_enable[3]) q[31:24] <= data[31:24];
end
endmodule
