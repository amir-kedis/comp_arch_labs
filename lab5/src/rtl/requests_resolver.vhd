library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity request_resolver is
    generic (
        NUM_FLOORS : integer := 10;    -- Total number of floors (0-9)
        FLOOR_BITS : integer := 4      -- Bits needed to represent floor number
    );
    port (
        clk              : in  std_logic;
        rst              : in  std_logic;
        -- Input requests and current state
        floor_request    : in  std_logic_vector(NUM_FLOORS-1 downto 0);
        current_floor    : in  unsigned(FLOOR_BITS-1 downto 0);
        moving_up        : in  std_logic;
        moving_down      : in  std_logic;
        is_idle         : in  std_logic;
        -- Output signals
        target_floor     : out unsigned(FLOOR_BITS-1 downto 0);
        request_valid    : out std_logic;
        suggest_direction : out std_logic
    );
end request_resolver;

architecture Behavioral of request_resolver is
    -- Internal signals for request tracking
    signal request_reg : std_logic_vector(NUM_FLOORS-1 downto 0);
    
    -- Function to check if there are any requests above current floor
    function has_requests_above(requests: std_logic_vector; curr_floor: integer) return boolean is
    begin
        for i in curr_floor + 1 to requests'high loop
            if requests(i) = '1' then
                return true;
            end if;
        end loop;
        return false;
    end function;
    
    -- Function to check if there are any requests below current floor
    function has_requests_below(requests: std_logic_vector; curr_floor: integer) return boolean is
    begin
        for i in 0 to curr_floor - 1 loop
            if requests(i) = '1' then
                return true;
            end if;
        end loop;
        return false;
    end function;
    
    -- Function to find next request in upward direction
    function find_next_up_request(requests: std_logic_vector; curr_floor: integer) 
    return integer is
    begin
        for i in curr_floor + 1 to requests'high loop
            if requests(i) = '1' then
                return i;
            end if;
        end loop;
        return curr_floor;  -- Return current floor if no requests found
    end function;
    
    -- Function to find next request in downward direction
    function find_next_down_request(requests: std_logic_vector; curr_floor: integer) 
    return integer is
    begin
        for i in curr_floor - 1 downto 0 loop
            if requests(i) = '1' then
                return i;
            end if;
        end loop;
        return curr_floor;  -- Return current floor if no requests found
    end function;
    
begin
    -- Main request resolution process
    process(clk, rst)
        variable next_target : integer;
        variable has_request : boolean;
        variable current_floor_int : integer;
    begin
        if rst = '1' then
            target_floor <= (others => '0');
            request_valid <= '0';
            suggest_direction <= '0';
            
        elsif rising_edge(clk) then
            current_floor_int := to_integer(current_floor);
            has_request := false;
            
            -- Check if there's a request at current floor
            if floor_request(current_floor_int) = '1' then
                next_target := current_floor_int;
                has_request := true;
                
            -- If moving up or idle, check requests above first
            elsif moving_up = '1' or is_idle = '1' then
                -- Check for requests above current floor
                if has_requests_above(floor_request, current_floor_int) then
                    next_target := find_next_up_request(floor_request, current_floor_int);
                    has_request := true;
                    suggest_direction <= '1';
                -- If no requests above, check below
                elsif has_requests_below(floor_request, current_floor_int) then
                    next_target := find_next_down_request(floor_request, current_floor_int);
                    has_request := true;
                    suggest_direction <= '0';
                end if;
                
            -- If moving down, check requests below first
            elsif moving_down = '1' then
                -- Check for requests below current floor
                if has_requests_below(floor_request, current_floor_int) then
                    next_target := find_next_down_request(floor_request, current_floor_int);
                    has_request := true;
                    suggest_direction <= '0';
                -- If no requests below, check above
                elsif has_requests_above(floor_request, current_floor_int) then
                    next_target := find_next_up_request(floor_request, current_floor_int);
                    has_request := true;
                    suggest_direction <= '1';
                end if;
            end if;
            
            -- Update outputs
            if has_request then
                target_floor <= to_unsigned(next_target, FLOOR_BITS);
                request_valid <= '1';
            else
                request_valid <= '0';
            end if;
        end if;
    end process;
    
end Behavioral;