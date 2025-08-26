library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity arithmetic_logic_unit is
    Port ( no1 : in STD_LOGIC_VECTOR (7 downto 0);
           no2 : in STD_LOGIC_VECTOR (7 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           rez : out STD_LOGIC_VECTOR (63 downto 0));
end arithmetic_logic_unit;
architecture Behavioral of arithmetic_logic_unit is
component multiplier_16_bit is
    Port ( in1 : in STD_LOGIC_VECTOR (7 downto 0);
           in2 : in STD_LOGIC_VECTOR (7 downto 0);
           Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Outp : out STD_LOGIC_VECTOR (15 downto 0));
end component multiplier_16_bit;
component multiplication_output_processor is
    Port (
        inp : in std_Logic_vector (15 downto 0);
        outp: out std_logic_vector(63 downto 0)
     );
end component multiplication_output_processor;
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
component adder_unit is
  Port ( 
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (8 downto 0)
        );
end component adder_unit;
component addition_output_processor is
   Port(
       inp : in std_logic_vector ( 8 downto 0);
       outp: out std_logic_vector( 63 downto 0)
       );
end component addition_output_processor;
component subtracter_unit is
  Port (
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           D : out STD_LOGIC_VECTOR (8 downto 0)
   );
end component subtracter_unit;
component subtraction_output_processor is
   Port(
       inp : in std_logic_vector ( 8 downto 0);
       outp: out std_logic_vector( 63 downto 0)
       );
end component subtraction_output_processor;
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
signal n1_abs : std_logic_vector( 7 downto 0);
signal n2_abs : std_logic_vector( 7 downto 0);
signal n1_n2_diff_sign : std_logic;
signal rez_string : std_logic_vector (63 downto 0);
signal add_rez_string : std_logic_vector (63 downto 0);
signal sub_rez_string : std_logic_vector (63 downto 0);
signal mul_rez_string : std_logic_vector (63 downto 0);
signal div_rez_string : std_logic_vector (63 downto 0);
signal inf_rez_string : std_logic_vector (63 downto 0) := x"CFAB8EEFABEF8F8D";
signal mux_div_string : std_logic_vector (63 downto 0);
signal zero_div: std_logic := '0';
signal sign_bit: std_logic;
signal add_rez : std_logic_vector ( 8 downto 0);
signal add_final:std_logic_vector ( 8 downto 0);
signal sub_rez : std_logic_vector ( 8 downto 0);
signal sub_final: std_logic_vector ( 8 downto 0);
signal mul : std_logic_vector ( 15 downto 0);
signal div : std_logic_vector ( 15 downto 0);
begin
c0: mux_2to1_64bits port map ( in1 => div_rez_string, in2 => inf_rez_string,
                              s => zero_div, outp => mux_div_string);
c1: mux_8to1_64bits port map ( in1 => add_rez_string, in2 => sub_rez_string,
                              in3 => mul_rez_string, in4 => mux_div_string,
                              in5 => x"FFFFFFFFFFFFFFFF", in6 => x"FFFFFFFFFFFFFFFF",
                              in7 => x"FFFFFFFFFFFFFFFF", in8 => x"FFFFFFFFFFFFFFFF",
                              s   => s, outp => rez);                      
c2: adder_unit port map (A => no1, B => no2, S => add_final);
c3: subtracter_unit port map (A => no1, B => no2, D => Sub_final);
c4: multiplier_16_bit port map ( in1 => no1, in2 => no2,
                                 Clk=> clk, Rst=> rst, Outp => mul);
c5: division_unit port map ( no1 => no1, no2 => no2, quotient => div(15 downto 8),
                             remainder => div(7 downto 0), sign_bit=>sign_bit,
                             zero_div => zero_div, clk=> clk, rst=>rst);
c6: addition_output_processor port map (inp => add_final, outp => add_rez_string);
c7: subtraction_output_processor port map ( inp => sub_final, outp => sub_rez_string);
c8: division_output_processor port map ( quotient => div ( 15 downto 8),
                                         remainder=> div ( 7 downto 0),
                                         sign_bit => sign_bit,
                                         outp=> div_rez_string);
c9: multiplication_output_processor port map( inp => mul, outp => mul_rez_string);
end Behavioral;
