# Legal Notice: (C)2019 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	processor_nios2_gen2_0_cpu 	processor_nios2_gen2_0_cpu:*
set 	processor_nios2_gen2_0_cpu_oci 	processor_nios2_gen2_0_cpu_nios2_oci:the_processor_nios2_gen2_0_cpu_nios2_oci
set 	processor_nios2_gen2_0_cpu_oci_break 	processor_nios2_gen2_0_cpu_nios2_oci_break:the_processor_nios2_gen2_0_cpu_nios2_oci_break
set 	processor_nios2_gen2_0_cpu_ocimem 	processor_nios2_gen2_0_cpu_nios2_ocimem:the_processor_nios2_gen2_0_cpu_nios2_ocimem
set 	processor_nios2_gen2_0_cpu_oci_debug 	processor_nios2_gen2_0_cpu_nios2_oci_debug:the_processor_nios2_gen2_0_cpu_nios2_oci_debug
set 	processor_nios2_gen2_0_cpu_wrapper 	processor_nios2_gen2_0_cpu_debug_slave_wrapper:the_processor_nios2_gen2_0_cpu_debug_slave_wrapper
set 	processor_nios2_gen2_0_cpu_jtag_tck 	processor_nios2_gen2_0_cpu_debug_slave_tck:the_processor_nios2_gen2_0_cpu_debug_slave_tck
set 	processor_nios2_gen2_0_cpu_jtag_sysclk 	processor_nios2_gen2_0_cpu_debug_slave_sysclk:the_processor_nios2_gen2_0_cpu_debug_slave_sysclk
set 	processor_nios2_gen2_0_cpu_oci_path 	 [format "%s|%s" $processor_nios2_gen2_0_cpu $processor_nios2_gen2_0_cpu_oci]
set 	processor_nios2_gen2_0_cpu_oci_break_path 	 [format "%s|%s" $processor_nios2_gen2_0_cpu_oci_path $processor_nios2_gen2_0_cpu_oci_break]
set 	processor_nios2_gen2_0_cpu_ocimem_path 	 [format "%s|%s" $processor_nios2_gen2_0_cpu_oci_path $processor_nios2_gen2_0_cpu_ocimem]
set 	processor_nios2_gen2_0_cpu_oci_debug_path 	 [format "%s|%s" $processor_nios2_gen2_0_cpu_oci_path $processor_nios2_gen2_0_cpu_oci_debug]
set 	processor_nios2_gen2_0_cpu_jtag_tck_path 	 [format "%s|%s|%s" $processor_nios2_gen2_0_cpu_oci_path $processor_nios2_gen2_0_cpu_wrapper $processor_nios2_gen2_0_cpu_jtag_tck]
set 	processor_nios2_gen2_0_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $processor_nios2_gen2_0_cpu_oci_path $processor_nios2_gen2_0_cpu_wrapper $processor_nios2_gen2_0_cpu_jtag_sysclk]
set 	processor_nios2_gen2_0_cpu_jtag_sr 	 [format "%s|*sr" $processor_nios2_gen2_0_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$processor_nios2_gen2_0_cpu_oci_break_path|break_readreg*] -to [get_keepers *$processor_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$processor_nios2_gen2_0_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$processor_nios2_gen2_0_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$processor_nios2_gen2_0_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$processor_nios2_gen2_0_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$processor_nios2_gen2_0_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$processor_nios2_gen2_0_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$processor_nios2_gen2_0_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$processor_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from *$processor_nios2_gen2_0_cpu_jtag_sr*    -to *$processor_nios2_gen2_0_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$processor_nios2_gen2_0_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$processor_nios2_gen2_0_cpu_oci_debug_path|monitor_go
