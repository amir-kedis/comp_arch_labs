vsim -gui -l /dev/null work.b

add wave -position insertpoint sim:/b/*

force -freeze sim:/b/S 0100 0
force -freeze sim:/b/A 11110000 0
force -freeze sim:/b/B 10110000 0
run

force -freeze sim:/b/S 0101 0
force -freeze sim:/b/B 00001011 0
run

force -freeze sim:/b/S 0110 0
force -freeze sim:/b/B 10110000 0
run

force -freeze sim:/b/S 0111 0
run


