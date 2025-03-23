# Loads the technological library and the SDF, resolution is ps
vsim -t ps -voptargs=+acc work.testbench

# caso 1: no codifica (BUSNORM)
power add /testbench/ck /testbench/rst /testbench/A /testbench/C*BUSNORM
run 100us
power report -file 41_power_report_data_busnorm.rpt

# caso 2: codifica bus invert (BUSINVBEH)
restart
power add /testbench/ck /testbench/rst /testbench/A /testbench/*BUSINVBEH
run 100us
power report -file 41_power_report_data_businvbeh.rpt

# caso 3: codifica transition based (TRANSBASED)
restart
power add /testbench/ck /testbench/rst /testbench/A /testbench/*TRANSBASED
run 100us
power report -file 41_power_report_data_transbased.rpt

# caso 4: codifica Gray (GRAYENCODER)
restart
power add /testbench/ck /testbench/rst /testbench/A /testbench/*GRAYENCODER
run 100us
power report -file 41_power_report_data_grayencoder.rpt

# caso 5: codifica T0 (T0ENCODER)
restart
power add /testbench/ck /testbench/rst /testbench/A /testbench/*T0ENCODER
run 100us
power report -file 41_power_report_data_t0encoder.rpt

# power report di tutti i segnali
restart
power add *
run 100us
power report -file 41_power_report_data_tot.rpt
