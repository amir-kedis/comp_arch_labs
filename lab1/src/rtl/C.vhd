library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C is
  port (
    A       : in std_logic_vector (7 downto 0);
    B       : in std_logic_vector (7 downto 0);
    Cin     : in std_logic;
    S       : in std_logic_vector (3 downto 0);
    F       : out std_logic_vector (7 downto 0);
    Cout    : out std_logic
  ) ;
end C;

architecture ArchC of C is

begin

    F <= A (6 downto 0) & "0"   when S = "1000" else
         A (6 downto 0) & A(7)  when S = "1001" else
         A (6 downto 0) & Cin   when S = "1010" else
         "00000000"             when S = "1011" else
        (others  => '0');   

    Cout <= A(7) when S = "1000" else
            A(7) when S = "1001" else
            A(7) when S = "1010" else
            '0'  when S = "1011";
            
            -- The line below causes an error:
            -- Aggregate expression cannot be scalar type ieee.std_logic_1164.STD_LOGIC.
            -- (others => '0'); 

end ArchC ; -- ArchC