library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity seven_seg_displayer is
    Port ( info : in STD_LOGIC_VECTOR (63 downto 0);
           state : in STD_LOGIC_VECTOR (2 downto 0);
           digit_info : out STD_LOGIC_VECTOR (7 downto 0);
           anodes : out STD_LOGIC_VECTOR (7 downto 0));
end seven_seg_displayer;

architecture Behavioral of seven_seg_displayer is

component mux_8to1_8bit is
    Port ( inp : in STD_LOGIC_VECTOR (63 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0);
           outp : out STD_LOGIC_VECTOR (7 downto 0));
end component mux_8to1_8bit;

component decoder_3_bit is
    Port ( inp : in STD_LOGIC_VECTOR (2 downto 0);
           outp : out STD_LOGIC_VECTOR (7 downto 0));
end component decoder_3_bit;

begin
c0: decoder_3_bit port map (inp => state, outp => anodes);
c1: mux_8to1_8bit port map ( inp => info, s => state, outp => digit_info);
end Behavioral;
