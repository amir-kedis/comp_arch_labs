library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider_tb is
end clock_divider_tb;

architecture clock_divider_tb_arch of clock_divider_tb is
  constant CLK_FREQ      : integer := 50_000_000;
  constant CLK_PERIOD    : time := 20 ns; -- 50 MHz

  signal clk     : std_logic := '0';
  signal rst     : std_logic := '1';
  signal enable  : std_logic;

begin
  uut: entity work.clock_divider
    generic map (
      CLK_FREQ => CLK_FREQ
    )
    port map (
      clk     => clk,
      rst     => rst,
      enable  => enable
    );

  clk_process : process
  begin
    clk <= '0';
    wait for CLK_PERIOD / 2;
    clk <= '1';
    wait for CLK_PERIOD / 2;
  end process;

  stimulus_process : process
  begin
    rst <= '1';
    wait for 100 ns;
    rst <= '0';

    wait for 5 * CLK_FREQ * CLK_PERIOD; -- 5 seconds simulated

    wait;
  end process;

end clock_divider_tb_arch ;
