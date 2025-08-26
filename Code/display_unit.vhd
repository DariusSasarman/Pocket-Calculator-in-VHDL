library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display_unit is
    Port ( no1 : in STD_LOGIC_VECTOR (7 downto 0);
           no2 : in STD_LOGIC_VECTOR (7 downto 0);
           rez : in STD_LOGIC_VECTOR (63 downto 0);
           s : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           digit_info : out STD_LOGIC_VECTOR (7 downto 0);
           anode_info : out STD_LOGIC_VECTOR (7 downto 0));
end display_unit;

architecture Behavioral of display_unit is
component Eight_bit_twos_complement_to_seven_seg_display is
    Port ( number : in STD_LOGIC_VECTOR (7 downto 0);
           display : out STD_LOGIC_VECTOR (31 downto 0));
end component Eight_bit_twos_complement_to_seven_seg_display;
component mux_2to1_64bits is
    Port ( in1 : in STD_LOGIC_VECTOR (63 downto 0);
           in2 : in STD_LOGIC_VECTOR (63 downto 0);
           s : in STD_LOGIC;
           outp : out STD_LOGIC_VECTOR (63 downto 0));
end component mux_2to1_64bits;
component three_bit_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           outp : out STD_LOGIC_VECTOR (2 downto 0));
end component three_bit_counter;
component seven_seg_displayer is
    Port ( info : in STD_LOGIC_VECTOR (63 downto 0);
           state : in STD_LOGIC_VECTOR (2 downto 0);
           digit_info : out STD_LOGIC_VECTOR (7 downto 0);
           anodes : out STD_LOGIC_VECTOR (7 downto 0));
end component seven_seg_displayer;
signal rn1_concat_rn2 : std_logic_vector (63 downto 0);
signal n1 : STD_LOGIC_VECTOR (7 downto 0);
signal n2 : STD_LOGIC_VECTOR (7 downto 0);
signal decision : std_logic_vector (63 downto 0);
signal state_cnt : std_logic_vector (2 downto 0);
begin
n1 <= no1;
n2 <= no2;
c0: Eight_bit_twos_complement_to_seven_seg_display port map ( number => n1,
                                 display => rn1_concat_rn2 (63 downto 32));
c1: Eight_bit_twos_complement_to_seven_seg_display port map ( number => n2,
                                 display => rn1_concat_rn2 (31 downto 0));
c3: mux_2to1_64bits port map ( in1 => rez , in2 => rn1_concat_rn2 ,
                               s => s, outp => decision);
c4: three_bit_counter port map ( clk =>clk, rst => rst, outp => state_cnt);
c7: seven_seg_displayer port map ( info => decision, state => state_cnt,
                                   digit_info => digit_info, anodes => anode_info);
end Behavioral;
