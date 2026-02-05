# -----------------------------------------------------------------------
# FINTA Loop A - Physical Constraints for KR260 (Connector J2 / PMOD1)
# Derived from Schematic Net Names [Source 250]
# -----------------------------------------------------------------------

# --- 1. DAC SPI (Custom Names) ---
# Note: We avoid Pin 4 (Clock) and Pin 1 (GPS PPS) for SPI.

# CLK -> J2 Pin 6 (Net: PMOD1_IO7_HDA17)
set_property PACKAGE_PIN [get_board_part_pins -filter {NAME=~*pmod1_io7*}] [get_ports DAC_SPI_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_SPI_CLK]

# CS -> J2 Pin 2 (Net: PMOD1_IO5_HDA15)
# Note: Since the port is a vector [0:0], we reference bit 0.
set_property PACKAGE_PIN [get_board_part_pins -filter {NAME=~*pmod1_io5*}] [get_ports {DAC_SPI_CS}]
set_property IOSTANDARD LVCMOS33 [get_ports {DAC_SPI_CS}]

# MOSI -> J2 Pin 8 (Net: PMOD1_IO8_HDA18)
set_property PACKAGE_PIN [get_board_part_pins -filter {NAME=~*pmod1_io8*}] [get_ports DAC_SPI_MOSI]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_SPI_MOSI]

# --- 2. OCXO Clock Input (CRITICAL) ---
# CLK -> J2 Pin 4 (Net: PMOD1_IO6_HDA16_CC)
# Source 250 confirms Pin 4 is the Clock Capable (CC) pin required for the 10MHz input.
set_property PACKAGE_PIN [get_board_part_pins -filter {NAME=~*pmod1_io6*}] [get_ports OCXO_10M_IN]
set_property IOSTANDARD LVCMOS33 [get_ports OCXO_10M_IN]

# --- 3. GPS Inputs/Outputs ---
# 1PPS -> J2 Pin 1 (Net: PMOD1_IO1_HDA11)
set_property PACKAGE_PIN [get_board_part_pins -filter {NAME=~*pmod1_io1*}] [get_ports GPS_1PPS_IN]
set_property IOSTANDARD LVCMOS33 [get_ports GPS_1PPS_IN]

# RX -> J2 Pin 3 (Net: PMOD1_IO2_HDA12)
set_property PACKAGE_PIN [get_board_part_pins -filter {NAME=~*pmod1_io2*}] [get_ports GPS_UART_TX]
set_property IOSTANDARD LVCMOS33 [get_ports GPS_UART_TX]

# TX -> J2 Pin 5 (Net: PMOD1_IO3_HDA13)
set_property PACKAGE_PIN [get_board_part_pins -filter {NAME=~*pmod1_io3*}] [get_ports GPS_UART_RX]
set_property IOSTANDARD LVCMOS33 [get_ports GPS_UART_RX]

# --- 4. Power Enable (CRITICAL) ---
# Net: PMOD_PWR_EN -> Controls U42 to supply 3.3V to the connector [Source 250].
# IMPORTANT: Check your Block Design to see if the GPIO port is named 
# "PMOD_PWR_EN" (which becomes PMOD_PWR_EN_tri_o) or just "PMOD_PWR_EN".
set_property PACKAGE_PIN [get_board_part_pins -filter {NAME=~*pmod_pwr_en*}] [get_ports {PMOD_PWR_EN_tri_o}]
set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_PWR_EN_tri_o}]
