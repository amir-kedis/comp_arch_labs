library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C is
  generic (
    N : integer := 8
  );
  port (
    A       : in std_logic_vector (N-1 downto 0);
    B       : in std_logic_vector (N-1 downto 0);
    Cin     : in std_logic;
    S       : in std_logic_vector (3 downto 0);
    F       : out std_logic_vector (N-1 downto 0);
    Cout    : out std_logic
  ) ;
end C;

architecture ArchC of C is

begin

    F <= A (N-2 downto 0) & "0"   when S = "1000" else
         A (N-2 downto 0) & A(N-1)  when S = "1001" else
         A (N-2 downto 0) & Cin   when S = "1010" else
        (others  => '0');   

    Cout <= A(N-1) when S = "1000" else
            A(N-1) when S = "1001" else
            A(N-1) when S = "1010" else
            '0';
          
end ArchC ; -- ArchC