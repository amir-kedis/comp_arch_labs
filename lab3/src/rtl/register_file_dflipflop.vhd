library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file_dflipflop is
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
end entity register_file_dflipflop;

-- NOTE: Combining all lanes we get:
-- DATA BUS = 8 bits * 3 lanes = 24 bits
-- ADDRESS BUS = 3 bits * 3 lanes = 9 bits

architecture register_file_dflipflop_struct_arch of register_file_dflipflop is
  component dflipflop is
    generic (
      n : integer := 8
    );

    port ( Clk, Rst : in std_logic;
           d : in std_logic_vector(n-1 downto 0);
           q : out std_logic_vector(n-1 downto 0));
  end component dflipflop;


  type register_file_type is array (0 to 7) of std_logic_vector(7 downto 0);
  signal reg_inputs, reg_outputs : register_file_type;
  signal reg_resets : std_logic_vector(7 downto 0);
begin
  
  gen_registers: for i in 0 to 7 generate
    dflipflop_inst: dflipflop port map (
      clk   => clk,
      Rst   => reg_resets(i),
      d     => reg_inputs(i),
      q     => reg_outputs(i)
    );
  end generate gen_registers;

  process(clk, reset, write_enable, write_address, write_data, reg_outputs)
  begin
    reg_inputs <= reg_outputs;
    reg_resets <= (others => reset);

    if write_enable = '1' then
      reg_inputs(to_integer(unsigned(write_address))) <= write_data;
    end if;
  end process;

  read_data_0 <= reg_outputs(to_integer(unsigned(read_address_0)));
  read_data_1 <= reg_outputs(to_integer(unsigned(read_address_1)));

end architecture register_file_dflipflop_struct_arch;
