library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity division_test is
--  Port ( );
end division_test;

architecture Behavioral of division_test is

component division_unit is
    Port ( no1 : in STD_LOGIC_VECTOR (7 downto 0);
           no2 : in STD_LOGIC_VECTOR (7 downto 0);
           quotient: out std_logic_vector (7 downto 0);
           remainder:  out std_logic_vector (7 downto 0);
           sign_bit: out std_logic;
           zero_div: out std_logic;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end component division_unit;

component division_output_processor is
     Port (   
           quotient: in std_logic_vector (7 downto 0);
           remainder:  in std_logic_vector (7 downto 0);
           sign_bit: in std_logic;
           outp : out std_logic_vector (63 downto 0));
end component division_output_processor;

component mux_8to1_64bits is
Port (
    in1 : in std_logic_vector(63 downto 0);
    in2 : in std_logic_vector(63 downto 0);
    in3 : in std_logic_vector(63 downto 0);
    in4 : in std_logic_vector(63 downto 0);
    in5 : in std_logic_vector(63 downto 0);
    in6 : in std_logic_vector(63 downto 0);
    in7 : in std_logic_vector(63 downto 0);
    in8 : in std_logic_vector(63 downto 0);
    s : in std_logic_vector(2 downto 0);
    outp : out STD_LOGIC_VECTOR (63 downto 0)
     );
end component mux_8to1_64bits;

component mux_2to1_64bits is
    Port ( in1 : in STD_LOGIC_VECTOR (63 downto 0);
           in2 : in STD_LOGIC_VECTOR (63 downto 0);
           s : in STD_LOGIC;
           outp : out STD_LOGIC_VECTOR (63 downto 0));
end component mux_2to1_64bits;

signal no1 : std_logic_vector ( 7 downto 0);
signal no2 : std_logic_vector ( 7 downto 0);
signal s : std_logic_vector (2 downto 0) := "011";
signal zero_div: std_logic := '0';
signal sign_bit: std_logic;
signal div : std_logic_vector ( 15 downto 0);
signal div_rez_string : std_logic_vector (63 downto 0);
signal inf_rez_string : std_logic_vector (63 downto 0) := x"CFAB8EEFABEF8F8D";
signal mux_div_string : std_logic_vector (63 downto 0);
signal rez : std_logic_vector ( 63 downto 0);
signal clk : std_logic := '0';
signal rst : std_logic := '0';

begin

clk <= not clk after 1ns;

c0: mux_2to1_64bits port map ( in1 => div_rez_string, in2 => inf_rez_string,
                              s => zero_div, outp => mux_div_string);
c1: mux_8to1_64bits port map ( in1 => x"FFFFFFFFFFFFFFFF", in2 => x"FFFFFFFFFFFFFFFF",
                              in3 => x"FFFFFFFFFFFFFFFF", in4 => mux_div_string,
                              in5 => x"FFFFFFFFFFFFFFFF", in6 => x"FFFFFFFFFFFFFFFF",
                              in7 => x"FFFFFFFFFFFFFFFF", in8 => x"FFFFFFFFFFFFFFFF",
                              s   => s, outp => rez);
                              
c5: division_unit port map ( no1 => no1, no2 => no2, quotient => div(15 downto 8),
                             remainder => div(7 downto 0), sign_bit=>sign_bit,
                             zero_div => zero_div, clk=> clk, rst=>rst);

c8: division_output_processor port map ( quotient => div ( 15 downto 8),
                                         remainder=> div ( 7 downto 0),
                                         sign_bit => sign_bit,
                                         outp=> div_rez_string);
                              
end Behavioral;
