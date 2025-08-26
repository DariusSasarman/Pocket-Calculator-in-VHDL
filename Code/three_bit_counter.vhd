library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity three_bit_counter is
    Port ( 
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        outp : out STD_LOGIC_VECTOR (2 downto 0));
end three_bit_counter;
architecture Behavioral of three_bit_counter is
    signal state: unsigned(2 downto 0) := "000";
    signal counter : unsigned(16 downto 0) := (others => '0'); 
    constant divider: integer := 100000; 
begin
    outp <= std_logic_vector(state);
    process(clk, rst)
    begin
        if rst = '1' then
            state <= "000";
            counter <= (others => '0');
        elsif rising_edge(clk) then
            if counter = divider - 1 then
                counter <= (others => '0');
                state <= state + 1;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
end Behavioral;