module my_register_slave_interface( clock, resetn, writedata, readdata, read, write, byte_enable, chip_select, to_lights );
 input clock, resetn, read, write, chip_select;
 input [3:0] byte_enable;
 input [31:0] writedata;
 output [31:0] readdata;
 output [31:0] to_lights;

 wire [3:0] local_byteenable;
 wire [31:0] to_reg, from_reg;
 my_register my_instance( .clock(clock), .resetn(resetn), .data(to_reg), .byte_enable(local_byteenable), .q(from_reg) );
 assign to_lights = from_reg;
 // Avalon MM Interface
 assign to_reg = writedata;
 assign readdata = from_reg;
 assign local_byteenable = (chip_select & write & ~read) ? byte_enable : 4'd0;
endmodule
