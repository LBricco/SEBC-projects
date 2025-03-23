# Loads the technological library and the SDF, resolution is ps
vsim -voptargs=+acc -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tbinccomp/DUT=../inccomp.sdf work.tbinccomp -t ps +nowarnTSCALE

add wave *

# Generates the VCD file and add all the DUT signals
vcd file ../inccomp.vcd
vcd add /tbinccomp/DUT/*

# runs the simulation
run 2000ns