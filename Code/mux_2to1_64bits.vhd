library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity mux_2to1_64bits is
    Port ( in1 : in STD_LOGIC_VECTOR (63 downto 0);
           in2 : in STD_LOGIC_VECTOR (63 downto 0);
           s : in STD_LOGIC;
           outp : out STD_LOGIC_VECTOR (63 downto 0));
end mux_2to1_64bits;

architecture Behavioral of mux_2to1_64bits is

begin

outp <= in1 when s = '0' else in2;

end Behavioral;
