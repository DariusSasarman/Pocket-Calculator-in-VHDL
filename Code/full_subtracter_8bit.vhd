library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_subtracter_8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           bin : in STD_LOGIC;
           bout : out STD_LOGIC;
           d : out STD_LOGIC_VECTOR (7 downto 0));
end full_subtracter_8bit;

architecture Behavioral of full_subtracter_8bit is

component full_subtracter_1bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           bin : in STD_LOGIC;
           bout : out STD_LOGIC;
           d : out STD_LOGIC);
end component full_subtracter_1bit;

signal inside_borrows : std_logic_vector (8 downto 0);

begin

inside_borrows(0) <= bin;
borrows: for i in 0 to 7 generate
    borrow: full_subtracter_1bit port map ( a => a(i), b=> b(i),
                                            bin => inside_borrows(i),
                                            bout=> inside_borrows(i+1),
                                            d => d(i));
end generate;

bout <= inside_borrows(8);

end Behavioral;
