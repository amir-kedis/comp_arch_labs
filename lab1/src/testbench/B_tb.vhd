library IEEE;
use IEEE.STD_logic_1164.ALL;

entity B_tb is
  -- empty
end B_tb;

architecture ArchB_tb of B_tb is

component B is 
    port (
        A     : in  std_logic_vector (7 downto 0) ;
        B     : in  std_logic_vector (7 downto 0) ;
        Cin   : in  std_logic                     ;
        S     : in  std_logic_vector (3 downto 0) ;
        F     : out std_logic_vector (7 downto 0) ;
        Cout  : out std_logic                     
    ) ;
end component;

-- signals are just wires
    signal A_sig, B_sig, F_sig : std_logic_vector(7 downto 0);
    signal Cin_sig, Cout_sig   : std_logic;
    signal S_sig               : std_logic_vector(3 downto 0);

begin
    
-- device under test 
    DUT: B port map (A_sig, B_sig, Cin_sig, S_sig, F_sig, Cout_sig);

    testing_partB : process
    begin

        -- we have 4 test cases
        -- we can specifiy a base for integers using
        -- base#value#
        -- normal quotations "1010101" is just a vector of bits
        -- but what we have here is indeed a vector of bits

        -- XOR
        S_sig <= "0100";
        A_sig <= "11110000";
        B_sig <= "10110000";
        wait for 1 ns; -- and check the output F=40 and Cout=0

        -- NAND
        S_sig <= "0101";
        A_sig <= "11110000";
        B_sig <= "00001011";
        wait for 1 ns; -- and check the output F=FF and Cout=0

        -- OR
        S_sig <= "0110";
        A_sig <= "11110000";
        B_sig <= "10110000";
        wait for 1 ns; -- and check the output F=F0 and Cout=0

        -- NOT
        S_sig <= "0111";
        A_sig <= "11110000";
        wait for 1 ns; -- and check the output F=0F and Cout=0
        
        wait; -- do not close the simulation

    end process ; -- testing_partB

end ArchB_tb ; -- ArchB_tb