library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elevator_ctrl_tb is
end entity elevator_ctrl_tb;

architecture testbench of elevator_ctrl_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component elevator_ctrl
        generic(
            NUM_FLOORS  : integer := 10;
            FLOOR_BITS  : integer := 4;
            CLK_FREQ    : integer := 50
        );
        port(
            clk           : in  std_logic;
            rst           : in  std_logic;
            floor_request : in  std_logic_vector(NUM_FLOORS - 1 downto 0);
            current_floor : out unsigned(FLOOR_BITS - 1 downto 0);
            moving_up     : out std_logic;
            moving_down   : out std_logic;
            door_open     : out std_logic
        );
    end component;

    -- Testbench signals
    signal clk           : std_logic := '0';
    signal rst           : std_logic := '0';
    signal floor_request : std_logic_vector(9 downto 0) := (others => '0');
    signal current_floor : unsigned(3 downto 0);
    signal moving_up     : std_logic;
    signal moving_down   : std_logic;
    signal door_open     : std_logic;

    -- Clock period definition
    constant clk_period : time := 20 ns;
    constant request_setup_time : time := 500 ns;
    constant between_tests_delay : time := 5000 ns;
    constant move_one_floor_time : time := 2000 ns;

    procedure print_report is
        begin
            report "current_floor=" & integer'image(to_integer(current_floor)) & 
                   " open=" & std_logic'image(door_open) & 
                   " mv_up=" & std_logic'image(moving_up) & 
                   " mv_dn=" & std_logic'image(moving_down) severity note;
        end procedure;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: elevator_ctrl
        generic map (
            NUM_FLOORS => 10,
            FLOOR_BITS => 4,
            CLK_FREQ   => 50
        )
        port map (
            clk           => clk,
            rst           => rst,
            floor_request => floor_request,
            current_floor => current_floor,
            moving_up     => moving_up,
            moving_down   => moving_down,
            door_open     => door_open
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        rst <= '1';
        floor_request <= "0000000000"; -- reset request
        wait for 2000 ns;
        rst <= '0';
        wait for 2000 ns;

        -- Resuest 1
        floor_request <= "0000000010"; -- Request at floor 1
        wait for request_setup_time;
        floor_request <= "0000000000"; -- reset request
        wait for move_one_floor_time * 1.2;
        print_report;
        if (current_floor = to_unsigned(1, 4) and moving_up = '0' 
        and moving_down = '0' and door_open = '1') then
            report "1 Pass";
        else
            report "1 Fail" severity error;
        end if;

        wait for between_tests_delay;

        -- Request 2
        floor_request <= "0000100000"; -- Request at floor 4
        wait for request_setup_time;
        floor_request <= "0000000000"; -- reset request
        wait for move_one_floor_time * 3.6;
        print_report;
        if (current_floor = to_unsigned(5, 4) and moving_up = '0' 
        and moving_down = '0' and door_open = '1') then
            report "2 Pass";
        else
            report "2 Fail" severity error;
        end if;
        
        wait for between_tests_delay;

        -- Request 3
        floor_request <= "0000000100"; -- Request at floor 2
        wait for request_setup_time;
        floor_request <= "0000000000"; -- reset request
        wait for move_one_floor_time * 2.6;
        print_report;
        if (current_floor = to_unsigned(2, 4) and moving_up = '0' 
        and moving_down = '0' and door_open = '1') then
            report "3 Pass";
        else
            report "3 Fail" severity error;
        end if;
        
        wait for between_tests_delay;
        
        -- Request 4
        floor_request <= "1000010000"; -- Request at floor 4, 9
        wait for request_setup_time;
        floor_request <= "0000000000"; -- reset request
        wait for move_one_floor_time * 2.5; -- to reach floor 4
        print_report;
        if (current_floor = to_unsigned(4, 4) and moving_up = '0' 
        and moving_down = '0' and door_open = '1') then
            report "4 Pass";
        else
            report "4 Fail" severity error;
        end if;

        wait for move_one_floor_time * 5.5; -- to reach floor 9
        print_report;
        if (current_floor = to_unsigned(9, 4) and moving_up = '0' 
        and moving_down = '0' and door_open = '1') then
            report "5 Pass";
        else
            report "5 Fail" severity error;
        end if;

        wait for between_tests_delay;

        -- Request 5
        floor_request <= "0010001001"; -- Request at floor 3, 7
        wait for request_setup_time;
        floor_request <= "0000000000"; -- reset request
        wait for move_one_floor_time * 2; -- to reach floor 7
        print_report;
        if (current_floor = to_unsigned(7, 4) and moving_up = '0' 
        and moving_down = '0' and door_open = '1') then
            report "6 Pass";
        else
            report "6 Fail" severity error;
        end if;

        wait for move_one_floor_time * 4.5; -- to reach floor 3
        print_report;
        if (current_floor = to_unsigned(3, 4) and moving_up = '0' 
        and moving_down = '0' and door_open = '1') then
            report "7 Pass";
        else
            report "7 Fail" severity error;
        end if;

        wait for move_one_floor_time * 4; -- to reach floor 3
        print_report;
        if (current_floor = to_unsigned(0, 4) and moving_up = '0' 
        and moving_down = '0' and door_open = '1') then
            report "8 Pass";
        else
            report "8 Fail" severity error;
        end if;

        -- End simulation
        wait;
    end process;

end architecture testbench;