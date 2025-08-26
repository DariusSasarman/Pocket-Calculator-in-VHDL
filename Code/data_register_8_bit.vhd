library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity data_register_8_bit is
    Port ( Load : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Load_inp : in STD_LOGIC_VECTOR (7 downto 0);
           Outp : out STD_LOGIC_VECTOR (7 downto 0));
end data_register_8_bit;

architecture Behavioral of data_register_8_bit is

signal info : std_logic_vector ( 7 downto 0) := x"00";

begin

Outp <= info;

process (Load,Clk,Rst)
begin
    if rising_edge(clk) then   
        if Rst = '1' then
            info <= x"00";
        elsif Load = '1' then
            info <= Load_inp;
        else
            info <= info;
        end if;
    end if;
end process;

end Behavioral;
