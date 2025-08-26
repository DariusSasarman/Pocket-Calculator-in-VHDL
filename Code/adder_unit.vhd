library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_unit is
  Port ( 
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (8 downto 0)
        );
end adder_unit;

architecture Behavioral of adder_unit is

component full_adder_8bit is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end component full_adder_8bit;

component full_adder_1bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC);
end component full_adder_1bit;

signal extended_a : std_logic_vector ( 8 downto 0);
signal extended_b : std_logic_vector ( 8 downto 0);
signal internal_carry : std_logic;

begin

extended_a <= std_logic_vector(resize(signed(A), 9));
extended_b <= std_logic_vector(resize(signed(B), 9));

c0: full_adder_8bit port map ( A => extended_a (7 downto 0), 
                               B => extended_b (7 downto 0),
                               Cin=> '0',
                               Cout => internal_carry,
                               S => S(7 downto 0));
c1: full_adder_1bit port map ( a => extended_a (8),
                               b => extended_b (8),
                               Cin=> internal_carry,
                               Cout => open,
                               S => S(8));
end Behavioral;
