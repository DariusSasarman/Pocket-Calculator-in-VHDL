library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux_4to1_64bits is
 Port (
    in1 : in std_logic_vector(63 downto 0);
    in2 : in std_logic_vector(63 downto 0);
    in3 : in std_logic_vector(63 downto 0);
    in4 : in std_logic_vector(63 downto 0);
    s : in std_logic_vector(1 downto 0);
    outp : out STD_LOGIC_VECTOR (63 downto 0)
     );
end mux_4to1_64bits;

architecture Behavioral of mux_4to1_64bits is

component mux_2to1_64bits is
    Port ( in1 : in STD_LOGIC_VECTOR (63 downto 0);
           in2 : in STD_LOGIC_VECTOR (63 downto 0);
           s : in STD_LOGIC;
           outp : out STD_LOGIC_VECTOR (63 downto 0));
end component mux_2to1_64bits;

signal outp_mux1 : std_logic_vector ( 63 downto 0);
signal outp_mux2 : std_logic_vector ( 63 downto 0);

begin

c0: mux_2to1_64bits port map ( in1 => in1, in2 => in2, s => s(0), outp => outp_mux1);
c1: mux_2to1_64bits port map ( in1 => in3, in2 => in4, s => s(0), outp => outp_mux2);
c2: mux_2to1_64bits port map ( in1 => outp_mux1, in2 => outp_mux2, s=>s(1), outp=>outp);
end Behavioral;
