# Clock
create_clock -name sys_clk -period 10.000 [get_ports clk]
set_property PACKAGE_PIN B4 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
# optional: set_property SLEW FAST [get_ports clk]

# control pins
set_property PACKAGE_PIN A4 [get_ports n_rst]
set_property PACKAGE_PIN P13 [get_ports wen]
set_property PACKAGE_PIN N13 [get_ports ren]

# data in
set_property PACKAGE_PIN G12 [get_ports wdata[0]]
set_property PACKAGE_PIN G13 [get_ports wdata[1]]
set_property PACKAGE_PIN F12 [get_ports wdata[2]]
set_property PACKAGE_PIN F13 [get_ports wdata[3]]
set_property PACKAGE_PIN E12 [get_ports wdata[4]]
set_property PACKAGE_PIN E13 [get_ports wdata[5]]
set_property PACKAGE_PIN D12 [get_ports wdata[6]]
set_property PACKAGE_PIN D13 [get_ports wdata[7]]

# data out
set_property PACKAGE_PIN B11 [get_ports rdata[0]]
set_property PACKAGE_PIN B12 [get_ports rdata[1]]
set_property PACKAGE_PIN A11 [get_ports rdata[2]]
set_property PACKAGE_PIN A12 [get_ports rdata[3]]
set_property PACKAGE_PIN C11 [get_ports rdata[4]]
set_property PACKAGE_PIN C12 [get_ports rdata[5]]
set_property PACKAGE_PIN D11 [get_ports rdata[6]]
set_property PACKAGE_PIN E11 [get_ports rdata[7]]

# status
set_property PACKAGE_PIN H11 [get_ports status[0]]
set_property PACKAGE_PIN H12 [get_ports status[1]]

# IOSTANDARD (apply per-port or grouped, but verify bank VCCO before applying globally)
set_property IOSTANDARD LVCMOS33 [get_ports {n_rst wen ren wdata[0] wdata[1] wdata[2] wdata[3] wdata[4] wdata[5] wdata[6] wdata[7] rdata[0] rdata[1] rdata[2] rdata[3] rdata[4] rdata[5] rdata[6] rdata[7] status[0] status[1]}]

# input/output delays (explicit port list)
set_input_delay -clock sys_clk -max 7.5 [get_ports {wdata[0] wdata[1] wdata[2] wdata[3] wdata[4] wdata[5] wdata[6] wdata[7] wen ren n_rst}]
set_input_delay -clock sys_clk -min 0.5 [get_ports {wdata[0] wdata[1] wdata[2] wdata[3] wdata[4] wdata[5] wdata[6] wdata[7] wen ren n_rst}]

set_output_delay -clock sys_clk -max 3.0 [get_ports {rdata[0] rdata[1] rdata[2] rdata[3] rdata[4] rdata[5] rdata[6] rdata[7] status[0] status[1]}]
set_output_delay -clock sys_clk -min 0.0 [get_ports {rdata[0] rdata[1] rdata[2] rdata[3] rdata[4] rdata[5] rdata[6] rdata[7] status[0] status[1]}]
