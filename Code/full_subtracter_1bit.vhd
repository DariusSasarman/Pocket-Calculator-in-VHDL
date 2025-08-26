library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity full_subtracter_1bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           bin : in STD_LOGIC;
           bout : out STD_LOGIC;
           d : out STD_LOGIC);
end full_subtracter_1bit;

architecture Behavioral of full_subtracter_1bit is

begin

d <= a xor b xor bin;
bout <= (not (a xor b) and bin) or (not a and b);

end Behavioral;
