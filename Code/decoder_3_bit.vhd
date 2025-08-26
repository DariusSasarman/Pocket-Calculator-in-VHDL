library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity decoder_3_bit is
    Port ( inp : in STD_LOGIC_VECTOR (2 downto 0);
           outp : out STD_LOGIC_VECTOR (7 downto 0));
end decoder_3_bit;

architecture Behavioral of decoder_3_bit is

begin

outp(0) <= '0' when inp = "000" else '1';
outp(1) <= '0' when inp = "001" else '1';
outp(2) <= '0' when inp = "010" else '1';
outp(3) <= '0' when inp = "011" else '1';
outp(4) <= '0' when inp = "100" else '1';
outp(5) <= '0' when inp = "101" else '1';
outp(6) <= '0' when inp = "110" else '1';
outp(7) <= '0' when inp = "111" else '1';

end Behavioral;
