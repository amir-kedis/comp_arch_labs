library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity dflipflop is
  generic (
    n : integer := 8
  );
  port (
    Clk, Rst : in std_logic;
    d : in std_logic_vector(n-1 downto 0);
    q : out std_logic_vector(n-1 downto 0)
  );
end entity dflipflop;


architecture rtl of dflipflop is
begin
  process (Clk, Rst)
  begin
    if Rst = '1' then
      q <= (others => '0');
    elsif rising_edge(Clk) then
      q <= d;
    end if;
  end process;
end architecture rtl;
