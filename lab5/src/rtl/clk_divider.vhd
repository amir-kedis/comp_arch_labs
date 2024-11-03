library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider is
  generic (
    CLK_FREQ      : integer := 50_000_000
  );
  port (
    clk           : in  std_logic;
    rst           : in  std_logic;
    enable        : out std_logic
  );
end clock_divider;

architecture rtl of clock_divider is
  constant ONE_SECOND : integer := CLK_FREQ - 1;
  signal counter : integer range 0 to ONE_SECOND;

begin
  process(clk, rst)
  begin
    if rst = '1' then
      counter <= 0;
      enable <= '0';
    elsif rising_edge(clk) then
      enable <= '0';
      if counter = ONE_SECOND then
        counter <= 0;
        enable <= '1';
      else
        counter <= counter + 1;
      end if;
    end if;
  end process;
end rtl;
