library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity division_unit is
    Port ( no1 : in STD_LOGIC_VECTOR (7 downto 0);
           no2 : in STD_LOGIC_VECTOR (7 downto 0);
           quotient: out std_logic_vector (7 downto 0);
           remainder:  out std_logic_vector (7 downto 0);
           sign_bit: out std_logic;
           zero_div: out std_logic;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end division_unit;
architecture Behavioral of division_unit is
component full_subtracter_8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           bin : in STD_LOGIC;
           bout : out STD_LOGIC;
           d : out STD_LOGIC_VECTOR (7 downto 0));
end component full_subtracter_8bit;
component full_adder_8bit is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end component full_adder_8bit;
type state_type is (LOADING, COMPARE, SUBTRACT, GIVE_RESULT);
signal current_state: state_type := LOADING;
signal R : std_logic_vector ( 7 downto 0);
signal S : std_logic_vector ( 7 downto 0);
signal Q : std_logic_vector ( 7 downto 0);
signal bigger : std_logic;
signal equal  : std_logic;
signal next_Q : std_logic_vector (7 downto 0);
signal next_R : std_logic_vector (7 downto 0);
signal no1_abs : std_logic_vector(7 downto 0);
signal no2_abs : std_logic_vector(7 downto 0);
signal store_n1 : std_logic_vector( 7 downto 0);
signal store_n2 : std_logic_vector( 7 downto 0);
signal zero : std_logic;
begin
bigger <= '1' when UNSIGNED(R) > UNSIGNED(S) else '0';
equal  <= '1' when UNSIGNED(R) = UNSIGNED(S) else '0';
c1: full_subtracter_8bit port map ( a => R, b => S, bin => '0', bout => open, d=> next_R);
c2: full_adder_8bit port map( a => Q, b => x"00", Cin => '1', Cout => open, S => next_Q);
sign_bit <= no1(7) xor no2(7);
zero <= not ( no2(0) or no2(1) or no2(2) or
              no2(3) or no2(4) or no2(5) or
              no2(6) or no2(7) );
zero_div <= zero;
process(clk, rst)
begin
    if rst = '1' then
        current_state <= LOADING;
        R <= std_logic_vector(abs(signed(no1)));
        S <= std_logic_vector(abs(signed(no2)));
        Q <= x"00";
        store_n1 <= no1;
        store_n2 <= no2;
    elsif zero = '1' then
        current_state <= LOADING;      
    elsif rising_edge(clk) then 
        case current_state is
            when LOADING =>
                R <= std_logic_vector(abs(signed(no1)));
                S <= std_logic_vector(abs(signed(no2)));
                Q <= x"00";
                current_state <= COMPARE;
                store_n1 <= no1;
                store_n2 <= no2;
            when COMPARE =>
                if (bigger = '1' or equal = '1')  then
                    current_state <= SUBTRACT;
                else
                    current_state <= GIVE_RESULT;
                end if;
            when SUBTRACT=>
                R <= next_R;
                Q <= next_Q;
                current_state <= COMPARE;
            when GIVE_RESULT=>
                if store_n1 /= no1 or store_n2 /= no2 then
                    current_state <= LOADING;
                end if;
                quotient <= Q;
                remainder<= R;  
        end case;
    end if;
end process;

end Behavioral;
