vcom ../src/configpkg.vhd
vcom ../src/Gates/XOR2.vhd
vcom ../src/Gates/AND2.vhd
vcom ../src/Gates/NAND2.vhd
vcom ../src/Gates/OAI21.vhd
vcom ../src/Gates/FLIPFLOP.vhd
vcom ../src/Gates/FA.vhd
vcom ../src/Gates/HA.vhd
vcom ../src/Gates/Memory.vhd
vcom ../src/Blocks/Reg.vhd
vcom ../src/Blocks/Adder.vhd
vcom ../src/Blocks/Multiplier.vhd
vcom ../src/Blocks/Logic.vhd
vcom ../src/Blocks/LUT.vhd
vcom ../src/PMU.vhd
vcom ../src/top_level.vhd
vcom ../src/dummyALU.vhd
vlog ./final_tb_pa.sv

vopt +acc  final_tb_pa -pa_top final_tb_pa/UUT -pa_lib work -pa_upf ../syn/power.upf -o SimModel -warning 9903 -warning 9642
vsim SimModel -pa -pa_lib work
add wave -position insertpoint sim:/final_tb_pa/UUT/*
run 10 us