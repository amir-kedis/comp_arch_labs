library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_tb is
  -- empty
end ALU_tb;

architecture ArchALU_tb of ALU_tb is

    component ALU is
        port (
            A_IN : in  std_logic_vector(7 downto 0);
            B_IN : in  std_logic_vector(7 downto 0);
            Cin  : in  std_logic                   ;
            S    : in  std_logic_vector(3 downto 0);
            F    : out std_logic_vector(7 downto 0);
            Cout : out std_logic
        );
    end component;

    signal A_IN_sig, B_IN_sig, F_sig : std_logic_vector(7 downto 0);
    signal Cin_sig, Cout_sig : std_logic;
    signal S_sig : std_logic_vector (3 downto 0);

begin

-- conventional label is DUT for device under test
-- or UUT for unit under test
-- or we can call it bofteka if we want

bofteka: ALU port map(A_IN_sig, B_IN_sig, Cin_sig, S_sig, F_sig, Cout_sig); 

    testing_ALU : process
    begin
        -- we have 10 test cases
        -- all of them have A = F0 so I will force it only once in the beginning
        -- and B is always undefined
        
        A_IN_sig <= "11110000";
        
        -- test case 1: logic shift left
        S_sig <= "1000";
        wait for 1 ns; -- and check output F=E0 and Cout=1

        -- test case 2: rotate left
        S_sig <= "1001";
        wait for 1 ns; -- and check output F=E1 and Cout=1

        -- test case 3: rotate left with cin
        S_sig <= "1010";
        Cin_sig <= '0';
        wait for 1 ns; -- and check output F=E0 and Cout=1

        -- test case 4: F = 0
        S_sig <= "1011";
        wait for 1 ns; -- and check output F=00 and Cout=0

        -- test case 5: logic shift right
        S_sig <= "1100";
        wait for 1 ns; -- and check output F=78 and Cout=0

        -- test case 6: rotate right
        S_sig <= "1101";
        wait for 1 ns; -- and check output F=78 and Cout=0

        -- test case 7: rotate right with cin
        S_sig <= "1110";
        Cin_sig <= '0';
        wait for 1 ns; -- and check output F=78 and Cout=0

        -- test case 8: arithmetic shift right
        S_sig <= "1111";
        wait for 1 ns; -- and check output F=F8 and Cout=0

        -- test case 9: rotate left with cin
        S_sig <= "1010";
        Cin_sig <= '1';
        wait for 1 ns; -- and check output F=E1 and Cout=1

        -- test case 10: rotate right with cin
        S_sig <= "1110";
        Cin_sig <= '1';
        wait for 1 ns; -- and check output F=F8 and Cout=0

        wait; -- do not close the simulation

    end process ; -- testing_ALU

end ArchALU_tb ; -- ArchALU_tb