library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file_mem is
  port (
    clk             : in   std_logic;
    reset           : in   std_logic;
    write_enable    : in   std_logic;
    write_address   : in   std_logic_vector(2 downto 0);
    write_data      : in   std_logic_vector(7 downto 0);
    read_address_0  : in   std_logic_vector(2 downto 0); -- ADDRESS BUS SIZE = 3 bits per lane
    read_address_1  : in   std_logic_vector(2 downto 0);
    read_data_0     : out  std_logic_vector(7 downto 0); -- DATA BUS SIZE = 8 bits per lane
    read_data_1     : out  std_logic_vector(7 downto 0)
  );
end entity register_file_mem;

-- NOTE: Combining all lanes we get:
-- DATA BUS = 8 bits * 3 lanes = 24 bits
-- ADDRESS BUS = 3 bits * 3 lanes = 9 bits

architecture register_file_mem_behav_arch of register_file_mem is
  type register_file_type is array (0 to 7) of std_logic_vector(7 downto 0);
  signal register_file : register_file_type;
begin
  process(clk, reset)
  begin
    if reset = '1' then
      for i in 0 to 7 loop
        register_file(i) <= (others => '0');
      end loop;
    elsif rising_edge(clk) then
      if write_enable = '1' then
        register_file(to_integer(unsigned(write_address))) <= write_data;
      end if;
    end if;
  end process;

  read_data_0 <= register_file(to_integer(unsigned(read_address_0)));
  read_data_1 <= register_file(to_integer(unsigned(read_address_1)));
end architecture register_file_mem_behav_arch ;

