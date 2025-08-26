library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Execution_Unit is
  Port (
        n1 : in std_logic_vector ( 7 downto 0);
        n2 : in std_logic_vector ( 7 downto 0);
        s  : in std_logic_vector ( 2 downto 0);
        clk: in std_logic;
        rst: in std_logic;
        digit_info : out STD_LOGIC_VECTOR (7 downto 0);
        anode_info : out STD_LOGIC_VECTOR (7 downto 0));
end Execution_Unit;
architecture Behavioral of Execution_Unit is
component display_unit is
    Port ( no1 : in STD_LOGIC_VECTOR (7 downto 0);
           no2 : in STD_LOGIC_VECTOR (7 downto 0);
           rez : in STD_LOGIC_VECTOR (63 downto 0);
           s : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           digit_info : out STD_LOGIC_VECTOR (7 downto 0);
           anode_info : out STD_LOGIC_VECTOR (7 downto 0));
end component display_unit;
component arithmetic_logic_unit is
    Port ( no1 : in STD_LOGIC_VECTOR (7 downto 0);
           no2 : in STD_LOGIC_VECTOR (7 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           rez : out STD_LOGIC_VECTOR (63 downto 0));
end component arithmetic_logic_unit;
component data_register_8_bit is
    Port ( Load : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Load_inp : in STD_LOGIC_VECTOR (7 downto 0);
           Outp : out STD_LOGIC_VECTOR (7 downto 0));
end component data_register_8_bit;
signal no1_stored : std_logic_vector ( 7 downto 0);
signal no2_stored : std_logic_vector ( 7 downto 0);
signal rez : std_logic_vector ( 63 downto 0);
begin
c0: data_register_8_bit port map ( Load => s(2), Clk => clk,
                                   Rst => rst, Load_inp => n1, outp => no1_stored);
c1: data_register_8_bit port map ( Load => s(2), Clk => clk,
                                   Rst => rst, Load_inp => n2, outp => no2_stored);
c2: arithmetic_logic_unit port map ( no1 => no1_stored, no2 => no2_stored,
                                     s => s, clk=>clk, rst => rst, rez => rez);
c3: display_unit port map ( no1 => no1_stored, no2 => no2_stored, rez => rez, s => s(2),
                            clk => clk, rst => rst, digit_info => digit_info, anode_info => anode_info); 
end Behavioral;
