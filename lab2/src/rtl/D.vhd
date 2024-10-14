library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D is
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
end D ;

architecture ArchD of D is



begin


  F <= '0'    & A(N-1 downto 1)   when S = "1100" else -- Logic Shift Right A, Cout = shifted bit
        A(0)  & A(N-1 downto 1)   when S = "1101" else -- Rotate Right A, Cout = rotated bit
        Cin   & A(N-1 downto 1)   when S = "1110" else -- Rotate Right A with carry, Cout = rotated bit
        A(N-1)  & A(N-1 downto 1)   when S = "1111" else -- Arithmetic Shift A
       (others => '0');

  Cout <= A(0) when S = "1100" else -- Logic Shift Right A, Cout = shifted bit
          A(0) when S = "1101" else -- Rotate Right A, Cout = rotated bit
          A(0) when S = "1110" else -- Rotate Right A with carry, Cout = rotated bit
          '0'  when S = "1111" else -- Arithmetic Shift A, Cout = 0
          '0';

end architecture ; -- ArchD
