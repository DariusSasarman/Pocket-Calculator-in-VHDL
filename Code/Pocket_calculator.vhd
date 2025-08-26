library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Pocket_calculator is
    Port ( N1 : in STD_LOGIC_VECTOR (7 downto 0);
           N2 : in STD_LOGIC_VECTOR (7 downto 0);
           clk: in std_logic;
           Add_button : in STD_LOGIC;
           Sub_button : in STD_LOGIC;
           Mul_button : in STD_LOGIC;
           Div_button : in STD_LOGIC;
           rst_button : in STD_LOGIC;
           Seven_seg_info : out STD_LOGIC_VECTOR (15 downto 0));
end Pocket_calculator;

architecture Behavioral of Pocket_calculator is

component Control_Unit is
    Port ( N1 : in STD_LOGIC_VECTOR (7 downto 0);
           N2 : in STD_LOGIC_VECTOR (7 downto 0);
           Add_button : in STD_LOGIC;
           Sub_button : in STD_LOGIC;
           Mul_button : in STD_LOGIC;
           Div_button : in STD_LOGIC;
           Rst_button : in STD_LOGIC;
           Clk : in STD_LOGIC;
           N1_eu : out STD_LOGIC_VECTOR (7 downto 0);
           N2_eu : out STD_LOGIC_VECTOR (7 downto 0);
           restart_eu : out std_logic;
           OP : out STD_LOGIC_VECTOR (2 downto 0);
           seven_seg_eu : in STD_LOGIC_VECTOR (15 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (15 downto 0));
end component Control_Unit;

component Execution_Unit is
  Port (
        n1 : in std_logic_vector ( 7 downto 0);
        n2 : in std_logic_vector ( 7 downto 0);
        s  : in std_logic_vector ( 2 downto 0);
        clk: in std_logic;
        rst: in std_logic;
        digit_info : out STD_LOGIC_VECTOR (7 downto 0);
        anode_info : out STD_LOGIC_VECTOR (7 downto 0));
end component Execution_Unit;

component MPG is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC);
end component MPG;

signal n1_eu : std_logic_vector ( 7 downto 0);
signal n2_eu : std_logic_vector ( 7 downto 0);
signal op : std_logic_vector ( 2 downto 0);
signal reset_eu : std_logic;
signal inside_7seg : std_logic_vector ( 15 downto 0);
signal add : std_logic;
signal sub : std_logic;
signal mul : std_logic;
signal div : std_logic;
signal rst : std_logic;

begin

c0: MPG port map ( btn => Add_button, clk => clk, en => add);
c1: MPG port map ( btn => Sub_button, clk => clk, en => sub);
c2: MPG port map ( btn => Mul_button, clk => clk, en => mul);
c3: MPG port map ( btn => Div_button, clk => clk, en => div);
c4: MPG port map ( btn => Rst_button, clk => clk, en => rst);
c5: Control_unit port map ( N1 => N1, N2 => N2, Add_button => add, Sub_button => sub,
                            Mul_button => mul, Div_button => div, Rst_button => rst,
                            clk => clk, N1_eu => n1_eu, N2_eu => n2_eu, restart_eu => reset_eu,
                            OP => op, seven_seg_eu => inside_7seg, seven_seg => seven_seg_info);
c6: Execution_Unit port map ( n1 => n1_eu, n2 => n2_eu, s => op, clk => clk, rst => reset_eu,
                              digit_info => inside_7seg(15 downto 8), anode_info=> inside_7seg(7 downto 0));

end Behavioral;
