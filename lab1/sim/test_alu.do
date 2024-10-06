vsim -gui -l /dev/null work.alu

add wave -position insertpoint sim:/alu/*

force -freeze sim:/alu/A_IN 11110000 0
force -freeze sim:/alu/S 1000 0
run

force -freeze sim:/alu/S 1001 0
run

force -freeze sim:/alu/S 1010 0
force -freeze sim:/alu/Cin 0 0
run

force -freeze sim:/alu/S 1011 0
run

force -freeze sim:/alu/S 1100 0
run

force -freeze sim:/alu/S 1101 0
run

force -freeze sim:/alu/S 1110 0
run

force -freeze sim:/alu/S 1111 0
run

force -freeze sim:/alu/S 1010 0
force -freeze sim:/alu/Cin 1 0
run

force -freeze sim:/alu/S 1110 0
run


