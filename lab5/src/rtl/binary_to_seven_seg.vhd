library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity binary_to_seven_seg is
  port (
    num : in std_logic_vector(3 downto 0);
    a : out std_logic;
    b : out std_logic;
    c : out std_logic;
    d : out std_logic;
    e : out std_logic;
    f : out std_logic;
    g : out std_logic
  ) ;
end binary_to_seven_seg;

architecture Behavioral of binary_to_seven_seg is
begin

process( num )
begin

case( num ) is

    when "0000" =>
        a <= '1';
        b <= '1';
        c <= '1';
        d <= '1';
        e <= '1';
        f <= '1';
        g <= '0';
    when "0001" =>
        a <= '0';
        b <= '1';
        c <= '1';
        d <= '0';
        e <= '0';
        f <= '0';
        g <= '0';
    when "0010" =>
        a <= '1';
        b <= '1';
        c <= '0';
        d <= '1';
        e <= '1';
        f <= '0';
        g <= '1';
    when "0011" =>
        a <= '1';
        b <= '1';
        c <= '1';
        d <= '1';
        e <= '0';
        f <= '0';
        g <= '1';
    when "0100" =>
        a <= '0';
        b <= '1';
        c <= '1';
        d <= '0';
        e <= '0';
        f <= '1';
        g <= '1';
    when "0101" =>
        a <= '1';
        b <= '0';
        c <= '1';
        d <= '1';
        e <= '0';
        f <= '1';
        g <= '1';
    when "0110" =>
        a <= '1';
        b <= '0';
        c <= '1';
        d <= '1';
        e <= '1';
        f <= '1';
        g <= '1';
    when "0111" =>
        a <= '1';
        b <= '1';
        c <= '1';
        d <= '0';
        e <= '0';
        f <= '0';
        g <= '0';
    when "1000" =>
        a <= '1';
        b <= '1';
        c <= '1';
        d <= '1';
        e <= '1';
        f <= '1';
        g <= '1';
    when "1001" =>
        a <= '1';
        b <= '1';
        c <= '1';
        d <= '1';
        e <= '0';
        f <= '1';
        g <= '1';
    when others =>
        a <= '0';
        b <= '0';
        c <= '0';
        d <= '0';
        e <= '0';
        f <= '0';
        g <= '0';

end case;

end process;

end Behavioral ; -- Behavioral