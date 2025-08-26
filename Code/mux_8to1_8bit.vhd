library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity mux_8to1_8bit is
    Port ( inp : in STD_LOGIC_VECTOR (63 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0);
           outp : out STD_LOGIC_VECTOR (7 downto 0));
end mux_8to1_8bit;
architecture Behavioral of mux_8to1_8bit is
begin
outp <= inp(7 downto 0)   when s = "000" else
        inp(15 downto 8)  when s = "001" else
        inp(23 downto 16) when s = "010" else
        inp(31 downto 24) when s = "011" else
        inp(39 downto 32) when s = "100" else
        inp(47 downto 40) when s = "101" else
        inp(55 downto 48) when s = "110" else
        inp(63 downto 56) when s = "111";
end Behavioral;
