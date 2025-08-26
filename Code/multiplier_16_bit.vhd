library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    
use IEEE.NUMERIC_STD.ALL;
entity multiplier_16_bit is
    Port ( 
        in1 : in  STD_LOGIC_VECTOR (7 downto 0);
        in2 : in  STD_LOGIC_VECTOR (7 downto 0);
        Clk : in  STD_LOGIC;
        Rst : in  STD_LOGIC;
        Outp : out STD_LOGIC_VECTOR (15 downto 0)
    );
end multiplier_16_bit;  
architecture Behavioral of multiplier_16_bit is
    component full_adder_8bit is
        Port ( 
            A : in  STD_LOGIC_VECTOR (7 downto 0);
            B : in  STD_LOGIC_VECTOR (7 downto 0);
            Cin : in  STD_LOGIC;
            Cout : out STD_LOGIC;
            S : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    type state_type is (LOADING, COMPARE, ADD, SHOW_RESULT);
    signal current_state: state_type := LOADING;
    signal store_n1: STD_LOGIC_VECTOR (7 downto 0) := x"00";
    signal store_n2 : STD_LOGIC_VECTOR (7 downto 0) := x"00";
    signal Accumulator : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
    signal Step : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
    signal Decision : STD_LOGIC_VECTOR (7 downto 0) := x"00";
    signal next_Accumulator: STD_LOGIC_VECTOR (15 downto 0) := x"0000";
    signal next_Step : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
    signal next_Decision : STD_LOGIC_VECTOR (7 downto 0) := x"00";
    signal equal_zero : STD_LOGIC := '0';
    signal internal_carry : STD_LOGIC := '0';
    signal different_sign : STD_LOGIC := '0';
begin
    c1: full_adder_8bit port map (
        A => Accumulator(7 downto 0), 
        B => Step(7 downto 0), 
        Cin => '0', 
        Cout => internal_carry, 
        S => next_Accumulator(7 downto 0)
    );
    c2: full_adder_8bit port map (
        A => Accumulator(15 downto 8), 
        B => Step(15 downto 8), 
        Cin => internal_carry, 
        Cout => open, 
        S => next_Accumulator(15 downto 8)
    );

    next_Step <= Step(14 downto 0) & '0';
    next_Decision <= '0' & Decision(7 downto 1);
    equal_zero <= not (Decision(0) or Decision(1) or Decision(2) or
                       Decision(3) or Decision(4) or Decision(5) or
                       Decision(6) or Decision(7));
    process(CLK, RST)
    begin
        if Rst = '1' then
            current_state <= LOADING;
            Accumulator <= x"0000";
            Step <= x"0000";
            Decision <= x"00";
            store_n1 <= x"00";
            store_n2 <= x"00";
            different_sign <= '0';
            Outp <= x"0000";
        elsif rising_edge(Clk) then
            case current_state is
                when LOADING =>
                    Accumulator <= x"0000";
                    Step(7 downto 0) <= std_logic_vector(abs(signed(in2)));
                    Step(15 downto 8) <= x"00";
                    Decision <= std_logic_vector(abs(signed(in1)));
                    current_state <= COMPARE;
                    store_n1 <= in1;
                    store_n2 <= in2;
                    different_sign <= in1(7) xor in2(7);
                    Outp <= x"0000";
                when COMPARE =>
                    if equal_zero = '1' then
                        current_state <= SHOW_RESULT;
                    else
                        current_state <= ADD;
                    end if;
                when ADD =>
                    if Decision(0) = '1' then
                        Accumulator <= next_Accumulator;
                    end if;
                    Step <= next_Step;
                    Decision <= next_Decision;
                    current_state <= COMPARE;
                when SHOW_RESULT =>
                    if ((store_n1 /= in1) or (store_n2 /= in2)) then
                        current_state <= LOADING;
                    end if;
                    if different_sign = '1' then
                        Outp <= std_logic_vector( resize((- signed( Accumulator )),16));
                    else
                        Outp <= Accumulator;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;