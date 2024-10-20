library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library STD;
use STD.ENV.STOP;

entity register_file_tb is
    --empty
end register_file_tb;


architecture register_file_tb_arch of register_file_tb is

  component register_file_mem is
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
  end component;
  
  signal clk_sig : std_logic := '0';
  signal reset_sig, write_enable_sig : std_logic;
  signal write_address_sig, read_address_0_sig, read_address_1_sig : std_logic_vector(2 downto 0);
  signal write_data_sig, read_data_0_sig, read_data_1_sig : std_logic_vector(7 downto 0);

begin


  DUT: register_file_mem port map (
    clk               => clk_sig,
    reset             => reset_sig,
    write_enable      => write_enable_sig,
    write_address     => write_address_sig,
    write_data        => write_data_sig,
    read_address_0    => read_address_0_sig,
    read_address_1    => read_address_1_sig,
    read_data_0       => read_data_0_sig,
    read_data_1       => read_data_1_sig
  );


  clk_sig <= not clk_sig after 5 ns;

  testing_register_file : process
  begin
    
    -- test case 1
    reset_sig           <= '1';
    write_enable_sig    <= '0';
    write_address_sig   <= "000";
    write_data_sig      <= x"00";
    read_address_0_sig  <= "000";
    read_address_1_sig  <= "000";
    wait for 10 ns;
    if (read_data_0_sig = x"00") and (read_data_1_sig = x"00") then 
      report "Test case 1 Passed" severity note;
    else
      report "FAILED test case 1" severity error;
    end if;


    -- test case 2: write in Reg(0) 0xFF
    reset_sig <= '0';
    write_enable_sig    <= '1';
    write_address_sig   <= "000";
    write_data_sig      <= x"FF";
    wait for 10 ns;
    if (read_data_0_sig = x"FF") and (read_data_1_sig = x"FF") then 
      report "Test case 2 Passed" severity note;
    else
      report "FAILED test case 2" severity error;
    end if;


    -- testcase 3: write in reg(1) 0x11
    write_address_sig   <= "001";
    write_data_sig      <= x"11";
    wait for 10 ns;
    if (read_data_0_sig = x"FF") and (read_data_1_sig = x"FF") then 
      report "Test case 3 Passed" severity note;
    else
      report "FAILED test case 3" severity error;
    end if;


    -- testcase 4: write in reg(7) 0x90
    write_address_sig   <= "111";
    write_data_sig      <= x"90";
    wait for 10 ns;
    if (read_data_0_sig = x"FF") and (read_data_1_sig = x"FF") then 
      report "Test case 4 Passed" severity note;
    else
      report "FAILED test case 4" severity error;
    end if;


    -- testcase 5: write in reg(3) 0x08
    write_address_sig   <= "011";
    write_data_sig      <= x"08";
    wait for 10 ns;
    if (read_data_0_sig = x"FF") and (read_data_1_sig = x"FF") then 
      report "Test case 5 Passed" severity note;
    else
      report "FAILED test case 5" severity error;
    end if;

    -- testcase 6: read reg1 on port 0, reg7 on port 1, write 0x03 to reg4
    read_address_0_sig  <= "001";
    read_address_1_sig  <= "111";
    write_address_sig   <= "100";
    write_data_sig      <= x"03";
    wait for 10 ns;
    if (read_data_0_sig = x"11") and (read_data_1_sig = x"90") then 
      report "Test case 6 Passed" severity note;
    else
      report "FAILED test case 6" severity error;
    end if;


    -- testcase 7: read reg2 on port 0, reg3 on port 1
    write_enable_sig    <= '0';
    read_address_0_sig  <= "010";
    read_address_1_sig  <= "011";
    wait for 10 ns;
    if (read_data_0_sig = x"00") and (read_data_1_sig = x"08") then 
      report "Test case 7 Passed" severity note;
    else
      report "FAILED test case 7" severity error;
    end if;


    -- testcase 8: read reg4 on port 0, reg5 on port 1
    read_address_0_sig  <= "100";
    read_address_1_sig  <= "101";
    wait for 10 ns;
    if (read_data_0_sig = x"03") and (read_data_1_sig = x"00") then 
      report "Test case 8 Passed" severity note;
    else
      report "FAILED test case 8" severity error;
    end if;


    -- testcase 9: read reg6 on port 0, reg0 on port 1, write 0x01 to reg0
    read_address_0_sig  <= "110";
    read_address_1_sig  <= "000";
    write_enable_sig    <= '1';
    write_address_sig   <= "000";
    write_data_sig      <= x"01";
    wait for 10 ns;
    if (read_data_0_sig = x"00") and (read_data_1_sig = x"01") then 
      report "Test case 9 Passed" severity note;
    else
      report "FAILED test case 9" severity error;
    end if;

    stop; -- stop the simulation

  end process ; -- testing_register_file

end register_file_tb_arch ; -- arch_register_file_tb_arch