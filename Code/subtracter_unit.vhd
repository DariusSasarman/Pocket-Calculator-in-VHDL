library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subtracter_unit is
  Port (
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           D : out STD_LOGIC_VECTOR (8 downto 0)
   );
end subtracter_unit;

architecture Behavioral of subtracter_unit is


component full_subtracter_8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           bin : in STD_LOGIC;
           bout : out STD_LOGIC;
           d : out STD_LOGIC_VECTOR (7 downto 0));
end component full_subtracter_8bit;

component full_subtracter_1bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           bin : in STD_LOGIC;
           bout : out STD_LOGIC;
           d : out STD_LOGIC);
end component full_subtracter_1bit;

signal extended_a : std_logic_vector ( 8 downto 0);
signal extended_b : std_logic_vector ( 8 downto 0);
signal internal_borrow : std_logic;

begin

extended_a <= std_logic_vector(resize(signed(A), 9));
extended_b <= std_logic_vector(resize(signed(B), 9));

c0 : full_subtracter_8bit port map ( a => extended_a ( 7 downto 0),
                                     b => extended_b ( 7 downto 0),
                                     bin=>'0',
                                     bout=>internal_borrow,
                                     d => D (7 downto 0));
c1 : full_subtracter_1bit port map ( a => extended_a (8),
                                     b => extended_b (8),
                                     bin=> internal_borrow,
                                     bout=>open,
                                     d => D(8));
end Behavioral;
