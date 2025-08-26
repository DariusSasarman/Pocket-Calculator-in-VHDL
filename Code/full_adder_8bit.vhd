library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity full_adder_8bit is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end full_adder_8bit;

architecture Behavioral of full_adder_8bit is

component full_adder_1bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC);
end component full_adder_1bit;

signal inside_carries : std_logic_vector (8 downto 0);

begin

inside_carries(0) <= Cin;

adders: for i in 0 to 7 generate
    adder: full_adder_1bit port map ( a => A(i), b=> B(i),
                                      cin => inside_carries(i), cout => inside_carries(i+1),
                                      S => S(i));
end generate;

Cout <= inside_carries(8);

end Behavioral;
