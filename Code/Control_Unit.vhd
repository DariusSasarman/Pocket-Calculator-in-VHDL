library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Control_Unit is
    Port ( N1 : in STD_LOGIC_VECTOR (7 downto 0);--
           N2 : in STD_LOGIC_VECTOR (7 downto 0);--
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
end Control_Unit;
architecture Behavioral of Control_Unit is
    type state_type is ( RESET, WAIT_OP, ADD, SUB, MUL, DIV);
    signal current_state : state_type := RESET;
    signal operation : std_logic_vector (2 downto 0) := "100";
begin
N1_eu <= N1;
N2_eu <= N2;
seven_seg <= seven_seg_eu;
OP <= operation;
process (clk)
begin
    if rising_edge(clk) then
        restart_eu <= '0';
        case current_state is
            when RESET =>
                operation <= "100";
                restart_eu <= '1';
                current_state <= WAIT_OP;
            when WAIT_OP =>
                operation <= "100";
                if Add_button = '1' then
                    current_state <= ADD;
                elsif sub_button = '1' then
                    current_state <= SUB;
                elsif mul_button = '1' then
                    current_state <= MUL;
                elsif div_button = '1' then
                    current_state <= DIV;
                elsif rst_button = '1' then
                    current_state <= RESET;
                end if;
            when ADD =>
                operation <= "000";
                if rst_button = '1' then
                    current_state <= RESET;
                end if;
            when SUB =>
                operation <= "001";
                if rst_button = '1' then
                    current_state <= RESET;
                end if;
            when MUL =>
                operation <= "010";
                if rst_button = '1' then
                    current_state <= RESET;
                end if;
            when DIV =>
                operation <= "011";
                if rst_button = '1' then
                    current_state <= RESET;
                end if;
            end case;
    end if;
end process;

end Behavioral;
