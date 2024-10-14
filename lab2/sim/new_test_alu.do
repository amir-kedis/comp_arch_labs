vsim work.alu

add wave -position insertpoint  \
sim:/alu/A_IN \
sim:/alu/B_IN \
sim:/alu/Cin \
sim:/alu/S \
sim:/alu/F \
sim:/alu/Cout

radix signal sim:/alu/A_IN hexadecimal
radix signal sim:/alu/B_IN hexadecimal
radix signal sim:/alu/F hexadecimal

# There are 3 tables in lab2 requirement/assignment, I will pul only 2 here
# becuase part b has different implementation from lab1 and hence different results


# Lab2 Requirement (first table in lab2)

# A = F0 for all cases
force -freeze sim:/alu/A_IN 11110000 0 
# B = B0 for all cases
force -freeze sim:/alu/B_IN 10110000 0
# Cin = 0
force -freeze sim:/alu/Cin 0 0

# F = A
force -freeze sim:/alu/S 0000 0
run

# F = A + B
force -freeze sim:/alu/S 0001 0
run

# F = A - B - 1
force -freeze sim:/alu/S 0010 0
run

# F = A - 1
force -freeze sim:/alu/S 0011 0
run

# F = A + 1 , Cin = 1
force -freeze sim:/alu/Cin 1 0
force -freeze sim:/alu/S 0000 0
run

# F = A + B + 1
force -freeze sim:/alu/S 0001 0
run

# F = A - B
force -freeze sim:/alu/S 0010 0
run

# F = B
force -freeze sim:/alu/S 0011 0
run

#####################################################

# Test ALU (third table in lab2)

# Logic Shift left
force -freeze sim:/alu/S 1000 0
run

# Rotate Left
force -freeze sim:/alu/S 1001 0
run

# Rotate Left with Cin
force -freeze sim:/alu/S 1010 0
force -freeze sim:/alu/Cin 0 0
run

# F = Zero
force -freeze sim:/alu/S 1011 0
run

# Logic Shift Right
force -freeze sim:/alu/S 1100 0
run

# Rotate Right
force -freeze sim:/alu/S 1101 0
run

# Rotate right With Cin
force -freeze sim:/alu/S 1110 0
run

# Arithmetic Shift Right
force -freeze sim:/alu/S 1111 0
run

# Rotate Left with Cin
force -freeze sim:/alu/S 1010 0
force -freeze sim:/alu/Cin 1 0
run

# Rotate right with Cin
force -freeze sim:/alu/S 1110 0
run


wave zoom full