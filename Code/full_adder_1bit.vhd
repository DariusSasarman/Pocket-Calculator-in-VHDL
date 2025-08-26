library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_1bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC);
end full_adder_1bit;

architecture Behavioral of full_adder_1bit is

begin

S <= a xor b xor Cin;
Cout <= (a and b) or (a and Cin) or (b and Cin);

end Behavioral;
