library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity B is
  generic (
    N : integer := 8
  );
  port (
    A     : in  std_logic_vector (N-1 downto 0) ;
    B     : in  std_logic_vector (N-1 downto 0) ;
    Cin   : in  std_logic                     ;
    S     : in  std_logic_vector (3 downto 0) ;
    F     : out std_logic_vector (N-1 downto 0) ;
    Cout  : out std_logic                     
  ) ;
end B ;

architecture ArchB of B is



begin


  F <= A xor B  when S = "0100" else
       A nand B when S = "0101" else
       A or B   when S = "0110" else
       not A    when S = "0111" else
       (others => '0');
  
  Cout <= '0';

  -- NOTE: THIS CODE IS NOT WORKING )X
  -- if (S = "0100") then
  --   F <= A xor B;
  --   Cout <= "0";
  -- elsif (S = "0101") then
  --   F <= A nand B;
  --   Cout <= "0";
  -- elsif (S = "0110") then
  --   F <= A or B;
  --   Cout <= "0";
  -- elsif (S = "0111") then
  --   F <= not A;
  --   Cout <= "0";
  -- else
  --   F <= (others => '0'); -- NOTE: output F is all zeros otherwise
  --   Cout <= "1";
  -- end if;


end architecture ; -- ArchB